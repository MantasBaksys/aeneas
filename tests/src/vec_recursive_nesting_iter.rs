//@ [lean] known-failure
//@ [!lean] skip

// Companion to `vec_recursive_nesting.rs`, demonstrating the miscompilation
// guard (part 4 of the fix). This mirrors the real ripgrep `regex_syntax::ast`
// shape: a struct field of type `Vec<Recursive>` that is *consumed as a `Vec`*
// (here iterated with `for c in &b.children`, which lowers to a projection of
// the rewritten field passed to `into_iter`).
//
// After the recursive `Vec` -> `List` rewrite, `VecTreeBranch.children` has
// Lean type `List VecTreeNode`, but the iteration still treats it as a `Vec`.
// Emitting that would be ill-typed Lean, so Aeneas MUST abort with a precise
// diagnostic naming the type, the field and the consuming function -- rather
// than silently miscompiling or (as before the fix) dying with an inscrutable
// Lean *kernel* error with no attribution.
//
// This is the *expected, correct* behaviour: the length bound
// `l.length <= Usize.max` cannot live inside a nested-recursive inductive, so
// consuming the field as a `Vec` needs a proof that is not available at the
// consumption site. Recovering it (an external `wfList` predicate) is a
// deliberate, separate follow-up.
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

// Consumes the recursive `Vec` field as a `Vec` (iteration -> projection +
// `into_iter`). This is what makes the guard fire.
pub fn vec_tree_sum(t: &VecTreeNode) -> u32 {
    match t {
        VecTreeNode::Leaf(n) => *n,
        VecTreeNode::Node(b) => {
            let mut total = 0u32;
            for c in &b.children {
                total += vec_tree_sum(c);
            }
            total
        }
    }
}
