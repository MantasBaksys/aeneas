//@ [!lean] skip
//! Passing a named function (a function-item value, `TFnDef`) by name when its
//! signature mentions a region.
//!
//! Region inference used to reject any `TFnDef` whose generics mentioned a
//! region (`RegionsHierarchy.ml` / `TypesAnalysis.ml`), so passing a named
//! function that takes or returns a reference as a value failed to translate.
//! This is ordinary Rust: `.map(str::trim)`, `.filter(char::is_alphanumeric)`,
//! `.map_or(false, f)` with a by-reference `f`, etc.

/// The exact grep-matcher shape: a named `fn(&u8) -> bool` passed by name to
/// `Option::map_or`.
fn is_valid_cap_letter(b: &u8) -> bool {
    matches!(*b, b'0'..=b'9' | b'a'..=b'z' | b'A'..=b'Z' | b'_')
}

pub fn map_or_by_ref(replacement: Option<&u8>) -> bool {
    replacement.map_or(false, is_valid_cap_letter)
}

/// A named function taking a reference, passed to `Iterator::map`.
fn deref_u8(b: &u8) -> u8 {
    *b
}

pub fn map_by_ref(s: &[u8]) -> impl Iterator<Item = u8> + '_ {
    s.iter().map(deref_u8)
}

/// A named function taking a reference, passed to `Iterator::filter`.
fn is_nonzero(b: &&u8) -> bool {
    **b != 0
}

pub fn filter_by_ref(s: &[u8]) -> impl Iterator<Item = &u8> {
    s.iter().filter(is_nonzero)
}

/// A named function with a reference in its *return* type, passed by name.
fn first<'a>(s: &'a [u8]) -> &'a u8 {
    &s[0]
}

pub fn map_returns_ref<'a>(o: Option<&'a [u8]>) -> Option<&'a u8> {
    o.map(first)
}

/// Control: a named function with no references in its signature, passed by
/// name. This already worked before the fix.
fn double(x: u32) -> u32 {
    x.wrapping_mul(2)
}

pub fn map_no_ref(o: Option<u32>) -> Option<u32> {
    o.map(double)
}
