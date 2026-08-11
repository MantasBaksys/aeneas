//@ [!lean] skip

// Regression test for recursive types that nest through `Vec`.
//
// Aeneas models `Vec<T>` as the subtype `{ l : List T // l.length <= Usize.max }`.
// When a Rust recursive type nests through `Vec` (e.g. `Node(Vec<VecTree>)`),
// Lean's *nested* inductive compiler specialises the container into a private
// copy but cannot rewrite inside the subtype's dependent bound `l.length <= _`
// (which mentions `l`), so the kernel rejects the declaration with
// "arg #1 of '...' contains a non valid occurrence of the datatypes being
// declared".
//
// The fix rewrites a *recursive* `Vec<T>` occurrence to the plain core-Lean
// `List T` (no subtype bound), which Lean's nested inductive compiler accepts.
//
// NAMING TRAP: the Lean type must NOT be called `Tree` (it collides with a
// deprecated Mathlib `Tree` and produces misleading "Tree has already been
// declared" errors). We use `VecTree`.

pub enum VecTree {
    Leaf(u32),
    Node(Vec<VecTree>),
}

// A simple function over the recursive-through-Vec type. It only pattern-matches
// (it does not construct or project the `Vec` field as a `Vec`), so the
// miscompilation guard does not fire.
pub fn vec_tree_is_leaf(t: &VecTree) -> bool {
    match t {
        VecTree::Leaf(_) => true,
        VecTree::Node(_) => false,
    }
}
