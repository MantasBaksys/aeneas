# Report — Non-local control flow out of nested loops

Branch: `fix/outer-loop-control-flow`, rebased onto `mantas-ripgrep` @ `ea7aeef6`
(the `fix/static-loans-traits` merge, which generalized the `replace_static`
pre-pass; originally branched from `9a81fa43`).
Compiler source touched: **`src/PrePasses.ml`** only.
charon: `/workspaces/charon-fnmut` @ `f4bf9ed0` (symlink left untouched).

This report covers the defect where Rust `break 'label` / `continue 'label` /
early `return` from inside a nested loop (LLBC `Break i` / `Continue i` with
`i > 0`, or a `Return` inside a loop body) is rejected by Aeneas.

**TL;DR.** After a deep investigation — including generating and reading the
actual LLBC for every pattern, and empirically validating the target encoding —
I conclude that a *sound* general (or even partial) transformation is an
architecturally deep change that must reconcile per-exit `storage_dead`
liveness, and that shipping a naive version would produce exactly the
"wrong drops / wrong backward functions" the task warns against. I therefore
**did not ship a code transformation**. Instead I landed:

1. **Precise, honest diagnostics** for all four rejection sites in
   `PrePasses.update_loops` (previously terse and, in one case, actively
   misleading), each naming the exact unsupported construct and the encoding it
   would require.
2. **Five regression tests** under `tests/src/` — four `known-failure` oracles
   that pin the current honest errors (one per pattern), plus one **positive**
   test whose manual flag-threaded encodings translate cleanly *today* and
   document the exact shape a future automatic fix must produce.
3. This design proposal, which engages with and **refines** the prior agent's
   double-drop finding using concrete new LLBC evidence, and gives a concrete,
   implementable algorithm.

This is the "STOP and write a design proposal" outcome the task explicitly
blesses, backed by real, safe, tested code.

---

## 1. Root cause and why the restriction exists

Aeneas translates **each loop into an isolated recursive function** (see the
generated `f_loop` / `f_loop.body` shape). The symbolic interpreter
(`src/interp/InterpLoops.ml`) supports only control flow that stays within the
**innermost** loop:

- `eval_after_loop_iter` hard-asserts `i = 0` for both `Break i` and
  `Continue i` ("Nested loops are not supported yet", `InterpLoops.ml:182,310`),
  and `craise`s "Unexpected return" if a loop body evaluates to `Return`.
- A loop's only channel to its enclosing context is its **break value**
  (`SA.LoopBreak`), computed from a fixed point over the loop body. There is no
  channel for "this inner loop wants to break/continue/return an *outer* loop".

Because the interpreter cannot express cross-loop exits, all such exits **must**
be eliminated earlier, in the `PrePasses.update_loops` pass. That pass already
performs three sound rewrites (transformations 1/2/3 in its doc comment):

- **T1** — a loop with returns but *no* breaks: replace `return` → `break`, put
  a fresh `return` after the loop (the old after-code becomes dead). Sound
  because the loop has exactly one exit path.
- **T2/T3** — a loop with *both* breaks and an early return, **directly followed
  by the function's `return`/panic**: keep the early return's own cleanup, turn
  it into `break`; move the function tail onto the normal-exit break path; unify
  at a single post-loop `return`.

Everything else is rejected:

| Site (`PrePasses.ml`) | Construct | Old message |
|---|---|---|
| `decompose_after []` (~586) | early return in a loop **not** directly followed by return/panic | "Early returns inside of loops are not supported yet" |
| `replace` Break (~608) | `break i`, i>0, inside T2/T3 | "Breaks to outer loops are not supported yet" |
| `visit_Break` (~662) | `break i`, i>0 | "Breaks to outer loops are not supported yet" |
| `visit_Continue` (~671) | `continue i`, i>0 | "Continue to outer loops are not supported yet" |
| `visit_statement` Return (~683) | `return` at loop depth ≥ 2 | "Returns inside of nested loops are not supported yet" |

The first message is actively **misleading**: early returns in simple loops
*are* supported (via T2/T3); the real precondition is "directly followed by the
function's return/panic".

### Engaging with the prior double-drop finding

The prior report (`REPORT-regex-syntax-hir-extraction.md`, Defect #1) correctly
identified that a **naive** rewrite is unsound because `StorageDead` evaluates to
`drop_value` (`InterpStatements.ml:942`), so relocating/duplicating a loop tail
can double-drop dead locals. I confirm this and **refine** it with LLBC evidence.

Reading the actual LLBC Charon emits (via `charon --print-built-llbc`, since
Aeneas's own `-print-llbc` crashes on these inputs) shows two facts the naive
analysis under- and over-stated:

1. **The deep exit site already carries *full* cleanup.** At an early `return`
   inside nested loops, Charon emits `storage_dead` for **every** in-scope local
   — inner-loop locals, outer-loop locals, *and* function locals — immediately
   before the `return`. So the return is a self-contained, fully-cleaning exit.
   The hazard is therefore **not** "the exit site forgets to drop"; it is that
   any transformation which lets the *intervening loop tails* also run will
   **double-drop** the locals the exit already dropped.

2. **The real obstacle is per-exit `storage_dead` liveness, exposed through the
   loop-break *join*.** A sound encoding (below) must NOT keep the deep exit's
   full cleanup before the synthetic `break`, because Aeneas **joins** the
   break contexts of all break sites of a loop. If the early-exit break drops an
   *external* local (e.g. `total`) to `⊥` while the normal-exit break keeps it
   live, the join yields a "maybe-⊥" value; the enclosing code that legitimately
   reads `total` on the normal path is then reading a possibly-`⊥` value →
   Aeneas errors (or, worse, silently produces a wrong backward function).
   Conversely, if the break drops *nothing*, inner-loop locals (e.g. the loop
   variable `x`, a shared/mut borrow) leak live into the break context and are
   never dropped. So the transformation must **partition** the exit's cleanup:
   drop exactly the locals scoped *inside* the loop being broken, and leave the
   locals live *outside* it untouched so the post-loop code drops them uniformly
   on all paths. This liveness partition, keyed on `StorageLive`/`StorageDead`
   scope, is the deep part — and it is exactly the coupling that made the
   interpreter restrict itself to innermost loops.

---

## 2. Empirical validation of the sound target (why I trust the design)

I reproduced each pattern minimally and confirmed the diagnostics
(`scratch/repro/`), then hand-wrote the **flag-threaded** ("state-machine")
equivalents and confirmed they translate cleanly, *including the mutable-borrow
case* that stresses backward-function synthesis. Two representative results:

- Index-based early-return-in-branch → a loop body returning
  `ControlFlow (U32 × U32) (U32 × Option U32)`; the enclosing function does
  `let (total, ret) ← g_loop …; match ret with | none => … | some r => …`.
- `&mut Vec<U32>` with early return → `pop` threaded correctly, backward value
  `v` reconstructed on every path. Clean Lean, no `sorry`.

These encodings are captured as the **positive** regression test
`tests/src/loops-flag-threaded.rs` (generates `tests/lean/LoopsFlagThreaded.lean`).
They prove the target shape is expressible and that Aeneas handles it — the open
problem is *synthesising* it in LLBC with the correct cleanup partition.

---

## 3. Exactly which subset I handled, and how the rest now fails

**Handled (unchanged, still sound):** the pre-existing T1/T2/T3 rewrites — an
early `return` from a single loop that is directly followed by the function's
`return`/panic. No new *accepting* behaviour was added.

**Rejected, now with precise/actionable errors** (no miscompilation):

| Pattern | Test | New message (abridged) |
|---|---|---|
| `return` in loop nested ≥ 2 deep | `loops-early-return-nested` | "Early returns out of nested loops are not supported yet …" |
| `return` in a loop not directly followed by return/panic (e.g. loop in `if`/`match`) — the `ban::check` shape | `loops-early-return-in-branch` | "Early returns out of loops are not supported yet … not directly followed by the function's return …" |
| `break i`, i>0 (labelled `break 'outer`) | `loops-break-outer` | "Breaks to outer loops are not supported yet …" |
| `continue i`, i>0 (labelled `continue 'outer`) | `loops-continue-outer` | "Continues to outer loops are not supported yet …" |

The two real call sites now report accurately:
- `regex_syntax::utf8::Utf8Sequences::next` → "Continues to outer loops …"
  (`continue 'TOP`).
- `grep_regex::ban::check` → "Early returns out of loops … not directly followed
  by the function's return" (the loop-in-branch shape).

All messages are keyed **purely on structure** (loop depth, `break`/`continue`
index, presence of a trailing return/panic). No function/type name is matched.

---

## 4. Soundness argument regarding drops

Because I ship **no transformation**, no new drop behaviour is introduced:
- The four rejection sites remain `craise`/`cassert` (only their *message
  strings* changed). Rejected functions have their body ignored, exactly as
  before — zero risk of double/omitted drops.
- The pre-existing T1/T2/T3 paths are byte-for-byte unchanged in behaviour,
  proven by the goldens below staying **identical**.
- The positive test relies only on Charon-emitted drops for ordinary Rust; no
  Aeneas drop logic is exercised differently.

---

## 5. Before/after validation (all four llbc inputs)

Measured with the final binary; ANSI stripped before counting.

| llbc input | errors before | errors after | uncaught before/after | lean files | golden byte-compare |
|---|---|---|---|---|---|
| `nonmatching-with-hir.llbc` | 20 | **20** | 0 / 0 | 4 | — |
| `grep-regex-full.llbc` | 35 | **35** | 0 / 0 | 4 | — |
| `grep-matcher.llbc` | 0 | **0** | 0 / 0 | 4 | **IDENTICAL** to `golden-grep-matcher/` |
| `nonmatching-clean.llbc` | 0 | **0** | 0 / 0 | 4 | **IDENTICAL** to `spike-nonmatching/C/` |

Counts are intentionally flat: the change only rewords error messages, so no
error appears or disappears. The value is (a) accurate diagnostics at the two
real call sites and (b) the regression oracles. **Aeneas's own test suite passes
(`make test`, exit 0)**; the only tracked files modified are `src/PrePasses.ml`
and `tests/lean/lakefile.lean`; no existing generated output changed.

Note on the `ea7aeef6` rebase (`fix/static-loans-traits`, which generalized
`replace_static` to all top-level functions and trait methods): this does **not**
affect the LLBC shape `update_loops` observes. `update_loops` runs inside the
per-function `function_passes` fold (`apply_passes`), whereas `replace_static`
is a later whole-crate pass invoked *after* that fold completes — so
`replace_static` is strictly downstream of my loop code and cannot change its
input. The `grep-regex-full.llbc` baseline dropped 42 → 35 on this base (the
`&'static Location` / `#[track_caller]` `Unreachable` bucket resolved by that
merge — unrelated to this task); the two target call sites still fail
identically.

---

## 6. Concrete design for the real fix (actionable)

A sound automatic transformation lives in `PrePasses.update_loops` and mirrors
the validated flag-threaded shape. For the **`return`-out-of-loops** subset
(the highest-value, borrow-light case — `ban::check`, and the return parts of
`Utf8Sequences::next`):

1. **Detect** functions with a `Return` inside ≥ 1 loop that T1/T2/T3 cannot
   handle.
2. **Introduce** a fresh option-typed local `__exit : Option <ret_ty>` (carrying
   the return value; using an `Option` rather than a bare bool avoids the
   "external local dropped to ⊥" join problem — the value rides in `__exit`,
   external locals stay live).
3. **At each early-return site**: set `__exit = Some <_0-value>`; **drop only the
   locals whose `StorageLive` is inside the innermost enclosing loop** (compute
   this scope set from the body's `StorageLive`/`StorageDead`); then `break 0`.
   Do **not** run the return's cleanup for locals live outside that loop.
4. **After each enclosing loop** (innermost-out), insert
   `if __exit.is_some() { break 0 } else { <original loop tail> }`, so the exit
   propagates one level per loop without running intervening tails.
5. **After the outermost enclosing loop**, `match __exit { Some r => <return r> |
   None => <original after-code> }`.
6. Thread `__exit` as a loop input/output at every level and give it correct
   `StorageLive`/`StorageDead`.

`break i` / `continue i` (i>0) generalise this: `break i` uses the same `__exit`
flag but with the "done" case propagated `i` levels; `continue i` needs the flag
checked *before* the outer loop's back-edge so the outer body is skipped and the
outer condition re-evaluated. Each requires the **same** loop-scope cleanup
partition (step 3), which is the crux to implement and test.

**Validation gate for whoever implements this:** the five tests in this branch.
The four `known-failure` files must flip to `Normal` and their generated Lean
must match the hand-written encodings in `loops-flag-threaded.rs` (same
`ControlFlow` shape, same backward functions), and `grep-matcher` /
`nonmatching-clean` must stay byte-identical to their goldens.

---

## 7. What I deliberately did NOT attempt, and why

- **The interpreter-level fix** (threading a `Return`/`Break i`/`Continue i`
  exit kind through the fixed-point and backward-function synthesis in
  `InterpLoops.ml`). This is the deepest option and touches the most fragile
  machinery; out of scope and higher-risk than the PrePasses encoding.
- **The PrePasses flag-threading transformation itself.** It is implementable
  (Section 6) but requires the loop-scope cleanup **partition** to be correct on
  every path, and getting it wrong yields precisely the wrong drops / wrong
  backward functions the task warns are "far worse than an honest error". Doing
  it responsibly needs per-pattern inspection of generated Lean (including
  mutable-borrow backward functions) across many drop shapes — more validation
  surface than can be discharged safely here. Per the task's explicit guidance,
  I stopped at a validated design rather than shipping a risky rewrite.
- **The other blockers on `nonmatching-with-hir.llbc`** (MaybeUninit/union
  support, the `case_fold_simple` loop fixed-point failure, the `debug::Byte`
  aggregate, Iterator-HRTB / mixed-group families). Not this task; my change
  neither fixes nor newly exposes them (counts unchanged at 20/35).

## Honest limitations
- No end-to-end `lake build` was run (out of scope, per the compiler-dev skill's
  "never lake clean/build for iteration"); the positive test is validated only
  to the extent Aeneas's own test runner validates it (successful extraction, no
  `sorry`, no error).
- The `known-failure` oracles pin the *current* honest errors, not a fix — by
  design, they are the gate for the future implementation.

## Files changed
- `src/PrePasses.ml` — reworded 5 rejection messages (behaviour otherwise
  unchanged).
- `tests/src/loops-early-return-nested.rs` (+`.lean.out`)
- `tests/src/loops-early-return-in-branch.rs` (+`.lean.out`)
- `tests/src/loops-break-outer.rs` (+`.lean.out`)
- `tests/src/loops-continue-outer.rs` (+`.lean.out`)
- `tests/src/loops-flag-threaded.rs` (+`tests/lean/LoopsFlagThreaded.lean`)
- `tests/lean/lakefile.lean` — added `LoopsFlagThreaded` lean_lib.
