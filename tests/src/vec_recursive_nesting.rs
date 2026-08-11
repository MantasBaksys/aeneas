//@ [!lean] skip

// Regression test for recursive types that nest through `Vec`.
//
// Aeneas models `Vec<T>` as the subtype `{ l : List T // l.length <= Usize.max }`.
// When a Rust recursive type nests through `Vec` (e.g. `Node(Vec<VecTree>)` or a
// struct field `children: Vec<VecTreeNode>`), Lean's *nested* inductive compiler
// specialises the container into a private copy but cannot rewrite inside the
// subtype's dependent bound `l.length <= _` (which mentions `l`), so the kernel
// rejects the declaration with "arg #... of '...' contains a non valid
// occurrence of the datatypes being declared".
//
// The fix rewrites a *recursive* `Vec<T>` occurrence to the plain core-Lean
// `List T` (no subtype bound), which Lean's nested inductive compiler accepts.
// Because the field type changed but functions are translated independently,
// each consumption of the field *as a `Vec`* (a projection fed to `into_iter`,
// etc.) is repaired with a monadic `vecOfList : List T -> Result (Vec T)`
// coercion that re-establishes the length bound at the site.
//
// NAMING TRAP: the Lean types must NOT be called `Tree` (it collides with a
// deprecated Mathlib `Tree` and produces misleading "Tree has already been
// declared" errors). We use `VecTree*`.

// --- Recursive-through-Vec ENUM (kernel-error fix, read-only use) ---

pub enum VecTree {
    Leaf(u32),
    Node(Vec<VecTree>),
}

// Only pattern-matches the recursive-through-`Vec` type; it neither constructs
// nor consumes the `Vec` field as a `Vec`, so no coercion is needed.
pub fn vec_tree_is_leaf(t: &VecTree) -> bool {
    match t {
        VecTree::Leaf(_) => true,
        VecTree::Node(_) => false,
    }
}

// --- Recursive-through-Vec STRUCT field (kernel-error fix + coercion) ---
//
// This mirrors the real ripgrep `regex_syntax::ast` shape: a struct field of
// type `Vec<Recursive>` iterated with `for x in &field`, which lowers to a
// projection of the (now `List`-typed) field passed to `into_iter`. The
// coercion pass wraps that projection in `vecOfList`.

pub struct VecTreeBranch {
    pub children: Vec<VecTreeNode>,
}

pub enum VecTreeNode {
    Leaf(u32),
    Node(VecTreeBranch),
}

// Iterates the recursive `Vec` field (projection -> `into_iter`), but does not
// recurse into `VecTreeNode`, so the generated loop has no cross-function
// recursive call and elaborates cleanly. Exercises the `vecOfList` coercion.
pub fn vec_tree_count_children(b: &VecTreeBranch) -> u64 {
    let mut n = 0u64;
    for _c in &b.children {
        n += 1;
    }
    n
}
