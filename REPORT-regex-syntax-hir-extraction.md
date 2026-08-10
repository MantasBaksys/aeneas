# Report — Aeneas compiler defects blocking `regex-syntax` HIR extraction

Branch: `fix/regex-syntax-hir-extraction`, **rebased onto the cascade fix**
`fix/mixed-decl-groups-cascade` @ `0cd375f0` (itself based on `26baea75`).
Input under test: `/workspaces/rg-verify/llbc/nonmatching-with-hir.llbc`.
Control: `nonmatching-clean.llbc` (0 errors, regex-syntax opaque).

This branch fixes Aeneas (OCaml) translation defects only — no Lean proof work.

## Environment correction (important)

Numbers in this report were **re-baselined** after two environment fixes:

1. **charon symlink repointed.** `./charon` pointed at the stale
   `/workspaces/aeneas/charon` @ `cb50ff16`; the campaign's charon is
   `/workspaces/charon-fnmut` @ `f4bf9ed0` ("NameMatcher: disambiguate extraction
   names of monomorphized items"), which is `cb50ff16` + exactly that one commit.
   charon-ml is linked into the aeneas binary, so building against the stale
   charon collapses `FnMut` trait-decl names and produces 8 phantom "Name clash"
   errors. `charon-pin` was **not** modified.
2. **Rebased onto the landed cascade fix.** The 63+2 "mixed declaration groups"
   cascade is now genuinely gone; the crate emits Lean files instead of dying with
   an uncaught exception.

With both corrections, `nonmatching-with-hir.llbc` sits at **20 total errors**
(was 70), no uncaught exception, all 4 Lean files emitted.

## Scope reminder

Of the residual **20** errors, most belong to the cascade family, the
Iterator-HRTB family, and other independent root causes that are **nobody's
current task**. Three distinct defects were assigned to me. This report tracks
*my* three and reports their status as **"my defects: 3 → 2"** separately from the
total.

---

## Defect #3 — `Assertion failed: new value doesn't have the same type as its destination`  — **FIXED**

Original span: `/rustc/.../core/src/slice/iter.rs:23` inside
`{impl Interval<char> for ClassUnicodeRange}::case_fold_simple`.
Compiler source: `interp/InterpPaths.ml`.

### Root cause
In `InterpPaths.access_place` (the backward / write-back path), after computing
the region-erased type of the value being written back (`updated_ty`, produced by
`Substitute.erase_regions`), the sanity check compared it against `v.ty` — the
**non-region-erased** type of the value currently at the place. When the place's
type carried a live region constant (in practice `'static`, which is a region
*constant* and therefore is not eliminated by ordinary region inference), the two
types differed *only by region erasure*, and the check spuriously failed. It
should compare like-with-like: both region-erased.

### Fix
`src/interp/InterpPaths.ml`: compare against the already-region-erased `v_ty`
instead of the raw `v.ty`.

### Follow-on defect (same root theme) — also FIXED
Removing the assertion unmasked `The input arguments don't have the proper type`
(`interp/InterpStatements.ml:1583`), where a call argument of type
`&'static [char]` failed the check `erase_regions arg.ty = erase_regions rty`
against a parameter of type `&'_ [char]`.

Root cause: **`Charon.Substitute.erase_regions` only rewrites `RVar`** (via
`visit_RVar`) and leaves `RStatic` intact, so "erasing" a `&'static _` type does
*not* actually erase the `'static`. Aeneas's own `Contexts.erase_regions` already
uses a catch-all `visit_region` that erases *every* region including `RStatic` —
the two were inconsistent.

Fix: `src/llbc/Substitute.ml` shadows `erase_regions` with a full-region visitor
(`region_erasing_visitor`, `visit_region _ _ = RErased`), making aeneas's
`Substitute.erase_regions` consistent with `Contexts.erase_regions`.

**Important constraint (documented in the code):** `erase_regions_substitute_types`
is deliberately **not** shadowed. `InterpStatements.eval_global_as_fresh_symbolic_value`
pattern-matches on `TRef (RStatic, ...)` *after* calling it; fully erasing `RStatic`
there regresses `static.rs` (Internal error at `InterpStatements.ml:778`). Only the
plain `erase_regions` is made fully-erasing.

### Verification (re-baselined on the corrected charon + cascade fix)
With the cascade fixed, `case_fold_simple` is now **reachable** (it is no longer
inside a cascade-blocked mixed-recursive group). On `nonmatching-with-hir.llbc`:

- **Attribution, proven by reverting only my two files against the rebased base**
  (`0cd375f0`) and rebuilding:
  - *Without* my fix: `new value doesn't have the same type` = **1**, and reverting
    the erase shadow alone makes the follow-on `don't have the proper type`
    reappear = **1**.
  - *With* my fix: both strings drop to **0**.
- **Both halves of the fix are load-bearing.** I confirmed empirically that the
  `InterpPaths` change alone removes the assertion but leaves the follow-on
  `proper type` error (case_fold_simple stops there); adding the `erase_regions`
  shadow removes that too, letting the function advance further.
- `case_fold_simple`, now past both of my errors, hits an **independent** blocker
  (`Could not compute a loop fixed point in 2 iterations`,
  `interp/InterpLoopsFixedPoint.ml:158`, at `hir/mod.rs:1290`) which is **not one
  of my three defects** and is nobody's current task.
- **No regressions** on the validation loop (see the dedicated section below):
  `grep-matcher.llbc` and `nonmatching-clean.llbc` stay at 0 errors and are
  **byte-identical** to their goldens; `grep-regex-full.llbc` stays at 42.
  Standard suite spot-checks (`loops`, `static`, `traits` across all backends)
  regenerate with no diff and no name clashes.

Commit: `cff0da0b`.

---

## Defect #2 — `Unexpected error` at the `vec!` macro — **ROOT-CAUSED + DIAGNOSTICS FIXED; underlying support gap is a design proposal**

Original span: `/rustc/.../alloc/src/macros.rs:59` (the `vec!` macro) inside
`regex_syntax::utf8::{Utf8Sequences}::new`.
Compiler source: `llbc/Substitute.ml`.

### Root cause
`Substitute.type_decl_get_instantiated_variants_fields_types` wrapped **any**
`Failure` raised by Charon's substitution in a bare `[%craise] span "Unexpected error"`,
discarding the real message. Surfacing that message reveals:

> `Can't retrieve the variants of non-adt type: core::mem::maybe_uninit::MaybeUninit`

The failing call originates in `cast_unsize_to_modified_fields`
(`interp/InterpExpressions.ml`), the **unsizing-cast** handler
(`Box<[T; N]> → Box<[T]>`), which recurses into a struct's fields to locate the
unsized tail field. Under the aggressive extraction flags used for this `.llbc`
(`--monomorphize-mut=except-types --remove-adt-clauses --lift-associated-types='*'`),
`vec![r]` pulls `Vec`'s internals in **concretely**, including
`MaybeUninit<Utf8Sequence>`. `MaybeUninit` is a **`union`**, and Aeneas does not
support unions (`TypesAnalysis.ml:527`, `SymbolicToPureTypes.ml:279` → Opaque), so
it arrives as an **opaque** ADT with no retrievable fields — hence the failure when
the unsize-cast logic asks for its fields.

### Fix (clean, general, exercised)
`src/llbc/Substitute.ml`: the catch-all now appends the underlying `Failure`
message — `"Unexpected error: " ^ msg` — instead of hiding it. This is general
(helps *any* masked `Failure`, not just this one) and turns an undebuggable
catch-all into an actionable diagnostic. Confirmed on `nonmatching-with-hir.llbc`:
the error now reads `Unexpected error: Can't retrieve the variants of non-adt
type: ... MaybeUninit` instead of a bare `Unexpected error`.

Commit: `a9f888fb`.

### Why the underlying gap is *not* fixed here (design proposal)
Making `Utf8Sequences::new` actually translate requires one of:

1. **Keep `Vec`/`MaybeUninit` opaque at extraction time.** The concrete
   `MaybeUninit` only appears because the monomorphization/`--remove-adt-clauses`
   flags dig into `Vec`'s guts. Adding `--opaque` for `alloc::vec::*` internals (or
   not monomorphizing `Vec`'s allocation path) keeps `vec!` as a builtin and
   sidesteps the union entirely. This is an **extraction-configuration** change,
   not a compiler change, and is the lowest-risk path.
2. **Add real union support to Aeneas.** This is a deep, cross-cutting change
   (type analysis, symbolic expansion, pure translation, every backend's type
   emission) and well out of scope for this task.

Recommendation: option 1 (extraction config) for the immediate campaign; option 2
only if unions become a recurring need. I did **not** speculatively implement
either, per the "stop and propose rather than rewrite" guidance.

---

## Defect #1 — `Continue to outer loops are not supported yet` — **DIAGNOSED; deep change → design proposal**

Span: `regex-syntax-0.8.11/src/utf8.rs:339` inside
`{impl Iterator<Utf8Sequence> for Utf8Sequences}::next`.
Compiler source: `PrePasses.ml` (`update_loops`), enforced again in
`interp/InterpLoops.ml`.

### Root cause / architecture
Aeneas translates **each loop into an isolated recursive function** and the
symbolic interpreter supports **only innermost-loop control flow**: `Break 0` /
`Continue 0`. `InterpLoops.ml` hard-asserts `i = 0` for both `Break i` and
`Continue i` ("Nested loops are not supported yet"), so any elimination of
multi-level break/continue **must** happen earlier, in the `PrePasses.update_loops`
pass. That pass currently:
- lifts early **returns** out of single-level loops (transformations 1/2/3), but
- **hard-rejects** every `Break i` / `Continue i` with `i ≥ 1`
  (`[%cassert] span (i = 0)` at the `visit_Break` / `visit_Continue` methods).

The real `Utf8Sequences::next`, dumped from LLBC, has **four** nested loops and a
mix of `continue 1`, `break 1`, and `break 2` — i.e. genuine multi-level control
flow, not a single idiomatic `continue 'outer`.

### Why a general fix is a deep change
I examined the tractable-looking sub-case — a tail-position `continue 'outer`
(`'outer: loop { loop { …; continue 'outer } }` with nothing effectful after the
inner loop). On paper `continue 1` → `break 0` looks sound. But inspecting the
actual LLBC Aeneas produces (see the minimal `count` example I built), the inner
loop's `continue 1` path executes its own `storage_dead(j)` etc., **while the
outer body after the inner loop also runs `storage_dead(_11/_10/_9/j)` then the
outer back-edge `continue 0`.** Redirecting `continue 1` to `break 0` would then
re-run `storage_dead` on locals that are already dead — and `StorageDead`
evaluates to `drop_value` (`InterpStatements.ml:942`), so double-dropping is
**not** a no-op. The two exit paths of the inner loop require **different**
trailing cleanup, exactly the coupling that makes the interpreter restrict itself
to innermost loops in the first place.

A correct, general transformation therefore needs one of:
- **Flag threading**: introduce boolean "which level to exit/continue" flags,
  set at the break/continue site and checked after each inner loop returns, with
  the trailing cleanup guarded per-path; or
- **Loop restructuring / continuation duplication**: duplicate the tail of each
  enclosing loop so every exit becomes local — sound but risks code blow-up.

Both touch the loop-translation core and the fixed-point machinery. Per the task's
explicit guidance ("if the fix requires deep architectural change, STOP and write
a design proposal rather than attempting a speculative rewrite"), I did **not**
ship a partial transform that mishandles `storage_dead` liveness — that would be
worse than the current honest failure.

### Proposed design (concrete)
Add a new, structure-keyed sub-pass to `update_loops` that eliminates `Continue i`
/ `Break i` (`i ≥ 1`) **only** when provably sound, using the existing
depth-counter idiom (`visit_Loop (i+1)`, act only at `depth = 0` so nested loops
are skipped):

1. For a `Continue i` targeting enclosing loop `L`: verify that every loop between
   the continue and `L` is in **tail position** of its parent (the loop is the last
   *effectful* statement; all statements between it and the parent's back-edge are
   "transparent" — `StorageDead`/`StorageLive`/`Nop`/`PlaceMention`). If so, rewrite
   `Continue i` to `Break (i-1)` **and** reconcile cleanup by moving the required
   `storage_dead`s to the break site (mirroring the existing transformation-2/3
   "move `after` before the break" logic) so no local is dropped twice or left live.
2. For `Break i` (`i ≥ 1`): this exits `L` entirely, so the tail-position trick does
   not apply; handle it with the flag-threaded scheme above, or reject with a
   precise message when the flag scheme is not yet implemented.

The soundness predicate must be keyed purely on **structure** (tail position +
transparent-trailing), never on function/type names.

I could not produce a passing regression test for #1 because no fix is landed;
the reproduction is the minimal nested-loop `continue 'outer` function (kept in
my scratch notes) which reproduces the exact error.

---

## Before / after error counts (`nonmatching-with-hir.llbc`)

All numbers below use the **corrected charon** (`f4bf9ed0`) and are measured on the
**cascade-fixed base** (`0cd375f0`). ANSI stripped before counting.

| | total `[Error]` | uncaught exception | my three defects |
|---|---|---|---|
| stale-charon, pre-cascade (obsolete) | 70 | yes | as originally triaged |
| cascade base `0cd375f0` (my fixes reverted) | 20 | none | assertion **1** + follow-on `proper type` **1** + `Unexpected error` (bare) **1** + `Continue to outer` **1** |
| **this branch** | 20 | none | assertion **0**, follow-on `proper type` **0**; `Unexpected error` **now surfaces real cause**; `Continue to outer` **1** |

**My defects: 3 → 2.** Defect #3 (assertion) **and** its follow-on `proper type`
error are eliminated; defect #2's opaque error now surfaces its true root cause
(`MaybeUninit`); defect #1 (`Continue to outer`) remains (design proposal). The
total stays at 20 because `case_fold_simple`, freed of my two errors, advances to
an **independent** blocker (`Could not compute a loop fixed point`,
`interp/InterpLoopsFixedPoint.ml:158`) that is not one of my three defects — so the
count is net-flat even though a genuine defect was removed.

---

## Validation loop (not just the Aeneas test suite)

| llbc | expected | measured | golden byte-compare |
|---|---|---|---|
| `grep-matcher.llbc` | 0 errors | **0** | **identical** to `golden-grep-matcher/` |
| `nonmatching-clean.llbc` | 0 errors | **0** | **identical** to `spike-nonmatching/C/` |
| `grep-regex-full.llbc` | ≤ ~42 | **42** | (count target only) |
| `nonmatching-with-hir.llbc` | main target | **20** (my defects 3→2) | — |

Standard suite spot-checks (`loops`, `static`, `traits` across Lean/Coq/F*/borrow-check)
regenerate with **no diff** and no `FnMut` name clashes under the corrected charon.

---

## Secondary question — does `Hir` become a real Lean ADT?

**Files are now emitted** (all 4: `Types.lean`, `Funs.lean`, and the two
`*External_Template.lean`), because the cascade fix stopped the crate from dying.
However `Hir` is **not yet a real ADT**: the 20 residual errors still block full
translation of the `hir` module (the `case_fold_simple` loop-fixed-point issue, the
`Continue to outer` in `Utf8Sequences::next`, the `MaybeUninit`/`vec!` issue in
`Utf8Sequences::new`, plus Iterator-HRTB / mixed-recursive-group errors that are
nobody's current task). The former uncaught `Invalid_argument` on
`regex_syntax::debug::Byte` is now **contained** by the cascade branch as a clean
error (`Cannot evaluate an aggregate for the non-transparent type … Byte`), not a
crash — and it is not one of my defects. `Hir` will become a real inductive only
once the remaining independent root causes are addressed; I did not force it.

---

## Honest limitations / what I could NOT verify

- **No isolated regression test for #3.** Every minimal `&'static [T]` reproduction
  I built either does *not* trigger the bug (Rust inserts a fresh reborrow, e.g.
  `&TABLE` passed to a `&[_]` parameter — translates fine on both baseline and
  fixed binaries) or hits an **independent** latent `'static` gap that is not mine
  (`Unreachable` at `interp/InterpBorrowsCore.ml:644` for a `'static`-returning
  function, unsizing-to-`dyn` borrow errors). Broad `&'static` support in Aeneas is
  incomplete, so #3 cannot currently be isolated into a self-contained test that
  both fails pre-fix and fully translates post-fix. The fix is instead validated by
  (a) attribution via reverting only my two files on the rebased base (assertion +
  follow-on 1→0), (b) the validation-loop goldens staying byte-identical, and
  (c) suite spot-checks showing no regressions. This is an honest gap.
- **No end-to-end Lean check** was run (out of scope — no `lake build`), and the
  hir crate still does not extract to completion (independent residual errors).
- Disk was tight (~93% used) throughout; I confined all scratch to the gitignored
  `scratch/` in this worktree and touched no other `/workspaces/aeneas-*` tree, and
  did not modify `/workspaces/charon-fnmut` or `charon-pin`.

## Commits on this branch (post-rebase hashes)
- `cff0da0b` — Fix spurious type-mismatch errors from unerased `'static` regions (defect #3 + load-bearing follow-on).
- `a9f888fb` — Surface real cause behind `Unexpected error` in variant lookup (defect #2 diagnostics).
- (this report)
