//@ [!lean] skip
//! Implementations of `core::error::Error`.
//!
//! `Error::description` is a (deprecated) method with a default body. An
//! implementation which overrides it used to fail to extract, because the Lean
//! model of `core::error::Error` had no `description` field.
//!
//! Note: we deliberately avoid returning a string *literal* here, so that this
//! test exercises the trait model only. Returning a literal additionally
//! requires promoted statics to be supported (see `promoted_statics.rs`).

use std::error::Error;
use std::fmt;

#[derive(Debug)]
pub struct MyError {
    msg: String,
}

impl fmt::Display for MyError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.msg)
    }
}

impl Error for MyError {
    fn description(&self) -> &str {
        &self.msg
    }
}

/// An implementation which does *not* override anything: it relies on the
/// default bodies of the trait.
#[derive(Debug)]
pub struct DefaultedError;

impl fmt::Display for DefaultedError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str("defaulted")
    }
}

impl Error for DefaultedError {}
