//@ [!lean] skip
//! Regression test for a *dead, borrow-carrying local surviving into a loop's
//! break context* (`InterpReduceCollapse.ml`, the marker sanity check).
//!
//! A `for` loop over an iterator whose `Item` is a reference has two break
//! edges of incompatible borrow shape: the explicit `break` leaves the
//! `Option<&T>` scrutinee holding `Some(&x)` (a live borrow that is, however,
//! *dead* — never read after the break), while for-loop exhaustion leaves it
//! holding `None` (borrow-free). The symbolic interpreter joins the break
//! contexts into a template that acquires a loan-projector abstraction for the
//! `Some`-case borrow which the borrow-free `None`-break cannot match; a lone
//! projection marker then survived every reduce/collapse stage and tripped the
//! marker sanity check.
//!
//! We now release such trailing, borrow-carrying `storage_dead`s on the break
//! edges (in `PrePasses.update_loop`), exactly as Charon already does on the
//! `continue` edge, so every break context is borrow-free and the join
//! succeeds. This is the reduced `ripgrep grep-regex`
//! `literal.rs::extract_alternation` shape.

/// Generic iterator whose `Item` is a shared reference, with an explicit
/// `break`. The borrow bound in each iteration is dead at the `break`.
pub fn sum_until<'a, I: Iterator<Item = &'a u32>>(it: I) -> u32 {
    let mut acc = 0u32;
    for x in it {
        if acc > 100 {
            break;
        }
        acc = acc.wrapping_add(*x);
    }
    acc
}
