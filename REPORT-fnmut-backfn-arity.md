# Report — FnMut backward-function arity: a zero-error silent miscompilation

Branch: `fix/fnmut-backfn-arity` (based on `mantas-ripgrep` @ `2c5c7195`).
Deliverable: **loud error** for a previously silent miscompilation, plus this
design proposal. This is a first-class "make it loud" outcome, as the task
permits — a sound general fix is architecturally deep (see §5).

## 1. The bug

With the seven `--opaque 'grep_matcher::Matcher::...'` flags removed, Aeneas
extracts `grep-matcher` with **0 errors, 0 warnings, 0 sorry, 211 defs** — and
emits Lean that does not elaborate. Four generated `Funs.lean` defs
(`Matcher.find_iter_at.default`, `captures_iter_at.default`, `replace.default`,
`replace_with_captures_at.default`) destructure a product out of a call:

```lean
let (r, _) ← MatcherInst.try_find_iter_at ... self haystack at1 matched
```

but the `try_find_iter_at` field of the `Matcher` trait, in the **same
generated `Types.lean`**, returns a non-product
`Result (core.result.Result (core.result.Result Unit E) Self_Error)`. Lean:

```
error: expected a product type, got core.result.Result (core.result.Result Unit Unit) Clause0_Error
```

Both files come from one Aeneas run, so this is **internally inconsistent
codegen**, not a stale-backend mismatch. Every acceptance signal this campaign
uses (error count, sorry count, golden diff, 115-crate differential) passes; only
a real `lake build` catches it.

## 2. Which side is wrong, and why

**The call site is "more correct" per borrow semantics; the callee signature
cannot express what the call site needs. Neither is trivially "wrong" — the two
are computed by two different code paths that legitimately disagree.**

- Rust: `try_find_iter_at<F>(&self, haystack, at, mut matched: F)` takes the
  closure **by value**; the callee consumes and drops it, never returns it.
  `find_iter_at.default` passes `|m| Ok(matched(m))`, an inner closure that
  captures `&mut matched`. When the callee drops that inner closure the borrow
  of `matched` ends, so `matched` is **given back** to the caller. The
  give-back is real: `replace.default` destructures `(r, c, c1, _)` and then
  `let (dst1, _, _, _) := c` to recover a `&mut`-captured `dst` and return it.
  So the backward function carries information and **cannot be filtered away**.

- Call site (`SymbolicToPureExpressions.ml`): backward functions are derived
  from `inst_sg = call.inst_sg`, the **instantiated** signature.
  `InterpUtils.instantiate_fun_sig` substitutes the concrete argument types and
  then **recomputes** `RegionsHierarchy.compute_regions_hierarchy_for_sig` on
  the substituted signature. The closure's `&mut` capture becomes its own
  region group ⇒ an extra backward function (N+1 components).

- Callee def site (`SymbolicToPureTypes.translate_fun_sigs`, and, for a trait
  method, the abstract trait-field type): the regions hierarchy is computed on
  the **generic** signature, where the by-value closure parameter `matched : F`
  is an opaque type variable with no visible borrow ⇒ no extra group (N
  components).

Result: the call destructures N+1, the callee returns N. The generic /
trait-abstract signature **fundamentally cannot express** a backward function
whose existence depends on the *instantiation* of a type parameter.

The existing `closure_capture_back_gids` machinery
(`SymbolicToPureTypes.ml`) already filters capture-region backward functions —
but only when the closure is the **receiver** (input 0) of an `FnMut::call_mut`,
where the capture is redundant with the returned closure state. That keeps
definition and call sites agreeing for the receiver case. It does **not** cover
a closure passed as a **non-receiver, by-value argument**, which is consumed
(not returned) so its capture is *not* redundant. That is the exact gap.

## 3. The fix (this branch): convert silent → loud

`src/symbolic/SymbolicToPureExpressions.ml`, in the `S.Fun` call-translation
branch, right after `back_tys` is computed. Structural guard:

1. `closure_arg_regions` = union of `TypesUtils.ty_regions ty` over the
   instantiated inputs `ty` that are **closure-state ADTs** (`TAdt {id=TAdtId
   id}` whose `type_decls[id].src = ClosureItem _`).
2. If non-empty, map each region group id to its regions via
   `inst_sg.regions_hierarchy`, then check whether **any surviving (non-filtered,
   `Some`) backward function** has a non-empty region group whose regions lie
   **entirely inside** `closure_arg_regions`.
3. If so, `[%cassert]` fails with a precise message.

Keyed purely on structure (`ClosureItem`), never on a function/trait name.

- Fires on **exactly** the four real methods (`crates/matcher/src/lib.rs`
  648/774/902/948 — `find_iter_at`, `captures_iter_at`, `replace`,
  `replace_with_captures_at`); each becomes an opaque `axiom` instead of an
  un-elaborable `def`.
- Does **not** fire on `Fn::call f x` (`tests/src/fn_def_regions.rs:90`), whose
  extra backward function is for a plain `&mut` *argument*, not a closure-state
  argument — the earlier count-only guard (v1) false-positived here; the
  structural guard (v2) does not.
- The receiver-closure case (`FnMut::call_mut`) is already filtered from
  `back_tys`, so it never reaches the guard.

## 4. Validation

| llbc | base (merge @2c5c7195) | this branch | notes |
|---|---|---|---|
| `grep-matcher` (flags-stripped) | 0 err / 0 sorry, **bad Lean** | **4 err** / 0 sorry | 4 methods → axioms; see §4.1 |
| `nonmatching-clean` | 0 / 0 | 0 / 0 | byte-identical to `spike-nonmatching/C` |
| `grep-regex-full` | 12 / 1 | 12 / 1 | guard does not fire |
| `nonmatching-with-hir` | 20 / 6 | 20 / 6 | guard does not fire |

- **`make test`**: exit 0, zero `git status --porcelain` drift on tracked files.
- **`fn_def_regions`**: `bin/aeneas` exit 0, output **byte-identical** to base
  (the false-positive class is gone).
- **115-crate differential** (`tests/llbc/*.llbc`, my binary vs
  `/workspaces/aeneas-merge/bin/aeneas` @ 2c5c7195; ANSI/dest/exec-time
  normalized, sorted): **0 differing crates** — outputs, logs, and exit codes
  identical everywhere. The guard fires on no in-tree crate (none exhibits the
  by-value-closure-capture-of-`&mut` pattern), so there are zero false positives.
- **`lake build C`** (the only check that detects this bug), `/tmp/proofs-test`:
  - This branch's output (4 methods as axioms) ⇒ **`Build completed successfully
    (1703 jobs)`**. Only pre-existing unrelated `sorry` warnings from
    `Aeneas.Std.Slice`/`StringIter`.
  - Base binary's output (4 methods as `def`) ⇒ **build fails**:
    `error: C/Funs.lean:1613/1868/2103/2248: expected a product type, got
    core.result.Result ...`. This is the direct proof that the fix removes the
    un-elaborable output.

### 4.1 The regression oracle itself encodes the bug

`/workspaces/rg-verify/llbc/grep-matcher.llbc` is a **full** extraction (methods
not opaque) that itself triggers the bug. The merge-base binary's output is
**byte-identical to `golden-grep-matcher/`**, and that golden output *contains*
the bad `let (r, _)` defs against a non-product `try_find_iter_at` field
(verified). So "grep-matcher 0/0, byte-identical to golden" has been silently
blessing broken Lean. Any real fix **necessarily** changes grep-matcher
(0 → 4 errors). This is expected and unavoidable; I cannot modify
`/workspaces/rg-verify/llbc/` (forbidden). The **live** build stays green
because `extract.sh` keeps the seven `--opaque` flags.

## 5. Why a loud error and not a transform

A sound automatic fix is architecturally deep and would be unsound if done
naively:

- The extra backward function is instantiation-dependent: it exists only because
  a type parameter (`F`) was instantiated with a closure capturing `&mut`. The
  callee's generic (or trait-abstract) signature cannot name it. There is no
  local rewrite of the call site that makes an un-expressible give-back
  expressible.
- Relocating/duplicating the give-back is unsound: `StorageDead` becomes
  `drop_value` in LLBC, and a naive transformation that moves or duplicates the
  loop/closure tail can **double-drop** dead locals (documented previously in
  `REPORT-regex-syntax-hir-extraction.md`).
- The give-back is *not* redundant (`replace.default` uses it — §2), so the
  receiver-closure filtering trick cannot be extended to it.

Two sound directions, both non-local:

1. **Monomorphize the callee for this instantiation** — generate a specialized
   `try_find_iter_at` whose signature has the extra region group materialized,
   so definition and call sites agree by construction. This is the general
   answer to "instantiation introduces a backward function the polymorphic
   signature cannot express."
2. **Thread the by-value closure state through the generic signature as an
   output** — extend the closure-state calling convention so a by-value
   `FnMut`/`FnOnce` argument that captures borrows returns its (given-back)
   captures as part of the result, uniformly at definition and call sites (the
   dual of `closure_capture_back_gids` for non-receiver arguments).

Either is a real design change to Aeneas's closure/region-polymorphism handling,
beyond the scope of a targeted defect fix. Until then, the loud error converts an
undetectable failure into a detected one at exactly the point of divergence.

## 6. What I did not add, and why (regression test)

I attempted to distil a minimal standalone `.rs` regression test under
`tests/src/`. Three reduced reproducers were built and run against both binaries:

- A closure capturing `&mut u32` passed by value → hits a *different*
  limitation ("ADTs containing nested mutable borrows are not supported yet"),
  not the arity divergence.
- A two-level closure (`outer` builds `|m| matched(m)` capturing `&mut matched`,
  hands it to a concrete generic `inner`) → 0 errors on both binaries; the
  give-back is collapsed consistently at both sites, so there is no divergence.
- The same with `matched` used *after* the `inner` call (give-back observable) →
  still 0/0; the give-back is emitted as `matched1 := ()` and stays consistent.

The divergence requires the callee to be an **abstract trait method** (whose
def-site type is the generic *trait declaration*, computed once), not a concrete
generic function (whose signature is recomputed consistently with the call). A
faithful minimal case therefore has to reconstruct a trait with a default method
that calls another trait method taking a by-value closure that captures `&mut` —
essentially re-deriving the `Matcher` trait. That is exactly why this bug
survived every non-`lake` signal. Rather than commit a synthetic test that fires
on **neither** binary (and so protects nothing), the regression protection here
is: the guard fires on exactly the four real `Matcher` methods, the 115-crate
differential shows **zero** false positives, `fn_def_regions` stays
byte-identical (guarding the false-positive class), and `lake build` is the
oracle. I would happily add a harness test if the trait-default-method reproducer
can be minimized in a follow-up.

## 7. Files changed

- `src/symbolic/SymbolicToPureExpressions.ml` — structural guard (this report §3).
- `REPORT-fnmut-backfn-arity.md` — this file.

No `--opaque` flags were re-added; `extract.sh` is untouched. `./charon` symlink
untouched.
