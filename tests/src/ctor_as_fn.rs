//@ [!lean] skip
//! Using an enum variant as a first-class function value.
//!
//! Charon turns `E::A` (used as a function) into a function item whose LLBC
//! name is `E::A` -- exactly the name of the variant constructor. Aeneas used
//! to extract a monadic wrapper under that same name, which collided with the
//! inductive constructor generated in `Types.lean`.

pub enum E {
    A(usize),
    B(usize),
}

/// `E::A` is passed as a function value here.
pub fn map_ctor(o: Option<usize>) -> Option<E> {
    o.map(E::A)
}

/// Same, for a second variant, to make sure disambiguation is per-variant.
pub fn map_ctor_b(o: Option<usize>) -> Option<E> {
    o.map(E::B)
}

/// A struct constructor used as a function value.
pub struct S(pub usize);

pub fn map_struct_ctor(o: Option<usize>) -> Option<S> {
    o.map(S)
}
