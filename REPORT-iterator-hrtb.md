# REPORT — `Iterator::find` HRTB-over-free-lifetime constraint

Branch: `fix/iterator-hrtb-lifetime-constraint` (worktree `/workspaces/aeneas-hrtb`,
based on `mantas-ripgrep` @ 9a81fa43, charon symlink → `/workspaces/charon-fnmut` @ f4bf9ed0).

## TL;DR / outcome

Per the task's explicit guidance ("If relaxing it is unsound or architecturally
deep, STOP and write a design proposal … A precise diagnosis plus a written
proposal is a fully acceptable outcome"), this deliverable is a **precise
diagnosis + design proposal + a documented regression test**, and **deliberately
no change to compiler behaviour**. Two independent empirical findings drove that
decision:

1. **The 14-error cascade hypothesis is REFUTED.** Fixing the HRTB check removes
   only **3** of 42 errors, not ~14. The ~14-error Iterator cascade has a
   *different, independent* root cause on a code path the HRTB check never
   touches (see §3).
2. **A sound relaxation of the HRTB check is architecturally deep.** The one case
   we want to admit (`slice::Iter::find`) is *structurally identical* to a case
   the Aeneas maintainers deliberately reject with a committed known-failure
   test. No syntactic distinction exists; distinguishing them soundly requires
   variance/return-position analysis of the higher-ranked region through the
   bound's methods (see §4).

## 1. Root cause of the HRTB defect (precise)

- **Where:** `src/llbc/TypesAnalysis.ml`, `check_no_bound_free_implied_bounds`
  (function spans ~975–1052; the raise is at line 983/985), invoked via
  `check_fun_decl_no_bound_free_implied_bounds` (line ~1061).
- **What it does:** given a function signature, it walks `(output :: inputs) @
  clause_tys` (where `clause_tys` are the types appearing in the possibly
  higher-ranked trait clauses) and, for every borrow `&'r T` it dives into,
  records `'r` as an "outer" borrow region; every region `r'` it later meets must
  outlive each outer `'r`. `check_pair` then rejects any pair in which one side
  is a locally-**bound** region (`RVar (Bound _)`, i.e. higher-ranked / `for<'x>`)
  and the other is a **free** region (`RVar (Free _)`).
- **Why `find` trips it:** for
  `<slice::Iter<'a, T> as Iterator>::find`, the where-clause
  `P: FnMut(&Self::Item) -> bool` with `Self::Item = &'a T` desugars to
  `P: for<'x> FnMut<(&'x &'a T,), Output = bool>`. The clause type `&'x &'a T`
  has the trivial implied bound "referent outlives borrow", i.e. `'a` (free,
  from the impl) outlives `'x` (higher-ranked, bound by the `FnMut` clause).
  `check_pair 'a 'x` sees free-outlives-bound and raises
  *"Unimplemented: found an occurrence of a lifetime constraint relating a
  higher-ranked lifetime to a free lifetime."*
- **Why the restriction exists:** it was added in PR #1158 ("Add preliminary
  support for higher ranked trait bounds") together with three committed
  known-failure tests (`higher_ranked_implied_bounds_{borrow,regions,types}.rs`).
  Aeneas erases regions and computes a region **hierarchy** (`RegionsHierarchy`)
  to synthesise backward functions. That hierarchy (a) is built **only from the
  signature's inputs/output**, and (b) **silently drops every outlives edge that
  touches a bound region** (`RegionsHierarchy.ml:75`,
  `RVar (Bound _), _ | _, RVar (Bound _) -> ()`). A bound↔free implied bound is
  therefore invisible to the hierarchy, so rather than compute a *wrong*
  hierarchy (→ silently wrong backward functions) the authors chose to reject
  such signatures up front. It is a conservative "not implemented yet" guard.

Minimal reproduction (added as a regression test, see §5):
`tests/src/higher_ranked_fnmut_free_lifetime.rs` — `fn find_like<'a,T,P>(x:&'a T,
mut pred:P)->bool where P: FnMut(&&'a T)->bool`. It raises the identical error at
`TypesAnalysis.ml:983`.

## 2. The HRTB check is worth only 3 errors — measured

Experiment (reverted afterwards): I relaxed `check_fun_decl_no_bound_free_implied_bounds`
to inspect only `inputs/output` (dropping `clause_tys`), rebuilt, and re-ran
`grep-regex-full.llbc`:

| metric | baseline | HRTB relaxed (exp1) |
|---|---|---|
| errors | 42 | **39** |
| `Unimplemented: … higher-ranked … free lifetime` | 2 | 0 |
| `Internal error: please file an issue` | 9 | 8 |
| `Could not find: trait_decl_id: 4` (Iterator) | 11 | **11 (unchanged)** |
| `Could not find the translated trait declaration` | 1 | **1 (unchanged)** |

Only the 2 HRTB errors (on the standalone impl `slice::Iter::find`) plus one
downstream internal error disappear. The Iterator cascade is untouched.

## 3. The REAL root of the ~14-error cascade (independent defect)

The Iterator **trait declaration** fails to translate for a reason that has
nothing to do with the HRTB check:

- **Where:** `src/symbolic/SymbolicToPureTypes.ml:1146`, inside `translate_fun_sigs`,
  the sanity check `sg.item_binder_params.trait_type_constraints = []`.
- **Why:** the Iterator trait's method declarations carry **trait type
  constraints** (associated-type projections such as `Self::Item` and, for
  `find`'s bound, `<P as FnMut<…>>::Output = bool`). `translate_fun_sigs`
  asserts there are none, so the method sig — and hence the whole `Iterator`
  trait declaration — fails with an internal error at `iterator.rs` line 42.
- **Independent of HRTB:** `check_fun_decl_no_bound_free_implied_bounds` is only
  ever called from `Translate.ml:127` and `SymbolicToPureTypes.ml:1281`, both of
  which are `fun_decl` (standalone function / impl method) paths. Trait method
  **declarations** are translated via
  `translate_flat_trait_method_sigs → translate_fun_sigs`, which never calls the
  HRTB check. I confirmed empirically that **both** the baseline binary and the
  HRTB-relaxed binary fail the Iterator trait decl at the *same* line 1146.

Consequently the 14 cascade errors (`11× trait_decl_id: 4` + "Could not
translate the trait declaration Iterator" + "Could not find the translated trait
declaration") are attributable to the **`trait_type_constraints` limitation**,
not to the HRTB check. Fixing the HRTB check alone can never resolve them.

## 4. Why no speculative HRTB fix was shipped (soundness)

The case we want to admit and the case the maintainers deliberately reject are
**structurally identical** — both are `for<'bound> Trait<&'bound &'free X>` with
the same constraint direction (free outlives bound):

| case | clause | verdict |
|---|---|---|
| `slice::Iter::find` (want to admit) | `for<'x> FnMut<(&'x &'a T,), Output=bool>` | currently rejected |
| `higher_ranked_implied_bounds_borrow.rs` (deliberately rejected) | `for<'a> RefTrait<&'a &'b u8>` | committed known-failure |

There is **no syntactic, type-level** predicate that separates them. The only
real difference is semantic: in `FnMut(..)->bool` the higher-ranked lifetime
appears solely in a **contravariant argument** position and never flows into a
returned borrow (the closure returns `bool`), so it can never enter a backward
function; whereas `RefTrait<X>` has a method `fn get(&self)->X` that *returns*
the entangled type. Distinguishing them requires opening the bound, looking up
the referenced trait's method signatures, and checking whether the higher-ranked
region can reach a borrow-returning (covariant/output) position — i.e. a variance
analysis over trait items. That is exactly the "architecturally deep" refactor
the task instructs me not to attempt speculatively. Dropping the `clause_tys`
check outright (the only *simple* change) is **unsound**: it silently re-admits
all three deliberately-rejected known-failure tests, whose region hierarchies
Aeneas cannot currently model, risking wrong backward functions — the worst
possible failure mode.

## 5. What I changed

Only a **test-only** addition — no compiler behaviour change:

- `tests/src/higher_ranked_fnmut_free_lifetime.rs` — minimal, real-world-motivated
  known-failure isolating the `Iterator::find` pattern (`FnMut(&&'a T)->bool`),
  with an in-file NOTE documenting the FnMut-returns-`bool` distinction a future
  sound fix must exploit.
- `tests/src/higher_ranked_fnmut_free_lifetime.lean.out` — generated oracle
  (`Unimplemented … TypesAnalysis.ml:983`).

This test is *not* redundant with the existing `RefTrait` known-failures: it
captures the specific bound shape that breaks ripgrep extraction, and it will
flip from known-failure to success on the day the sound fix (§6) lands, acting
as its acceptance oracle.

## 6. Design proposal for a sound, general fix

Two independent defects must both be fixed to clear the Iterator cascade; they
should be separate PRs.

**A. `trait_type_constraints` on trait method declarations
(`SymbolicToPureTypes.ml:1146`) — the actual cascade root.**
`translate_fun_sigs` bails whenever `item_binder_params.trait_type_constraints`
is non-empty. Supporting associated-type-projection constraints in method
signatures (or at minimum normalising/erasing them the way regular functions'
signatures already tolerate) is what actually unblocks the `Iterator` trait
declaration and therefore ~14 of the 42 errors. This is where the real value is
and should be scoped first; it is a larger, orthogonal piece of work.

**B. The HRTB bound↔free check (`TypesAnalysis.ml:983`).** Replace the purely
syntactic rejection with a variance-aware one. For a clause
`P: for<'r…> Tr<G>`, a bound↔free implied bound between a higher-ranked region
`'x` and a free region `'a` is only genuinely unmodelable if `'x` can appear in a
position from which the region hierarchy would need to relate it to `'a` — i.e.
in a **borrow-returning (covariant/output)** position of one of `Tr`'s methods,
so that a backward function would thread it out. Concretely: open the bound,
substitute, and for each method of the referenced trait check whether the
higher-ranked region reaches the method's **output** (or any `&mut`/return-borrow
position). If it appears only in strictly contravariant argument positions
(the `Fn`/`FnMut`/`FnOnce` closure-argument case, whose `Output` is separately
constrained), the constraint never enters any region hierarchy and is safe to
ignore. This is general (keyed on variance, not on `Iterator`/`Fn`/`find` names)
and would admit `find_like` while still rejecting `RefTrait<X>`-returning cases.
Caveat: it requires trait-declaration method signatures at the point of the
check and may need Charon-AST support for the late-bound region information (the
same limitation already recorded for `TFnPtr`/`TFnDef` in
`RegionsHierarchy.ml`); it should be validated against the three existing
known-failure tests and the new `find_like` test.

## 7. Validation performed (before = baseline, after = this branch)

No compiler source changed, so "after" equals baseline by construction; the
numbers below were both re-measured on the final binary.

| llbc input | errors | uncaught | files emitted | oracle |
|---|---|---|---|---|
| grep-regex-full | 42 → 42 | 0 → 0 | 4 → 4 | (primary target) |
| nonmatching-with-hir | 20 → 20 | 0 → 0 | 4 → 4 | — |
| grep-matcher | 0 → 0 | 0 → 0 | 4 → 4 | **byte-identical to `golden-grep-matcher`** |
| nonmatching-clean | 0 → 0 | 0 → 0 | 4 → 4 | **byte-identical to `spike-nonmatching/C`** |

- **Aeneas test suite:** `make extract-tests` completed with exit code 0 and
  produced **zero diffs** to any committed test output (`git status` shows only
  the two new untracked test files). The three existing HRTB known-failure tests
  and the two passing HRTB tests behave as before. The new
  `higher_ranked_fnmut_free_lifetime` known-failure test passes against its
  oracle.
- **Regression oracles:** both byte-identical (`diff -r`), as above.

### What I did NOT validate / deliberately did not attempt
- I did **not** run `cargo-test` (the `make test` half), because its recipe
  writes to `/tmp`, which is forbidden in this environment. It exercises Rust
  unit tests, not the OCaml translator, and is unaffected by a test-only change.
- I did **not** implement fix (A) (`trait_type_constraints`) — it is the real
  cascade root but a large, orthogonal feature, out of scope for "the HRTB
  defect" and not safely doable speculatively.
- I did **not** implement fix (B) (variance-aware HRTB check) — sound
  implementation is architecturally deep (needs trait-method variance analysis
  and possibly Charon-AST changes); attempting it speculatively risks silently
  wrong backward functions, which the task explicitly warns against.
- I did **not** modify `charon`, the shared llbc/golden oracles, or any other
  worktree.

---

# Part 2 — Implementing Proposal A: support trait type constraints on method signatures

Follow-up task after the refutation above was accepted and the test-only branch
merged. The base moved to `mantas-ripgrep` (now including `fix/static-loans-traits`
+ the task-1 test commit); I rebased onto it before measuring. On the rebased
base, `grep-regex-full` is **35 errors / 14 `sorry`** (not 42).

## Root cause (precise)

`src/symbolic/SymbolicToPureTypes.ml`, in `translate_fun_sigs`, built the local
`inst_sg : LlbcAst.inst_fun_sig` and guarded it with:

```ocaml
[%sanity_check_opt_span] span (sg.item_binder_params.trait_type_constraints = []);
```

For a *regular* function this is always satisfied, because Charon normalises
associated-type projections away. But a trait **provided method** whose
`where`-clause constrains an associated type of `Self` keeps a non-empty
`trait_type_constraints` on the method signature. The concrete offender in
ripgrep is `core::iter::traits::iterator::Iterator::copied` (method id 56),
whose clause `Self: Iterator<Item = &'a T>` becomes the LLBC
`trait_type_constraint` `<Self as Iterator>::Item = &'0 T`. (`find` on
`slice::Iter` is a *different*, HRTB, root — see Part 1; it is unaffected here.)

Because the sanity check aborts, the **whole `Iterator` trait declaration**
fails to translate, and every downstream lookup of it fails
(`ExtractBase.ml:484` "Could not find: trait_decl_id: N", which *emits*
`sorry /- Could not find … -/` into the generated Lean; `Translate.ml:1073/1090`
`trait_{decl,impl}_is_builtin`). This is the ~20-of-35 cascade.

## Why the check was over-conservative (soundness argument)

The local `inst_sg` is used **only** to compute the regions hierarchy and the
decomposed signature *types*. `trait_type_constraints` are predicates, not
borrow-bearing types, so they play no role in the regions hierarchy. The check
was a stale defensive assertion that the input "happens" to have none — true for
regular functions, false for these methods — but dropping them in this *local*
signature loses no information, because the constraints are preserved everywhere
they are actually consumed:

1. The **pure** signature keeps them: `translate_generic_params` translates
   `trait_type_constraints` into `preds`, which flows into the emitted signature.
   (Pure `trait_type_constraints` are otherwise only *printed* — see
   `PrintPure.ml:784` — i.e. inert for extraction.)
2. **Body** symbolic execution reconstructs its **own** `inst_fun_sig` with the
   constraints preserved (`InterpUtils.instantiate_fun_sig`, ~L905–1010); it does
   not reuse this local `inst_sg`.
3. Charon's `--lift-associated-types` (implied by `--preset=aeneas`) already
   re-encodes the `Item = &T` relationship as an extra trait clause, so the
   emitted signature carries it as an ordinary instance parameter.

The fix therefore **removes the assertion** (with an explanatory comment) rather
than inventing new machinery — it reuses the already-trusted `preds`/interpreter
paths, exactly the "reuse an existing trusted code path" bar requested.

## What the fix produces (structural spot-check)

After the fix, `Iterator::copied.default` extracts as a well-typed `axiom`:

```
axiom core.iter.traits.iterator.Iterator.copied.default
  {Self T Clause2_Item : Type}
  (IteratorSelfSharedATInst : core.iter.traits.iterator.Iterator Self T)
  (markerCopyInst : core.marker.Copy T)
  (IteratorInst : core.iter.traits.iterator.Iterator Self Clause2_Item) :
  Self → Result (core.iter.adapters.copied.Copied Self)
```

The associated-type constraint `Item = &T` manifests as the extra
`Iterator Self T` instance (`…SelfSharedAT…`). This is slightly over-general (the
`Eq` between the two Items is not re-imposed), but it is an **opaque axiom that
replaces a `sorry` hole** — strictly a soundness *improvement*: an over-general
opaque axiom cannot be exploited to derive falsehood (the output type does not
mention `Item`), whereas `sorry` is literally unsound. The `Iterator` trait
declaration itself is a core trait provided by the Aeneas Lean support library,
so it is (correctly) not re-emitted; its impls and provided-method axioms now all
resolve.

## Cascade: confirmed and quantified

| metric | before (rebased) | after | delta |
|---|---|---|---|
| `grep-regex-full` errors | 35 | 14 | **−21** |
| `grep-regex-full` `sorry` lines | 14 | 3 | **−11** |
| `Could not find: trait_decl_id` errors | 11 | **0** | −11 |
| `sorry /- Could not find … -/` holes | 11 | **0** | −11 |

The 3 remaining `sorry` are ordinary **body** placeholders from *other*
pre-existing defects (`ban.rs` early-return-in-loops; `literal.rs` Extractor
methods that hit the HRTB-`find` / mixed-recursive roots), **not** the dangerous
missing-trait-decl type-holes. The remaining 14 errors are all pre-existing
unrelated roots (4× mixed-recursive `strip.rs`, 2× HRTB `find` from Part 1,
`ban.rs` early-return, internal errors, etc.) — none introduced by this change.

## Validation (rebased base 35 / 20 / 0 / 0)

| input | errors before→after | uncaught | files | `sorry` before→after | oracle |
|---|---|---|---|---|---|
| grep-regex-full   | 35 → **14** | 0 | 4 | 14 → **3** | — |
| nonmatching-with-hir | 20 → **20** | 0 | 4 | 6 → **6** | — |
| grep-matcher      | 0 → **0** | 0 | 4 | 0 → 0 | **byte-identical** to golden-grep-matcher |
| nonmatching-clean | 0 → **0** | 0 | 4 | 0 → 0 | **byte-identical** to spike-nonmatching/C |

`nonmatching-with-hir` is unchanged by design: it has **0** `trait_decl_id`
cascade errors — it never triggered this bug (its 20 errors are mixed-recursive
groups, `SwitchInt`, continue-to-outer-loops, float/string literals, etc.).

- **Aeneas test suite:** `make extract-tests` exits **0**; **zero diffs** to any
  committed backend output (`git status` shows only the new test files +
  lakefile entry). The "Uncaught exception" lines in the log are the *expected*
  known-failure tests (`dyn_unsize`, `higher_ranked_*`), which the runner asserts
  must fail.

## Regression test

`tests/src/trait_method_assoc_type_constraint.rs` — a self-contained trait
`MyIter` with a provided method `count_copied` whose `where`-clause is
`Self: MyIter<Item = &'a T>` (an associated-type-projection constraint on a
method signature). I verified it genuinely exercises the bug: temporarily
reinstating the sanity check and rebuilding makes exactly this test fail with the
same cascade (`… trait declaration 'MyIter' … / Could not find: trait_decl_id`).
With the fix it translates to well-typed, `sorry`-free Lean
(`tests/lean/TraitMethodAssocTypeConstraint.lean`), including a structurally
correct `structure MyIter (Self) (Self_Item)` and a `count_copied.default` that
carries the associated-type constraint as an extra `MyIter Self T` instance —
the exact miniature of the real `Iterator::copied`. Added the corresponding
`lean_lib` entry to `tests/lean/lakefile.lean`.

## What I did NOT validate / deliberately did not attempt

- I did **not** run `lake build` on the generated Lean (the new test or the
  ripgrep output): the Aeneas Lean support library is **not** prebuilt in this
  environment, so building even one lib would require compiling all of Aeneas +
  Mathlib/Batteries — infeasible here. Validation is at the *extraction* level
  (Aeneas → Lean produces 0 errors, structurally well-formed, `sorry`-free
  output), which is what the compiler regression harness (`make extract-tests`)
  checks. The over-generality of `copied.default` is argued sound above but was
  not machine-checked by a downstream proof.
- I did **not** run `cargo-test` (writes to `/tmp`, forbidden here; it exercises
  Rust unit tests, not the translator).
- I did **not** touch `Translate.ml:1073/1090` or `ExtractBase.ml:484` to make
  the missing-trait-decl path fail loudly instead of emitting `sorry`. With the
  root fixed, those `sorry` holes no longer appear on our inputs; the secondary
  hardening is left out to keep this change surgical (as instructed, secondary to
  the root fix and not to be ballooned).
- I did **not** implement the Part-1 HRTB (`find`) fix — still a separate,
  architecturally-deep root (2 remaining errors), tracked by the task-1
  known-failure test.
- I did **not** modify `charon`, the shared llbc/golden oracles, `PrePasses.ml`,
  or any other worktree.
