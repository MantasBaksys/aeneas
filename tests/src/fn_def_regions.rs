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
// Soundness cases for the function-item region relaxation.
//
// We ignore the regions of a function-item type ([TFnDef]) because such a type
// is zero-sized: its unique inhabitant is a compile-time constant that cannot
// alias the caller's data, so it holds no borrow. The regions in its type
// describe the signature of a function one may later call, not storage the
// value currently holds; that information is re-read from the callee's own
// signature at the call site.
//
// WHICH CASES ACTUALLY GUARD THIS: only those where a function item is used as
// a VALUE (passed to a generic higher-order function), because that is what
// puts a [TFnDef] into a type the region analysis inspects. Verified by setting
// `type_analysis_ignore_fn_types = false` and re-extracting: only
// [fn_item_through_generic] and [fn_item_with_live_mut] change (they fail to
// translate); everything else is byte-identical.
//
// In particular the [pick_shared] pair below is NOT a test of the relaxation -
// see the note on it.
// -------------------------------------------------------------------------

/// A function item taking `&mut` threaded through a generic higher-order
/// function: the write-back must survive the round trip.
///
/// This DOES exercise the relaxation: `bump` is passed as a value, so its
/// function-item type becomes a type argument of `apply_mut` and the region
/// analysis inspects it.
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
/// Also exercises the relaxation, and additionally checks that the unrelated
/// live `&mut` is still given back correctly.
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

/// Two `&mut` sharing ONE lifetime, where the backward functions must be
/// attributed to different arguments (`pick_shared` gives back `x`,
/// `pick_shared2` gives back `y`).
///
/// NOTE: this is a CONTROL, not a test of the function-item relaxation. These
/// functions are called DIRECTLY, so no [TFnDef] value is ever built and the
/// relaxation never runs; the baselines here are invariant under
/// `type_analysis_ignore_fn_types`. They are kept because they pin down the
/// ordinary two-`&mut`-same-lifetime disambiguation that the fn-item cases
/// above rely on being correct underneath.
///
/// It is worth recording WHY the corresponding by-value case is absent: Rust
/// itself rejects it. Passing a function item whose signature ties two `&mut`
/// to one lifetime into a generic `Fn` bound fails with "implementation of `Fn`
/// is not general enough", because the bound is higher-ranked
/// (`for<'0,'1> Fn(&'0 mut u32, &'1 mut u32)`) while the function item only
/// implements `Fn(&'2 mut u32, &'2 mut u32)` for one specific `'2`. So the
/// shape in which an ignored region would correlate two distinct live borrows
/// is not constructible: any lifetimes that do flow through such a call are
/// forced independent by the trait bound and re-read from it.
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
