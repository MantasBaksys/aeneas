//@ [!lean] skip
// The `Iterator::find` pattern, minimized. A higher-ranked `FnMut` bound whose
// closure argument nests the free lifetime of the enclosing item used to be
// rejected by TypesAnalysis.check_no_bound_free_implied_bounds, exactly like
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
// It is now ACCEPTED by the variance-aware relaxation of the check: unlike the
// `RefTrait` known-failure tests, here the higher-ranked lifetime `'x` appears
// ONLY in the (contravariant) argument of the closure, under a *shared*
// reference, and never flows into a returned borrow — the closure returns
// `bool`. It therefore cannot reach any backward function, so the (invisible)
// bound<->free constraint is harmless. The `RefTrait` cases, where the
// higher-ranked lifetime reaches the *output* of a trait method, remain
// rejected.

pub fn find_like<'a, T, P>(x: &'a T, mut pred: P) -> bool
where
    P: FnMut(&&'a T) -> bool,
{
    pred(&x)
}
