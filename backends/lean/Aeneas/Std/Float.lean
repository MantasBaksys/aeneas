import Aeneas.Std.Core

/-! # Rust's floating-point types

The Lean backend names Rust's `f32`/`f64` `F32`/`F64` (see `float_name` in
`src/extract/ExtractBase.ml`), but until now nothing declared those names. A
crate mentioning a float therefore extracted to a file referring to undeclared
identifiers; Lean's auto-bound implicits silently turned every occurrence into a
fresh type variable, and the resulting errors ("Invalid field notation ... `F32`
has type `Sort ?u`", kernel "declaration has free variables") pointed nowhere
near the cause.

`f32` and `f64` are exactly Lean's `Float32` and `Float`, both of which are
IEEE-754 binary32/binary64, so we can give them proper definitions rather than
axiomatising them.

Rust's `f16` and `f128` have no Lean counterpart and are still unstable
(rust-lang/rust#116909); we declare them opaque so that code merely mentioning
them elaborates, while nothing can be proved about their values.
-/

namespace Aeneas.Std

@[rust_type "f32"]
abbrev F32 := Float32

@[rust_type "f64"]
abbrev F64 := Float

/-- Rust's `f16`. Unstable, and with no Lean counterpart: opaque on purpose. -/
@[rust_type "f16" (body := .opaque)]
structure F16 where
  toBits : BitVec 16

/-- Rust's `f128`. Unstable, and with no Lean counterpart: opaque on purpose. -/
@[rust_type "f128" (body := .opaque)]
structure F128 where
  toBits : BitVec 128

end Aeneas.Std
