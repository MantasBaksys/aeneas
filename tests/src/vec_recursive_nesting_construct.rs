//@ [lean] known-failure
//@ [!lean] skip

// Companion to `vec_recursive_nesting.rs`, demonstrating the miscompilation
// guard. After the recursive `Vec` -> `List` rewrite, `VecTreeBranch.children`
// has Lean type `List VecTreeNode`, and consuming the field *as a `Vec`* inside
// a `Result` monad is repaired by the `vecOfList` coercion. But *constructing*
// the type from a `Vec` (a `Vec` value flowing into the now-`List` field) is
// the opposite direction: it would need a total `Vec -> List` (`.val`)
// coercion, which is intentionally NOT inserted (a deliberate follow-up).
//
// So Aeneas MUST abort with a precise diagnostic naming the type, the field and
// the constructing function -- rather than silently emitting ill-typed Lean (a
// `Vec` value in a `List` field slot), or (as before the fix) dying with an
// inscrutable Lean *kernel* error on the type declaration with no attribution.
//
// NAMING TRAP: do not call the Lean type `Tree` (collides with a deprecated
// Mathlib `Tree`).

pub struct VecTreeBranch {
    pub children: Vec<VecTreeNode>,
}

pub enum VecTreeNode {
    Leaf(u32),
    Node(VecTreeBranch),
}

// Constructs the recursive-through-`Vec` type from a `Vec`: the `children`
// argument (a `Vec`) flows into the `children` field, which the rewrite retyped
// to `List`. This is what makes the guard fire.
pub fn make_branch(children: Vec<VecTreeNode>) -> VecTreeBranch {
    VecTreeBranch { children }
}
