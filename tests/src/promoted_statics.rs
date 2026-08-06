//@ [!lean] skip
//! Returning references to *promoted* constants.
//!
//! When a function returns a reference to a literal aggregate, rustc promotes
//! the literal to an anonymous `'static` global and the function body becomes a
//! read of that global. Aeneas used to fail on those reads with
//! "There should be no bottoms in the value", because the global's place was
//! never initialized before being read.

/// The minimal case: a promoted byte-slice literal.
pub fn just_promoted() -> &'static [u8] {
    &[b'\r', b'\n']
}

/// A promoted string literal.
pub fn promoted_str() -> &'static str {
    "description() is deprecated; use Display"
}

pub enum LineTerminator {
    Byte(u8),
    CRLF,
}

/// The shape that occurs in ripgrep's `grep-matcher`: a promoted constant in
/// one arm of a match, a projection out of `self` in the other.
impl LineTerminator {
    pub fn as_bytes(&self) -> &[u8] {
        match self {
            LineTerminator::Byte(ref byte) => std::slice::from_ref(byte),
            LineTerminator::CRLF => &[b'\r', b'\n'],
        }
    }
}

/// Control: same shape, but no promoted constant. This already worked.
pub fn only_from_ref(byte: &u8) -> &[u8] {
    std::slice::from_ref(byte)
}
