# REPORT — triage of the 6 never-examined `grep-regex-full` errors (`fix/untriaged-interp`)

Branch: `fix/untriaged-interp`, based on `mantas-ripgrep` @ `7da47094`.
`./charon` → `/workspaces/charon-fnmut` (untouched).

## TL;DR

Of the 6 in-scope errors, **2 were fixable and are fixed** (grep-regex-full
14 → **12** errors, `sorry` 3 → **1**), and **4 are the same root cause as
things already declined in this campaign** (the `strip_from_match_ascii`
closure-mixed-SCC I declined last task, plus one deep loop-collapse invariant).

| # | Site | Message | Source | Verdict |
|---|---|---|---|---|
| 1 | `interp/InterpJoin.ml:1542` | Could not match the contexts | literal.rs 285 | **FIXED** — cherry-picked `fcc481cd` |
| 2 | `interp/InterpExpressions.ml:1159` | Invalid inputs for binop | ban.rs 22:45 | **FIXED** — char comparison support |
| 3 | `interp/InterpReduceCollapse.ml:1137` | Internal error, please file an issue | literal.rs 236 | **declined** — deep loop reduce/collapse marker invariant |
| 4 | `symbolic/SymbolicToPureTypes.ml:1429` | Internal error: please file an issue | strip.rs 55 | **symptom** of the closure-mixed-SCC (declined) |
| 5 | `interp/Interp.ml:174` | Detected groups of mixed mutually recursive definitions | strip.rs | **declined** — my own closure-SCC diagnostic (prior task) |
| 6 | `llbc/FunsAnalysis.ml:307` | Mixed declaration groups … not supported | (SCC ids) | **declined** — same closure-SCC, downstream guard |

## Method note

Attribution uses the per-error parser the task mandated (take each `^[Error]`
and the *first* `Compiler source:` after it), not a `grep -A6` window, which
miscounts intervening `[Warn ]` blocks:

```
awk '/^\[Error\]/{i=1;next} i&&/Compiler source:/{match($0,/Compiler source: .*/);print substr($0,RSTART,RLENGTH);i=0}'
```

All counts strip ANSI first (`sed -r 's/\x1b\[[0-9;]*m//g'`); `sorry` is counted
with `grep -a` because the emitted `.lean` is UTF-8 (grep otherwise skips it as
"binary" and reports 0).

## Fix 1 — char comparison in the binop evaluator (my code)

**Root cause.** `ban.rs:22` is `|r: &&ClassUnicodeRange| r.start() <= ch && ch
<= r.end()`. The operands of `<=` are `char`. Aeneas's binop evaluator
(`InterpExpressions.ml`) handled only `bool` and integer operands for the
ordered comparisons `Lt/Le/Ge/Gt`; two `char` operands fell through to
`[%craise] span "Invalid inputs for binop"`. This is a genuine, general gap:
Rust's `char` is `Ord` (compared by Unicode scalar value).

**Why it is safe and general.**
- I key on the operand *literal type* (`TChar`), never on a function name.
- The pure representation *already* supports it: `SymbolicToPureExpressions.ml`
  builds `Lt (get_single_lit_ty ())` etc., where `get_single_lit_ty` uses
  `ty_as_literal` and so already accepts `TChar`; pure `binop` is
  `Lt of literal_type` (not `integer_type`). `PureTypeCheck.ml` has no
  binop-specific rejection.
- The Lean backend (`extract_binop`) emits `<=`/`<` syntactically, and Lean's
  `Char` supports these natively. I verified this three ways against Lean 4.31:
  a bare `('a' : Char) <= 'b'`, and the **exact emitted `do`/`if`/`ok` shape**
  of the extracted closure (`evidence/ban-closure-shape.lean`, which elaborates
  and `#eval`s to the right booleans). The coercion of `Char`'s `Prop`-valued
  `≤` to `Bool` in `if`/`ok` position holds.

**Change.** Two arms in `InterpExpressions.ml`:
- symbolic path: `TLiteral TChar, TLiteral TChar when binop ∈ {Lt,Le,Ge,Gt} → TLiteral TBool`;
- concrete path: `VLiteral (VChar c1), VLiteral (VChar c2)` → compare via
  `Uchar.compare` (code-point order = Rust semantics), result `bool`.

`char` remains rejected for arithmetic/bitwise ops (Rust forbids those too).

**Effect.** Removes the `InterpExpressions:1159` error and the
`ban.check.closure_3::call` `sorry`. The emitted Lean is well-formed:
```
def ...ban.check.closure_3...call (c : ban.check.closure_3) (tupled_args : ...ClassUnicodeRange) : Result Bool := do
  let c1 ← regex_syntax.hir.ClassUnicodeRange.start tupled_args
  if c1 <= c then
    let c2 ← regex_syntax.hir.ClassUnicodeRange.end tupled_args
    ok (c <= c2)
  else ok false
```
(no `sorry`).

## Fix 2 — cherry-pick `fcc481cd` (join matching for local reborrows)

**Root cause.** `InterpJoin.ml:1542` `[%craise] span "Could not match the
contexts"` at `literal.rs:285` (a repetition-extraction loop). The
fixed-point/source context fails to match the joined context because of an
isolated eta-expanded *local reborrow* abstraction
(`local ML@outer + abs{MB@outer; ML@inner} + local MB@inner`) that the final
match does not know how to reconcile.

**Fix.** Commit `fcc481cd` ("Fix join matching for local reborrows") from the
miniz_oxide campaign touches **only `InterpJoin.ml`** and applies **cleanly** on
this base. It (a) contracts such isolated local-reborrow abstractions (renaming
`inner→outer`, guarded so the ids occur nowhere else — `ids_sets_disjoint` with
the source ctx and exact borrow/loan occurrence counts) before the final match,
and (b) routes the final failure through `[%craise_recover] recoverable` so
non-strict join recovery no longer accepts a mismatched context. This is a
targeted hand-in cherry-pick, exactly the "cheap and clean" outcome the task
flagged; I did **not** merge the branch. `recoverable` is already a parameter of
`match_ctx_with_target`, so the hunk compiles unchanged.

**Effect.** Removes the `InterpJoin:1542` error and the corresponding
`literal.rs` repetition `sorry`.

## The 4 declined / symptom errors

- **`Interp.ml:174`** and **`FunsAnalysis.ml:307`** are the
  `strip_from_match_ascii` **closure-mixed-SCC** (group ids
  `[6,73,74,495,496,75,76,497,498]`) — the exact defect I analysed and declined
  last task (`REPORT-closure-mixed-scc.md`). `Interp.ml:174` is *my own*
  closure-recursion diagnostic firing; `FunsAnalysis:307` is its downstream
  guard. Still blocked by a Lean limitation (a closure trait-instance *record*
  cannot sit in, nor be forward-referenced from, a `partial_fixpoint` mutual
  block); the sound fix needs SCC-internal closure-dictionary inlining in the
  extraction layer. `Translate.ml:1287` ×4 (out of scope, "DO NOT REVISIT") and
  `PrePasses.ml:2555` are the same SCC at other rejection sites.

- **`SymbolicToPureTypes.ml:1429`** is `[%silent_unwrap_opt_span]
  (lookup_pure_fn_ptr_sig ctx fun_id)` in `get_fun_effect_info`. It fails
  because `strip_from_match_ascii`'s pure signature was never produced (its group
  is the unsupported closure-mixed-SCC), so the lookup returns `None`. **This is
  a direct symptom of the declined closure-SCC, not an independent root** — it
  will disappear when that SCC is supported, and there is nothing to fix here in
  isolation.

- **`InterpReduceCollapse.ml:1137`** `[%sanity_check] span (not
  (eval_ctx_has_markers ctx))` at `literal.rs:236` (`extract_alternation`). After
  the full reduce → collapse → `eliminate_shared_borrow_markers` →
  `eliminate_shared_loans` → `eliminate_ended_markers` pipeline on the joined
  loop context, a projection marker still remains, violating the "no markers
  after collapse" invariant. This is a **deep borrow-abstraction / loop-join
  invariant failure**, not a shallow guard. I **declined** it:
  - `extract_alternation`'s loop uses a plain tail-position `break` (not a
    labelled break / non-local exit), so the flagged lead
    `fc387ac0` ("Initialize loop locals for non-local exits") does not match the
    symptom; and that commit is a ~207-line change in `PrePasses.ml`, i.e. the
    outer-loop-control-flow area I previously declined on double-drop soundness
    grounds. Cherry-picking it here would re-open a declined-unsound area to
    chase a symptom it very likely does not address.
  - A real fix means reproducing and repairing the marker/collapse invariant in
    the loop fixpoint — genuinely architectural interp work, out of proportion to
    one error. This remains the last `sorry` in `grep-regex-full`
    (`extract_alternation`).

## Validation

### Four llbc inputs (base `7da47094`, `-backend lean -split-files -subdir C`)

| llbc input | errors before | errors after | sorry before | sorry after | uncaught | files | golden |
|---|---|---|---|---|---|---|---|
| `grep-regex-full.llbc` | 14 | **12** | 3 | **1** | 0 | 4 | — |
| `nonmatching-with-hir.llbc` | 20 | **20** | 6 | **6** | 0 | 4 | — |
| `grep-matcher.llbc` | 0 | **0** | 0 | **0** | 0 | 4 | **IDENTICAL** to `golden-grep-matcher/` |
| `nonmatching-clean.llbc` | 0 | **0** | 0 | **0** | 0 | 4 | **IDENTICAL** to `spike-nonmatching/C/` |

grep-regex-full attribution after the fixes (12): `Translate.ml:1287` ×4,
`TypesAnalysis:983` ×2, `SymbolicToPureTypes:1429`, `PrePasses:586`,
`PrePasses:2555`, `FunsAnalysis:307`, `InterpReduceCollapse:1137`,
`Interp.ml:174`. (The two removed are `InterpJoin:1542` and
`InterpExpressions:1159`.)

### Aeneas test suite

`make test` → **exit 0**, and **zero `git status` changes on tracked files** —
neither fix perturbs any committed `.out` oracle (no test currently exercises
char comparison, and the join contraction only triggers on the specific match
failure).

### 115-crate differential (`tests/llbc/*.llbc`) vs merge-base binary

Built the base binary at `7da47094` in a throwaway worktree (charon symlink
recreated → `/workspaces/charon-fnmut`) and ran both binaries over all 115
`tests/llbc/*.llbc` (`-backend lean`), comparing emitted files, logs, and exit
codes.

- **Emitted Lean: byte-identical for all 115.** Exit codes: identical for all
  115.
- Logs: the only content difference is `borrow_check_negative`, and it is **pure
  error *re-ordering*** — the base binary is itself **non-deterministic** in
  error order there (running the *unmodified base* twice already gives different
  orders), and the sorted error sets are byte-identical between base and mine (7
  errors each). So there are **zero real behavioural differences** attributable
  to my change. (This matches the campaign's earlier "exactly one change and it
  was my own test" standard — here, zero.)

## What I did NOT validate / attempt

- I did not do a full `lake build` of the emitted Lean library (banned for
  iteration; no prebuilt oleans). The char-comparison Lean was validated with
  standalone Lean 4.31 files (bare char comparison + the exact emitted closure
  shape), not the real Aeneas library. The construct is `Char`'s core `≤`, which
  is library-independent.
- I did not attempt `InterpReduceCollapse:1137` (deep loop-collapse invariant)
  or the closure-mixed-SCC cluster (declined last task with evidence), and did
  not re-open the outer-loop `PrePasses` area.
- The differential covered `tests/llbc`; I did not re-run the SymCRust Lean
  proofs (explicitly out of scope for this campaign).

## Evidence files

`evidence/ban-closure-shape.lean` — the exact emitted `ban.check.closure_3` body
(Result monad + `ClassUnicodeRange.start/end` + char `<=` in `if`/`ok`), which
elaborates and `#eval`s correctly under Lean 4.31.
