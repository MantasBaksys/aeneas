# fix/hrtb-variance-aware — variance-aware HRTB implied-bounds check

Fix commit: `69426527` (`src/llbc/TypesAnalysis.ml`, `src/Translate.ml`,
`src/symbolic/SymbolicToPureTypes.ml`). Merged into `mantas-ripgrep`.

## Problem

`TypesAnalysis.check_no_bound_free_implied_bounds` rejected any signature in
which a higher-ranked (locally bound) lifetime was related to a free lifetime by
an implied bound. That is exactly the shape of `Iterator::find`:

```rust
fn find<P>(&mut self, predicate: P) -> Option<Self::Item>
where P: FnMut(&Self::Item) -> bool
```

With `Self::Item = &'a T`, the bound desugars to
`P: for<'x> FnMut<(&'x &'a T,), Output = bool>`. The argument type `&'x &'a T`
carries the implied bound `'a: 'x`, relating the bound lifetime `'x` to the free
lifetime `'a`. Rejecting it blocked `grep-regex` extraction.

## Why the original check exists

The check guards against invisible bound↔free constraints reaching a **backward
function**, where a region relation that Aeneas cannot see would produce an
unsound signature. That risk is real when the higher-ranked lifetime flows into
a *mutable* borrow or into a trait method's *output*.

## The fix

Make the check variance-aware via a `?(relaxed:bool)` parameter and an
`(outer, benign)` visitor state:

- Once the traversal is underneath a **shared** reference in relaxed mode, stop
  rejecting: a shared reference induces no backward function, so the constraint
  cannot reach one.
- Continue to reject through **mutable** borrows and through non-closure trait
  outputs.
- Recognise `Fn`/`FnMut`/`FnOnce` structurally via `item_meta.lang_item` (this is
  why `trait_decls` is now plumbed through `Translate.ml` and
  `SymbolicToPureTypes.ml` — plumbing only, no behaviour change).

`higher_ranked_fnmut_free_lifetime.rs` (new test) now translates sorry-free. The
three `RefTrait` known-failure tests, where the higher-ranked lifetime reaches a
method **output**, remain rejected.

## Effect

`grep-regex-full`: **12 → 9 errors**. It removes three errors, not the two
predicted: both `TypesAnalysis:983` sites **plus** one `SymbolicToPureTypes:1429`
internal error on `strip.rs`. The third is explained by `Translate.ml`'s own
comment — the check exists to cleanly *skip* a function rather than fail later
looking up its untranslated signature, so fewer skips means fewer
untranslated-signature lookups.

## Validation

| Gate | Result |
|---|---|
| Build | OK |
| `make test` | exit 0, zero oracle drift |
| 115-crate differential | 2/115, both explained (below) |
| Backward-function inspection | done — sound (below) |
| `lake build` (grep-regex) | error set byte-identical to baseline (below) |

**Differential.** `borrow_check_negative` differs in the **log only**, and only
in the emission *ordering* of identical error/warning blocks — the same binary
run three times produces three different log orderings, so this is pre-existing
nondeterminism, not the fix. `higher_ranked_fnmut_free_lifetime` differs by the
**addition** of one function; nothing is removed or altered.

**Backward-function inspection.** Because this fix relaxes a soundness guard, the
newly-translated function was hand-checked:

```lean
def find_like {T P} (inst : core.ops.function.FnMut P T Bool) (x : T) (pred : P) :
  Result Bool := do
  let (b, _) ← inst.call_mut pred x
  ok b
```

The `let (b, _) ←` shape is syntactically identical to the FnMut backward-arity
**miscompilation** guarded by `5fd05f31`, so it was checked against the Rust
source rather than assumed. In `find_like`, `pred` is taken **by value**
(`mut pred: P`), is dead at return, and the function yields only `bool`; the
discarded backward value is genuinely unobservable. The shape is correct here.

**Elaboration.** `lake build` of the full `grep-regex` output produces an error
set **byte-identical** to the pre-fix baseline (78 errors, all cascading from one
kernel error), so this fix introduces no elaboration regression. See
`REPORT-closure-scc-dict-inlining.md` §"Remaining blockers" for what that kernel
error is.
