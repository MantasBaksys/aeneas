//@ [!lean] skip
//! Regression test for the `update_loops` tail-duplication (continuation-sinking)
//! normalization in `PrePasses.ml`.
//!
//! Both functions below place a loop with a *non-local exit* (an early `return`)
//! that carries a borrow (the slice iterator) inside a `match`/`if` arm, while a
//! *shared* continuation (`Ok(())`) sits after the match. Before the
//! normalization, that shared continuation lived outside the loop's own block,
//! so the loop's break context could not be resolved locally and Aeneas rejected
//! the function at the borrow guard ("Non-local control flow ... out of a loop
//! that carries a borrow across the exit is not supported yet", `PrePasses.ml`).
//!
//! The normalization sinks a copy of the shared tail into each fall-through arm,
//! so every arm ends in its own `return` and the loop resolves its break context
//! locally. These are the `e2`/`e8` shapes from the ripgrep `ban.rs::check`
//! campaign, specialized to slices of scalars so the recursive-through-`Vec`
//! type (which Lean's kernel rejects for positivity reasons, unrelated to this
//! transform) is avoided and the generated Lean builds.
use std::vec::Vec;

/// `e2` shape: a two-way `if`/`match` with a shared `Ok(())` continuation, one
/// arm looping over a borrowed slice with an early `return`.
pub fn check_flag(flag: bool, xs: &[u8], byte: u8) -> Result<(), u32> {
    match flag {
        true => {}
        false => {
            for x in xs.iter() {
                if *x == byte {
                    return Err(1);
                }
            }
        }
    };
    Ok(())
}

pub enum Shape {
    Empty,
    One(u8),
    Many(Vec<u8>),
    Pair(u8, u8),
}

/// `e8`/`ban.rs::check` shape: a multi-arm `match` where several arms fall
/// through to a shared `Ok(())`, and one arm loops over a borrowed slice with an
/// early `return`.
pub fn check_shape(s: &Shape, byte: u8) -> Result<(), u32> {
    match *s {
        Shape::Empty => {}
        Shape::One(b) => {
            if b == byte {
                return Err(1);
            }
        }
        Shape::Many(ref xs) => {
            for x in xs.iter() {
                if *x == byte {
                    return Err(2);
                }
            }
        }
        Shape::Pair(a, b) => {
            if a == byte || b == byte {
                return Err(3);
            }
        }
    };
    Ok(())
}
