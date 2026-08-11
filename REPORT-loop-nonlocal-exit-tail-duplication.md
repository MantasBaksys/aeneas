# Loop non-local-exit tail-duplication — report

Branch: `fix/loop-nonlocal-exit-tail-duplication` (off `mantas-ripgrep`)
Worktree: `/workspaces/aeneas-taildup`
Single source file changed: `src/PrePasses.ml` (+ one regression test and its lakefile registration).

## TL;DR / headline conclusion

I implemented the requested **tail-duplication (continuation-sinking)
normalization** in `src/PrePasses.ml`. It is correct, semantics-preserving,
zero-drift on the committed test suite, and it makes the toy specification
functions `e2`/`e6`/`e7`/`e8` all extract cleanly (**Gate 2 passes**).

**However, tail-duplication is NECESSARY BUT NOT SUFFICIENT for the real
`ban.rs::check`.** It removes the `PrePasses.ml:988` guard hit, but the real
function then fails one step deeper in the symbolic interpreter at
`interp/InterpMatchCtxs.ml:201` ("Not implemented yet"). So the real
`grep-regex` extraction goes from **3 errors → 2 errors**, not to the **1
error** Gate 3 requires. **Gate 3 is therefore NOT met.**

Crucially, `InterpMatchCtxs.ml:201` is the *same underlying limitation* that the
`PrePasses.ml:988` guard was created to catch — the guard's own message says
"the loop's break-context join cannot reconcile a loan over a borrow-containing
value", and `InterpMatchCtxs.ml:201` is exactly the
`AEndedSharedLoan (sv, child)` assertion `not (tvalue_has_loans_or_borrows … sv)`.
For `ban.rs` the non-local-exit-with-borrow is a **genuine instance of the
unsupported feature**, not a false positive of an over-conservative guard.
Tail-duplication only moves *where* the limitation is detected (from the honest
PrePasses guard to the opaque interpreter assertion); it cannot make the feature
supported.

Per the task's explicit instruction — "If you conclude the tail-duplication
approach is wrong or insufficient, STOP and report that with evidence rather
than inventing a different fix or weakening the guard" — I stopped short of
inventing an out-of-scope fix. I did try one in-scope refinement
(reordering the recovered borrow-cleanup so the loop matches the working "e7"
shape); it is **unsound** and I reverted it (evidence below). The guard is
untouched; `backends/` is untouched.

The implemented normalization is a real, upstreamable improvement (fixes the
`e2`/`e8` shallow-element class with zero drift), so I have **kept it** and added
a regression test for the cases it fixes. The remaining `ban.rs` failure needs a
complementary fix at a layer this task does not permit me to touch (Charon's
control-flow reconstruction, or Aeneas' loop-exit synthesis / interpreter loan
join). Details and recommendation below.

---

## 1. Root cause (as diagnosed and confirmed)

`update_loops` in `src/PrePasses.ml` handles a loop containing a `Return`:

- Loop has `Return` and **no** `Break`: every `Return` → `Break 0`, a `Return`
  is appended after the loop, `exits` stays empty → fine.
- Loop **has** a `Break`: it calls `decompose_after after`, which scans the
  statements **following the loop in the loop's own block** for a
  `Return`/`Abort`. If found, it rewrites and `exits` stays empty → fine. If
  `decompose_after` returns `None`, control falls to `(loop, [], after)`, the
  generic exit-flattening runs, `exits` becomes non-empty, and the guard
  `if exits <> [] && loop_refs_borrow loop` at ~line 988 raises.

`decompose_after` only looks **within the loop's own block**. When the loop is
the last statement of a `match` arm and another arm falls through, the `match`
has a **shared continuation after it**. The loop's own block ends with nothing →
`decompose_after` returns `None` → guard fires.

This is exactly the difference between `e2` (fails: shared `Ok(())` after the
match) and `e6` (passes: `return Ok(())` hand-duplicated into each arm).

## 2. Design and trigger condition

The normalization runs **before** any loop rewriting, at the top of
`update_body` in `update_loops`, over the whole body. Informally: for a block of
the form `<switch>; <tail>` where `<tail>` ends in `Return`/`Abort`, sink a copy
of `<tail>` into each *fall-through* arm of the switch, so every arm ends with
its own copy of the tail and the shared continuation disappears — turning the
`e2` shape into the `e6` shape automatically.

Key correctness properties:

- **Semantics preserved / no duplicated side effects.** Only *fall-through* arms
  receive a copy (`block_falls_through`: the arm's last statement is not
  `Return`/`Abort`/`Break`/`Continue`/`UnwindResume`). Arms that already
  terminate never reached the shared tail, so they get no copy. Every single
  execution path therefore still runs the tail **exactly once**.
- **Targeted, not blanket.** To avoid code-size blow-up and output churn, the
  transform fires **only on the exact configuration that would otherwise hit the
  guard**: `switch_needs_taildup` requires some fall-through arm to contain a
  loop that both **carries a borrow** (`loop_refs_borrow`, reused) **and**
  performs a **non-local exit** (`loop_body_has_nonlocal_exit`: a `Return`, or a
  `Break`/`Continue` whose index escapes the loop). The tail is only sunk when
  it is itself recoverable (`tail_is_sinkable`: ends in `Return`/`Abort`, the
  precondition for `decompose_after` to later succeed inside each arm).
- **Nesting / termination.** The `map_statement_base` visitor sinks at the
  current block level first, then recurses into the (rewritten) children, so a
  tail sunk into an arm that itself contains a problematic switch is normalized
  in turn. Termination is structural: each sink strictly consumes the shared
  tail at that level and recursion only descends into finite sub-terms.
- **Statement-id safety.** Duplicating statements produces duplicate
  `statement_id`s, but `refresh_statement_ids` runs *after* `update_loop` in
  `apply_passes`, so ids are re-freshened downstream — confirmed by reading the
  pass registration.

Helpers added (all local to `update_body`, reusing existing infrastructure):
`block_falls_through`, `tail_is_sinkable`, `loop_body_has_nonlocal_exit`,
`block_has_dangerous_loop`, `switch_arms`, `map_switch_arms`,
`switch_needs_taildup`, `sink_stmts`, and the `taildup_visitor`. See the diff in
`src/PrePasses.ml` (search `Tail-duplication (continuation-sinking)`).

## 3. Why this is insufficient for the real `ban.rs` — full evidence chain

The task's reproducers `e6`/`e7`/`e8` all use **bare enums** (`E`, `H`). The
real `ban.rs::check` matches on `*expr.kind()` where `Hir { kind: HirKind, props:
Box<PropertiesI> }` and `kind()` returns `&HirKind`. That extra **live shared
reborrow** as the match scrutinee is the distinguishing feature.

Bisection (all commands re-run and decolorized; scratch crate
`/workspaces/rg-verify/repro2`):

- `e9` (e8 + closure capturing `byte`): **passes**.
- `e10` (e8 + `Box`-carrying error type): **passes**.
- Editing the **real** `ban.rs` directly (backed up to
  `/workspaces/rg-verify/ban.rs.bak`, since restored): removing the `Class`
  arms, removing the closure, reducing to a single loop, changing the error type
  to `u32` — **all still fail**. The trigger is the type `Hir` itself.
- Minimal reproducer `e14`: `struct Hh { kind: Hk, props: Box<u32> }`, `impl Hh {
  fn kind(&self) -> &Hk }`, `match *expr.kind()` with a `Concat` loop arm + `_`
  wildcard + shared `Ok(())`. **`e14` reproduces `InterpMatchCtxs.ml:201`.**
- `e14b` (hand-duplicated: every arm ends in `return Ok(())`): **passes**.
- Direct-field-match variant `e13` (`match expr.kind` without the `kind()`
  reborrow): **passes**. Confirms the reborrow scrutinee is the trigger.

Post-prepass body comparison (`-log PrePasses`) of `e14` (fails) vs `e14b`
(passes):

- **`e14b` (works):** Charon builds a loop with **no internal `return`**: both
  exits do `_0 = <result>; break 0`, and the borrow-cleanup `storage_dead`s +
  the single `return` stay **after** the loop.
- **`e14` (my tail-dup, fails):** the loop keeps an internal `return` (from `?`);
  `decompose_after` converts it and **injects the entire after-loop tail —
  including the borrow-carrying `storage_dead`s — into the loop's `Break 0`**,
  so a shared loan over a borrow-containing value is ended *inside* the loop's
  break-context join. The interpreter cannot express that:
  `InterpMatchCtxs.ml:201`, the `AEndedSharedLoan` assertion
  `not (tvalue_has_loans_or_borrows (Some span) ctx sv)` "Not implemented yet".

I confirmed the assertion by reading `src/interp/InterpMatchCtxs.ml:197–203`:

```
| AEndedSharedLoan (sv, child) ->
    [%cassert] span
      (not (tvalue_has_loans_or_borrows (Some span) ctx sv))
      "Not implemented yet";
```

This is verbatim the guard's own description ("a loan over a borrow-containing
value"). So the guard and this assertion are the same limitation.

**Positive control:** rewriting the *full* real `ban.rs` in the `e7` style
(every arm ends in `return Ok(())`) extracts with **zero errors**. This proves a
working shape exists — but it is produced by **Charon's** control-flow
reconstruction from all-arms-`return` *source*, not by any post-Charon PrePasses
transform.

### Why the in-scope refinement is unsound

The obvious idea is to make `decompose_after` produce the `e7` shape: in the
`Some after` branch, keep the borrow-carrying `storage_dead`s **after** the loop
(partitioned via `local_tys` + `ty_has_borrow`) and inject only the productive
`_0 = Ok` part into `Break 0`. I implemented this and it **breaks the
symbolic→pure translation**: extracting isolated `ban::check` produced 4×
`Could not find var for symbolic value` at `symbolic/SymbolicToPureCore.ml:520`.
Reason: the loop's abstraction fixed point is synthesized by Aeneas *after*
PrePasses; moving the `storage_dead`s past the loop leaves the borrow live
across the loop join in a way the fixed point wasn't built for, dangling
symbolic values. Charon can build the `e7` shape coherently because its loop
reconstruction accounts for the borrow being threaded through and ended after;
a post-hoc reorder at the LLBC level cannot. **I reverted this refinement.**

### The architectural reason, stated plainly

PrePasses is the earliest Aeneas pass, but it runs **after** Charon has already
done control-flow / loop reconstruction. A shared continuation sunk into an arm
at PrePasses time is too late to benefit from Charon's clean loop-exit shaping;
the cruder `update_loop`/`decompose_after` path handles it and injects the
borrow-cleanup into the break. To get the working `e7` shape, the duplication
must happen **before loop reconstruction (in Charon)**, or Aeneas' loop-exit
synthesis / interpreter loan-join must learn to end a shared loan whose value
still contains loans/borrows. Both are outside this task's permitted scope
("work exclusively in PrePasses.ml, do not weaken the guard, do not touch
backends").

## 4. Gate evidence

### Gate 1 — `make build-dev` exits 0, no new warnings — PASS

```
$ eval $(opam env) && make build-dev
… cp -f src/_build/default/main.exe bin/aeneas …
(exit 0, no warnings)
```

### Gate 2 — repro2 `e2`/`e6`/`e7`/`e8` all extract cleanly — PASS

Commands (from `/workspaces/rg-verify/repro2`, ANSI-stripped):

```
$ AE=/workspaces/aeneas-taildup
$ $AE/charon/bin/charon cargo --preset=aeneas --lift-associated-types='*' \
    --remove-adt-clauses --monomorphize-mut=except-types --dest-file /tmp/td.llbc
$ $AE/bin/aeneas /tmp/td.llbc -dest /tmp/td-lean -subdir C -split-files \
    -backend lean -print-error-emitters -no-progress-bar -max-error-spans -1
$ sed -r 's/\x1b\[[0-9;]*m//g' /tmp/td-ae.log | grep -c '^\[Error\]'
0
$ for f in e2 e6 e7 e8; do echo "$f: $(… grep -cE "body of '?repro2::$f\b") error(s)"; done
e2: 0 error(s)
e6: 0 error(s)
e7: 0 error(s)
e8: 0 error(s)
```

### Gate 3 — real `grep-regex` / `ban.rs` — NOT MET (2 errors, expected 1)

```
$ cd /workspaces/rg-verify && AENEAS=/workspaces/aeneas-taildup OUT=/tmp/gr-taildup ./extract-regex.sh
$ sed -r 's/\x1b\[[0-9;]*m//g' /tmp/gr-taildup/ae.log | grep -A2 '^\[Error\]'
[Error] Internal error, please file an issue
Source: 'crates/regex/src/literal.rs', lines 236:8-245:9
Compiler source: interp/InterpReduceCollapse.ml, line 1137
--
[Error] Not implemented yet
Source: 'crates/regex/src/ban.rs', lines 42:12-53:1
Compiler source: interp/InterpMatchCtxs.ml, line 201
```

Baseline (`mantas-ripgrep`) = 3 errors (`PrePasses.ml:988` on `ban.rs`, the
knock-on "Ignoring the body of 'grep_regex::ban::check'", and the unrelated
`InterpReduceCollapse.ml:1137` on `literal.rs`). After this change = 2 errors:
the `PrePasses.ml:988` guard **and** its knock-on are gone (error count for
`ban.rs` drops 2→1), but `ban.rs` now hits `InterpMatchCtxs.ml:201` instead of
translating. The unrelated `literal.rs` error is left untouched as instructed.

So the two `ban.rs` guard errors became one different `ban.rs` interpreter
error. **`ban.rs` is not fixed.**

### Gate 4 — `make test` exits 0, zero drift — PASS

```
$ eval $(opam env) && make test    # exit 0
$ git status --porcelain tests/
 M tests/lean/lakefile.lean
?? tests/lean/LoopNonlocalExitSharedTail.lean
?? tests/src/loop_nonlocal_exit_shared_tail.rs
```

**No committed generated output (`.lean`/`.fst`/etc.) changed.** The only
modified tracked file is `tests/lean/lakefile.lean`, which is my intentional
registration of the new regression test lib (Gate 6), not drift. The two
untracked (`??`) files are the new regression test and its generated Lean. The
narrow trigger condition therefore perturbs no existing test.

### Gate 5 — `git diff --stat backends/` empty — PASS

```
$ git diff --stat backends/
(empty)
```

### Gate 6 — regression test — PASS

New file `tests/src/loop_nonlocal_exit_shared_tail.rs` (header `//@ [!lean] skip`,
Lean-only, matching `loops.rs`), registered in `tests/lean/lakefile.lean` as
`LoopNonlocalExitSharedTail`. It contains two functions:

- `check_flag` — the `e2` shape: an `if`/`match` with a shared `Ok(())`
  continuation, one arm looping over a borrowed slice with an early `return`.
- `check_shape` — the `e8`/`ban.rs::check` shape: a four-arm `match` where
  several arms fall through to a shared `Ok(())`, and one arm loops over a
  borrowed slice with an early `return`.

**Why not the literal recursive `e2`/`e8` types?** Aeneas models `Vec α` in the
Lean backend as `{ l : List α // l.length ≤ Usize.max }` (a `Subtype`), through
which Lean's **kernel positivity check rejects self-recursion**: a type
`inductive NodeTree | Node : Vec NodeTree → NodeTree` fails with "arg #1 …
contains a non valid occurrence of the datatypes being declared". This is an
unrelated, pre-existing limitation of the `Vec` model — it has nothing to do
with the tail-duplication transform, but it means the recursive-through-`Vec`
`e2`/`e8` shapes cannot be *Lean-built*. The regression test therefore uses the
**same control-flow shape** (loop with a borrow-carrying non-local exit inside a
`match`/`if` arm + shared tail) specialized to slices of scalars, so the
generated Lean builds. (The recursive-through-`Vec` `e2`/`e8` extraction is still
covered by Gate 2 at the Aeneas level in repro2.)

**The test genuinely regresses.** With the transform disabled (I `git stash`ed
`src/PrePasses.ml` and rebuilt), both functions hit the exact guard:

```
$ # baseline binary (tail-dup disabled), extracting the two functions in repro2
=== baseline (fix disabled) err count: 4 ===
[Error] Non-local control flow (early return, ...) out of a loop that carries a
borrow across the exit is not supported yet: the loop's break-context join cannot
reconcile a loan over a borrow-containing value ...
Compiler source: PrePasses.ml, line 988
[Error] Ignoring the body of 'repro2::check_flag' because of previous error
Compiler source: PrePasses.ml, line 2932
[Error] Non-local control flow ...
Compiler source: PrePasses.ml, line 988
[Error] Ignoring the body of 'repro2::check_shape' because of previous error
Compiler source: PrePasses.ml, line 2932
```

With the transform enabled, both extract cleanly and the generated
`tests/lean/LoopNonlocalExitSharedTail.lean` has **no `sorry`** (both functions
translate with their loops resolved locally: `check_flag_loop`,
`check_shape_loop0` each with a `none => ok (done …)` normal exit and an early
`ok (done (… .Err …))` exit).

Lean build (Mathlib cache fetched via `lake exe cache get`, then):

```
$ cd tests/lean && lake build LoopNonlocalExitSharedTail
✔ [1696/1697] Built LoopNonlocalExitSharedTail (2.2s)
Build completed successfully (1697 jobs).
```

(The `declaration uses 'sorry'` warnings during the build are in the pre-existing
`Aeneas.Std.Slice` / `Aeneas.Std.StringIter` library, not in the generated file.)

## 5. Decision on final state, and recommendation

I kept the tail-duplication because, within scope, it is a strict improvement:
Gates 1/2/4/5 pass with **zero drift**, it fixes the whole `e2`/`e8` shallow
class, the guard is untouched, and total `grep-regex` errors drop 3→2. It is
general and upstreamable (no ripgrep-specific logic).

I did **not** invent an out-of-scope or unsound fix to force Gate 3. The one
in-scope refinement I tried is unsound (§3). The residual `ban.rs` failure is a
genuine instance of the unsupported "end a shared loan over a borrow-containing
value at a loop-break join" feature.

**Limitation to flag honestly:** for `ban.rs` specifically, this change trades
the honest `PrePasses.ml:988` guard message for the opaque
`InterpMatchCtxs.ml:201` "Not implemented yet" — the very message the guard was
added to replace. The *outcome* is unchanged (the body is dropped either way,
no unsoundness), and the error *count* drops, but a reviewer who values the
honest guard text for `ban.rs` may prefer to gate the transform even more
tightly or reject the borrow-carrying case up front. There is **no syntactic
predicate** that distinguishes "tail-dup will succeed" (e8) from "tail-dup
exposes the interpreter limitation" (ban.rs): both have borrow-carrying
`storage_dead`s in the sunk tail; the difference (a live shared reborrow
scrutinee producing a shared loan whose value still contains loans) is a
semantic property only the interpreter knows.

**Recommended follow-up (out of this task's scope):**

1. Preferred: teach **Charon** to duplicate a shared continuation into
   fall-through match arms *before* loop reconstruction, so the loop-bearing arm
   ends lexically in a `return` and Charon produces the working `e7` loop shape
   (both exits `_0 = …; break 0`, cleanup + `return` after the loop). This is the
   same normalization as here, but at the layer where it can be made sound.
2. Alternatively: extend the interpreter's `AEndedSharedLoan` handling
   (`InterpMatchCtxs.ml:201`) / the loop-break join to reconcile a loan over a
   borrow-containing value — this would also let the existing
   `PrePasses.ml:988`-guarded programs extract, retiring the guard.

Until one of those lands, the `PrePasses.ml:988` guard should remain (it is the
honest front-line rejection for exactly this feature), and this tail-dup
normalization stands on its own merit for the shallow class it fixes.
