//@ [!lean] skip
//@ charon-args=--lift-associated-types=* --remove-adt-clauses --monomorphize-mut=except-types

// Reduced reproducer for the "closure that CAPTURES `&mut` borrows" defect
// (the dual of the `&mut`-in-closure-ARGUMENTS defect handled by
// `--monomorphize-mut=except-types` + closures_mut_args.rs).
//
// STATUS: FIXED. Aeneas now drops the redundant per-capture backward functions
// (see the "closure_capture_back_gids" selection in
// src/symbolic/SymbolicToPureTypes.ml), so `call_mut`/`call_once` match the
// builtin `FnMut`/`FnOnce` trait declarations
// (`Self -> Args -> Result (Output x Self)` / `Self -> Args -> Result Output`)
// and the generated Lean elaborates. This file is registered (alphabetically)
// in tests/lean/lakefile.lean.

// One captured `&mut`. The closure self is exactly the captured `&mut [u8]`, so
// its `call_mut` gets type
//   Result (Unit x closure x (closure -> closure))
// while builtin `FnMut::call_mut` expects  Result (Unit x closure).
pub fn call_fn_mut_one(a: &mut [u8], i: usize) {
    let mut write = |i: usize| a[i] = 0;
    write(i)
}

// Two captured `&mut`s: `call_mut` gains two backward continuations.
pub fn call_fn_mut_two(a: &mut [u8], b: &mut [u8], i: usize) {
    let mut write = |i: usize| {
        a[i] = 0;
        b[i] = 1;
    };
    write(i)
}

// Mix of a captured `&mut` (a) and a `&mut` argument threaded to an inner
// closure (dst): exercises both the capture path (this file) and the argument
// path (closures_mut_args.rs) at once.
pub fn call_fn_mut_mixed<A>(a: &mut [u8], mut append: A, dst: &mut Vec<u8>)
where
    A: FnMut(u8, &mut Vec<u8>),
{
    let mut step = |i: usize| {
        a[i] = 0;
        append(a[i], dst);
    };
    step(0)
}
