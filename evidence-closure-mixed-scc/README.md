# Evidence: closure-mixed-SCC Lean target shape

Standalone Lean 4.31 files (no Aeneas library needed) that establish, empirically,
what Lean will and will not accept for a function that is mutually recursive with
its own closures' `Fn`/`FnMut`/`FnOnce` trait implementations (the shape Charon
hands Aeneas as a `MixedGroup`).

Run each with plain Lean (no lake):

    LEAN=~/.elan/toolchains/leanprover--lean4---v4.31.0/bin/lean
    $LEAN evidence-closure-mixed-scc/<file>.lean

- `minimal-repro.rs` — the Rust that produces the SCC (`map_tree` + `.map(|e| map_tree(e))`).
- `target-shape-WORKS.lean` — the ONLY viable extraction shape: a `mutual` block of
  the function + closure `call_mut`/`call_once` bodies, with the closure's FnMut
  dictionary built INLINE at the recursive use site, and the named trait-instance
  values emitted as plain `def`s AFTER the block. Elaborates and runs (`#eval` = "ok").
- `named-instance-forward-ref-FAILS.lean` — the FAITHFUL-to-current-extraction shape
  (function references the *named* `...FnMutInst` value). Fails: the instance value
  cannot be defined before the block (it needs `call_mut`) nor referenced from inside
  it (forward reference).
- `partial_fixpoint-mixing-FAILS.lean` — shows Lean refuses to mix a plain value
  `def` with `partial_fixpoint` functions in one `mutual` block ("needs to be marked
  partial_fixpoint"), which a trait-instance value cannot be.

Conclusion: the target shape exists, but reaching it requires inlining the closure
trait dictionary at SCC-internal use sites — an extraction-expression change, not
declaration-group export logic. See ../REPORT-closure-mixed-scc.md.
