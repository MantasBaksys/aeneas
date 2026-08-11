# Fix: recursive types nesting through `Vec` (`Vec<Tree>` → `List`) + monadic coercion + miscompilation guard

Branch: `fix/recursive-vec-list-nesting` (off `mantas-ripgrep`)
Worktree: `/workspaces/aeneas-veclist`

## Problem

Aeneas models `alloc::vec::Vec α` as the Lean **subtype**
`{ l : List α // l.length ≤ Usize.max }`
(`backends/lean/Aeneas/Std/Vec.lean:22`). When a Rust recursive type nests
through `Vec`, e.g.

```rust
enum Tree { Leaf(u32), Node(Vec<Tree>) }
```

the generated Lean fails **in the kernel**:

```
(kernel) arg #1 of 'Tree.Node' contains a non valid occurrence of the datatypes being declared
```

Lean supports *nested* inductives, but when compiling one it specialises the
container into a private copy (`_nested.List_2`) and does **not** rewrite inside
a dependent field whose type mentions the container. `Vec`'s subtype bound
`l.length ≤ Usize.max` mentions `l`, so it can never be rewritten. On the
ripgrep `regex_syntax::ast` target this produces a bare kernel error plus 77
cascading "Unknown identifier"s in `C/Types.lean` — so `C/Funs.lean` was never
even elaboration-checked, with no attribution.

Baseline symptom on `mantas-ripgrep` (measured on the emitted Lean):

```
error: C/Types.lean:463:0: (kernel) arg #2 of 'grep_regex.regex_syntax.ast.ClassSetUnion.mk'
       contains a non valid occurrence of the datatypes being declared
(+77 knock-on "unknown identifier")
```

## What this deliverable does

1. **`TList` Pure builtin** — emits core-Lean `List` (which carries no subtype
   bound), needing **no** `backends/` support because `List` is core Lean, not
   Aeneas `Std`.
2. **Type-decl rewrite** — for a *recursive* occurrence only, rewrite `Vec<T>` →
   `List T` when `T` mentions a member of the same recursive declaration group.
3. **Monadic coercion at consumption sites** (`vecOfList`) — the length bound
   cannot live inside the inductive, so it is re-established *at each site that
   consumes the field as a `Vec`*, pushing the obligation to the proof layer.
   This is what makes the three ripgrep consumption sites translate.
4. **Loud guard** — any `List`/`Vec` boundary crossing the coercion cannot
   repair (a pure/non-monadic consumption, or a construction that would need the
   `Vec → List` direction) is reported as a single, precise, *saved* `[Error]`
   (extraction continues) rather than silently emitting ill-typed Lean.

The net effect on the ripgrep target: `C/Types.lean` now elaborates (the kernel
error is **gone**), and the three recursive-`Vec` consumption sites
(`Alternation.asts`, `Concat.asts`, `ClassSetUnion.items`) are repaired by
`vecOfList` and are well-typed.

## Design

### 1. New `TList` builtin in Pure (`src/pure/Pure.ml`)

Added `TList` to `builtin_ty`. OCaml exhaustiveness (warnings-as-errors here)
drove the checklist of match sites: `PrintPure.ml` (`"List"` + opaque matches),
`PureTypeCheck.ml` (opaque `get_adt_field_types` arm), `ExtractBase.ml`
(`builtin_adts ()` registers **`(TList, "_root_.List")` for Lean only**; var
basename `"l"`), and the Extract explicit-info matches.

**Name-clash handling (`_root_.List`).** Registering a builtin type name
reserves that identifier globally. Two clashes were fixed: (a) for F*/Coq/HOL4
lowercase `list` is a reserved keyword — fixed by registering `TList` **only for
Lean** (the rewrite never fires elsewhere); (b) for Lean a bare `"List"` clashes
with a user type named `List` (`tests/src/derive.rs`) — fixed by registering the
**fully-qualified `_root_.List`** (user types are always under the crate
namespace, so no collision, and `_root_.List = List` is core Lean).

### 2. Rewrite hook (`src/Translate.ml`)

`rewrite_recursive_vec_as_list` runs in `translate_crate_to_pure`, inserted
**between** `SymbolicToPure.translate_type_decls` and the construction of
`type_decls_map`, so the rewritten decls flow consistently into constructors,
projectors, the auto-generated projector `_simpLemma_`s, and later function
translation. It returns the `Vec` type-decl id (computed once, by LLBC name
`alloc::vec::Vec` via the existing `NameMatcher`, not string munging) and the
set of rewritten `(type_decl_id, field_id)` pairs.

### 3. Rewrite rule

- Recursive groups come from `trans_ctx.type_ctx.type_decls_groups` (`RecGroup
  ids` vs `NonRecGroup`). For each decl `d`, `S` = the ids of `d`'s group **iff**
  it is a `RecGroup`; otherwise `d` is skipped.
- Every field type is rewritten **bottom-up** (recursive traversal through
  `TAdt` generics and `TArrow`), replacing `Vec<T>` by `TBuiltin TList` applied
  to `T` **iff** `T` mentions some id in `S`. Handles nesting:
  `Vec<Vec<Ast>>` → `List (List Ast)`, `Vec<(Ast,u32)>` → `List (Ast × u32)`.

### 4. Monadic coercion `vecOfList` (`coerce_list_to_vec_at_uses`)

The crucial observation for this round: **function bodies are translated from
LLBC independently of the type-level rewrite**, so a field projection such as
`alt.asts` still has Pure type `Vec Ast` in the function body — even though the
*projector we emit* returns `List Ast`. The mismatch is therefore invisible to a
purely type-based check on the Pure IR (both sides read `Vec`); it is only
visible at the *Lean* level. So detection keys structurally on **projections of
rewritten fields**, not on Pure types.

The pass walks each (opened) function body and, for every application whose
result is a `Result _` (so a monadic bind fits without synthesising a context),
replaces each argument that is a rewritten-field projection flowing into a
`Vec`-typed parameter:

```
f … (proj) …   ~~>   let v ← vecOfList proj; f … v …
```

`vecOfList` is emitted (as generated output, never in `backends/`) as:

```lean
def Aeneas.VecListNesting.vecOfList {T : Type} (l : List T) : Result (alloc.vec.Vec T) :=
  if h : l.length ≤ Usize.max then .ok ⟨l, h⟩ else .fail .panic
```

This is exactly how array indexing already handles an unprovable-at-site bound —
`ok` if the length fits, `fail` otherwise — pushing the obligation to the proof
layer. It mirrors the existing `Aeneas.Std` `from_iter` idiom
(`backends/lean/Aeneas/Std/VecIter.lean:60`) but lives entirely in the emitted
crate. At the Pure level the builtin is given the type `Vec T → Result (Vec T)`
so the IR stays internally consistent (its argument, a projection, is
Pure-typed `Vec T`); the emitted Lean signature is the honest `List T → Result
(Vec T)`, and since the projector emits `List T` the call site is well-typed in
Lean. Because a rewritten-field projection is the *only* thing that is
Lean-`List` but Pure-`Vec`, the pass is zero-regression by construction.

The helper's `def` text is emitted once, as a file-level `prelude`, into the
`Funs` file (and the single-file output), immediately after the `open` lines so
that `Result`/`Usize`/`alloc.vec.Vec` are in scope. A crate that needs no
coercion emits no prelude.

**Why design (a) (this) and not (b) a `wf` predicate.** The re-scoped brief asked
to evaluate (a) a monadic coercion at the consumption site vs (b) a generated
`wfList` predicate threaded to each site, and to implement the less invasive one.
Design (a) is strictly less invasive: no new type-level predicate, no change to
constructors or signatures, and it fits the existing monadic shape (the sites are
already inside `Result` function bodies — verified: all three ripgrep sites are
`for x in &field` loops lowering to a projection fed into `Vec::into_iter`, whose
enclosing application is `Result`-typed). Design (b) would require emitting and
plumbing a predicate through every consumer and every caller. (a) was feasible
and is implemented; (b) was not needed.

### 5. Loud guard (`check_no_rewritten_field_uses`)

Runs **after** the coercion pass, so it only reports what the coercion could not
repair. Using the `iter_expr` visitor it collects, across every translated
function/loop/decomposed body:

- **Un-repaired consumption**: a rewritten-field projection flowing into a
  `Vec`-typed argument that is *not* wrapped by `vecOfList` (e.g. a pure,
  non-monadic use, or one nested behind another call so the coercion pass did not
  reach it). `vecOfList`'s own projection argument is explicitly skipped.
- **Construction**: an `AdtCons`/`struct_update` of a rewritten type. The
  constructor's Pure signature still mentions `Vec` (constructors are not retyped
  when functions are translated), so a type-based check on the argument would
  miss it — detection therefore keys structurally on the constructed type id.
  This direction (`Vec → List`, exact and total via `.val`) is intentionally not
  auto-coerced; it is a documented follow-up.

Violations are deduped on `(function, kind, type/field)` — one source-level use
can appear both in a loop and its decomposed continuation body — and emitted as a
**single** `[%save_error_opt_span]`. Crucially this is a *saved* error, **not** a
`craise`: under the decisive gate (which runs without `-abort-on-error`)
extraction continues, so the rest of the crate still translates and other,
independent errors still surface. The message explains **why** the bound cannot
live inside a nested-recursive inductive, so a future reader is not misled.

## Problem 1 (regression) fix

An earlier revision had reworked the guard's aggregation into a raising
`[%craise]`, which produced an uncaught `CFailure` that killed the whole run
(`files emitted: 0`). The aggregation is a genuine improvement and is **kept**,
but the guard is now a *saved* error (`[%save_error_opt_span]`) so extraction
continues. Verified below: the decisive gate now shows `uncaught: 0` and `files:
4`.

## Why this is zero-regression

- The rewrite fires **only** when a `Vec`'s element type mentions a member of the
  *same recursive declaration group*. Such types are impossible to translate
  today (they always produce the kernel error above), so nothing that works today
  can change.
- The coercion fires **only** on projections of rewritten fields (the sole values
  that are Lean-`List` but Pure-`Vec`), and only into `Vec`-typed argument slots
  inside a `Result`; nothing else is touched.
- The rewrite is additionally gated to the **Lean backend**; F*/Coq/HOL4 are
  untouched.
- Empirical proof: `make test` regenerates every backend's output and **no
  committed output file changed** (not even emitter line-number drift). Only the
  intended sources plus the new/updated test artifacts differ.

## Known limitations (deliberate follow-ups)

- **Construction (`Vec → List`) is not auto-coerced.** It is exact and total
  (`.val`), but we emit a loud guard error rather than silently miscompiling. The
  ripgrep target has no such site.
- **Pure/non-monadic consumption is not repairable** by design (a): a coercion
  needs a monadic bind. Such a site is reported by the guard.
- **Match-bound tuple-variant fields** (e.g. `Sum(Vec<T>)` where a `match` binds
  the field directly to a variable, with no projection node) are neither coerced
  nor detected — a residual general-Rust hole. The ripgrep fields are *struct*
  fields consumed via projection, so the target is unaffected.
- **No external `wf`/`wfList` predicate** is generated. Design (a) makes it
  unnecessary for the consumption sites; recovering the bound structurally is a
  larger, separate design decision.

## Gate evidence

All commands run in `/workspaces/aeneas-veclist` with `eval $(opam env)` and (for
Lean) `export PATH="$HOME/.elan/bin:$PATH"`. `charon` is a gitignored symlink to
`/workspaces/charon-fnmut`. **Error counts are taken after stripping ANSI** with
`sed -r 's/\x1b\[[0-9;]*m//g'`, because Aeneas colourises its output.

Built from a clean tree. Base commit before this round's work: `f5502084`. The
final commit SHA is recorded in `git log` on this branch (see the commit that
adds the `vecOfList` coercion).

### Gate 1 — `make build-dev` succeeds, no new warnings

```
$ make build-dev 2>&1 | sed -r 's/\x1b\[[0-9;]*m//g' | grep -iE '^(error|warning)'
Warning: `./charon` is a symlink; we assume it is a working copy and will not check commit hashes.
$ echo EXIT=$?    # of the build
BUILD EXIT=0
```
The only `Warning:` is the pre-existing Makefile `./charon is a symlink` note,
unrelated to code. Warnings-as-errors is on; the build is clean.

### Gate 2 — `make test` exits 0 with zero drift

```
$ make test 2>&1 | sed -r 's/\x1b\[[0-9;]*m//g' | tail
# Rust unit tests done
TEST EXIT=0
```
`git status --short` after `make test` shows only the intended changes — **no**
modified committed output files beyond the intended `VecRecursiveNesting.lean`
regeneration:
```
 M src/Translate.ml
 M src/extract/Extract.ml
 M src/extract/ExtractBase.ml
 M src/pure/PrintPure.ml
 M src/pure/Pure.ml
 M src/pure/PureMicroPassesAnnots.ml
 M tests/lean/VecRecursiveNesting.lean
 M tests/src/vec_recursive_nesting.rs
 D tests/src/vec_recursive_nesting_iter.lean.out
 D tests/src/vec_recursive_nesting_iter.rs
?? tests/src/vec_recursive_nesting_construct.lean.out
?? tests/src/vec_recursive_nesting_construct.rs
```

#### Gate 2a — read-only + coerced recursive-`Vec` type translates and `lake build`s

`tests/src/vec_recursive_nesting.rs` defines a recursive-through-`Vec` **enum**
(`VecTree { Leaf(u32), Node(Vec<VecTree>) }`, read-only match) and a
recursive-through-`Vec` **struct** field (`VecTreeBranch { children:
Vec<VecTreeNode> }`) iterated non-recursively by `vec_tree_count_children` —
which exercises the `vecOfList` coercion. The Lean types are **not** called
`Tree` (that collides with a deprecated Mathlib `Tree`). Registered in
`tests/lean/lakefile.lean` as `@[default_target] lean_lib VecRecursiveNesting`.

Generated Lean (note the `List` field types and the coercion):
```
$ grep -n 'Node :\|mk :\|vecOfList b.children' tests/lean/VecRecursiveNesting.lean
44:| Node : _root_.List VecTree → VecTree
60:| mk : _root_.List VecTreeNode → VecTreeBranch
111:    let v ← Aeneas.VecListNesting.vecOfList b.children
```
`lake build` (deps cached in `/workspaces/aeneas-merge/tests/lean`):
```
$ cd tests/lean && lake build VecRecursiveNesting
Build completed successfully (1697 jobs).
LAKE EXIT=0
```
(The `Aeneas/Std/Slice.lean … uses 'sorry'` / `StringIter` warnings are
pre-existing, unrelated noise.)

#### Gate 2b — construction of a recursive-`Vec` type triggers the loud guard

`tests/src/vec_recursive_nesting_construct.rs` constructs `VecTreeBranch` from a
`Vec` (`make_branch`). Because the `children` field is now `List` in Lean but the
argument is a `Vec`, and construction is intentionally not auto-coerced, the
guard fires. Marked `//@ [lean] known-failure` / `//@ [!lean] skip`, so the
runner runs Aeneas expecting failure and captures output to
`tests/src/vec_recursive_nesting_construct.lean.out`:
```
$ make test-vec_recursive_nesting_construct.rs   # make EXIT 0 (failure expected & captured)
$ sed -r 's/\x1b\[[0-9;]*m//g' tests/src/vec_recursive_nesting_construct.lean.out | grep -c '^\[Error\]'
1
```
Captured diagnostic (decolorized, abridged):
```
[Error] The recursive Vec->List rewrite changed the type of one or more recursive
fields from `Vec T` to `List T`, and the automatic coercion inserted at
consumption sites could not repair the following boundary crossing(s). ...
- function 'vec_recursive_nesting_construct::make_branch' constructs a value of a
  recursive `Vec` type, supplying the recursive field as a `Vec` (the field is now
  a `List`; the total `Vec -> List` (`.val`) coercion for constructions is
  intentionally not inserted) of type 'vec_recursive_nesting_construct::VecTreeBranch'

Why this rewrite exists, and why it is fundamental: `Vec T` is modelled in Lean as
the subtype `{ l : List T // l.length <= Usize.max }`. A nested-recursive inductive
CANNOT carry a field whose type mentions the nested container ...
Source: 'tests/src/vec_recursive_nesting_construct.rs', lines 32:0-34:1
```

### Gate 3 — `git diff --stat backends/` is EMPTY (also vs `mantas-ripgrep`)

```
$ git diff --stat backends/                    # (no output)
$ git diff --stat mantas-ripgrep -- backends/  # (no output)
```

### Gate 4 (decisive) — grep-regex extracts with the baseline error set

Harness: `AENEAS=/workspaces/aeneas-veclist OUT=… ./extract-regex.sh`
(`/workspaces/rg-verify`). The cached `gr.llbc` (8.6M, charon exit 0) was reused;
aeneas run without `-abort-on-error` (so `save_error` accumulates and extraction
continues):
```
$ ./bin/aeneas .gr-veclist/gr.llbc -dest .gr-veclist/lean -subdir C -split-files \
    -backend lean -print-error-emitters -no-progress-bar -max-error-spans -1
aeneas exit=1
errors:   3          # == baseline; the guard does NOT fire on grep-regex
uncaught: 0
files:    4          # == baseline
```
Full decolorized error list — all three are **other people's defects** (do not
fix), none from this change:
```
[Error] Non-local control flow (early return, or break/continue to an outer loop) out of a loop that carries a borrow across the exit is not supported yet: ...
[Error] Ignoring the body of 'grep_regex::ban::check' because of previous error
[Error] Internal error, please file an issue
```
The three recursive-`Vec` consumption sites are repaired by the coercion:
```
$ grep -n 'vecOfList' .gr-veclist/lean/C/Funs.lean
25:def Aeneas.VecListNesting.vecOfList {T : Type} (l : List T) :
722:        let v ← Aeneas.VecListNesting.vecOfList union.items
816:        let v ← Aeneas.VecListNesting.vecOfList alt.asts
823:        let v ← Aeneas.VecListNesting.vecOfList alt.asts
```

### Gate 5 — the nested-inductive kernel error is GONE

Built the emitted Lean in `/workspaces/aeneas-merge/tests/lean` (deps cached),
registering the `C` sub-library via a temporary `lean_lib C` (reverted
afterwards; `aeneas-merge` left clean).

`C.Types` — where the baseline kernel error lived — now builds cleanly:
```
$ lake build C.Types
Build completed successfully (1697 jobs).
EXIT=0
```
i.e. the baseline `C/Types.lean:463 (kernel) … ClassSetUnion.mk … non valid
occurrence` (+77 knock-on) is **eliminated**.

`C.Funs` still has **78** errors — but **zero** relate to the `Vec`/`List`
rewrite or the coercion (a `grep -iE 'vecOfList|_root_.List|alloc.vec.Vec|List'`
over the build log finds none). They are all pre-existing, orthogonal
consequences of extracting a *partial* crate whose external glue is unfilled:
unresolved external trait methods (`Iterator.map/collect/any/find/copied/sum`),
trait associated types/consts (`AstAnalysis`, `Config`, `ConfiguredHIR`), and one
unrelated closure-monotonicity failure (`strip_from_match_ascii`). These require
providing the `FunsExternal`/`TypesExternal` definitions and are out of scope for
this change.

**Strict improvement.** Baseline: `C/Types.lean` dies with the kernel error + 77
unknowns, so `C/Funs.lean` is never checked at all. After this change:
`C/Types.lean` builds, the three recursive-`Vec` consumptions are well-typed via
`vecOfList`, and `C/Funs.lean` type-checks far enough to surface the real,
orthogonal external-hole issues instead of being blocked with no attribution.

## Files changed

```
 src/Translate.ml               | rewrite hook + rewrite rule + vecOfList coercion pass
                                | + restructured (saved) guard + helper prelude emission
 src/pure/Pure.ml               | TList builtin_ty; VecOfList pure_builtin_fun_id
 src/pure/PrintPure.ml          | TList in builtin_ty_to_string; VecOfList name
 src/pure/PureMicroPassesAnnots.ml | VecOfList exhaustiveness arm
 src/extract/ExtractBase.ml     | (TList,"_root_.List") Lean-only; var basename "l";
                                | (VecOfList, "Aeneas.VecListNesting.vecOfList")
 src/extract/Extract.ml         | VecOfList explicit-info (single implicit type arg)
 tests/lean/lakefile.lean       | (already) registers lean_lib VecRecursiveNesting
```
Test artifacts:
```
 tests/src/vec_recursive_nesting.rs            (Gate 2a: read-only + coerced iteration)
 tests/lean/VecRecursiveNesting.lean           (generated output for 2a; lake-builds)
 tests/src/vec_recursive_nesting_construct.rs  (Gate 2b: known-failure, guard fires on construction)
 tests/src/vec_recursive_nesting_construct.lean.out (captured guard diagnostic)
 (removed) tests/src/vec_recursive_nesting_iter.rs / .lean.out
           — the round-2 iteration known-failure is now REPAIRED by the coercion,
             so it is superseded by 2a (coerced iteration) and 2b (construction guard).
```

All changed OCaml is `ocamlformat`-clean (per `src/.ocamlformat`); pre-existing
formatting drift in files/regions we did not author was left untouched.
`git diff --stat backends/` and `git diff --stat mantas-ripgrep -- backends/` are
both empty.
