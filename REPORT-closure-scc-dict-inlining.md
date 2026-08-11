# fix/closure-scc-dict-inlining — translating mixed closure/function SCCs

Fix commit: `02441236` (`src/Translate.ml`, `src/interp/Interp.ml`,
`src/pure/ReorderDecls.ml`, `src/extract/{Extract,ExtractBase,ExtractTypes}.ml`).
Merged into `mantas-ripgrep`.

## Problem

A function that recurses *through one of its own closures* — the ubiquitous
`f(...).map(|e| f(e))` shape in any recursive AST traversal — lands in a single
strongly-connected component together with its closure's `Fn`/`FnMut`/`FnOnce`
trait impls and their `call`/`call_mut`/`call_once` methods. Charon hands Aeneas
that SCC as a `MixedGroup` (a function declaration mutually recursive with trait
implementations), which Aeneas could not extract.

## Why the obvious shapes do not work

Verified experimentally in `leanverify/` before implementing anything:

| Shape | File | Result |
|---|---|---|
| Trait-instance record inside the `partial_fixpoint` mutual block | `partial_fixpoint-mixing-FAILS.lean` | **fails** |
| Trait-instance record forward-referenced from the block | `named-instance-forward-ref-FAILS.lean` | **fails** |
| Records as plain `def`s *after* the block, dictionaries inlined at recursive use sites | `target-shape-WORKS.lean` | **elaborates** |

All three were re-run independently; the two negative results are genuine and the
target shape is sound. This is the only shape Lean accepts.

## The fix

Emit the group as one `mutual ... end` block of `partial_fixpoint` definitions
containing the function together with the closures' `call`/`call_mut`/`call_once`
bodies; emit the closures' trait-instance values as plain `def`s **after** the
block; inline the trait dictionaries at the recursive use sites inside the block.

## Effect

- Alone: `grep-regex-full` **12 → 6 errors**.
- Combined with `fix/hrtb-variance-aware`: **12 → 3 errors**.

The two fixes are genuinely complementary, and this was confirmed rather than
inferred. `SymbolicToPureTypes:1429` is precisely what kept
`strip::strip_from_match_ascii` an axiom in this branch's output; hrtb removes it,
and this fix then translates the group. In the combined output
`strip_from_match_ascii` is a real `def` inside a `mutual` block, with **zero**
`strip` entries in `FunsExternal_Template.lean`.

Residual 3 errors: 2 × `ban.rs` (non-local exit, `PrePasses`) and 1 × `literal.rs`
(deep-loop reduce/collapse).

## Validation

| Gate | Result |
|---|---|
| Build | OK |
| `make test` | exit 0 after test reconciliation (below) |
| `lake build` of the feature test | **passes** — see below |
| `lake build` (grep-regex) | error set byte-identical to baseline |

**The feature test now genuinely gates the feature.** `mixed_group_recursion` was
a `known-failure`; it now translates, so it was reshaped (commit `618fb68f`) into
a test that can actually be lake-built, and registered in
`tests/lean/lakefile.lean`. Two incidental blockers had to be removed from it:

1. `Tree` recursed through `Vec<Tree>`. Aeneas models `Vec<T>` as the subtype
   `{ l : List T // l.length ≤ Usize.max }`, and Lean's positivity checker cannot
   see a recursive occurrence through a subtype's *predicate* — the type ends up
   to the left of an arrow in `List Tree → Prop`, which is a negative position.
   Changed to `Box`, which Aeneas erases.
2. The recursion went through `.map(|e| f(e))`, which additionally requires
   `Iterator::map`/`collect` in the Lean `Iterator` model (currently **missing**)
   and a monotonicity lemma for `Iterator.map.default` so `partial_fixpoint` can
   discharge its obligation through a higher-order combinator. Changed to a
   directly-applied closure, which produces the same mixed SCC.

The reshaped test **elaborates** (`lake build MixedGroupRecursion` exit 0) and has
the intended shape: `mutual` block of `partial_fixpoint` defs, trait-instance
records as plain `def`s after it, and `unrelated_add` still translating normally —
the cascade-locality property the test was originally written for.

This is the first end-to-end Rust → Aeneas → Lean validation of the fix.

## Remaining blockers (independent of this fix)

**`Vec`-nested inductives block the whole `grep-regex` lake build.** Any Rust type
containing `Vec<Self>` extracts to Lean that cannot elaborate, for the positivity
reason above. `regex_syntax::ast::Ast` has exactly that shape, so `Types.lean`
fails with one kernel error on `ClassSetUnion.mk` and 77 cascading
"Unknown identifier" errors.

This is **pre-existing and orthogonal**, established two ways: a five-line file
with no fix loaded reproduces the kernel error, and the pre-fix baseline produces a
**byte-identical** 78-error set. It is nonetheless a hard blocker for verifying
`grep-regex`, and note that because `Types.lean` fails first, `Funs.lean` — and
therefore the `strip.rs` mutual block — has **not yet been elaboration-checked**.

Only three types are affected: `Alternation`, `ClassSetUnion`, `Concat`. Two ways
forward:

- **Axiomatize them** via charon `--opaque`. Cheap, and sound for our purposes
  since grep-regex matches on the HIR and the compiled automaton rather than
  walking the parser AST. A workaround, and it would unblock elaboration-checking
  of `Funs.lean` immediately.
- **Fix codegen**: emit a field recursive through `Vec` as a plain `List` (which
  nests fine) and carry the length bound as a separate well-formedness predicate.
  General and upstreamable, but real work.
