//@ [lean] known-failure
//@ [!lean] skip

// Regression test for the "mixed mutually-recursive declaration group" cascade.
//
// A recursive function that recurses *through a closure* (the extremely common
// `.map(|x| f(x))` shape used in any recursive AST traversal) ends up in a
// single strongly-connected component together with its closure's
// `FnOnce`/`FnMut` trait impls and their `call_once`/`call_mut` methods. Charon
// hands Aeneas that SCC as a `MixedGroup` (a function declaration mutually
// recursive with trait implementations).
//
// Aeneas does not (yet) *support* extracting such a group, but the failure must
// stay LOCAL to this group: `FunsAnalysis` must still analyse every other
// declaration group, and functions that do not depend on the mixed group must
// translate normally. Previously the `MixedGroup` case failed to recurse into
// the remaining declaration groups, leaving `fun_infos` incomplete for the
// whole crate and cascading into an internal error for every unrelated
// function's signature translation.

pub enum Tree {
    Leaf(u32),
    Node(Vec<Tree>),
}

// Recurses through the `.map(|e| sum_tree(e))` closure: this is the function
// that lands in a mixed group with its closure's `Fn*` impls.
pub fn sum_tree(t: Tree) -> u32 {
    match t {
        Tree::Leaf(n) => n,
        Tree::Node(children) => {
            let sums: Vec<u32> = children.into_iter().map(|e| sum_tree(e)).collect();
            let mut total = 0u32;
            let mut i = 0;
            while i < sums.len() {
                total += sums[i];
                i += 1;
            }
            total
        }
    }
}

// A completely unrelated function that shares no code with `sum_tree` and
// contains no closures. It must keep translating normally even though
// `sum_tree`'s group cannot be analysed — i.e. it must NOT become collateral
// damage of the mixed group's failure.
pub fn unrelated_add(a: u32, b: u32) -> u32 {
    a + b
}
