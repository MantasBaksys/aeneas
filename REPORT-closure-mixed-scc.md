# REPORT — mixed SCCs containing closure trait impls (`fix/closure-mixed-scc`)

Branch: `fix/closure-mixed-scc`, rebased onto `mantas-ripgrep` @ `af5a7731`
(contains the `fix/outer-loop-control-flow` merge, the `fix/static-loans-traits`
generalization of `replace_static`, and the `hrtb` agent's "Proposal A" —
allowing trait type constraints on method signatures, which removed the blanket
`trait_type_constraints = []` check in `translate_fun_sigs` and dropped
`grep-regex-full` from 35 → 14 errors / 14 → 3 `sorry`). My change is
message-only and rebased with no conflicts; error/`sorry` counts are unchanged
by it.

`./charon` → `/workspaces/charon-fnmut` @ `f4bf9ed0` (untouched).

## 0. TL;DR

**Question posed:** *Can Aeneas emit a mixed SCC as a Lean `mutual` block when
every trait-impl member of the SCC is a closure `Fn`/`FnMut`/`FnOnce` impl?*

**Answer (with evidence):** **Yes at the Lean level — a `mutual` target shape
exists and typechecks — but No with the current extraction architecture without
adding a new transformation.** The blocker is *not* Lean's `mutual`/recursion
machinery (which is happy), and *not* the declaration-group export logic. It is
that Aeneas extracts a closure's `Fn*` trait impl to a **record-valued `def`**
that sits *inside* the recursive cycle (`f → closure.FnMutInst → call_mut → f`).
Lean cannot place that value-`def`:

- it cannot go **inside** the `partial_fixpoint` mutual block (Lean forbids
  mixing a non-`partial_fixpoint` value with `partial_fixpoint` functions), and
- it cannot be emitted **after** the block and referenced from inside it
  (forward reference), and
- it cannot be emitted **before** the block (it needs `call_mut`, which is in
  the block).

The only shape Lean accepts requires **inlining the closure's trait dictionary
at the recursive use site** so the function members reference sibling *functions*
(`call_mut`/`call_once`) directly, with the named instance values emitted after
the block. Producing that shape is an **extraction-expression-level change**
(a pure micro-pass or a change to trait-ref extraction), which is outside the
declaration-group export logic and overlaps the `extract/` area another agent is
actively working in. Per the task guidance (correctness beats coverage; an
accurate negative/deferred result with evidence is acceptable), I did **not**
ship a risky partial transformation.

**What I did land** (safe, general, keyed on structure — never on names):

1. A precise, closure-specific diagnostic. When *every* mixed group is a
   closure-recursion group, the error now explains exactly what the pattern is,
   what the Lean target shape is, and why it is not yet produced — instead of the
   generic "type mutually recursive with a function" message which does not
   describe this case.
2. Strengthened the existing regression oracle
   (`tests/src/mixed_group_recursion.lean.out`) so it pins the new
   closure-specific diagnostic (the pre-existing `mixed_group_recursion.rs` test
   already exercises exactly this `f(...).map(|e| f(e))` pattern).
3. Reproducible Lean evidence (`evidence-closure-mixed-scc/`) — standalone Lean
   4.31 files, runnable without lake, proving each claim above.

## 1. The defect and the offending SCC

`grep_regex::strip::strip_from_match_ascii` contains
`... .map(|e| strip_from_match_ascii(e)) ...`. The closure calls back into the
function, so Charon puts the function into one strongly-connected component with
its closures' `Fn*` trait impls and their `call_mut`/`call_once` bodies:

```
Group 1 (item ids 6, 73, 74, 495, 496, 75, 76, 497, 498):
- fun decl   strip_from_match_ascii
- trait impl {impl FnOnce for closure#2}          \
- trait impl {impl FnMut  for closure#2}           }  closure #2's Fn* impls
- fun decl   {impl FnOnce for closure#2}::call_once }  + their bodies
- fun decl   {impl FnMut  for closure#2}::call_mut /
- trait impl {impl FnOnce for closure#3}   (same shape for closure #3)
- trait impl {impl FnMut  for closure#3}
- fun decl   {impl FnOnce for closure#3}::call_once
- fun decl   {impl FnMut  for closure#3}::call_mut
```

Aeneas rejects any `MixedGroup` (functions + trait impls in one SCC) at three
sites:

| Site | Message | Role |
|---|---|---|
| `interp/Interp.ml` (~L86) | "Detected groups of mixed mutually recursive definitions…" | **root**: the informative, user-facing report; lists the group |
| `llbc/FunsAnalysis.ml` (~L308) | "Mixed declaration groups … are not supported yet" | downstream guard; already recovers and analyses the fun members (prior cascade fix) |
| `Translate.ml` (~L1288) | "Mixed-recursive declaration groups are not supported" | the extraction/export `MixedGroup _ -> craise` |

The prior `fix/mixed-decl-groups-cascade` agent fixed the *cascade* (an empty
`fun_infos` crate-wide → 141 spurious errors) and explicitly **declined** to
*support* mixed SCCs, calling it architectural. This report re-examines that
declination specifically for the **closure** subset, as requested.

## 2. Minimal reproduction (no cargo, no ripgrep)

`evidence-closure-mixed-scc/minimal-repro.rs`:

```rust
pub enum Tree { Leaf(u32), Node(Vec<Tree>) }
pub fn map_tree(t: Tree) -> Tree {
    match t {
        Tree::Leaf(x) => Tree::Leaf(x + 1),
        Tree::Node(v) => Tree::Node(v.into_iter().map(|e| map_tree(e)).collect()),
    }
}
```

Charon emits the identical SCC shape (`MixedGroup [0,0,1,4,5]`); Aeneas emits the
identical three errors. The closure's `call_mut` body calls `map_tree`, and
`map_tree` passes the closure's `FnMut` dictionary to the (opaque) `Iterator::map`.

## 3. What Lean output would be needed — the empirical core

I hand-wrote the candidate Lean shapes and checked them with plain Lean 4.31
(the same technique used successfully for `loops-flag-threaded.rs`). All files
are in `evidence-closure-mixed-scc/` and are runnable standalone.

### 3.1 How closures already extract (baseline)

For a non-recursive closure Aeneas emits (see `tests/lean/Closures.lean`) a set
of plain `def`s: the closure state type, `…call`/`…call_mut`/`…call_once`
functions, and the trait instances as **record-valued `def`s**, e.g.

```
def …FnMut… : core.ops.function.FnMut … := { FnOnceInst := …, call_mut := … }
```

So the trait-impl members of the SCC are *values*, not functions.

### 3.2 `partial_fixpoint` is required

The recursion runs through `Iterator::map`/`collect`, which are opaque (axioms).
`Hir` (and `Tree`) are therefore not seen to decrease, so the functions cannot
use structural/WF recursion — they need `partial_fixpoint` (exactly as Aeneas
already emits for `remove_matching_bytes` in `non_matching.rs`).
`partial_fixpoint` mutual blocks are fine (evidence file `PF.lean` inside the
report's sibling tests). The problem is the *value* members.

### 3.3 Three decisive Lean experiments

- **`partial_fixpoint-mixing-FAILS.lean`** — a `mutual` block mixing a
  `partial_fixpoint` function with a plain value `def` that references it:

  > `error: … is mutually recursive with f, which is marked as
  > 'partial_fixpoint' so this one also needs to be marked 'partial_fixpoint'.`

  A record value cannot be `partial_fixpoint`. ⇒ **the trait-instance values
  cannot live in the mutual block.**

- **`named-instance-forward-ref-FAILS.lean`** — the shape faithful to the
  current extraction: the function references the *named* `…FnMutInst` value,
  emitted after the block. Fails with a forward-reference/projection error. ⇒
  **the function cannot reference the named instance if it is defined after the
  block, and it cannot be defined before (needs `call_mut`).**

- **`target-shape-WORKS.lean`** — the function builds the `FnMut` dictionary
  **inline** at the recursive use site (referencing sibling functions
  `call_mut`/`call_once` directly); the named instances are emitted as plain
  `def`s after the block. **Elaborates and runs** (`#eval` = `"ok"`).

### 3.4 Conclusion of the empirical core

The Lean target shape exists — refuting a blanket "impossible even for
closures". It is uniquely the **inline-dictionary** shape:

```
mutual
  partial def map_tree …            -- builds the FnMut dict INLINE (uses call_mut)
  partial def map_tree.closure.call_mut …  -- calls map_tree
  partial def map_tree.closure.call_once … -- calls call_mut
  … (partial_fixpoint)
end
def map_tree.closure.FnOnceInst : … := { call_once := … }   -- plain defs, AFTER
def map_tree.closure.FnMutInst  : … := { FnOnceInst := …, call_mut := … }
```

## 4. Why this is architectural (not a group-export change)

Reaching §3.3's working shape requires that the SCC's **function** members not
reference the **named** trait-instance values. But the pure translation of
`map_tree` references the closure's trait impl by name
(`map_tree.closure.Insts.CoreOpsFunctionFnMutTupleTreeTree`, confirmed via
`-log-debug Extract`): the opaque `Iterator::map` takes an `FnMut` trait clause,
and Aeneas resolves it to the instance `def`.

To break the cycle we must **inline the closure dictionary** at that use site
(and at any other SCC-internal reference), i.e. emit a record literal instead of
the instance name. That is a change to **expression / trait-ref extraction**
(`extract/Extract.ml`/`ExtractBase.ml`) or a new **pure micro-pass**, gated on
"this trait-ref points to a closure `Fn*` impl that is a member of the current
mixed SCC". Concretely it must:

1. classify the SCC as closure-only (done structurally here — see §5);
2. emit the fun-decl members as one `mutual … partial_fixpoint … end` block
   (the machinery already exists — `fun_decl_kind_to_qualif`/`post_qualif` in
   `ExtractBase.ml` already emit `mutual`/`partial_fixpoint` for Lean recursive
   fun groups);
3. inline SCC-internal closure dictionaries so no fun member references a
   sibling instance value;
4. emit the instance values as plain `def`s after the block;
5. relax the three rejection sites for this subset only.

Steps 1, 2, 4, 5 are modest. **Step 3 is the deep one** and lands in the
`extract/` files another agent is actively editing. It also carries real
validation surface: closures are pervasive, and inlining must not perturb the
hundreds of existing (non-recursive) closure extractions. Shipping it
half-validated risks silently wrong models — the exact failure mode the task
warns against. I therefore stopped at a validated design.

### Engagement with the prior "architectural, decline" finding

The prior agent was right that *general* mixed SCCs (a user type mutually
recursive with a user trait impl, needing genuine `inductive`/`def` mutual
induction) are out of reach. For the **closure** subset the picture is more
favourable — the trait impls erase to plain records and the whole thing is one
`mutual` block of `def`s — **but not free**: the record-in-cycle problem forces
dictionary inlining. So the declination stands for now, but for a *sharper*
reason than "mixed SCCs are hard": specifically, *the closure trait-instance
value cannot be placed in a `partial_fixpoint` mutual block, so the recursive
functions must stop referencing it, which requires SCC-internal dictionary
inlining.*

## 5. What I implemented

`src/interp/Interp.ml` — in `compute_contexts`, at the mixed-group report:

- Collect, structurally, the set of trait-impl ids that are a closure's
  `Fn`/`FnMut`/`FnOnce` implementations. A closure's **state type** declaration
  carries `src = ClosureItem info`, and `info` records `fn_once_impl`,
  `fn_mut_impl`, `fn_impl`. This is **not** keyed on the `Fn*` trait name or on
  any function name — it is the same `ClosureItem` signal already used in
  `SymbolicToPureTypes.ml`.
- A mixed group is a *closure-recursion* group iff it contains ≥1 function, ≥1
  such closure `Fn*` impl, and **only** functions and closure `Fn*` impls (no
  types, no user trait impls).
- When **every** mixed group is a closure-recursion group, append a precise note
  to the error explaining the pattern, the known Lean target shape, and why it is
  not yet produced (pointing at this report).

This is **message-only**: control flow is unchanged, so no accepted program
changes and no error count moves. It fires on the real
`strip_from_match_ascii` case and on the minimal repro, and — verified — does
**not** fire on `nonmatching-with-hir.llbc`, whose mixed group is a genuine
*user* trait impl (`Interval<char> for ClassUnicodeRange`) recursive with
functions (the real general hard case).

Termination story of the eventual output: `partial_fixpoint` for the whole
mutual block (as in §3.2), matching what Aeneas already emits for opaque
recursion elsewhere.

## 6. Validation

### 6.1 Aeneas test suite

`make test` — **exit 0**, no failures. `make format` applied; two unrelated
files it also reflowed (`InterpExpressions.ml`, `InterpStatements.ml`) were
reverted, keeping only my `Interp.ml` formatting.

Committed test-output changes (all consequences of my single `Interp.ml` edit):

- `tests/src/mixed_group_recursion.lean.out` — now contains the closure-specific
  note (the intended improvement; this test already exercised the pattern).
- `tests/src/borrow-check-negative.borrow-check.out`,
  `tests/src/loops-borrow-check-negative.borrow-check.out` — only a
  `Compiler source: interp/Interp.ml, line …` shift (now `680`), because my
  ~70 added lines pushed a later error site down. No semantic change.

### 6.2 Four llbc inputs (base `mantas-ripgrep` @ `af5a7731`)

Because the change is message-only (no control-flow change), "before" and
"after" are identical; both are shown against the current base. `sorry` counts
the `\bsorry\b` occurrences in the emitted `C/*.lean` (files are UTF-8 with
non-ASCII, so grep must be told to treat them as text: `grep -a`).

| llbc input | errors before | errors after | sorry before | sorry after | uncaught | lean files | golden byte-compare |
|---|---|---|---|---|---|---|---|
| `nonmatching-with-hir.llbc` | 20 | **20** | 6 | **6** | 0 / 0 | 4 | — |
| `grep-regex-full.llbc` | 14 | **14** | 3 | **3** | 0 / 0 | 4 | — |
| `grep-matcher.llbc` | 0 | **0** | 0 | **0** | 0 / 0 | 4 | **IDENTICAL** to `golden-grep-matcher/` |
| `nonmatching-clean.llbc` | 0 | **0** | 0 | **0** | 0 / 0 | 4 | **IDENTICAL** to `spike-nonmatching/C/` |

Counts are intentionally flat (message-only change). The value is the accurate
diagnostic on the real `strip_from_match_ascii` case plus the strengthened oracle.

**`sorry` did NOT leak into the SCC (checked explicitly).** The 3 `sorry` holes
in `grep-regex-full` are `ast.AstAnalysis.impl.any_literal`,
`literal.Extractor.extract_alternation`, `literal.Extractor.extract_repetition`
— none is in the closure SCC. `strip_from_match_ascii` and its recursive
closures (`closure#2`/`closure#3`) are **not** emitted as `sorry` bodies:
`grep -a '^def .*strip_from_match_ascii' Funs.lean` returns nothing — the
function is rejected loudly (a `[Error]`), exactly as intended. Only the
unrelated non-recursive `closure#1` (`.filter(|b| …)`) `call_mut` is emitted,
which is correct. So the fix does not convert a loud error into a silent hole.

### 6.3 Drop / soundness reasoning

Not applicable in the "did I change codegen" sense — I changed no transformation,
so no drop, backward-function, or ordering behaviour changed. For the *eventual*
fix, the soundness concern is different from the outer-loop task: there is no
drop-duplication hazard here (closures own their captured state); the hazard is
**wrong models from mis-inlined dictionaries** if step-3 inlining is done
imprecisely (e.g. inlining a dictionary that is *also* referenced from outside
the SCC). That is exactly why step 3 needs full validation against the existing
closure corpus before it can land.

## 7. What I deliberately did NOT attempt, and why

- **The dictionary-inlining transformation itself** (step 3 of §4). It is the
  crux, it lives in the `extract/` files another agent is editing, and it has a
  large validation surface (every existing closure extraction). Landing it
  half-validated risks silently wrong Lean — worse than an honest error.
- **Touching `Translate.ml`/`FunsAnalysis.ml` rejection sites.** Relaxing them is
  only meaningful once step 3 exists; doing so earlier would let a
  known-miscompiling group through. I left all three as honest errors.
- **`nonmatching-with-hir.llbc`'s mixed group** — it is a genuine *user* trait
  impl recursive with functions (the general hard case), not a closure group; my
  classifier correctly excludes it and I did not chase it.
- **Anything name-keyed** on `strip_from_match_ascii`, `Utf8Sequences`, etc.

## 8. What I did NOT validate

- I did not build the Aeneas Lean library (`lake build` is banned for iteration
  and ~30+ min); the target-shape evidence uses standalone Lean files with a
  faithful minimal model of `Result`/`FnMut`/`FnOnce` rather than the real
  library. The structural claims tested (mutual/`partial_fixpoint` placement,
  forward references, mixing rules) are Lean-elaborator properties independent of
  the library, so this is sound evidence, but it is a model, not the real
  extracted file (which cannot be produced today).
- I did not measure whether inlining would change any *existing* golden output
  (there is no implementation to measure).
- Coq/F*/HOL4 backends: out of scope; the analysis is Lean-specific.
