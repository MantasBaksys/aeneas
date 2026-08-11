# Fix: recursive types nesting through `Vec` (`Vec<Tree>` → `List`) + miscompilation guard

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
`l.length ≤ Usize.max` mentions `l`, so it can never be rewritten. This blocks
the whole `regex_syntax::ast` module of ripgrep, with no attribution: a bare
kernel error and 77 cascading "Unknown identifier"s.

## Scope of this deliverable (IMPORTANT — read this first)

An earlier version of the brief claimed the ripgrep target's recursive `Vec`
fields are never consumed as `Vec`s, so that a **type-only** `Vec`→`List`
rewrite would suffice to unblock grep-regex. **That claim was subsequently
falsified by the task author.** The real `regex_syntax::ast` code *does* consume
those fields as `Vec`s (`for x in &alt.asts { … }` over `Alternation.asts`,
`Concat.asts`, `ClassSetUnion.items`), which lowers to a projection fed to
`Vec::into_iter`. So:

- A type-only rewrite makes `alt.asts : List Ast` while `into_iter` still
  expects `alloc.vec.Vec Ast` → **ill-typed Lean**.
- Therefore the type-only rewrite does **not**, on its own, unblock grep-regex.
- The **guard** (part 4) is now the primary deliverable: on grep-regex it fires
  by design and produces a precise, attributed diagnostic instead of the
  inscrutable kernel error.

The underlying reason is fundamental: the length bound `l.length ≤ Usize.max`
**cannot** be stored inside a nested-recursive inductive at all (any field
carrying it mentions the nested container, which is exactly what Lean refuses),
so the bound must become an external `wf` predicate, and a `List → Vec`
projection then inherently needs a proof unavailable at the projection site.
`Vec → List` (construction) is by contrast exact and total (`.val`).

Per the re-scoped instructions this change delivers **exactly**: (1) the `TList`
builtin, (2) the type-decl rewrite, (3) the loud guard, (4) the two-part test.
It deliberately does **not** attempt to solve the projection problem (no
coercions, clamps, `wf` threading, or `sorry`s). The net improvement is real and
upstreamable: read-only cases now translate correctly and `lake build`; consuming
cases fail loudly with a precise Aeneas diagnostic rather than an inscrutable
kernel error.

## Design

For a **recursive occurrence only**, and only for the Lean backend, emit
core-Lean `List T` (which has no subtype bound) instead of `alloc.vec.Vec T`.
Because `List` is core Lean (not Aeneas `Std`), this needs **no** stdlib support
— satisfying the hard constraint that `backends/` must not be modified.

### 1. New `TList` builtin in Pure (`src/pure/Pure.ml`)

Added `TList` to `builtin_ty`. OCaml exhaustiveness warnings (warnings-as-errors
here) drove the checklist of match sites:

- `src/pure/PrintPure.ml` — `builtin_ty_to_string` (`"List"`), and three
  "opaque/unreachable" builtin matches.
- `src/pure/PureTypeCheck.ml` — `get_adt_field_types` (opaque field access).
- `src/extract/ExtractBase.ml`:
  - `builtin_adts ()` — registered **`(TList, "_root_.List")` for Lean only**
    (see the name-clash note below).
  - `ctx_compute_var_basename` — variable basename `"l"`.

### 2. Rewrite hook (`src/Translate.ml`)

`rewrite_recursive_vec_as_list` runs in `translate_crate_to_pure`, inserted
**between** `SymbolicToPure.translate_type_decls` and the construction of
`type_decls_map`, so the rewritten decls flow consistently into constructors,
projectors, the auto-generated projector `_simpLemma_`s, and later function
translation.

### 3. Rewrite rule

- Recursive groups come from `trans_ctx.type_ctx.type_decls_groups`
  (`RecGroup ids` vs `NonRecGroup`). For each decl `d`, `S` = the set of ids in
  `d`'s group **iff** it is a `RecGroup`; otherwise `d` is skipped entirely.
- `Vec` is recognised **by LLBC name** (`alloc::vec::Vec`) via the existing
  `NameMatcher` machinery — not by string munging. The `Vec` type-decl id is
  computed once up front.
- Every field type is rewritten **bottom-up** (recursive traversal through
  `TAdt` generics and `TArrow`), replacing `Vec<T>` by `TBuiltin TList` applied
  to `T` **iff** `T` mentions some id in `S`. This handles nesting:
  `Vec<Vec<Ast>>` → `List (List Ast)`, `Vec<(Ast,u32)>` → `List (Ast × u32)`.

### 4. Loud guard against silent miscompilation (primary deliverable)

`check_no_rewritten_field_uses` runs **after** function translation and the
micro-passes. Using the `iter_expr` visitor it collects, across every translated
function/loop/decomposed body:

- ADT construction (`AdtCons`) or `struct_update` of a type that had a field
  rewritten, and
- field projection (`Proj`) of a rewritten `(type_decl_id, field_id)` pair
  (a `for x in &s.field` iteration lowers to exactly such a projection fed to
  `into_iter`).

Uses are deduped on `(function, type, field, kind)` — one source-level use can
appear both inside a loop and in its decomposed continuation body. After
scanning, if any violations were found it emits a **single** loud `[Error]`
(`craise`) enumerating each offending function/type/field, then aborts rather
than emit ill-typed Lean. The message explains **why** this is fundamental (the
bound cannot live inside a nested-recursive inductive) so a future reader is not
misled. Pattern-match *deconstruction* uses `adt_pat` (not
`adt_cons_id`/`projection`), so a plain `match` on a `List` correctly does not
trip the guard.

**Single-error design.** Existing known-failure tests use `craise` and show one
`[Error]`. Under `-abort-on-error` (`fail_hard`, which the test runner sets),
`[%save_error]` prints the message *twice* (once in `push_error`, once before
raising) — so the guard collects all violations first and emits one `craise`,
matching the repo convention and giving complete enumeration.

### Known gap in the guard (documented, with evidence)

The guard catches consumption that appears as an explicit **construction or
projection** node. It does **not** catch a value that a `match` binds *directly*
to a rewritten field — a single-field tuple variant like `Sum(Vec<T>)` — that is
then handed to a `Vec` operation as a plain function argument. That is an
application on a bound variable with no projection node; detecting it soundly
would require a full Pure type-consistency pass, which is explicitly out of
scope.

I verified this gap empirically (throwaway `EE { Lit(u32), Sum(Vec<EE>) }` with
`for x in items` over the pattern-bound `items`): the guard stays silent, Aeneas
emits Lean, and that Lean is ill-typed —

```
error: Application type mismatch: The argument
  items
has type
  List EE
but is expected to have type
  alloc.vec.Vec ?m.75
in the application
  ...into_iter Global items
```

The **real ripgrep target does not hit this gap**: its recursive `Vec` fields
(`Alternation.asts`, `Concat.asts`, `ClassSetUnion.items`) are *struct* fields,
consumed via projection (`alt.asts`), which the guard *does* catch. The tuple-
variant shape is a residual general-Rust hole; closing it (a sound Pure
type-consistency pass) is a follow-up, tracked alongside the `wf` work below.

## Why this is zero-regression

- The rewrite fires **only** when a `Vec`'s element type mentions a member of
  the *same recursive declaration group*. Such types are impossible to translate
  today (they always produce the kernel error above), so nothing that works
  today can change — and, for the same reason, the guard firing on them cannot
  break any currently-working translation.
- Non-recursive `Vec` occurrences, and any `Vec` outside a `RecGroup`, are never
  touched.
- The rewrite is additionally gated to the **Lean backend**; F*/Coq/HOL4 are
  left completely untouched.
- Empirical proof: `make test` regenerates every backend's output and **no
  committed output file changed at all** (not even emitter line-number drift).
  Only the intended source files plus the new test artifacts differ.

### Name-clash handling (`_root_.List`)

Registering a builtin type name reserves that identifier globally. Two clashes
surfaced and were fixed:

1. For F*/Coq/HOL4 the lowercase `list` clashes with a reserved keyword. Fixed
   by registering `TList` **only for Lean** (the rewrite never fires elsewhere).
2. For Lean, a bare `"List"` clashes with a user type named `List`
   (`tests/src/derive.rs` defines one). Fixed by registering the
   **fully-qualified `_root_.List`**: user types are always emitted under the
   crate namespace, so `_root_.List` can never collide, and `_root_.List = List`
   is core Lean.

## Known limitation (deliberate follow-up)

We do **not** regenerate a well-formedness predicate (e.g. `wfList`) to recover
the lost `length ≤ Usize.max` bound, nor the coercions/proofs a `List → Vec`
consumption site would need. Recovering the bound is exactly what would let the
consuming cases (grep-regex included) go through; it is a larger design decision,
escalated to the user, and intentionally not attempted here. The guard's tuple-
variant gap (above) is part of the same follow-up.

## Gate evidence

All commands run in `/workspaces/aeneas-veclist` with `eval $(opam env)` and (for
Lean) `export PATH="$HOME/.elan/bin:$PATH"`. `charon` is a symlink to
`/workspaces/charon-fnmut` (same `charon-pin` commit as `aeneas-merge`;
gitignored). Error counts are taken **after** stripping ANSI with
`sed -r 's/\x1b\[[0-9;]*m//g'`, because Aeneas colourises its output.

### Gate 1 — `make build-dev` succeeds, no new warnings

```
$ make build-dev 2>&1 | sed -r 's/\x1b\[[0-9;]*m//g' | tail
cd src && dune build
...
BUILDEXIT:0
```
Warnings-as-errors is on; the build is clean. (The only console `Warning:` is the
pre-existing `./charon is a symlink` note from the Makefile, unrelated to code.)

### Gate 2a — read-only recursive-`Vec` type translates and `lake build`s

`tests/src/vec_recursive_nesting.rs` defines
`enum VecTree { Leaf(u32), Node(Vec<VecTree>) }` plus `vec_tree_is_leaf` (which
only pattern-matches — no `Vec` consumption). The Lean type is **not** called
`Tree` (that collides with a deprecated Mathlib `Tree`). Registered in
`tests/lean/lakefile.lean` as `@[default_target] lean_lib VecRecursiveNesting`.

```
$ rm -f tests/llbc/vec_recursive_nesting.llbc && make test-vec_recursive_nesting.rs
[Info ] Generated: tests/lean/VecRecursiveNesting.lean

$ grep -n 'inductive VecTree\|Node :\|Leaf :' tests/lean/VecRecursiveNesting.lean
21:inductive VecTree where
22:| Leaf : Std.U32 → VecTree
23:| Node : _root_.List VecTree → VecTree
```
Full kernel elaboration and `lake build`:
```
$ cd /workspaces/aeneas-merge/tests/lean && lake env lean .../VecRecursiveNesting.lean
LEANEXIT:0

$ cd tests/lean && lake build VecRecursiveNesting
✔ Built VecRecursiveNesting (2.2s)
Build completed successfully (1697 jobs).
LAKEEXIT:0
```
(The `Aeneas/Std/StringIter.lean … uses 'sorry'` warnings are pre-existing,
unrelated noise.)

### Gate 2b — iterated recursive-`Vec` field triggers the loud guard

`tests/src/vec_recursive_nesting_iter.rs` mirrors the ripgrep shape: a struct
field `VecTreeBranch.children : Vec<VecTreeNode>` consumed via `for c in
&b.children` (projection + `into_iter`). Marked `//@ [lean] known-failure` /
`//@ [!lean] skip`, so the test runner runs Aeneas expecting failure and captures
output to `tests/src/vec_recursive_nesting_iter.lean.out`.

```
$ rm -f tests/llbc/vec_recursive_nesting_iter.llbc tests/src/vec_recursive_nesting_iter.lean.out
$ make test-vec_recursive_nesting_iter.rs
# Test vec_recursive_nesting_iter.rs done          # make EXIT 0 (failure is expected & captured)

$ sed -r 's/\x1b\[[0-9;]*m//g' tests/src/vec_recursive_nesting_iter.lean.out | grep -c '^\[Error\]'
1
```
The captured diagnostic (decolorized):
```
[Error] The recursive Vec->List rewrite changed the type of one or more recursive
fields from `Vec T` to `List T`, but the following function(s) consume or construct
such a field as a `Vec`. Emitting this would produce ill-typed Lean, so we abort
here rather than silently miscompiling:
- function 'vec_recursive_nesting_iter::vec_tree_sum' projects that field and treats
  it as a `Vec`: field of type 'vec_recursive_nesting_iter::VecTreeBranch' (field 0)

Why this rewrite exists, and why it is fundamental: `Vec T` is modelled in Lean as
the subtype `{ l : List T // l.length <= Usize.max }`. A nested-recursive inductive
CANNOT carry a field whose type mentions the nested container ...
... Fixing this in general requires an external well-formedness predicate (e.g.
`wfList`) ... intentionally NOT attempted here ...
Source: 'tests/src/vec_recursive_nesting_iter.rs', lines 37:0-48:1
Compiler source: Translate.ml, line 598
```

### Gate 3 — `make test` exits 0

```
$ make test 2>&1 | sed -r 's/\x1b\[[0-9;]*m//g' | tee test-final.log | tail
# Rust unit tests done
TESTEXIT:0

$ grep -c '^\[Error\]' test-final.log     # log already decolorized
0
```
`git status` after `make test` shows **no** modified committed output files (only
the intended sources + the two new untracked test artifacts), i.e. zero
regression / zero line drift:
```
 M src/Translate.ml
?? tests/src/vec_recursive_nesting_iter.lean.out
?? tests/src/vec_recursive_nesting_iter.rs
```
(The `[Error]` for the known-failure test goes to its `.out` file, not to
stdout, so the suite log has 0.)

### Gate 4 — `git diff --stat backends/` is EMPTY

```
$ git diff --stat backends/
$ echo $?
0
```
(No output — empty.)

### Gate 5 — the guard is demonstrated by an in-tree test

Per the re-scoped instructions, no throwaway is needed: Gate 2b's committed
`known-failure` test (`vec_recursive_nesting_iter.rs` + `.lean.out`) demonstrates
the guard firing, and Gate 2a's `vec_recursive_nesting.rs` demonstrates the
read-only case translating and building. (The tuple-variant gap was additionally
verified with a throwaway, described above and then removed — not committed.)

## Files changed

```
 src/Translate.ml           | guard restructure + rewrite hook + rewrite rule
 src/extract/ExtractBase.ml | (TList, "_root_.List") Lean-only; var basename "l"
 src/pure/PrintPure.ml      | TList in builtin_ty_to_string + opaque matches
 src/pure/Pure.ml           | TList constructor in builtin_ty
 src/pure/PureTypeCheck.ml  | TList in opaque get_adt_field_types arm
 tests/lean/lakefile.lean   | register lean_lib VecRecursiveNesting
```
New test files:
```
 tests/src/vec_recursive_nesting.rs           (Gate 2a: read-only, translates)
 tests/lean/VecRecursiveNesting.lean          (generated output for 2a)
 tests/src/vec_recursive_nesting_iter.rs      (Gate 2b: known-failure, guard fires)
 tests/src/vec_recursive_nesting_iter.lean.out (captured guard diagnostic)
```

All changed OCaml is `ocamlformat` 0.27.0-clean (per `src/.ocamlformat`);
pre-existing formatting drift in files/regions we did not author was left
untouched.
