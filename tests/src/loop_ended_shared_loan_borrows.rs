//@ [!lean] skip
//! Regression test for handling an *ended shared loan whose shared value still
//! contains loans/borrows* in the symbolic interpreter (`InterpMatchCtxs.ml`).
//!
//! The scrutinee `*w.wkind()` is a shared *reborrow* through a method returning
//! `&Kind`. When the matched arm loops over a borrowed slice with a non-local
//! exit (an early `return`) and a shared `Ok(())` continuation follows the
//! match, the loop's break-context join ends the reborrow's shared loan while
//! its shared value still nests the slice's shared loan. Before the fix, the
//! interpreter bailed out with "Not implemented yet"
//! (`compute_abs_borrows_loans_maps`, the `AEndedSharedLoan` case) and then
//! "Could not match the contexts" (`match_ctx_with_target`). We now register the
//! nested loans/borrows and match ended shared loans structurally.
//!
//! This is the reduced `ripgrep grep-regex ban.rs::check` shape (`match
//! *expr.kind()` over `Hir`), specialized to a `Vec<u8>` so the type is not
//! recursive-through-`Vec` (which Lean's kernel rejects for positivity reasons,
//! unrelated to this transform) and the generated Lean builds.
use std::vec::Vec;

pub enum Kind {
    Leaf(u8),
    Many(Vec<u8>),
}

pub struct Wrap {
    kind: Kind,
    tag: Box<u32>,
}

impl Wrap {
    pub fn wkind(&self) -> &Kind {
        &self.kind
    }
}

/// Matches on a shared *reborrow* `*w.wkind()`, loops over a borrowed slice in
/// one arm with an early `return`, and falls through to a shared `Ok(())` tail.
pub fn scan(w: &Wrap, byte: u8) -> Result<(), u32> {
    match *w.wkind() {
        Kind::Leaf(b) => {
            if b == byte {
                return Err(1);
            }
        }
        Kind::Many(ref xs) => {
            for x in xs.iter() {
                if *x == byte {
                    return Err(2);
                }
            }
        }
    };
    Ok(())
}
