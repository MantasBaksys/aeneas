import Aeneas.Std.Scalar.Ops
import Aeneas.Std.Scalar.Bitwise

namespace Aeneas.Std

open Result Error Arith

/-!
# Core operator trait implementations for scalar types

Models for concrete `core::ops::{arith,bit}` trait methods used when Rust
lowers generic scalar operations through trait calls rather than MIR binops.
-/

@[rust_fun "core::ops::arith::{core::ops::arith::Add<u8, u8, u8>}::add"]
def core.ops.arith.U8.add (x y : U8) : Result U8 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<u8, u8, u8>}::sub"]
def core.ops.arith.U8.sub (x y : U8) : Result U8 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<u8, u8, u8>}::mul"]
def core.ops.arith.U8.mul (x y : U8) : Result U8 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<u8, u8, u8>}::div"]
def core.ops.arith.U8.div (x y : U8) : Result U8 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<u8, u8, u8>}::bitand"]
def core.ops.bit.U8.bitand (x y : U8) : Result U8 :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<u8, u8, u8>}::bitor"]
def core.ops.bit.U8.bitor (x y : U8) : Result U8 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<u8, u8, u8>}::bitxor"]
def core.ops.bit.U8.bitxor (x y : U8) : Result U8 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u8, u8>}::bitor_assign"]
def core.ops.bit.U8.bitor_assign (x y : U8) : Result U8 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u8, u8>}::bitxor_assign"]
def core.ops.bit.U8.bitxor_assign (x y : U8) : Result U8 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, u8, u8>}::shl"]
def core.ops.bit.U8.shlU8 (x : U8) (s : U8) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, u16, u8>}::shl"]
def core.ops.bit.U8.shlU16 (x : U8) (s : U16) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, u32, u8>}::shl"]
def core.ops.bit.U8.shlU32 (x : U8) (s : U32) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, u64, u8>}::shl"]
def core.ops.bit.U8.shlU64 (x : U8) (s : U64) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, u128, u8>}::shl"]
def core.ops.bit.U8.shlU128 (x : U8) (s : U128) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, usize, u8>}::shl"]
def core.ops.bit.U8.shlUsize (x : U8) (s : Usize) : Result U8 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, i8, u8>}::shl"]
def core.ops.bit.U8.shlI8 (x : U8) (s : I8) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, i16, u8>}::shl"]
def core.ops.bit.U8.shlI16 (x : U8) (s : I16) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, i32, u8>}::shl"]
def core.ops.bit.U8.shlI32 (x : U8) (s : I32) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, i64, u8>}::shl"]
def core.ops.bit.U8.shlI64 (x : U8) (s : I64) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, i128, u8>}::shl"]
def core.ops.bit.U8.shlI128 (x : U8) (s : I128) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u8, isize, u8>}::shl"]
def core.ops.bit.U8.shlIsize (x : U8) (s : Isize) : Result U8 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, u8, u8>}::shr"]
def core.ops.bit.U8.shrU8 (x : U8) (s : U8) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, u16, u8>}::shr"]
def core.ops.bit.U8.shrU16 (x : U8) (s : U16) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, u32, u8>}::shr"]
def core.ops.bit.U8.shrU32 (x : U8) (s : U32) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, u64, u8>}::shr"]
def core.ops.bit.U8.shrU64 (x : U8) (s : U64) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, u128, u8>}::shr"]
def core.ops.bit.U8.shrU128 (x : U8) (s : U128) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, usize, u8>}::shr"]
def core.ops.bit.U8.shrUsize (x : U8) (s : Usize) : Result U8 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, i8, u8>}::shr"]
def core.ops.bit.U8.shrI8 (x : U8) (s : I8) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, i16, u8>}::shr"]
def core.ops.bit.U8.shrI16 (x : U8) (s : I16) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, i32, u8>}::shr"]
def core.ops.bit.U8.shrI32 (x : U8) (s : I32) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, i64, u8>}::shr"]
def core.ops.bit.U8.shrI64 (x : U8) (s : I64) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, i128, u8>}::shr"]
def core.ops.bit.U8.shrI128 (x : U8) (s : I128) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u8, isize, u8>}::shr"]
def core.ops.bit.U8.shrIsize (x : U8) (s : Isize) : Result U8 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<u16, u16, u16>}::add"]
def core.ops.arith.U16.add (x y : U16) : Result U16 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<u16, u16, u16>}::sub"]
def core.ops.arith.U16.sub (x y : U16) : Result U16 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<u16, u16, u16>}::mul"]
def core.ops.arith.U16.mul (x y : U16) : Result U16 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<u16, u16, u16>}::div"]
def core.ops.arith.U16.div (x y : U16) : Result U16 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<u16, u16, u16>}::bitand"]
def core.ops.bit.U16.bitand (x y : U16) : Result U16 :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<u16, u16, u16>}::bitor"]
def core.ops.bit.U16.bitor (x y : U16) : Result U16 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<u16, u16, u16>}::bitxor"]
def core.ops.bit.U16.bitxor (x y : U16) : Result U16 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u16, u16>}::bitor_assign"]
def core.ops.bit.U16.bitor_assign (x y : U16) : Result U16 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u16, u16>}::bitxor_assign"]
def core.ops.bit.U16.bitxor_assign (x y : U16) : Result U16 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, u8, u16>}::shl"]
def core.ops.bit.U16.shlU8 (x : U16) (s : U8) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, u16, u16>}::shl"]
def core.ops.bit.U16.shlU16 (x : U16) (s : U16) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, u32, u16>}::shl"]
def core.ops.bit.U16.shlU32 (x : U16) (s : U32) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, u64, u16>}::shl"]
def core.ops.bit.U16.shlU64 (x : U16) (s : U64) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, u128, u16>}::shl"]
def core.ops.bit.U16.shlU128 (x : U16) (s : U128) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, usize, u16>}::shl"]
def core.ops.bit.U16.shlUsize (x : U16) (s : Usize) : Result U16 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, i8, u16>}::shl"]
def core.ops.bit.U16.shlI8 (x : U16) (s : I8) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, i16, u16>}::shl"]
def core.ops.bit.U16.shlI16 (x : U16) (s : I16) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, i32, u16>}::shl"]
def core.ops.bit.U16.shlI32 (x : U16) (s : I32) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, i64, u16>}::shl"]
def core.ops.bit.U16.shlI64 (x : U16) (s : I64) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, i128, u16>}::shl"]
def core.ops.bit.U16.shlI128 (x : U16) (s : I128) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u16, isize, u16>}::shl"]
def core.ops.bit.U16.shlIsize (x : U16) (s : Isize) : Result U16 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, u8, u16>}::shr"]
def core.ops.bit.U16.shrU8 (x : U16) (s : U8) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, u16, u16>}::shr"]
def core.ops.bit.U16.shrU16 (x : U16) (s : U16) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, u32, u16>}::shr"]
def core.ops.bit.U16.shrU32 (x : U16) (s : U32) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, u64, u16>}::shr"]
def core.ops.bit.U16.shrU64 (x : U16) (s : U64) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, u128, u16>}::shr"]
def core.ops.bit.U16.shrU128 (x : U16) (s : U128) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, usize, u16>}::shr"]
def core.ops.bit.U16.shrUsize (x : U16) (s : Usize) : Result U16 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, i8, u16>}::shr"]
def core.ops.bit.U16.shrI8 (x : U16) (s : I8) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, i16, u16>}::shr"]
def core.ops.bit.U16.shrI16 (x : U16) (s : I16) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, i32, u16>}::shr"]
def core.ops.bit.U16.shrI32 (x : U16) (s : I32) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, i64, u16>}::shr"]
def core.ops.bit.U16.shrI64 (x : U16) (s : I64) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, i128, u16>}::shr"]
def core.ops.bit.U16.shrI128 (x : U16) (s : I128) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u16, isize, u16>}::shr"]
def core.ops.bit.U16.shrIsize (x : U16) (s : Isize) : Result U16 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<u32, u32, u32>}::add"]
def core.ops.arith.U32.add (x y : U32) : Result U32 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<u32, u32, u32>}::sub"]
def core.ops.arith.U32.sub (x y : U32) : Result U32 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<u32, u32, u32>}::mul"]
def core.ops.arith.U32.mul (x y : U32) : Result U32 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<u32, u32, u32>}::div"]
def core.ops.arith.U32.div (x y : U32) : Result U32 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<u32, u32, u32>}::bitand"]
def core.ops.bit.U32.bitand (x y : U32) : Result U32 :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<u32, u32, u32>}::bitor"]
def core.ops.bit.U32.bitor (x y : U32) : Result U32 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<u32, u32, u32>}::bitxor"]
def core.ops.bit.U32.bitxor (x y : U32) : Result U32 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u32, u32>}::bitor_assign"]
def core.ops.bit.U32.bitor_assign (x y : U32) : Result U32 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u32, u32>}::bitxor_assign"]
def core.ops.bit.U32.bitxor_assign (x y : U32) : Result U32 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, u8, u32>}::shl"]
def core.ops.bit.U32.shlU8 (x : U32) (s : U8) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, u16, u32>}::shl"]
def core.ops.bit.U32.shlU16 (x : U32) (s : U16) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, u32, u32>}::shl"]
def core.ops.bit.U32.shlU32 (x : U32) (s : U32) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, u64, u32>}::shl"]
def core.ops.bit.U32.shlU64 (x : U32) (s : U64) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, u128, u32>}::shl"]
def core.ops.bit.U32.shlU128 (x : U32) (s : U128) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, usize, u32>}::shl"]
def core.ops.bit.U32.shlUsize (x : U32) (s : Usize) : Result U32 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, i8, u32>}::shl"]
def core.ops.bit.U32.shlI8 (x : U32) (s : I8) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, i16, u32>}::shl"]
def core.ops.bit.U32.shlI16 (x : U32) (s : I16) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, i32, u32>}::shl"]
def core.ops.bit.U32.shlI32 (x : U32) (s : I32) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, i64, u32>}::shl"]
def core.ops.bit.U32.shlI64 (x : U32) (s : I64) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, i128, u32>}::shl"]
def core.ops.bit.U32.shlI128 (x : U32) (s : I128) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u32, isize, u32>}::shl"]
def core.ops.bit.U32.shlIsize (x : U32) (s : Isize) : Result U32 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, u8, u32>}::shr"]
def core.ops.bit.U32.shrU8 (x : U32) (s : U8) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, u16, u32>}::shr"]
def core.ops.bit.U32.shrU16 (x : U32) (s : U16) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, u32, u32>}::shr"]
def core.ops.bit.U32.shrU32 (x : U32) (s : U32) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, u64, u32>}::shr"]
def core.ops.bit.U32.shrU64 (x : U32) (s : U64) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, u128, u32>}::shr"]
def core.ops.bit.U32.shrU128 (x : U32) (s : U128) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, usize, u32>}::shr"]
def core.ops.bit.U32.shrUsize (x : U32) (s : Usize) : Result U32 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, i8, u32>}::shr"]
def core.ops.bit.U32.shrI8 (x : U32) (s : I8) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, i16, u32>}::shr"]
def core.ops.bit.U32.shrI16 (x : U32) (s : I16) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, i32, u32>}::shr"]
def core.ops.bit.U32.shrI32 (x : U32) (s : I32) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, i64, u32>}::shr"]
def core.ops.bit.U32.shrI64 (x : U32) (s : I64) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, i128, u32>}::shr"]
def core.ops.bit.U32.shrI128 (x : U32) (s : I128) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u32, isize, u32>}::shr"]
def core.ops.bit.U32.shrIsize (x : U32) (s : Isize) : Result U32 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<u64, u64, u64>}::add"]
def core.ops.arith.U64.add (x y : U64) : Result U64 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<u64, u64, u64>}::sub"]
def core.ops.arith.U64.sub (x y : U64) : Result U64 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<u64, u64, u64>}::mul"]
def core.ops.arith.U64.mul (x y : U64) : Result U64 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<u64, u64, u64>}::div"]
def core.ops.arith.U64.div (x y : U64) : Result U64 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<u64, u64, u64>}::bitand"]
def core.ops.bit.U64.bitand (x y : U64) : Result U64 :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<u64, u64, u64>}::bitor"]
def core.ops.bit.U64.bitor (x y : U64) : Result U64 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<u64, u64, u64>}::bitxor"]
def core.ops.bit.U64.bitxor (x y : U64) : Result U64 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u64, u64>}::bitor_assign"]
def core.ops.bit.U64.bitor_assign (x y : U64) : Result U64 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u64, u64>}::bitxor_assign"]
def core.ops.bit.U64.bitxor_assign (x y : U64) : Result U64 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, u8, u64>}::shl"]
def core.ops.bit.U64.shlU8 (x : U64) (s : U8) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, u16, u64>}::shl"]
def core.ops.bit.U64.shlU16 (x : U64) (s : U16) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, u32, u64>}::shl"]
def core.ops.bit.U64.shlU32 (x : U64) (s : U32) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, u64, u64>}::shl"]
def core.ops.bit.U64.shlU64 (x : U64) (s : U64) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, u128, u64>}::shl"]
def core.ops.bit.U64.shlU128 (x : U64) (s : U128) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, usize, u64>}::shl"]
def core.ops.bit.U64.shlUsize (x : U64) (s : Usize) : Result U64 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, i8, u64>}::shl"]
def core.ops.bit.U64.shlI8 (x : U64) (s : I8) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, i16, u64>}::shl"]
def core.ops.bit.U64.shlI16 (x : U64) (s : I16) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, i32, u64>}::shl"]
def core.ops.bit.U64.shlI32 (x : U64) (s : I32) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, i64, u64>}::shl"]
def core.ops.bit.U64.shlI64 (x : U64) (s : I64) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, i128, u64>}::shl"]
def core.ops.bit.U64.shlI128 (x : U64) (s : I128) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u64, isize, u64>}::shl"]
def core.ops.bit.U64.shlIsize (x : U64) (s : Isize) : Result U64 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, u8, u64>}::shr"]
def core.ops.bit.U64.shrU8 (x : U64) (s : U8) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, u16, u64>}::shr"]
def core.ops.bit.U64.shrU16 (x : U64) (s : U16) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, u32, u64>}::shr"]
def core.ops.bit.U64.shrU32 (x : U64) (s : U32) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, u64, u64>}::shr"]
def core.ops.bit.U64.shrU64 (x : U64) (s : U64) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, u128, u64>}::shr"]
def core.ops.bit.U64.shrU128 (x : U64) (s : U128) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, usize, u64>}::shr"]
def core.ops.bit.U64.shrUsize (x : U64) (s : Usize) : Result U64 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, i8, u64>}::shr"]
def core.ops.bit.U64.shrI8 (x : U64) (s : I8) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, i16, u64>}::shr"]
def core.ops.bit.U64.shrI16 (x : U64) (s : I16) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, i32, u64>}::shr"]
def core.ops.bit.U64.shrI32 (x : U64) (s : I32) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, i64, u64>}::shr"]
def core.ops.bit.U64.shrI64 (x : U64) (s : I64) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, i128, u64>}::shr"]
def core.ops.bit.U64.shrI128 (x : U64) (s : I128) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u64, isize, u64>}::shr"]
def core.ops.bit.U64.shrIsize (x : U64) (s : Isize) : Result U64 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<u128, u128, u128>}::add"]
def core.ops.arith.U128.add (x y : U128) : Result U128 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<u128, u128, u128>}::sub"]
def core.ops.arith.U128.sub (x y : U128) : Result U128 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<u128, u128, u128>}::mul"]
def core.ops.arith.U128.mul (x y : U128) : Result U128 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<u128, u128, u128>}::div"]
def core.ops.arith.U128.div (x y : U128) : Result U128 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<u128, u128, u128>}::bitand"]
def core.ops.bit.U128.bitand (x y : U128) : Result U128 :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<u128, u128, u128>}::bitor"]
def core.ops.bit.U128.bitor (x y : U128) : Result U128 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<u128, u128, u128>}::bitxor"]
def core.ops.bit.U128.bitxor (x y : U128) : Result U128 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u128, u128>}::bitor_assign"]
def core.ops.bit.U128.bitor_assign (x y : U128) : Result U128 :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u128, u128>}::bitxor_assign"]
def core.ops.bit.U128.bitxor_assign (x y : U128) : Result U128 :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, u8, u128>}::shl"]
def core.ops.bit.U128.shlU8 (x : U128) (s : U8) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, u16, u128>}::shl"]
def core.ops.bit.U128.shlU16 (x : U128) (s : U16) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, u32, u128>}::shl"]
def core.ops.bit.U128.shlU32 (x : U128) (s : U32) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, u64, u128>}::shl"]
def core.ops.bit.U128.shlU64 (x : U128) (s : U64) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, u128, u128>}::shl"]
def core.ops.bit.U128.shlU128 (x : U128) (s : U128) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, usize, u128>}::shl"]
def core.ops.bit.U128.shlUsize (x : U128) (s : Usize) : Result U128 :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, i8, u128>}::shl"]
def core.ops.bit.U128.shlI8 (x : U128) (s : I8) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, i16, u128>}::shl"]
def core.ops.bit.U128.shlI16 (x : U128) (s : I16) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, i32, u128>}::shl"]
def core.ops.bit.U128.shlI32 (x : U128) (s : I32) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, i64, u128>}::shl"]
def core.ops.bit.U128.shlI64 (x : U128) (s : I64) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, i128, u128>}::shl"]
def core.ops.bit.U128.shlI128 (x : U128) (s : I128) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<u128, isize, u128>}::shl"]
def core.ops.bit.U128.shlIsize (x : U128) (s : Isize) : Result U128 :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, u8, u128>}::shr"]
def core.ops.bit.U128.shrU8 (x : U128) (s : U8) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, u16, u128>}::shr"]
def core.ops.bit.U128.shrU16 (x : U128) (s : U16) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, u32, u128>}::shr"]
def core.ops.bit.U128.shrU32 (x : U128) (s : U32) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, u64, u128>}::shr"]
def core.ops.bit.U128.shrU64 (x : U128) (s : U64) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, u128, u128>}::shr"]
def core.ops.bit.U128.shrU128 (x : U128) (s : U128) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, usize, u128>}::shr"]
def core.ops.bit.U128.shrUsize (x : U128) (s : Usize) : Result U128 :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, i8, u128>}::shr"]
def core.ops.bit.U128.shrI8 (x : U128) (s : I8) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, i16, u128>}::shr"]
def core.ops.bit.U128.shrI16 (x : U128) (s : I16) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, i32, u128>}::shr"]
def core.ops.bit.U128.shrI32 (x : U128) (s : I32) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, i64, u128>}::shr"]
def core.ops.bit.U128.shrI64 (x : U128) (s : I64) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, i128, u128>}::shr"]
def core.ops.bit.U128.shrI128 (x : U128) (s : I128) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<u128, isize, u128>}::shr"]
def core.ops.bit.U128.shrIsize (x : U128) (s : Isize) : Result U128 :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<usize, usize, usize>}::add"]
def core.ops.arith.Usize.add (x y : Usize) : Result Usize :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<usize, usize, usize>}::sub"]
def core.ops.arith.Usize.sub (x y : Usize) : Result Usize :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<usize, usize, usize>}::mul"]
def core.ops.arith.Usize.mul (x y : Usize) : Result Usize :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<usize, usize, usize>}::div"]
def core.ops.arith.Usize.div (x y : Usize) : Result Usize :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<usize, usize, usize>}::bitand"]
def core.ops.bit.Usize.bitand (x y : Usize) : Result Usize :=
  ok (UScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<usize, usize, usize>}::bitor"]
def core.ops.bit.Usize.bitor (x y : Usize) : Result Usize :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<usize, usize, usize>}::bitxor"]
def core.ops.bit.Usize.bitxor (x y : Usize) : Result Usize :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<usize, usize>}::bitor_assign"]
def core.ops.bit.Usize.bitor_assign (x y : Usize) : Result Usize :=
  ok (UScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<usize, usize>}::bitxor_assign"]
def core.ops.bit.Usize.bitxor_assign (x y : Usize) : Result Usize :=
  ok (UScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, u8, usize>}::shl"]
def core.ops.bit.Usize.shlU8 (x : Usize) (s : U8) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, u16, usize>}::shl"]
def core.ops.bit.Usize.shlU16 (x : Usize) (s : U16) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, u32, usize>}::shl"]
def core.ops.bit.Usize.shlU32 (x : Usize) (s : U32) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, u64, usize>}::shl"]
def core.ops.bit.Usize.shlU64 (x : Usize) (s : U64) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, u128, usize>}::shl"]
def core.ops.bit.Usize.shlU128 (x : Usize) (s : U128) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, usize, usize>}::shl"]
def core.ops.bit.Usize.shlUsize (x : Usize) (s : Usize) : Result Usize :=
  UScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, i8, usize>}::shl"]
def core.ops.bit.Usize.shlI8 (x : Usize) (s : I8) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, i16, usize>}::shl"]
def core.ops.bit.Usize.shlI16 (x : Usize) (s : I16) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, i32, usize>}::shl"]
def core.ops.bit.Usize.shlI32 (x : Usize) (s : I32) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, i64, usize>}::shl"]
def core.ops.bit.Usize.shlI64 (x : Usize) (s : I64) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, i128, usize>}::shl"]
def core.ops.bit.Usize.shlI128 (x : Usize) (s : I128) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<usize, isize, usize>}::shl"]
def core.ops.bit.Usize.shlIsize (x : Usize) (s : Isize) : Result Usize :=
  UScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, u8, usize>}::shr"]
def core.ops.bit.Usize.shrU8 (x : Usize) (s : U8) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, u16, usize>}::shr"]
def core.ops.bit.Usize.shrU16 (x : Usize) (s : U16) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, u32, usize>}::shr"]
def core.ops.bit.Usize.shrU32 (x : Usize) (s : U32) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, u64, usize>}::shr"]
def core.ops.bit.Usize.shrU64 (x : Usize) (s : U64) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, u128, usize>}::shr"]
def core.ops.bit.Usize.shrU128 (x : Usize) (s : U128) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, usize, usize>}::shr"]
def core.ops.bit.Usize.shrUsize (x : Usize) (s : Usize) : Result Usize :=
  UScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, i8, usize>}::shr"]
def core.ops.bit.Usize.shrI8 (x : Usize) (s : I8) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, i16, usize>}::shr"]
def core.ops.bit.Usize.shrI16 (x : Usize) (s : I16) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, i32, usize>}::shr"]
def core.ops.bit.Usize.shrI32 (x : Usize) (s : I32) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, i64, usize>}::shr"]
def core.ops.bit.Usize.shrI64 (x : Usize) (s : I64) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, i128, usize>}::shr"]
def core.ops.bit.Usize.shrI128 (x : Usize) (s : I128) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<usize, isize, usize>}::shr"]
def core.ops.bit.Usize.shrIsize (x : Usize) (s : Isize) : Result Usize :=
  UScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<i8, i8, i8>}::add"]
def core.ops.arith.I8.add (x y : I8) : Result I8 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<i8, i8, i8>}::sub"]
def core.ops.arith.I8.sub (x y : I8) : Result I8 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<i8, i8, i8>}::mul"]
def core.ops.arith.I8.mul (x y : I8) : Result I8 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<i8, i8, i8>}::div"]
def core.ops.arith.I8.div (x y : I8) : Result I8 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<i8, i8, i8>}::bitand"]
def core.ops.bit.I8.bitand (x y : I8) : Result I8 :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<i8, i8, i8>}::bitor"]
def core.ops.bit.I8.bitor (x y : I8) : Result I8 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<i8, i8, i8>}::bitxor"]
def core.ops.bit.I8.bitxor (x y : I8) : Result I8 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i8, i8>}::bitor_assign"]
def core.ops.bit.I8.bitor_assign (x y : I8) : Result I8 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i8, i8>}::bitxor_assign"]
def core.ops.bit.I8.bitxor_assign (x y : I8) : Result I8 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, u8, i8>}::shl"]
def core.ops.bit.I8.shlU8 (x : I8) (s : U8) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, u16, i8>}::shl"]
def core.ops.bit.I8.shlU16 (x : I8) (s : U16) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, u32, i8>}::shl"]
def core.ops.bit.I8.shlU32 (x : I8) (s : U32) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, u64, i8>}::shl"]
def core.ops.bit.I8.shlU64 (x : I8) (s : U64) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, u128, i8>}::shl"]
def core.ops.bit.I8.shlU128 (x : I8) (s : U128) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, usize, i8>}::shl"]
def core.ops.bit.I8.shlUsize (x : I8) (s : Usize) : Result I8 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, i8, i8>}::shl"]
def core.ops.bit.I8.shlI8 (x : I8) (s : I8) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, i16, i8>}::shl"]
def core.ops.bit.I8.shlI16 (x : I8) (s : I16) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, i32, i8>}::shl"]
def core.ops.bit.I8.shlI32 (x : I8) (s : I32) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, i64, i8>}::shl"]
def core.ops.bit.I8.shlI64 (x : I8) (s : I64) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, i128, i8>}::shl"]
def core.ops.bit.I8.shlI128 (x : I8) (s : I128) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i8, isize, i8>}::shl"]
def core.ops.bit.I8.shlIsize (x : I8) (s : Isize) : Result I8 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, u8, i8>}::shr"]
def core.ops.bit.I8.shrU8 (x : I8) (s : U8) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, u16, i8>}::shr"]
def core.ops.bit.I8.shrU16 (x : I8) (s : U16) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, u32, i8>}::shr"]
def core.ops.bit.I8.shrU32 (x : I8) (s : U32) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, u64, i8>}::shr"]
def core.ops.bit.I8.shrU64 (x : I8) (s : U64) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, u128, i8>}::shr"]
def core.ops.bit.I8.shrU128 (x : I8) (s : U128) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, usize, i8>}::shr"]
def core.ops.bit.I8.shrUsize (x : I8) (s : Usize) : Result I8 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, i8, i8>}::shr"]
def core.ops.bit.I8.shrI8 (x : I8) (s : I8) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, i16, i8>}::shr"]
def core.ops.bit.I8.shrI16 (x : I8) (s : I16) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, i32, i8>}::shr"]
def core.ops.bit.I8.shrI32 (x : I8) (s : I32) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, i64, i8>}::shr"]
def core.ops.bit.I8.shrI64 (x : I8) (s : I64) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, i128, i8>}::shr"]
def core.ops.bit.I8.shrI128 (x : I8) (s : I128) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i8, isize, i8>}::shr"]
def core.ops.bit.I8.shrIsize (x : I8) (s : Isize) : Result I8 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<i16, i16, i16>}::add"]
def core.ops.arith.I16.add (x y : I16) : Result I16 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<i16, i16, i16>}::sub"]
def core.ops.arith.I16.sub (x y : I16) : Result I16 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<i16, i16, i16>}::mul"]
def core.ops.arith.I16.mul (x y : I16) : Result I16 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<i16, i16, i16>}::div"]
def core.ops.arith.I16.div (x y : I16) : Result I16 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<i16, i16, i16>}::bitand"]
def core.ops.bit.I16.bitand (x y : I16) : Result I16 :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<i16, i16, i16>}::bitor"]
def core.ops.bit.I16.bitor (x y : I16) : Result I16 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<i16, i16, i16>}::bitxor"]
def core.ops.bit.I16.bitxor (x y : I16) : Result I16 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i16, i16>}::bitor_assign"]
def core.ops.bit.I16.bitor_assign (x y : I16) : Result I16 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i16, i16>}::bitxor_assign"]
def core.ops.bit.I16.bitxor_assign (x y : I16) : Result I16 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, u8, i16>}::shl"]
def core.ops.bit.I16.shlU8 (x : I16) (s : U8) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, u16, i16>}::shl"]
def core.ops.bit.I16.shlU16 (x : I16) (s : U16) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, u32, i16>}::shl"]
def core.ops.bit.I16.shlU32 (x : I16) (s : U32) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, u64, i16>}::shl"]
def core.ops.bit.I16.shlU64 (x : I16) (s : U64) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, u128, i16>}::shl"]
def core.ops.bit.I16.shlU128 (x : I16) (s : U128) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, usize, i16>}::shl"]
def core.ops.bit.I16.shlUsize (x : I16) (s : Usize) : Result I16 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, i8, i16>}::shl"]
def core.ops.bit.I16.shlI8 (x : I16) (s : I8) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, i16, i16>}::shl"]
def core.ops.bit.I16.shlI16 (x : I16) (s : I16) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, i32, i16>}::shl"]
def core.ops.bit.I16.shlI32 (x : I16) (s : I32) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, i64, i16>}::shl"]
def core.ops.bit.I16.shlI64 (x : I16) (s : I64) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, i128, i16>}::shl"]
def core.ops.bit.I16.shlI128 (x : I16) (s : I128) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i16, isize, i16>}::shl"]
def core.ops.bit.I16.shlIsize (x : I16) (s : Isize) : Result I16 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, u8, i16>}::shr"]
def core.ops.bit.I16.shrU8 (x : I16) (s : U8) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, u16, i16>}::shr"]
def core.ops.bit.I16.shrU16 (x : I16) (s : U16) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, u32, i16>}::shr"]
def core.ops.bit.I16.shrU32 (x : I16) (s : U32) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, u64, i16>}::shr"]
def core.ops.bit.I16.shrU64 (x : I16) (s : U64) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, u128, i16>}::shr"]
def core.ops.bit.I16.shrU128 (x : I16) (s : U128) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, usize, i16>}::shr"]
def core.ops.bit.I16.shrUsize (x : I16) (s : Usize) : Result I16 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, i8, i16>}::shr"]
def core.ops.bit.I16.shrI8 (x : I16) (s : I8) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, i16, i16>}::shr"]
def core.ops.bit.I16.shrI16 (x : I16) (s : I16) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, i32, i16>}::shr"]
def core.ops.bit.I16.shrI32 (x : I16) (s : I32) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, i64, i16>}::shr"]
def core.ops.bit.I16.shrI64 (x : I16) (s : I64) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, i128, i16>}::shr"]
def core.ops.bit.I16.shrI128 (x : I16) (s : I128) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i16, isize, i16>}::shr"]
def core.ops.bit.I16.shrIsize (x : I16) (s : Isize) : Result I16 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<i32, i32, i32>}::add"]
def core.ops.arith.I32.add (x y : I32) : Result I32 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<i32, i32, i32>}::sub"]
def core.ops.arith.I32.sub (x y : I32) : Result I32 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<i32, i32, i32>}::mul"]
def core.ops.arith.I32.mul (x y : I32) : Result I32 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<i32, i32, i32>}::div"]
def core.ops.arith.I32.div (x y : I32) : Result I32 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<i32, i32, i32>}::bitand"]
def core.ops.bit.I32.bitand (x y : I32) : Result I32 :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<i32, i32, i32>}::bitor"]
def core.ops.bit.I32.bitor (x y : I32) : Result I32 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<i32, i32, i32>}::bitxor"]
def core.ops.bit.I32.bitxor (x y : I32) : Result I32 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i32, i32>}::bitor_assign"]
def core.ops.bit.I32.bitor_assign (x y : I32) : Result I32 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i32, i32>}::bitxor_assign"]
def core.ops.bit.I32.bitxor_assign (x y : I32) : Result I32 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, u8, i32>}::shl"]
def core.ops.bit.I32.shlU8 (x : I32) (s : U8) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, u16, i32>}::shl"]
def core.ops.bit.I32.shlU16 (x : I32) (s : U16) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, u32, i32>}::shl"]
def core.ops.bit.I32.shlU32 (x : I32) (s : U32) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, u64, i32>}::shl"]
def core.ops.bit.I32.shlU64 (x : I32) (s : U64) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, u128, i32>}::shl"]
def core.ops.bit.I32.shlU128 (x : I32) (s : U128) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, usize, i32>}::shl"]
def core.ops.bit.I32.shlUsize (x : I32) (s : Usize) : Result I32 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, i8, i32>}::shl"]
def core.ops.bit.I32.shlI8 (x : I32) (s : I8) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, i16, i32>}::shl"]
def core.ops.bit.I32.shlI16 (x : I32) (s : I16) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, i32, i32>}::shl"]
def core.ops.bit.I32.shlI32 (x : I32) (s : I32) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, i64, i32>}::shl"]
def core.ops.bit.I32.shlI64 (x : I32) (s : I64) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, i128, i32>}::shl"]
def core.ops.bit.I32.shlI128 (x : I32) (s : I128) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i32, isize, i32>}::shl"]
def core.ops.bit.I32.shlIsize (x : I32) (s : Isize) : Result I32 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, u8, i32>}::shr"]
def core.ops.bit.I32.shrU8 (x : I32) (s : U8) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, u16, i32>}::shr"]
def core.ops.bit.I32.shrU16 (x : I32) (s : U16) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, u32, i32>}::shr"]
def core.ops.bit.I32.shrU32 (x : I32) (s : U32) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, u64, i32>}::shr"]
def core.ops.bit.I32.shrU64 (x : I32) (s : U64) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, u128, i32>}::shr"]
def core.ops.bit.I32.shrU128 (x : I32) (s : U128) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, usize, i32>}::shr"]
def core.ops.bit.I32.shrUsize (x : I32) (s : Usize) : Result I32 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, i8, i32>}::shr"]
def core.ops.bit.I32.shrI8 (x : I32) (s : I8) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, i16, i32>}::shr"]
def core.ops.bit.I32.shrI16 (x : I32) (s : I16) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, i32, i32>}::shr"]
def core.ops.bit.I32.shrI32 (x : I32) (s : I32) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, i64, i32>}::shr"]
def core.ops.bit.I32.shrI64 (x : I32) (s : I64) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, i128, i32>}::shr"]
def core.ops.bit.I32.shrI128 (x : I32) (s : I128) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i32, isize, i32>}::shr"]
def core.ops.bit.I32.shrIsize (x : I32) (s : Isize) : Result I32 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<i64, i64, i64>}::add"]
def core.ops.arith.I64.add (x y : I64) : Result I64 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<i64, i64, i64>}::sub"]
def core.ops.arith.I64.sub (x y : I64) : Result I64 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<i64, i64, i64>}::mul"]
def core.ops.arith.I64.mul (x y : I64) : Result I64 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<i64, i64, i64>}::div"]
def core.ops.arith.I64.div (x y : I64) : Result I64 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<i64, i64, i64>}::bitand"]
def core.ops.bit.I64.bitand (x y : I64) : Result I64 :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<i64, i64, i64>}::bitor"]
def core.ops.bit.I64.bitor (x y : I64) : Result I64 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<i64, i64, i64>}::bitxor"]
def core.ops.bit.I64.bitxor (x y : I64) : Result I64 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i64, i64>}::bitor_assign"]
def core.ops.bit.I64.bitor_assign (x y : I64) : Result I64 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i64, i64>}::bitxor_assign"]
def core.ops.bit.I64.bitxor_assign (x y : I64) : Result I64 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, u8, i64>}::shl"]
def core.ops.bit.I64.shlU8 (x : I64) (s : U8) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, u16, i64>}::shl"]
def core.ops.bit.I64.shlU16 (x : I64) (s : U16) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, u32, i64>}::shl"]
def core.ops.bit.I64.shlU32 (x : I64) (s : U32) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, u64, i64>}::shl"]
def core.ops.bit.I64.shlU64 (x : I64) (s : U64) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, u128, i64>}::shl"]
def core.ops.bit.I64.shlU128 (x : I64) (s : U128) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, usize, i64>}::shl"]
def core.ops.bit.I64.shlUsize (x : I64) (s : Usize) : Result I64 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, i8, i64>}::shl"]
def core.ops.bit.I64.shlI8 (x : I64) (s : I8) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, i16, i64>}::shl"]
def core.ops.bit.I64.shlI16 (x : I64) (s : I16) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, i32, i64>}::shl"]
def core.ops.bit.I64.shlI32 (x : I64) (s : I32) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, i64, i64>}::shl"]
def core.ops.bit.I64.shlI64 (x : I64) (s : I64) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, i128, i64>}::shl"]
def core.ops.bit.I64.shlI128 (x : I64) (s : I128) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i64, isize, i64>}::shl"]
def core.ops.bit.I64.shlIsize (x : I64) (s : Isize) : Result I64 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, u8, i64>}::shr"]
def core.ops.bit.I64.shrU8 (x : I64) (s : U8) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, u16, i64>}::shr"]
def core.ops.bit.I64.shrU16 (x : I64) (s : U16) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, u32, i64>}::shr"]
def core.ops.bit.I64.shrU32 (x : I64) (s : U32) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, u64, i64>}::shr"]
def core.ops.bit.I64.shrU64 (x : I64) (s : U64) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, u128, i64>}::shr"]
def core.ops.bit.I64.shrU128 (x : I64) (s : U128) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, usize, i64>}::shr"]
def core.ops.bit.I64.shrUsize (x : I64) (s : Usize) : Result I64 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, i8, i64>}::shr"]
def core.ops.bit.I64.shrI8 (x : I64) (s : I8) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, i16, i64>}::shr"]
def core.ops.bit.I64.shrI16 (x : I64) (s : I16) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, i32, i64>}::shr"]
def core.ops.bit.I64.shrI32 (x : I64) (s : I32) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, i64, i64>}::shr"]
def core.ops.bit.I64.shrI64 (x : I64) (s : I64) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, i128, i64>}::shr"]
def core.ops.bit.I64.shrI128 (x : I64) (s : I128) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i64, isize, i64>}::shr"]
def core.ops.bit.I64.shrIsize (x : I64) (s : Isize) : Result I64 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<i128, i128, i128>}::add"]
def core.ops.arith.I128.add (x y : I128) : Result I128 :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<i128, i128, i128>}::sub"]
def core.ops.arith.I128.sub (x y : I128) : Result I128 :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<i128, i128, i128>}::mul"]
def core.ops.arith.I128.mul (x y : I128) : Result I128 :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<i128, i128, i128>}::div"]
def core.ops.arith.I128.div (x y : I128) : Result I128 :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<i128, i128, i128>}::bitand"]
def core.ops.bit.I128.bitand (x y : I128) : Result I128 :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<i128, i128, i128>}::bitor"]
def core.ops.bit.I128.bitor (x y : I128) : Result I128 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<i128, i128, i128>}::bitxor"]
def core.ops.bit.I128.bitxor (x y : I128) : Result I128 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i128, i128>}::bitor_assign"]
def core.ops.bit.I128.bitor_assign (x y : I128) : Result I128 :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i128, i128>}::bitxor_assign"]
def core.ops.bit.I128.bitxor_assign (x y : I128) : Result I128 :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, u8, i128>}::shl"]
def core.ops.bit.I128.shlU8 (x : I128) (s : U8) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, u16, i128>}::shl"]
def core.ops.bit.I128.shlU16 (x : I128) (s : U16) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, u32, i128>}::shl"]
def core.ops.bit.I128.shlU32 (x : I128) (s : U32) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, u64, i128>}::shl"]
def core.ops.bit.I128.shlU64 (x : I128) (s : U64) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, u128, i128>}::shl"]
def core.ops.bit.I128.shlU128 (x : I128) (s : U128) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, usize, i128>}::shl"]
def core.ops.bit.I128.shlUsize (x : I128) (s : Usize) : Result I128 :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, i8, i128>}::shl"]
def core.ops.bit.I128.shlI8 (x : I128) (s : I8) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, i16, i128>}::shl"]
def core.ops.bit.I128.shlI16 (x : I128) (s : I16) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, i32, i128>}::shl"]
def core.ops.bit.I128.shlI32 (x : I128) (s : I32) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, i64, i128>}::shl"]
def core.ops.bit.I128.shlI64 (x : I128) (s : I64) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, i128, i128>}::shl"]
def core.ops.bit.I128.shlI128 (x : I128) (s : I128) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<i128, isize, i128>}::shl"]
def core.ops.bit.I128.shlIsize (x : I128) (s : Isize) : Result I128 :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, u8, i128>}::shr"]
def core.ops.bit.I128.shrU8 (x : I128) (s : U8) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, u16, i128>}::shr"]
def core.ops.bit.I128.shrU16 (x : I128) (s : U16) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, u32, i128>}::shr"]
def core.ops.bit.I128.shrU32 (x : I128) (s : U32) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, u64, i128>}::shr"]
def core.ops.bit.I128.shrU64 (x : I128) (s : U64) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, u128, i128>}::shr"]
def core.ops.bit.I128.shrU128 (x : I128) (s : U128) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, usize, i128>}::shr"]
def core.ops.bit.I128.shrUsize (x : I128) (s : Usize) : Result I128 :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, i8, i128>}::shr"]
def core.ops.bit.I128.shrI8 (x : I128) (s : I8) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, i16, i128>}::shr"]
def core.ops.bit.I128.shrI16 (x : I128) (s : I16) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, i32, i128>}::shr"]
def core.ops.bit.I128.shrI32 (x : I128) (s : I32) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, i64, i128>}::shr"]
def core.ops.bit.I128.shrI64 (x : I128) (s : I64) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, i128, i128>}::shr"]
def core.ops.bit.I128.shrI128 (x : I128) (s : I128) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<i128, isize, i128>}::shr"]
def core.ops.bit.I128.shrIsize (x : I128) (s : Isize) : Result I128 :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::arith::{core::ops::arith::Add<isize, isize, isize>}::add"]
def core.ops.arith.Isize.add (x y : Isize) : Result Isize :=
  x + y

@[rust_fun "core::ops::arith::{core::ops::arith::Sub<isize, isize, isize>}::sub"]
def core.ops.arith.Isize.sub (x y : Isize) : Result Isize :=
  x - y

@[rust_fun "core::ops::arith::{core::ops::arith::Mul<isize, isize, isize>}::mul"]
def core.ops.arith.Isize.mul (x y : Isize) : Result Isize :=
  x * y

@[rust_fun "core::ops::arith::{core::ops::arith::Div<isize, isize, isize>}::div"]
def core.ops.arith.Isize.div (x y : Isize) : Result Isize :=
  x / y

@[rust_fun "core::ops::bit::{core::ops::bit::BitAnd<isize, isize, isize>}::bitand"]
def core.ops.bit.Isize.bitand (x y : Isize) : Result Isize :=
  ok (IScalar.and x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOr<isize, isize, isize>}::bitor"]
def core.ops.bit.Isize.bitor (x y : Isize) : Result Isize :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXor<isize, isize, isize>}::bitxor"]
def core.ops.bit.Isize.bitxor (x y : Isize) : Result Isize :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitOrAssign<isize, isize>}::bitor_assign"]
def core.ops.bit.Isize.bitor_assign (x y : Isize) : Result Isize :=
  ok (IScalar.or x y)

@[rust_fun "core::ops::bit::{core::ops::bit::BitXorAssign<isize, isize>}::bitxor_assign"]
def core.ops.bit.Isize.bitxor_assign (x y : Isize) : Result Isize :=
  ok (IScalar.xor x y)

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, u8, isize>}::shl"]
def core.ops.bit.Isize.shlU8 (x : Isize) (s : U8) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, u16, isize>}::shl"]
def core.ops.bit.Isize.shlU16 (x : Isize) (s : U16) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, u32, isize>}::shl"]
def core.ops.bit.Isize.shlU32 (x : Isize) (s : U32) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, u64, isize>}::shl"]
def core.ops.bit.Isize.shlU64 (x : Isize) (s : U64) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, u128, isize>}::shl"]
def core.ops.bit.Isize.shlU128 (x : Isize) (s : U128) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, usize, isize>}::shl"]
def core.ops.bit.Isize.shlUsize (x : Isize) (s : Usize) : Result Isize :=
  IScalar.shiftLeft_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, i8, isize>}::shl"]
def core.ops.bit.Isize.shlI8 (x : Isize) (s : I8) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, i16, isize>}::shl"]
def core.ops.bit.Isize.shlI16 (x : Isize) (s : I16) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, i32, isize>}::shl"]
def core.ops.bit.Isize.shlI32 (x : Isize) (s : I32) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, i64, isize>}::shl"]
def core.ops.bit.Isize.shlI64 (x : Isize) (s : I64) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, i128, isize>}::shl"]
def core.ops.bit.Isize.shlI128 (x : Isize) (s : I128) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shl<isize, isize, isize>}::shl"]
def core.ops.bit.Isize.shlIsize (x : Isize) (s : Isize) : Result Isize :=
  IScalar.shiftLeft_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, u8, isize>}::shr"]
def core.ops.bit.Isize.shrU8 (x : Isize) (s : U8) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, u16, isize>}::shr"]
def core.ops.bit.Isize.shrU16 (x : Isize) (s : U16) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, u32, isize>}::shr"]
def core.ops.bit.Isize.shrU32 (x : Isize) (s : U32) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, u64, isize>}::shr"]
def core.ops.bit.Isize.shrU64 (x : Isize) (s : U64) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, u128, isize>}::shr"]
def core.ops.bit.Isize.shrU128 (x : Isize) (s : U128) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, usize, isize>}::shr"]
def core.ops.bit.Isize.shrUsize (x : Isize) (s : Usize) : Result Isize :=
  IScalar.shiftRight_UScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, i8, isize>}::shr"]
def core.ops.bit.Isize.shrI8 (x : Isize) (s : I8) : Result Isize :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, i16, isize>}::shr"]
def core.ops.bit.Isize.shrI16 (x : Isize) (s : I16) : Result Isize :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, i32, isize>}::shr"]
def core.ops.bit.Isize.shrI32 (x : Isize) (s : I32) : Result Isize :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, i64, isize>}::shr"]
def core.ops.bit.Isize.shrI64 (x : Isize) (s : I64) : Result Isize :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, i128, isize>}::shr"]
def core.ops.bit.Isize.shrI128 (x : Isize) (s : I128) : Result Isize :=
  IScalar.shiftRight_IScalar x s

@[rust_fun "core::ops::bit::{core::ops::bit::Shr<isize, isize, isize>}::shr"]
def core.ops.bit.Isize.shrIsize (x : Isize) (s : Isize) : Result Isize :=
  IScalar.shiftRight_IScalar x s

end Aeneas.Std
