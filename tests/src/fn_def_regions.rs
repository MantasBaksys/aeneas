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

// -------------------------------------------------------------------------
// Soundness cases: the relaxation must not lose track of *which* mutable
// borrow a write-back belongs to.
//
// We ignore the regions of a function-item type because such a type is
// zero-sized: its unique inhabitant is a compile-time constant that cannot
// alias the caller's data, so it holds no borrow. The regions in its type
// describe the signature of a function one may later call, not storage the
// value currently holds; that information is re-read from the callee's own
// signature at the call site.
//
// The cases below are the ones that would break if that were wrong.
// -------------------------------------------------------------------------

/// Two `&mut` sharing ONE lifetime, returning one of them. The generated
/// backward functions must attribute the write-back to the *correct*
/// argument: `pick_shared` gives back `x`, `pick_shared2` gives back `y`.
/// If the region relaxation lost information these two would be identical.
pub fn pick_shared<'a>(x: &'a mut u32, _y: &'a mut u32) -> &'a mut u32 {
    x
}

pub fn pick_shared2<'a>(_x: &'a mut u32, y: &'a mut u32) -> &'a mut u32 {
    y
}

pub fn write_through_pick(a: &mut u32, b: &mut u32) {
    let r = pick_shared(a, b);
    *r += 1;
}

pub fn write_through_pick2(a: &mut u32, b: &mut u32) {
    let r = pick_shared2(a, b);
    *r += 1;
}

/// A function item taking `&mut` threaded through a generic higher-order
/// function: the write-back must survive the round trip.
fn bump(x: &mut u32) {
    *x += 1;
}

fn apply_mut<F: Fn(&mut u32)>(x: &mut u32, f: F) {
    f(x);
}

pub fn fn_item_through_generic(x: &mut u32) {
    apply_mut(x, bump);
}

/// The riskiest combination: a function item held by a generic higher-order
/// function while a mutable borrow is live and written through afterwards.
fn is_pos(c: &u8) -> bool {
    *c > 0
}

fn any_of<F: Fn(&u8) -> bool>(v: &[u8], f: F) -> bool {
    let mut acc = false;
    for b in v {
        acc = acc || f(b);
    }
    acc
}

pub fn fn_item_with_live_mut(v: &[u8], out: &mut u32) -> bool {
    let hit = any_of(v, is_pos);
    if hit {
        *out += 1;
    }
    hit
}
