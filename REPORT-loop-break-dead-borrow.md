# Report: releasing dead borrows on loop break edges (`InterpReduceCollapse.ml:1137`)

Branch: `fix/loop-break-dead-borrow` · Base commit: `140d017e` · Fix commit: `ca3e8f8c`
Status: **Sound fix landed.** The last extraction error in ripgrep's `grep-regex`
crate is gone (`aeneas errors: 1 → 0`, `files emitted: 4`), the MWE and a new
regression test extract and Lean-build cleanly, and the change causes **zero
drift** on the existing test suite (measured my-binary-vs-base-binary,
byte-identical across all 122 regenerated outputs).

This builds directly on the previous agent's negative-result report
(`/workspaces/aeneas-brkmarker/REPORT-loop-break-marker-join.md`), whose
diagnosis I did not re-derive. I chose **Avenue B** (kill the dead borrow before
the break, in PrePasses) over Avenue A (rewrite `join_ctxs`), and it turned out
to be both surgical and sound.

---

## 1. Avenue chosen, and why

**Avenue B — release the dead borrow on the break edge (a PrePasses LLBC→LLBC
transform).**

The previous agent characterised the disease precisely: a loop with **two break
edges of incompatible borrow shape** forces `compute_loop_break_context` to build
a template containing a loan-projector abstraction (`abs@9`) that the borrow-free
break cannot match, so a lone `PLeft` marker survives to the sanity check at
`InterpReduceCollapse.ml:1137`. It judged Avenue A (teach `join_ctxs` to expand
the concrete borrow-free side with a vacuous abstraction) to be non-surgical and
un-attestably sound, and it measured that naïve pipeline marker-elimination is
unsound (it relocates the failure to `InterpJoin.ml:1671`).

Avenue B attacks the **cause of the asymmetry** rather than the join that
observes it. At the offending `break`, the `Option<&T>` scrutinee local is
`Some(&x)` — a borrow that is **dead** (never read after the break; the loop
result is a scalar). Charon emits the loop-local `storage_dead`s *after* the
loop, so that dead borrow is still live in the break context. If it is released
**on the break edge**, both break edges become borrow-free, the loan projector
never enters the template, and the join succeeds trivially. This is:

- **Surgical**: one self-contained transform in `PrePasses.update_loop`, no
  interpreter change, the `InterpReduceCollapse.ml:1137` sanity check untouched,
  the `PrePasses.ml:988` guard untouched.
- **Provably semantics-preserving** (§3), which is exactly the attestation
  Avenue A could not provide.
- **Natural**: Charon *already* kills these same locals before the `continue`
  (back-)edge; the transform simply restores the same symmetry on the `break`
  edge.

---

## 2. Root-cause refinement

The previous agent's diagnosis is correct. Two refinements make Avenue B precise
and let the fix be minimal:

**(a) The live-but-dead borrow lives in the `Option` scrutinee local, not the
bound element.** In the LLBC for the MWE, at the explicit `break` Charon has
already emitted `storage_dead(x)` (the bound `&u32`), but the *match scrutinee*
`_6 : Option<&u32>` still holds `Some(&x)` (references are `Copy`), and `_6` is
only `storage_dead` **after** the loop. So it is `_6` — together with
`_8 = &mut iter` — that carries the borrow into the break context. Post-loop
tail, before the fix:

```
loop { … match _6 { None => break 0 ; Some => { … storage_dead(x); break 0 } } … continue 0 }
storage_dead(_8)      ← borrow-carrying, killed only here
storage_dead(_6)      ← borrow-carrying, killed only here
```

**(b) The bug requires ≥2 break edges.** The marker only survives when the
interpreter *joins* break contexts (`compute_loop_break_context`). A loop with a
single break takes the no-join path in `InterpLoops.ml` (`break_info = None`,
`SA.LoopBreak (output_ctx, …)` built directly, no template match). This is the
key that makes the fix drift-free (§4): the transform must fire on the ≥2-break
bug shape but leave single-break loops — e.g. a plain
`while let Some(_) = it.next() { … }` — byte-identical.

---

## 3. The fix, and its soundness argument

`PrePasses.update_loop` runs a new post-pass, `sink_break_dead_borrows`, after
the existing loop-exit flattening. For a `Loop lb` followed by a run of trailing
`storage_dead`s, it:

1. selects the trailing `storage_dead(x)` whose local `x` has a **borrow-carrying
   type** (`ty_has_borrow`, reused verbatim from the same file) — call this set
   `to_sink`;
2. fires only when `to_sink ≠ ∅`, **all** of `lb`'s exits are `break 0` to `lb`
   (`exits_are_simple`: no surviving `return`, no `break`/`continue` to an outer
   loop, no nested-loop break targeting `lb`), and **`lb` has ≥2 exiting
   `break 0`** (`count_exiting_breaks ≥ 2`);
3. inserts `to_sink` (copied with each break's span) immediately before **every**
   `break 0` that exits `lb` (including those nested inside `switch` arms, but
   not breaks inside nested inner loops); and
4. removes `to_sink` from after the loop.

After the fix, the MWE's post-loop tail becomes (verbatim from
`-log-debug PrePasses`):

```
match _6 {
  None => { storage_dead(_8); storage_dead(_6); break 0 }
  Some => { … storage_dead(x); storage_dead(_8); storage_dead(_6); break 0 }
}
… continue 0                                   ← unchanged (Charon already kills them here)
}
storage_dead(iter)  conditional_drop _3  …     ← _6/_8 storage_deads removed from here
```

Both break edges now release `_6`/`_8` before breaking ⇒ both break contexts are
borrow-free and symmetric ⇒ no loan projector enters the template ⇒ the join
succeeds and no marker reaches `:1137`.

**Soundness — semantics preservation.** `StorageDead local` in the interpreter is
`drop_value` on that local (`InterpStatements.ml:942`). Moving those drops from
after the loop to the break edges is behaviour-preserving because:

- **Every loop exit goes through a `break 0`.** A loop is otherwise
  non-terminating; the only statements that transfer control to the post-loop
  code are the `break 0`s. `return`/`break i>0` leave the function or an outer
  loop and never reach this loop's post-loop tail — and `exits_are_simple`
  rejects the loop if any such statement is present. Hence sinking `to_sink` into
  *every* `break 0` and deleting it from after the loop reproduces exactly the
  same set of drops on every path.
- **No double deallocation.** By Charon's storage discipline a `storage_dead(x)`
  after the loop is valid only if `x` is allocated (storage-live) on entry to the
  post-loop code — i.e. live at each `break`. The loop body re-`storage_live`s
  these locals every iteration and only `storage_dead`s them on the `continue`
  path (which does not reach a `break`), so along any single break path `x` is
  live and not-yet-dead. The inserted `storage_dead(x)` is therefore the *first*
  deallocation on that path; the deleted post-loop copy was the one that would
  otherwise have run. No path drops `x` twice.
- **The released locals are genuinely dead.** A local `storage_dead` immediately
  after the loop is, by definition, not read afterwards; the borrow it holds does
  not escape.

**Soundness — no symptom-masking.** The fix does not touch, weaken, or broaden
the `InterpReduceCollapse.ml:1137` sanity check, the `InterpJoin`/`InterpMatchCtxs`
join machinery, or the `PrePasses.ml:988` guard. It removes the *input* condition
that produced the unpairable marker (an asymmetric borrow across break edges),
rather than discarding the marker after the fact — which the previous agent
measured to be unsound (it relocates the failure to `InterpJoin.ml:1671`).

**Soundness — drift.** The ≥2-break restriction confines firing to the join-bug
shape. Measured effect on the whole test suite is **zero** (§4).

---

## 4. Gate evidence (measured against the committed tree `ca3e8f8c`)

All commands ANSI-stripped per the measurement discipline; the environment's
`aeneas` colourises output.

| Gate | Requirement | Result |
|---|---|---|
| 1. Build | `make build-dev` exits 0, no new warnings | **PASS** — clean build of the committed tree; the only `Warning:` is the pre-existing `./charon is a symlink` note (not a compiler warning). |
| 2. MWE | extracts with 0 errors | **PASS** — `aeneas errors: 0`; full-log `[Error]` count 0; no "Could not translate" for `b1`; `b1` body fully translated. |
| 3. grep-regex | `aeneas errors: 0`, `uncaught: 0`, `files emitted: 4` | **PASS** — `aeneas errors: 0`, `aeneas uncaught: 0`, `files emitted: 4`; full-log `[Error]` 0, `Uncaught exception` 0, `Could not translate the body` 0; `extract_alternation` body translated (no `sorry`). Base measures 1 error. |
| 4. `make test` zero drift | exit 0 AND `git status --porcelain tests/` empty | **PASS on the metric that matters — zero drift; see note below.** My change produces **byte-identical** output to the base binary across all 122 regenerated test outputs (`diff -rq /tmp/lean-mine2 /tmp/lean-base` → empty). |
| 5. `backends/` untouched | `git diff --stat mantas-ripgrep -- backends/` empty | **PASS** — empty. |
| 6. Regression test | MWE under `tests/src/` that regresses on base and Lean-builds | **PASS** — `tests/src/loop_break_dead_borrow.rs` (+ `tests/lean/LoopBreakDeadBorrow.lean` + lakefile registration). Base binary fails on it at `InterpReduceCollapse.ml:1137`; my binary extracts it with 0 errors; `lake build LoopBreakDeadBorrow` succeeds. |

### Gate 1
```
$ eval $(opam env) && make build-dev
… cp -f src/_build/default/main.exe bin/aeneas …   (exit 0; only the ./charon symlink Warning)
```

### Gate 2 (MWE, `/workspaces/rg-verify/repro2/src/lib.rs::b1`)
```
$ AENEAS=/workspaces/aeneas-brkmarker2 OUT=/tmp/g2-mwe ./extract.sh
aeneas errors:   0
$ sed -r 's/\x1b\[[0-9;]*m//g' /tmp/g2-mwe/ae.log | grep -c '^\[Error\]'      # 0
$ sed -r 's/\x1b\[[0-9;]*m//g' /tmp/g2-mwe/ae.log | grep -c 'Could not translate'  # 0
```

### Gate 3 (grep-regex)
```
$ cd /workspaces/rg-verify && AENEAS=/workspaces/aeneas-brkmarker2 OUT=/tmp/g3-gr ./extract-regex.sh
aeneas errors:    0
aeneas uncaught:  0
files emitted:    4
# cross-check on the full log:
#   [Error] lines: 0   Uncaught exception: 0   Could not translate the body: 0
#   grep -c extract_alternation lean/C/Funs.lean -> 9   (body present, no `sorry`)
```

### Gate 4 — drift measurement (and an honest caveat about this environment)

`make test` **cannot exit 0 in this checkout for reasons unrelated to my change**:
the `charon` vendored here (`cb50ff16`, shared read-only at `/workspaces/aeneas/charon`)
generates different trait-instance names than the committed `tests/lean/*.lean`
expectations were produced with. The **base binary** exhibits the identical
failures/drift:

- `closures_mut_captures` aborts on both my binary and the base binary with the
  same `ExtractBase.ml:269` duplicate-name error (`core::ops::function` trait).
- `ClosuresMutArgs.lean` regenerates with the same renaming
  (`core.ops.function.FnOnce.InstT0PairT1Mut0T2T3` → `core.ops.function.FnOnce`)
  under **both** binaries — verified by regenerating from the base binary and
  diffing against the committed file (exit 0, i.e. base also drifts).

To isolate **my change's** effect from this environmental charon mismatch I
regenerated the entire suite twice from the **same** LLBCs (same charon), once
with my binary and once with the base binary, and diffed:

```
$ make -k extract-tests LLBC_DIR=/tmp/llbc-cmp AENEAS_EXE=$PWD/bin/aeneas       # -> /tmp/lean-mine2
$ make -k extract-tests LLBC_DIR=/tmp/llbc-cmp AENEAS_EXE=/workspaces/aeneas-brkmarker/bin/aeneas  # -> /tmp/lean-base
$ diff -rq /tmp/lean-mine2 /tmp/lean-base
$ echo $?      # 0  — byte-identical across all 122 outputs
```

This is the sound form of the zero-drift gate: **my change alters no existing
test's translation.** (An earlier, looser version of the transform did change one
function — `nested_borrows::iter_list_while`, a *single-break* loop — to a
semantically-equivalent but textually different back-continuation. That is what
motivated the `count_exiting_breaks ≥ 2` restriction in §3; with it, drift is
exactly zero.)

### Gate 5
```
$ git diff --stat mantas-ripgrep -- backends/     # empty
```

### Gate 6
```
# base binary on the committed test's LLBC — regresses:
$ /workspaces/aeneas-brkmarker/bin/aeneas /tmp/llbc-cmp/loop_break_dead_borrow.llbc -backend lean … 
[Error] Internal error, please file an issue
Source: 'tests/src/loop_break_dead_borrow.rs', lines 1:0-30:5
Compiler source: interp/InterpReduceCollapse.ml, line 1137
# my (committed) binary on the same LLBC — 0 errors; committed .lean == fresh regen.
# Lean:
$ cd tests/lean && lake build LoopBreakDeadBorrow      # Build completed successfully (1697 jobs).
```

---

## 5. Residual limitations / deliberately untouched

- **`make test` cannot be made to exit 0 in this worktree** because of the
  environmental charon/name mismatch described in Gate 4 (it fails on the base
  binary too). I did not attempt to "fix" the committed expectations, since
  regenerating them here would bake in the environmental renaming — an unrelated,
  much larger change. The zero-drift property of *my* change is established by
  the my-vs-base comparison instead.
- **Interpreter and guards untouched.** `InterpReduceCollapse.ml:1137`,
  `InterpJoin.ml`, `InterpMatchCtxs.ml`, `InterpBorrows.ml`, and the
  `PrePasses.ml:988` guard are unchanged. Avenue A (the `join_ctxs` expansion the
  previous agent outlined) remains a valid but larger alternative; I did not
  pursue it because Avenue B fully resolves the observed failures with a
  provable soundness argument.
- **Scope of the transform.** It fires only on loops whose exits are all local
  `break 0`, with ≥2 exiting breaks, and only sinks borrow-carrying trailing
  `storage_dead`s. Loops with genuine non-local exits carrying a borrow are still
  handled (rejected honestly) by the pre-existing `PrePasses.ml:988` guard — this
  fix is orthogonal to, and does not weaken, that guard. Loops that already
  extracted are provably unaffected (Gate 4).
- **A pleasant side effect, not relied upon:** the slice variant
  `for x in xs.iter() { … break … }` (which regresses on base with a *different*
  error — `Nested borrows are not supported yet`, `InterpMatchCtxs.ml:1095` —
  because the element reborrow was carried into the break-context join) also
  extracts cleanly after the fix, for the same reason. The regression test uses
  the generic-iterator shape that hits `:1137` exactly.
- An unrelated `stash@{0}` ("mantas-diagnostic-logging") pre-existed in this
  worktree; I left it untouched. The `./charon` symlink I added to enable the
  build is git-ignored and not part of the commit.

## 6. Summary

- **grep-regex measured error count: 1 (base) → 0 (fixed).** `files emitted: 4`,
  `aeneas uncaught: 0`.

| Gate | 1 build | 2 MWE | 3 grep-regex | 4 drift | 5 backends | 6 regression |
|---|---|---|---|---|---|---|
| Result | PASS | PASS (0) | PASS (0 err, 4 files) | PASS (zero drift, my-vs-base) | PASS (empty) | PASS (regresses on base, Lean-builds) |
