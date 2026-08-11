# Ended shared loan over borrow/loan-containing values — report

Branch: `fix/ended-shared-loan-borrows` (off `fix/loop-nonlocal-exit-tail-duplication`, base `a76b1b04`)
Worktree: `/workspaces/aeneas-sharedloan`
Commit built and gated: **`957d9429212aee419a17da760c86dca1650ee95e`**
Files changed: `src/interp/InterpJoinCore.ml`, `src/interp/InterpMatchCtxs.ml`, plus a Lean
regression test (`tests/src/loop_ended_shared_loan_borrows.rs`,
`tests/lean/LoopEndedSharedLoanBorrows.lean`) and its lakefile registration.
`backends/` untouched.

## TL;DR

I took **avenue (a): the interpreter fix**. I implemented proper handling of
`AEndedSharedLoan (sv, child)` when the ended shared value `sv` still contains
loans/borrows, at the two interpreter sites that previously bailed with "Not
implemented yet" / "Could not match the contexts":

1. `compute_abs_borrows_loans_maps` (`InterpMatchCtxs.ml`) — now **registers**
   the loans/borrows nested in the ended shared value into the abstraction
   borrow/loan maps, instead of asserting they are absent.
2. the context matcher `match_tavalues` (`InterpMatchCtxs.ml`) — now has a case
   for two `AEndedSharedLoan`s (new `match_aended_shared_loans` primitive on the
   `PrimMatcher` interface), instead of falling through to `Distinct`.

The key soundness lever is an **invariant I verified across the whole
interpreter**: an `AEndedSharedLoan` is *only ever* produced from an
`ASharedLoan` whose projection marker is `PNone` (every ending site asserts
`pm = PNone`). So the ended shared value must be explored/rebuilt with the
`PNone` marker — exactly mirroring the live `ASharedLoan` treatment. The fix is
therefore not a special case: it makes ended shared loans behave like their live
counterparts.

Result: the target defect (`InterpMatchCtxs.ml:201`) is **retired by
implementation** (not by weakening a guard), `ban.rs::check` now fully
translates, and the whole `grep-regex` extraction drops to **1 error** — only
the unrelated `literal.rs` / `InterpReduceCollapse.ml:1137` defect owned by
someone else. All six gates pass with **zero drift**.

---

## 1. Root cause

The failing assertion was `InterpMatchCtxs.ml` ~201, inside
`compute_abs_borrows_loans_maps`:

```ocaml
| AEndedSharedLoan (sv, child) ->
    (* TODO: ... we need the marker which was in [ASharedLoan] ... *)
    [%cassert] span
      (not (tvalue_has_loans_or_borrows (Some span) ctx sv))
      "Not implemented yet";
    self#visit_tavalue (abs, pm) child
```

`compute_abs_borrows_loans_maps` walks every fresh region abstraction and builds
maps (`abs_to_loans`, `loan_to_abs`, `abs_to_borrows`, …) recording which
borrows/loans each abstraction owns. Those maps drive the reduce/collapse
**merge policy** in `InterpReduceCollapse.ml` (two abstractions get merged when a
borrow id in one matches a loan id in another). The `AEndedSharedLoan` branch
asserted the ended shared value had no loans/borrows, i.e. it refused to register
anything nested in it.

For ripgrep's `ban.rs::check` the scrutinee is `*expr.kind()` — a shared
**reborrow** through a method returning `&HirKind` over the recursive `Hir`
type whose `Concat`/`Alt` variants hold `Vec<Hir>`. I reproduced the exact
failing value (debug dump, `-log InterpMatchCtxs`) with a minimal crate:

```
AEndedSharedLoan sv = Hk::Concat (SL@3(s@7 : Vec<Hh>))
  pm = PNone
  abs = abs@1{regions={1},endable} {
          SB@0(^1),
          @ended_shared_loan(Hk::Concat (SL@3(s@7 : Vec<Hh>)), _)
        }⟦(_ : &'1 Hh) := FunCall(abs_id@1)[((_ : &'1 Hk))]⟧
```

So the ended shared value nests a **shared loan** `SL@3` (the loan the slice
iterator holds), and `pm = PNone`. `SL@3`'s matching shared borrow `SB@3` lives
in a *different* abstraction (`abs@3`), so this is a genuine live loan/borrow
relationship the maps must record. Refusing to register it is why the honest
guard fired.

Why the reborrow is the trigger (confirmed by the previous agent and re-verified
here): `e13` (`match expr.kind`, direct field, no reborrow) passes; `e14`
(`match *expr.kind()`) fails; `e14b` (every arm ends in `return Ok(())`) passes
because Charon then builds a loop with no internal `return` and the shared loan
never ends inside the break-context join.

## 2. Phase 1 decision — (a) interpreter, with evidence

The task asked me to choose between (a) implementing the interpreter handling and
(b) a PrePasses refinement. **I chose (a).**

### Why not (b)

The previous agent already showed the natural (b) — making `decompose_after`
leave the borrow-carrying `storage_dead`s after the loop to mimic the `e14b`
shape — is **unsound**: it produced 4 × `SymbolicToPureCore.ml:520` "Could not
find var for symbolic value". Reason: the loop's abstraction fixed point is
synthesized *after* PrePasses; moving the `storage_dead`s past the loop leaves a
borrow live across the loop join in a way the fixed point was not built for,
dangling symbolic values. Charon can build the `e14b` shape coherently only
because it does so *before* loop reconstruction. Any post-Charon LLBC reorder
races the fixed-point synthesis. I did not find a materially different (b) that
avoids this, and (b) only ever hides the limitation behind a shape change rather
than supporting the feature. It also would not retire the underlying interpreter
assertion for other programs.

### Why (a) is the right, general fix

The `AEndedSharedLoan`-with-loans case is a *real, supportable* situation, not an
inconsistency: the ended shared value legitimately owns nested loans/borrows that
the maps and matcher must account for. Implementing it:

- retires the honest guard **by covering the missing case**, not by silencing it;
- is general/upstreamable (no ripgrep-specific logic — it keys purely off the
  value shape and the `PNone` invariant);
- is the same limitation flagged by the sibling assertion at `InterpAbs.ml:786`.

The risk with (a) was that it could cascade unboundedly through the join
machinery. I bounded it empirically: after fix #1 the failure moved exactly one
step (map computation → context matching), fix #2 closed that, and then the whole
crate went to 1 (unrelated) error with **zero test drift**. The cascade
terminated at two sites.

## 3. The invariant that makes the fix sound

`AEndedSharedLoan` stores no projection marker (`Values.ml:668`:
`AEndedSharedLoan of tvalue * tavalue`). The TODO worried we'd lost the
`ASharedLoan` marker. I verified we did **not** lose anything that matters: every
site that converts an `ASharedLoan` into an `AEndedSharedLoan` first asserts the
marker is `PNone`:

- `InterpBorrows.ml:1144-1149` — `[%sanity_check] span (pm = PNone)` immediately
  before `ALoan (AEndedSharedLoan (shared_value, child))`.
- `InterpBorrows.ml:2500-2506` — `[%sanity_check] span (pm = PNone)` immediately
  before `super#visit_AEndedSharedLoan () sv child`.

Every other `AEndedSharedLoan (...)` occurrence in the tree is a structural
pass-through reconstruction (`InterpBorrows.ml:176`, `InterpJoin.ml:1283`), which
preserves the marker-less/`PNone` nature. The debug dump independently showed
`pm = PNone` at the failing site.

Therefore the correct marker to explore/rebuild an ended shared value with is
`PNone`, which is exactly what the live `ASharedLoan` case uses for its `sv`
(`self#visit_tvalue (abs, npm) sv`, with `npm = PNone` here) and matches the
entry sanity check `pm = PNone` already present at the top of
`visit_aloan_content`.

## 4. The two changes

### 4.1 Register nested loans/borrows (`compute_abs_borrows_loans_maps`)

```ocaml
| AEndedSharedLoan (sv, child) ->
    (* ... shared value now behaves as a regular value that may contain
       borrows/loans; marker is always PNone at this point ... *)
    self#visit_tvalue (abs, PNone) sv;
    self#visit_tavalue (abs, pm) child
```

`self#visit_tvalue` reuses the visitor's existing overrides: a nested
`VSharedLoan` hits `visit_loan_id` → `register_loan_id`, so loan `SL@3` is
correctly added to `abs_to_loans`/`loan_to_abs` for the owning abstraction. This
is *more* complete than before, not less: previously a real loan owned by the
abstraction was omitted from the maps (the guard just prevented us reaching a
state where that omission could silently corrupt the merge policy). Registering
it is the sound, complete behaviour. (Concrete `VSharedBorrow`s inside `sv` would
reach the visitor's `visit_borrow_id = [%internal_error]` — but that boundary is
identical for the live `ASharedLoan` case and is pre-existing; the fix does not
widen or narrow it.)

### 4.2 Match two ended shared loans (`match_tavalues` + `PrimMatcher`)

The context matcher `MakeMatcher.match_tavalues` had no `AEndedSharedLoan` case,
so `try_match_ctxs` (used by `match_ctx_with_target`) fell through to
`match_avalues` → `Distinct` → "Could not match the contexts"
(`InterpJoin.ml:1671`). I added:

- a new `match_aended_shared_loans` value to the `PrimMatcher` module type
  (`InterpJoinCore.ml`), signature mirroring `match_ashared_loans` minus the
  (absent) marker and loan id;
- a dispatch case in `match_tavalues` that matches the shared value and child
  (`match_rec` / `match_arec`) and calls the primitive;
- the `MakeJoinMatcher` implementation is an `"Unreachable"` stub, consistent
  with every other a-loan primitive there (the join pre-destructures
  abstractions, so avalue-level loan matching is never reached during a join —
  I verified all sibling `match_a*loan*`/`match_a*borrow*` prims are identical
  stubs);
- the `MakeCheckEquivMatcher` implementation rebuilds
  `ALoan (AEndedSharedLoan (v, av))` from the already-matched shared value `v`
  and child `av` — the direct analogue of its `match_ashared_loans`, which
  rebuilds `ASharedLoan (PNone, bid, v, av)`. No marker/id to reconcile.

This is an equivalence check between the loop fixed-point context and the joined
context: both sides carry the *same* `@ended_shared_loan(...)` structure with the
same symbolic ids, so the match is structural and introduces no new values.

## 5. Gate evidence (all against committed `957d9429`)

### Gate 1 — `make build-dev` exit 0, no new warnings — PASS
Fresh build from the committed tree: exit 0. The only `Warning:` line is the
pre-existing `./charon is a symlink` notice (unrelated). No OCaml compiler
warnings.

### Gate 2 — repro2 `e2`/`e6`/`e7`/`e8`/`e13`/`e14`/`e14b` all clean — PASS
```
aeneas errors:   0
e2: 0  e6: 0  e7: 0  e8: 0  e13: 0  e14: 0  e14b: 0
```
The `e14` body is fully translated (no `sorry`): `e14`, `e14_loop`,
`e14_loop.body` with a `none => ok (done ...)` normal exit and an early
`ok (done (... .Err ...))` exit.

### Gate 3 — real `grep-regex` — PASS (1 error, the unrelated one)
```
$ cd /workspaces/rg-verify && AENEAS=/workspaces/aeneas-sharedloan OUT=/tmp/gr-sharedloan ./extract-regex.sh
charon exit=0  llbc=8.6M
aeneas exit=1
aeneas errors:    1
aeneas uncaught:  0
files emitted:    4

$ sed -r 's/\x1b\[[0-9;]*m//g' /tmp/gr-sharedloan/ae.log | grep -A2 '^\[Error\]'
[Error] Internal error, please file an issue
Source: 'crates/regex/src/literal.rs', lines 236:8-245:9
Compiler source: interp/InterpReduceCollapse.ml, line 1137
```
`ban.rs` references in the error stream: **0**. `ban::check` translates with a
full body (verified in `Funs.lean`). The single remaining error is the
`literal.rs` / `InterpReduceCollapse.ml:1137` defect explicitly out of scope. The
lone `sorry` in the emitted `Funs.lean` belongs to
`literal.Extractor.extract_alternation` (that same defect), not to `ban::check`.

### Gate 4 — `make test` exit 0, **zero drift** — PASS
`make test` completed (exit 0, cargo unit tests pass). `git status --porcelain
tests/` is **empty** — no committed `.lean`/`.fst` output changed, and the new
test files were already committed. An unsound interpreter change would most
likely have perturbed some existing loop/borrow translation here; none moved.

### Gate 5 — `git diff --stat backends/` empty — PASS
`git diff --stat a76b1b04 HEAD -- backends/` prints nothing.

### Gate 6 — regression test — PASS
New Lean-only test `tests/src/loop_ended_shared_loan_borrows.rs`
(`scan` over `Wrap`/`Kind`, using the `match *w.wkind()` reborrow scrutinee with
a `Vec<u8>` slice loop + early `return` + shared `Ok(())` tail), registered as
`LoopEndedSharedLoanBorrows` in `tests/lean/lakefile.lean`. (No type is named
`Tree`.)

- **Builds in Lean:** `lake build LoopEndedSharedLoanBorrows` →
  `✔ Built LoopEndedSharedLoanBorrows`, "Build completed successfully (1698
  jobs)". Generated file has no `sorry`.
- **Genuinely regresses on base:** reverting only the two interpreter files to
  `a76b1b04` and rebuilding, then `make test-loop_ended_shared_loan_borrows.rs`
  fails with:
  ```
  [Error] Not implemented yet
  Compiler source: interp/InterpMatchCtxs.ml, line 201
  ... compute_abs_borrows_loans_maps.object#visit_aloan_content ...
  ```
  i.e. exactly the target defect. Restored the fix and rebuilt afterward; tree
  clean.

I deliberately did **not** reuse the previous agent's `check_shape` test — it
uses `match *s` (direct deref, the `e13` shape) which passes even without this
fix. The reborrow scrutinee (`*w.wkind()`) is required to reach
`InterpMatchCtxs.ml:201`.

## 6. Scope, residual limitations, things I did not verify

- **Did not touch** the `literal.rs` / `InterpReduceCollapse.ml:1137` defect
  (out of scope, owned elsewhere), the `PrePasses.ml:988` guard, or any
  assertion other than the one I *implemented* the missing case for. No
  `[%cassert]`/`[%sanity_check]`/`[%craise]` was weakened into a silent
  fallthrough.
- **Sibling site `InterpAbs.ml:786`** (the merge `add_avalue` path) still carries
  the same `"Unimplemented"` assertion for `AEndedSharedLoan`-with-loans. It was
  **not reached** by `grep-regex` or by any test after my fix, so I left it as an
  honest guard rather than speculatively changing merge code I could not exercise
  (changing untested merge logic is exactly the kind of unsound-by-accident edit
  Gate 4 guards against). If a future program hits it, the same `PNone`-invariant
  reasoning and `add_avalue child` + register-nested pattern should apply, but I
  have **not** verified that and did not implement it.
- **`PrePasses.ml:988` guard.** This fix implements the interpreter feature the
  guard was protecting against, so in principle the guard could eventually be
  relaxed; I did **not** relax it (it still usefully rejects other unsupported
  non-local-exit-with-borrow shapes that this change does not cover, e.g. cases
  routed through `InterpAbs.ml:786`). Retiring it safely needs its own
  investigation and is out of scope here.
- **Concrete borrows inside an ended shared value** (`VSharedBorrow`/`VMutBorrow`
  directly in `sv`) would hit the pre-existing `visit_borrow_id = internal_error`
  in the map visitor, exactly as they would for a live `ASharedLoan`. I did not
  encounter this and did not change that boundary.
- The join-matcher `match_aended_shared_loans` is an `Unreachable` stub by
  construction (join pre-destructures abstractions). I verified this matches all
  sibling a-loan prims but did not construct an adversarial input that would
  reach it; if one ever does, it raises a recoverable error rather than
  miscompiling.
