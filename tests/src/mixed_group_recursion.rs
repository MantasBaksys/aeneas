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
// Aeneas now *supports* extracting such a group: it emits the function together
// with the closures' `call`/`call_mut`/`call_once` bodies as one `mutual ... end`
// block of `partial_fixpoint` defs, and emits the closures' trait-instance values
// as plain `def`s after the block, inlining the trait dictionaries at the
// recursive use sites inside the group. That is the only shape Lean accepts: a
// trait-instance record can neither live inside a `partial_fixpoint` mutual block
// nor be forward-referenced from one. See REPORT-closure-mixed-scc.md.
//
// The failure must also stay LOCAL to this group: `FunsAnalysis` must still
// analyse every other declaration group, and functions that do not depend on the
// mixed group must translate normally. Previously the `MixedGroup` case failed to
// recurse into the remaining declaration groups, leaving `fun_infos` incomplete
// for the whole crate and cascading into an internal error for every unrelated
// function's signature translation.
//
// NOTE: `Tree` deliberately recurses through `Box`, not through `Vec`. Aeneas
// models `Vec<T>` as the subtype `{ l : List T // l.length <= Usize.max }`, and
// Lean's positivity checker cannot see a recursive occurrence through a
// subtype's predicate ("contains a non valid occurrence of the datatypes being
// declared"). A `Vec<Tree>` field would therefore make the generated Lean fail
// to elaborate for a reason entirely unrelated to mixed-group recursion.
//
// NOTE: the recursive call goes through a closure that is applied *directly*,
// rather than through `.map(|e| sum_tree(e))`. Both produce the same mixed SCC
// (the function is mutually recursive with its closure's `Fn*` impls), but the
// `.map` form additionally requires (a) `Iterator::map`/`collect` in the Lean
// `Iterator` model, which are currently missing, and (b) a monotonicity lemma
// for `Iterator.map.default` so that `partial_fixpoint` can discharge its
// obligation through a higher-order library combinator. Neither is related to
// mixed-group recursion, and both would stop this test from being lake-built.

pub enum Tree {
    Leaf(u32),
    Node(Box<Tree>, Box<Tree>),
}

// Recurses through a closure: this is the function that lands in a mixed group
// with its closure's `Fn*` impls.
pub fn sum_tree(t: Tree) -> u32 {
    match t {
        Tree::Leaf(n) => n,
        Tree::Node(left, right) => {
            let rec = |x: Tree| sum_tree(x);
            rec(*left) + rec(*right)
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
