//@ [!lean] skip
//@ [lean] known-failure
// The `Iterator::find` pattern, minimized. A higher-ranked `FnMut` bound whose
// closure argument nests the free lifetime of the enclosing item is rejected by
// TypesAnalysis.check_no_bound_free_implied_bounds, exactly like
// `higher_ranked_implied_bounds_borrow.rs`.
//
// The bound `P: FnMut(&&'a T) -> bool` desugars to
//   P: for<'x> FnMut<(&'x &'a T,), Output = bool>
// The closure argument type `&'x &'a T` has the implied bound `'a: 'x`
// (the referent outlives the borrow), relating the higher-ranked (locally
// bound) lifetime `'x` to the free lifetime `'a`.
//
// This is the signature shape of
//   `<slice::Iter<'a, T> as Iterator>::find`, whose `where P: FnMut(&Self::Item)`
// bound (with `Self::Item = &'a T`) is what makes ripgrep extraction fail.
//
// NOTE for a future fix: unlike the `RefTrait` known-failure tests, here the
// higher-ranked lifetime `'x` appears ONLY in the (contravariant) argument of
// the closure and never flows into a returned borrow — the closure returns
// `bool`. A sound relaxation of the check would need to distinguish these two
// cases (see REPORT-iterator-hrtb.md), which is why this remains a
// known-failure for now rather than being silently accepted.

pub fn find_like<'a, T, P>(x: &'a T, mut pred: P) -> bool
where
    P: FnMut(&&'a T) -> bool,
{
    pred(&x)
}
