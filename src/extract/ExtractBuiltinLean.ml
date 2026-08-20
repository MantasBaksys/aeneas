(** THIS FILE WAS AUTOMATICALLY GENERATED FROM LEAN: DO NOT MODIFY DIRECTLY *)
open ExtractBuiltinCore

let lean_builtin_types = [
  (* file: "Aeneas/Std/Alloc.lean", line: 16 *)
  mk_type "alloc::alloc::Global" "Global" ~kind:(KEnum [("Mk", Some "mk")]);
  (* file: "Aeneas/Std/Alloc.lean", line: 11 *)
  mk_type "alloc::string::String" "String";
  (* file: "Aeneas/Std/Vec.lean", line: 21 *)
  mk_type "alloc::vec::Vec" "alloc.vec.Vec";
  (* file: "Aeneas/Std/VecIter.lean", line: 8 *)
  mk_type "alloc::vec::into_iter::IntoIter" "alloc.vec.into_iter.IntoIter" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Ptr.lean", line: 78 *)
  mk_type "core::alloc::layout::Layout" "core.alloc.layout.Layout" ~kind:(KStruct [("size", Some "size"); ("align", Some "align")]);
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 123 *)
  mk_type "core::array::TryFromSliceError" "core.array.TryFromSliceError";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 60 *)
  mk_type "core::cmp::Ordering" "Ordering" ~kind:(KEnum [("Less", Some "lt"); ("Equal", Some "eq"); ("Greater", Some "gt")]);
  (* file: "Aeneas/Std/Core/Convert.lean", line: 10 *)
  mk_type "core::convert::Infallible" "core.convert.Infallible" ~kind:(KEnum []);
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 47 *)
  mk_type "core::fmt::Arguments" "core.fmt.Arguments";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 8 *)
  mk_type "core::fmt::Error" "core.fmt.Error";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 12 *)
  mk_type "core::fmt::Formatter" "core.fmt.Formatter";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 50 *)
  mk_type "core::fmt::rt::Argument" "core.fmt.rt.Argument";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 36 *)
  mk_type "core::iter::adapters::enumerate::Enumerate" "core.iter.adapters.enumerate.Enumerate" ~kind:(KStruct [("iter", Some "iter"); ("count", Some "count")]);
  (* file: "Aeneas/Std/Core/Iter.lean", line: 788 *)
  mk_type "core::iter::adapters::map::Map" "core.iter.adapters.map.Map" ~kind:(KStruct [("iter", Some "iter"); ("f", Some "f")]);
  (* file: "Aeneas/Std/Core/Iter.lean", line: 46 *)
  mk_type "core::iter::adapters::rev::Rev" "core.iter.adapters.rev.Rev" ~kind:(KStruct [("iter", Some "iter")]);
  (* file: "Aeneas/Std/Core/Iter.lean", line: 30 *)
  mk_type "core::iter::adapters::step_by::StepBy" "core.iter.adapters.step_by.StepBy";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 41 *)
  mk_type "core::iter::adapters::take::Take" "core.iter.adapters.take.Take" ~kind:(KStruct [("iter", Some "iter"); ("n", Some "n")]);
  (* file: "Aeneas/Std/Core/Iter.lean", line: 54 *)
  mk_type "core::iter::adapters::zip::Zip" "core.iter.adapters.zip.Zip" ~kind:(KStruct [("fst", Some "fst"); ("snd", Some "snd")]);
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 870 *)
  mk_type "core::num::error::TryFromIntError" "core.num.error.TryFromIntError";
  (* file: "Aeneas/Std/Core/Ops.lean", line: 92 *)
  mk_type "core::ops::control_flow::ControlFlow" "core.ops.control_flow.ControlFlow" ~kind:(KEnum [("Continue", Some "Continue"); ("Break", Some "Break")]);
  (* file: "Aeneas/Std/Range.lean", line: 14 *)
  mk_type "core::ops::range::Range" "core.ops.range.Range" ~kind:(KStruct [("start", Some "start"); ("end", Some "«end»")]);
  (* file: "Aeneas/Std/Core/Core.lean", line: 124 *)
  mk_type "core::ops::range::RangeFrom" "core.ops.range.RangeFrom" ~kind:(KStruct [("start", Some "start")]);
  (* file: "Aeneas/Std/Range.lean", line: 30 *)
  mk_type "core::ops::range::RangeInclusive" "core.ops.range.RangeInclusive" ~kind:(KStruct [("start", Some "start"); ("end", Some "«end»"); ("exhausted", Some "exhausted")]);
  (* file: "Aeneas/Std/Range.lean", line: 20 *)
  mk_type "core::ops::range::RangeTo" "core.ops.range.RangeTo" ~kind:(KStruct [("end", Some "«end»")]);
  (* file: "Aeneas/Std/Core/Core.lean", line: 13 *)
  mk_type "core::option::Option" "Option" ~prefix_variant_names:false ~kind:(KEnum [("None", Some "none"); ("Some", Some "some")]);
  (* file: "Aeneas/Std/Core/Panic.lean", line: 6 *)
  mk_type "core::panic::panic_info::PanicInfo" "core.panic.panic_info.PanicInfo";
  (* file: "Aeneas/Std/Core/Core.lean", line: 128 *)
  mk_type "core::panicking::AssertKind" "core.panicking.AssertKind" ~kind:(KEnum [("Eq", Some "Eq"); ("Ne", Some "Ne"); ("Match", Some "Match")]);
  (* file: "Aeneas/Std/Core/Pin.lean", line: 6 *)
  mk_type "core::pin::Pin" "core.pin.Pin";
  (* file: "Aeneas/Std/Core/Pin.lean", line: 10 *)
  mk_type "core::pin::helper::PinHelper" "core.pin.helper.PinHelper";
  (* file: "Aeneas/Std/Core/Ptr.lean", line: 74 *)
  mk_type "core::ptr::alignment::Alignment" "core.ptr.alignment.Alignment";
  (* file: "Aeneas/Std/Core/Ptr.lean", line: 7 *)
  mk_type "core::ptr::alignment::AlignmentEnum" "core.ptr.alignment.AlignmentEnum" ~kind:(KEnum [("_Align1Shl0", Some "_Align1Shl0"); ("_Align1Shl1", Some "_Align1Shl1"); ("_Align1Shl2", Some "_Align1Shl2"); ("_Align1Shl3", Some "_Align1Shl3"); ("_Align1Shl4", Some "_Align1Shl4"); ("_Align1Shl5", Some "_Align1Shl5"); ("_Align1Shl6", Some "_Align1Shl6"); ("_Align1Shl7", Some "_Align1Shl7"); ("_Align1Shl8", Some "_Align1Shl8"); ("_Align1Shl9", Some "_Align1Shl9"); ("_Align1Shl10", Some "_Align1Shl10"); ("_Align1Shl11", Some "_Align1Shl11"); ("_Align1Shl12", Some "_Align1Shl12"); ("_Align1Shl13", Some "_Align1Shl13"); ("_Align1Shl14", Some "_Align1Shl14"); ("_Align1Shl15", Some "_Align1Shl15"); ("_Align1Shl16", Some "_Align1Shl16"); ("_Align1Shl17", Some "_Align1Shl17"); ("_Align1Shl18", Some "_Align1Shl18"); ("_Align1Shl19", Some "_Align1Shl19"); ("_Align1Shl20", Some "_Align1Shl20"); ("_Align1Shl21", Some "_Align1Shl21"); ("_Align1Shl22", Some "_Align1Shl22"); ("_Align1Shl23", Some "_Align1Shl23"); ("_Align1Shl24", Some "_Align1Shl24"); ("_Align1Shl25", Some "_Align1Shl25"); ("_Align1Shl26", Some "_Align1Shl26"); ("_Align1Shl27", Some "_Align1Shl27"); ("_Align1Shl28", Some "_Align1Shl28"); ("_Align1Shl29", Some "_Align1Shl29"); ("_Align1Shl30", Some "_Align1Shl30"); ("_Align1Shl31", Some "_Align1Shl31"); ("_Align1Shl32", Some "_Align1Shl32"); ("_Align1Shl33", Some "_Align1Shl33"); ("_Align1Shl34", Some "_Align1Shl34"); ("_Align1Shl35", Some "_Align1Shl35"); ("_Align1Shl36", Some "_Align1Shl36"); ("_Align1Shl37", Some "_Align1Shl37"); ("_Align1Shl38", Some "_Align1Shl38"); ("_Align1Shl39", Some "_Align1Shl39"); ("_Align1Shl40", Some "_Align1Shl40"); ("_Align1Shl41", Some "_Align1Shl41"); ("_Align1Shl42", Some "_Align1Shl42"); ("_Align1Shl43", Some "_Align1Shl43"); ("_Align1Shl44", Some "_Align1Shl44"); ("_Align1Shl45", Some "_Align1Shl45"); ("_Align1Shl46", Some "_Align1Shl46"); ("_Align1Shl47", Some "_Align1Shl47"); ("_Align1Shl48", Some "_Align1Shl48"); ("_Align1Shl49", Some "_Align1Shl49"); ("_Align1Shl50", Some "_Align1Shl50"); ("_Align1Shl51", Some "_Align1Shl51"); ("_Align1Shl52", Some "_Align1Shl52"); ("_Align1Shl53", Some "_Align1Shl53"); ("_Align1Shl54", Some "_Align1Shl54"); ("_Align1Shl55", Some "_Align1Shl55"); ("_Align1Shl56", Some "_Align1Shl56"); ("_Align1Shl57", Some "_Align1Shl57"); ("_Align1Shl58", Some "_Align1Shl58"); ("_Align1Shl59", Some "_Align1Shl59"); ("_Align1Shl60", Some "_Align1Shl60"); ("_Align1Shl61", Some "_Align1Shl61"); ("_Align1Shl62", Some "_Align1Shl62"); ("_Align1Shl63", Some "_Align1Shl63")]);
  (* file: "Aeneas/Std/Core/Result.lean", line: 5 *)
  mk_type "core::result::Result" "core.result.Result" ~kind:(KEnum [("Ok", Some "Ok"); ("Err", Some "Err")]);
  (* file: "Aeneas/Std/SliceIter.lean", line: 125 *)
  mk_type "core::slice::iter::ChunksExact" "core.slice.iter.ChunksExact";
  (* file: "Aeneas/Std/SliceIter.lean", line: 13 *)
  mk_type "core::slice::iter::Iter" "core.slice.iter.Iter" ~kind:(KStruct [("slice", Some "slice"); ("i", Some "i")]);
  (* file: "Aeneas/Std/SliceIter.lean", line: 20 *)
  mk_type "core::slice::iter::IterMut" "core.slice.iter.IterMut" ~mut_regions:([0]);
  (* file: "Aeneas/Std/StringIter.lean", line: 7 *)
  mk_type "core::str::iter::Chars" "core.str.iter.Chars";
  (* file: "Aeneas/Std/Core/Atomic.lean", line: 6 *)
  mk_type "core::sync::atomic::AtomicBool" "core.sync.atomic.AtomicBool";
  (* file: "Aeneas/Std/Core/Atomic.lean", line: 10 *)
  mk_type "core::sync::atomic::AtomicU32" "core.sync.atomic.AtomicU32";
  (* file: "Aeneas/Std/Float.lean", line: 36 *)
  mk_type "f128" "F128";
  (* file: "Aeneas/Std/Float.lean", line: 31 *)
  mk_type "f16" "F16";
  (* file: "Aeneas/Std/Float.lean", line: 24 *)
  mk_type "f32" "F32";
  (* file: "Aeneas/Std/Float.lean", line: 27 *)
  mk_type "f64" "F64";
]

let lean_builtin_consts = [
]

let lean_builtin_funs = [
  (* file: "Aeneas/Std/Alloc.lean", line: 25 *)
  mk_fun "alloc::alloc::{core::clone::Clone<alloc::alloc::Global>}::clone" "alloc.alloc.CloneGlobal.clone";
  (* file: "Aeneas/Std/Core/Core.lean", line: 50 *)
  mk_fun "alloc::boxed::{core::clone::Clone<Box<@T>>}::clone" "core.alloc.boxed.CloneBox.clone" ~keep_params:(Some [true; false]) ~keep_trait_clauses:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 230 *)
  mk_fun "alloc::boxed::{core::cmp::PartialEq<Box<@T>, Box<@T>>}::eq" "alloc.boxed.PartialEqBox.eq" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Core.lean", line: 15 *)
  mk_fun "alloc::boxed::{core::convert::AsMut<Box<@T>, @T>}::as_mut" "alloc.boxed.AsMutBox.as_mut" ~keep_params:(Some [true; false]) ~can_fail:false;
  (* file: "Aeneas/Std/Alloc.lean", line: 19 *)
  mk_fun "alloc::boxed::{core::ops::deref::Deref<Box<@T>, @T>}::deref" "alloc.boxed.Box.deref" ~keep_params:(Some [true; false]) ~can_fail:false;
  (* file: "Aeneas/Std/Alloc.lean", line: 22 *)
  mk_fun "alloc::boxed::{core::ops::deref::DerefMut<Box<@T>, @T>}::deref_mut" "alloc.boxed.Box.deref_mut" ~keep_params:(Some [true; false]) ~can_fail:false;
  (* file: "Aeneas/Std/Vec.lean", line: 328 *)
  mk_fun "alloc::slice::{[@T]}::into_vec" "alloc.slice.Slice.into_vec" ~keep_params:(Some [true; false]) ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Vec.lean", line: 316 *)
  mk_fun "alloc::slice::{[@T]}::to_vec" "alloc.slice.Slice.to_vec";
  (* file: "Aeneas/Std/Vec.lean", line: 332 *)
  mk_fun "alloc::vec::from_elem" "alloc.vec.from_elem";
  (* file: "Aeneas/Std/VecIter.lean", line: 81 *)
  mk_fun "alloc::vec::into_iter::{core::iter::traits::iterator::Iterator<alloc::vec::into_iter::IntoIter<@T, @A>, @T>}::map" "alloc.vec.into_iter.IntoIter.Insts.CoreIterTraitsIteratorIterator.map";
  (* file: "Aeneas/Std/VecIter.lean", line: 11 *)
  mk_fun "alloc::vec::into_iter::{core::iter::traits::iterator::Iterator<alloc::vec::into_iter::IntoIter<@T, @A>, @T>}::next" "alloc.vec.into_iter.IteratorIntoIter.next" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 550 *)
  mk_fun "alloc::vec::partial_eq::{core::cmp::PartialEq<alloc::vec::Vec<@T>, alloc::vec::Vec<@U>>}::eq" "alloc.vec.partial_eq.PartialEqVec.eq" ~keep_params:(Some [true; true; false; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 560 *)
  mk_fun "alloc::vec::partial_eq::{core::cmp::PartialEq<alloc::vec::Vec<@T>, alloc::vec::Vec<@U>>}::ne" "alloc.vec.partial_eq.PartialEqVec.ne" ~keep_params:(Some [true; true; false; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 352 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::extend_from_slice" "alloc.vec.Vec.extend_from_slice" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 135 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::insert" "alloc.vec.Vec.insert" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 53 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::len" "alloc.vec.Vec.len" ~keep_params:(Some [true; false]) ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Vec.lean", line: 46 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::new" "alloc.vec.Vec.new" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Vec.lean", line: 120 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::push" "alloc.vec.Vec.push" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 386 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::resize" "alloc.vec.Vec.resize" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 349 *)
  mk_fun "alloc::vec::{alloc::vec::Vec<@T>}::with_capacity" "alloc.vec.Vec.with_capacity" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Vec.lean", line: 537 *)
  mk_fun "alloc::vec::{core::clone::Clone<alloc::vec::Vec<@T>>}::clone" "alloc.vec.CloneVec.clone" ~keep_params:(Some [true; false]) ~keep_trait_clauses:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 459 *)
  mk_fun "alloc::vec::{core::convert::From<Box<[@T]>, alloc::vec::Vec<@T>>}::from" "alloc.vec.FromBoxSliceVec.from" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 445 *)
  mk_fun "alloc::vec::{core::convert::From<alloc::vec::Vec<@T>, [@T; @N]>}::from" "alloc.vec.FromVecArray.from";
  (* file: "Aeneas/Std/Vec.lean", line: 581 *)
  mk_fun "alloc::vec::{core::fmt::Debug<alloc::vec::Vec<@T>>}::fmt" "alloc.vec.DebugVec.fmt" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/VecIter.lean", line: 60 *)
  mk_fun "alloc::vec::{core::iter::traits::collect::FromIterator<alloc::vec::Vec<@T>, @T>}::from_iter" "alloc.vec.FromIteratorVec.from_iter";
  (* file: "Aeneas/Std/VecIter.lean", line: 34 *)
  mk_fun "alloc::vec::{core::iter::traits::collect::IntoIterator<alloc::vec::Vec<@T>, @T, alloc::vec::into_iter::IntoIter<@T, @A>>}::into_iter" "alloc.vec.IntoIteratorVec.into_iter" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 363 *)
  mk_fun "alloc::vec::{core::ops::deref::Deref<alloc::vec::Vec<@T>, [@T]>}::deref" "alloc.vec.Vec.deref" ~keep_params:(Some [true; false]) ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Vec.lean", line: 373 *)
  mk_fun "alloc::vec::{core::ops::deref::DerefMut<alloc::vec::Vec<@T>, [@T]>}::deref_mut" "alloc.vec.Vec.deref_mut" ~keep_params:(Some [true; false]) ~can_fail:false;
  (* file: "Aeneas/Std/Vec.lean", line: 195 *)
  mk_fun "alloc::vec::{core::ops::index::Index<alloc::vec::Vec<@T>, @I, @O>}::index" "alloc.vec.Vec.index" ~keep_params:(Some [true; true; false; true]);
  (* file: "Aeneas/Std/Vec.lean", line: 201 *)
  mk_fun "alloc::vec::{core::ops::index::IndexMut<alloc::vec::Vec<@T>, @I, @O>}::index_mut" "alloc.vec.Vec.index_mut" ~keep_params:(Some [true; true; false; true]);
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 135 *)
  mk_fun "core::array::equality::{core::cmp::PartialEq<[@T; @N], [@U; @N]>}::eq" "core.array.equality.PartialEqArray.eq";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 144 *)
  mk_fun "core::array::equality::{core::cmp::PartialEq<[@T; @N], [@U; @N]>}::ne" "core.array.equality.PartialEqArray.ne";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 365 *)
  mk_fun "core::array::{[@T; @N]}::as_mut_slice" "core.array.Array.as_mut_slice";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 344 *)
  mk_fun "core::array::{[@T; @N]}::as_slice" "core.array.Array.as_slice";
  (* file: "Aeneas/Std/Array/Array.lean", line: 295 *)
  mk_fun "core::array::{core::clone::Clone<[@T; @N]>}::clone" "core.array.CloneArray.clone";
  (* file: "Aeneas/Std/Array/Array.lean", line: 308 *)
  mk_fun "core::array::{core::clone::Clone<[@T; @N]>}::clone_from" "core.array.CloneArray.clone_from";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 356 *)
  mk_fun "core::array::{core::convert::AsMut<[@T; @N], [@T]>}::as_mut" "Array.Insts.CoreConvertAsMutSlice.as_mut";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 349 *)
  mk_fun "core::array::{core::convert::AsRef<[@T; @N], [@T]>}::as_ref" "Array.Insts.CoreConvertAsRefSlice.as_ref";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 313 *)
  mk_fun "core::array::{core::convert::TryFrom<&'a [@T; @N], &'a [@T], core::array::TryFromSliceError>}::try_from" "core.array.TryFromSharedArraySlice.try_from";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 328 *)
  mk_fun "core::array::{core::convert::TryFrom<&'a mut [@T; @N], &'a mut [@T], core::array::TryFromSliceError>}::try_from" "core.array.TryFromMutArraySlice.try_from";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 293 *)
  mk_fun "core::array::{core::convert::TryFrom<[@T; @N], &'0 [@T], core::array::TryFromSliceError>}::try_from" "core.array.TryFromArrayCopySlice.try_from";
  (* file: "Aeneas/Std/Array/Array.lean", line: 404 *)
  mk_fun "core::array::{core::default::Default<[@T; 0]>}::default" "core.default.DefaultArrayEmpty.default";
  (* file: "Aeneas/Std/Array/Array.lean", line: 388 *)
  mk_fun "core::array::{core::default::Default<[@T; @N]>}::default" "core.default.DefaultArray.default";
  (* file: "Aeneas/Std/Array/ArrayDebug.lean", line: 9 *)
  mk_fun "core::array::{core::fmt::Debug<[@T; @N]>}::fmt" "core.array.DebugArray.fmt";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 279 *)
  mk_fun "core::array::{core::fmt::Debug<core::array::TryFromSliceError>}::fmt" "core.array.DebugTryFromSliceError.fmt";
  (* file: "Aeneas/Std/SliceIter.lean", line: 89 *)
  mk_fun "core::array::{core::iter::traits::collect::IntoIterator<&'a [@T; @N], &'a @T, core::slice::iter::Iter<'a, @T>>}::into_iter" "SharedArray.Insts.CoreIterTraitsCollectIntoIteratorSharedIter.into_iter";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 94 *)
  mk_fun "core::array::{core::ops::index::Index<[@T; @N], @I, @O>}::index" "core.array.Array.index";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 100 *)
  mk_fun "core::array::{core::ops::index::IndexMut<[@T; @N], @I, @O>}::index_mut" "core.array.Array.index_mut";
  (* file: "Aeneas/Std/Core/Core.lean", line: 134 *)
  mk_fun "core::clone::impls::{core::clone::Clone<&'0 @T>}::clone" "core.clone.impls.CloneShared.clone";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 21 *)
  mk_fun "core::cmp::Eq::assert_fields_are_eq" "core.cmp.Eq.assert_fields_are_eq.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 170 *)
  mk_fun "core::cmp::Ord::clamp" "core.cmp.Ord.clamp.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 155 *)
  mk_fun "core::cmp::Ord::max" "core.cmp.Ord.max.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 164 *)
  mk_fun "core::cmp::Ord::min" "core.cmp.Ord.min.trait_default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 31 *)
  mk_fun "core::cmp::PartialEq::ne" "core.cmp.PartialEq.ne.trait_default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 120 *)
  mk_fun "core::cmp::PartialOrd::ge" "core.cmp.PartialOrd.ge.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 113 *)
  mk_fun "core::cmp::PartialOrd::gt" "core.cmp.PartialOrd.gt.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 106 *)
  mk_fun "core::cmp::PartialOrd::le" "core.cmp.PartialOrd.le.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 99 *)
  mk_fun "core::cmp::PartialOrd::lt" "core.cmp.PartialOrd.lt.default";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 201 *)
  mk_fun "core::cmp::impls::{core::cmp::Ord<()>}::cmp" "core.cmp.impls.OrdUnit.cmp";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 213 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialEq<&'a @A, &'b @B>}::eq" "core.cmp.impls.PartialEqShared.eq";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 218 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialEq<&'a @A, &'b @B>}::ne" "core.cmp.impls.PartialEqShared.ne";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 185 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialEq<(), ()>}::eq" "core.cmp.impls.PartialEqUnit.eq";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 188 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialEq<(), ()>}::ne" "core.cmp.impls.PartialEqUnit.ne";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 205 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialEq<bool, bool>}::eq" "core.cmp.impls.PartialEqBool.eq";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 197 *)
  mk_fun "core::cmp::impls::{core::cmp::PartialOrd<(), ()>}::partial_cmp" "core.cmp.impls.PartialOrdUnit.partial_cmp";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 180 *)
  mk_fun "core::cmp::max" "core.cmp.max";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 175 *)
  mk_fun "core::cmp::min" "core.cmp.min";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 882 *)
  mk_fun "core::convert::num::ptr_try_from_impls::{core::convert::TryFrom<u32, usize, core::num::error::TryFromIntError>}::try_from" "core.convert.num.ptr_try_from_impls.TryFromU32Usize.try_from";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 32 *)
  mk_fun "core::convert::{core::convert::From<@T, @T>}::from" "core.convert.FromSame.from" ~can_fail:false;
  (* file: "Aeneas/Std/Core/Convert.lean", line: 17 *)
  mk_fun "core::convert::{core::convert::Into<@T, @U>}::into" "core.convert.IntoFrom.into";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 44 *)
  mk_fun "core::convert::{core::convert::TryInto<@T, @U, @Error>}::try_into" "core.convert.TryInto.Blanket.try_into";
  (* file: "Aeneas/Std/Core/Default.lean", line: 9 *)
  mk_fun "core::default::{core::default::Default<bool>}::default" "core.default.DefaultBool.default";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 56 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<i128>}::fmt" "core.fmt.num.imp.DisplayI128.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 41 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<i16>}::fmt" "core.fmt.num.imp.DisplayI16.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 46 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<i32>}::fmt" "core.fmt.num.imp.DisplayI32.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 51 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<i64>}::fmt" "core.fmt.num.imp.DisplayI64.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 36 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<i8>}::fmt" "core.fmt.num.imp.DisplayI8.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 61 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<isize>}::fmt" "core.fmt.num.imp.DisplayIsize.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 26 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<u128>}::fmt" "core.fmt.num.imp.DisplayU128.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 11 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<u16>}::fmt" "core.fmt.num.imp.DisplayU16.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 16 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<u32>}::fmt" "core.fmt.num.imp.DisplayU32.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 21 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<u64>}::fmt" "core.fmt.num.imp.DisplayU64.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 6 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<u8>}::fmt" "core.fmt.num.imp.DisplayU8.fmt";
  (* file: "Aeneas/Std/Scalar/Display.lean", line: 31 *)
  mk_fun "core::fmt::num::imp::{core::fmt::Display<usize>}::fmt" "core.fmt.num.imp.DisplayUsize.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 102 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<i128>}::fmt" "core.fmt.num.DebugI128.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 84 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<i16>}::fmt" "core.fmt.num.DebugI16.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 90 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<i32>}::fmt" "core.fmt.num.DebugI32.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 96 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<i64>}::fmt" "core.fmt.num.DebugI64.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 78 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<i8>}::fmt" "core.fmt.num.DebugI8.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 108 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<isize>}::fmt" "core.fmt.num.DebugIsize.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 36 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<u128>}::fmt" "core.fmt.num.DebugU128.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 18 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<u16>}::fmt" "core.fmt.num.DebugU16.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 24 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<u32>}::fmt" "core.fmt.num.DebugU32.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 30 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<u64>}::fmt" "core.fmt.num.DebugU64.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 12 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<u8>}::fmt" "core.fmt.num.DebugU8.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 42 *)
  mk_fun "core::fmt::num::{core::fmt::Debug<usize>}::fmt" "core.fmt.num.DebugUsize.fmt";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 6 *)
  mk_fun "core::fmt::num::{core::fmt::LowerHex<u16>}::fmt" "core.fmt.num.LowerHexU16.fmt";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 62 *)
  mk_fun "core::fmt::rt::{core::fmt::rt::Argument<'0>}::new_debug" "core.fmt.rt.Argument.new_debug";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 193 *)
  mk_fun "core::fmt::rt::{core::fmt::rt::Argument<'0>}::new_display" "core.fmt.rt.Argument.new_display";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 76 *)
  mk_fun "core::fmt::rt::{core::fmt::rt::Argument<'0>}::new_lower_hex" "core.fmt.rt.Argument.new_lower_hex";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 53 *)
  mk_fun "core::fmt::{core::fmt::Arguments<'a>}::from_str" "core.fmt.Arguments.from_str";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 56 *)
  mk_fun "core::fmt::{core::fmt::Arguments<'a>}::new" "core.fmt.Arguments.new";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 96 *)
  mk_fun "core::fmt::{core::fmt::Debug<&'0 @T>}::fmt" "core.fmt.DebugShared.fmt";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 108 *)
  mk_fun "core::fmt::{core::fmt::Debug<()>}::fmt" "core.fmt.DebugUnit.fmt";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 102 *)
  mk_fun "core::fmt::{core::fmt::Debug<bool>}::fmt" "core.fmt.DebugBool.fmt";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 123 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_field1_finish" "core.fmt.Formatter.debug_struct_field1_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 130 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_field2_finish" "core.fmt.Formatter.debug_struct_field2_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 138 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_field3_finish" "core.fmt.Formatter.debug_struct_field3_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 148 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_field4_finish" "core.fmt.Formatter.debug_struct_field4_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 159 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_field5_finish" "core.fmt.Formatter.debug_struct_field5_finish";
  (* file: "Aeneas/Std/Core/FmtWithSlice.lean", line: 7 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_struct_fields_finish" "core.fmt.Formatter.debug_struct_fields_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 169 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::debug_tuple_field1_finish" "core.fmt.Formatter.debug_tuple_field1_finish";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 89 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::write_fmt" "core.fmt.Formatter.write_fmt";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 83 *)
  mk_fun "core::fmt::{core::fmt::Formatter<'a>}::write_str" "core.fmt.Formatter.write_str";
  (* file: "Aeneas/Std/Core/Discriminant.lean", line: 26 *)
  mk_fun "core::intrinsics::discriminant_value" "core.intrinsics.discriminant_value";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 428 *)
  mk_fun "core::iter::adapters::enumerate::{core::iter::traits::iterator::Iterator<core::iter::adapters::enumerate::Enumerate<@I>, (usize, @Clause0_Item)>}::next" "core.iter.adapters.enumerate.IteratorEnumerate.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 723 *)
  mk_fun "core::iter::adapters::rev::{core::iter::traits::iterator::Iterator<core::iter::adapters::rev::Rev<@I>, @Clause0_Clause0_Item>}::next" "core.iter.adapters.rev.Rev.Insts.CoreIterTraitsIteratorIterator.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 127 *)
  mk_fun "core::iter::adapters::step_by::{core::iter::traits::iterator::Iterator<core::iter::adapters::step_by::StepBy<@I>, @Clause0_Item>}::next" "core.iter.adapters.step_by.IteratorStepBy.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 461 *)
  mk_fun "core::iter::adapters::take::{core::iter::traits::iterator::Iterator<core::iter::adapters::take::Take<@I>, @Clause0_Item>}::next" "core.iter.adapters.take.IteratorTake.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 525 *)
  mk_fun "core::iter::adapters::zip::{core::iter::traits::iterator::Iterator<core::iter::adapters::zip::Zip<@A, @B>, (@Clause0_Item, @Clause1_Item)>}::next" "core.iter.adapters.zip.Zip.Insts.CoreIterTraitsIteratorIteratorPair.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 418 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i128>}::backward_checked" "core.iter.range.StepI128.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 416 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i128>}::forward_checked" "core.iter.range.StepI128.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 414 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i128>}::steps_between" "core.iter.range.StepI128.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 391 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i16>}::backward_checked" "core.iter.range.StepI16.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 389 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i16>}::forward_checked" "core.iter.range.StepI16.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 387 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i16>}::steps_between" "core.iter.range.StepI16.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 400 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i32>}::backward_checked" "core.iter.range.StepI32.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 398 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i32>}::forward_checked" "core.iter.range.StepI32.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 396 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i32>}::steps_between" "core.iter.range.StepI32.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 409 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i64>}::backward_checked" "core.iter.range.StepI64.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 407 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i64>}::forward_checked" "core.iter.range.StepI64.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 405 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i64>}::steps_between" "core.iter.range.StepI64.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 382 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i8>}::backward_checked" "core.iter.range.StepI8.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 380 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i8>}::forward_checked" "core.iter.range.StepI8.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 378 *)
  mk_fun "core::iter::range::{core::iter::range::Step<i8>}::steps_between" "core.iter.range.StepI8.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 373 *)
  mk_fun "core::iter::range::{core::iter::range::Step<isize>}::backward_checked" "core.iter.range.StepIsize.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 371 *)
  mk_fun "core::iter::range::{core::iter::range::Step<isize>}::forward_checked" "core.iter.range.StepIsize.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 369 *)
  mk_fun "core::iter::range::{core::iter::range::Step<isize>}::steps_between" "core.iter.range.StepIsize.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 364 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u128>}::backward_checked" "core.iter.range.StepU128.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 362 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u128>}::forward_checked" "core.iter.range.StepU128.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 360 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u128>}::steps_between" "core.iter.range.StepU128.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 337 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u16>}::backward_checked" "core.iter.range.StepU16.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 335 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u16>}::forward_checked" "core.iter.range.StepU16.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 333 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u16>}::steps_between" "core.iter.range.StepU16.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 346 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u32>}::backward_checked" "core.iter.range.StepU32.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 344 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u32>}::forward_checked" "core.iter.range.StepU32.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 342 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u32>}::steps_between" "core.iter.range.StepU32.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 355 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u64>}::backward_checked" "core.iter.range.StepU64.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 353 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u64>}::forward_checked" "core.iter.range.StepU64.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 351 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u64>}::steps_between" "core.iter.range.StepU64.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 328 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u8>}::backward_checked" "core.iter.range.StepU8.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 326 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u8>}::forward_checked" "core.iter.range.StepU8.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 324 *)
  mk_fun "core::iter::range::{core::iter::range::Step<u8>}::steps_between" "core.iter.range.StepU8.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 319 *)
  mk_fun "core::iter::range::{core::iter::range::Step<usize>}::backward_checked" "core.iter.range.StepUsize.backward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 317 *)
  mk_fun "core::iter::range::{core::iter::range::Step<usize>}::forward_checked" "core.iter.range.StepUsize.forward_checked";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 315 *)
  mk_fun "core::iter::range::{core::iter::range::Step<usize>}::steps_between" "core.iter.range.StepUsize.steps_between";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 736 *)
  mk_fun "core::iter::range::{core::iter::traits::double_ended::DoubleEndedIterator<core::ops::range::Range<@A>, @A>}::next_back" "core.ops.range.Range.Insts.CoreIterTraitsDoubleEndedIterator.next_back";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 770 *)
  mk_fun "core::iter::range::{core::iter::traits::double_ended::DoubleEndedIterator<core::ops::range::RangeInclusive<@A>, @A>}::next_back" "core.ops.range.RangeInclusive.Insts.CoreIterTraitsDoubleEndedIterator.next_back";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 489 *)
  mk_fun "core::iter::range::{core::iter::traits::iterator::Iterator<core::ops::range::Range<@A>, @A>}::next" "core.iter.range.IteratorRange.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 572 *)
  mk_fun "core::iter::range::{core::iter::traits::iterator::Iterator<core::ops::range::RangeInclusive<@A>, @A>}::next" "core.ops.range.RangeInclusive.Insts.CoreIterTraitsIteratorIterator.next";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 177 *)
  mk_fun "core::iter::traits::collect::{core::iter::traits::collect::IntoIterator<@I, @Item, @I>}::into_iter" "core.iter.traits.collect.IntoIterator.Blanket.into_iter";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 194 *)
  mk_fun "core::iter::traits::iterator::Iterator::collect" "core.iter.traits.iterator.Iterator.collect.default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 99 *)
  mk_fun "core::iter::traits::iterator::Iterator::enumerate" "core.iter.traits.iterator.Iterator.enumerate.trait_default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 617 *)
  mk_fun "core::iter::traits::iterator::Iterator::rev" "core.iter.traits.iterator.Iterator.rev.trait_default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 91 *)
  mk_fun "core::iter::traits::iterator::Iterator::step_by" "core.iter.traits.iterator.Iterator.step_by.trait_default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 107 *)
  mk_fun "core::iter::traits::iterator::Iterator::take" "core.iter.traits.iterator.Iterator.take.trait_default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 603 *)
  mk_fun "core::iter::traits::iterator::Iterator::zip" "core.iter.traits.iterator.Iterator.zip.trait_default";
  (* file: "Aeneas/Std/Core/Core.lean", line: 75 *)
  mk_fun "core::mem::replace" "core.mem.replace" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Core/Core.lean", line: 79 *)
  mk_fun "core::mem::swap" "core.mem.swap" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 761 *)
  mk_fun "core::num::{i128}::cast_unsigned" "core.num.I128.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 44 *)
  mk_fun "core::num::{i128}::wrapping_shl" "core.num.I128.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 45 *)
  mk_fun "core::num::{i128}::wrapping_shr" "core.num.I128.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 743 *)
  mk_fun "core::num::{i16}::cast_unsigned" "core.num.I16.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 41 *)
  mk_fun "core::num::{i16}::wrapping_shl" "core.num.I16.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 42 *)
  mk_fun "core::num::{i16}::wrapping_shr" "core.num.I16.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 749 *)
  mk_fun "core::num::{i32}::cast_unsigned" "core.num.I32.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 42 *)
  mk_fun "core::num::{i32}::wrapping_shl" "core.num.I32.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 43 *)
  mk_fun "core::num::{i32}::wrapping_shr" "core.num.I32.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 755 *)
  mk_fun "core::num::{i64}::cast_unsigned" "core.num.I64.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 43 *)
  mk_fun "core::num::{i64}::wrapping_shl" "core.num.I64.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 44 *)
  mk_fun "core::num::{i64}::wrapping_shr" "core.num.I64.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 737 *)
  mk_fun "core::num::{i8}::cast_unsigned" "core.num.I8.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 40 *)
  mk_fun "core::num::{i8}::wrapping_shl" "core.num.I8.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 41 *)
  mk_fun "core::num::{i8}::wrapping_shr" "core.num.I8.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 767 *)
  mk_fun "core::num::{isize}::cast_unsigned" "core.num.Isize.cast_unsigned";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 45 *)
  mk_fun "core::num::{isize}::wrapping_shl" "core.num.Isize.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 46 *)
  mk_fun "core::num::{isize}::wrapping_shr" "core.num.Isize.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 758 *)
  mk_fun "core::num::{u128}::cast_signed" "core.num.U128.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 851 *)
  mk_fun "core::num::{u128}::is_multiple_of" "core.num.U128.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 38 *)
  mk_fun "core::num::{u128}::wrapping_shl" "core.num.U128.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 39 *)
  mk_fun "core::num::{u128}::wrapping_shr" "core.num.U128.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 740 *)
  mk_fun "core::num::{u16}::cast_signed" "core.num.U16.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 842 *)
  mk_fun "core::num::{u16}::is_multiple_of" "core.num.U16.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 35 *)
  mk_fun "core::num::{u16}::wrapping_shl" "core.num.U16.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 36 *)
  mk_fun "core::num::{u16}::wrapping_shr" "core.num.U16.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 746 *)
  mk_fun "core::num::{u32}::cast_signed" "core.num.U32.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 845 *)
  mk_fun "core::num::{u32}::is_multiple_of" "core.num.U32.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 36 *)
  mk_fun "core::num::{u32}::wrapping_shl" "core.num.U32.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 37 *)
  mk_fun "core::num::{u32}::wrapping_shr" "core.num.U32.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 752 *)
  mk_fun "core::num::{u64}::cast_signed" "core.num.U64.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 848 *)
  mk_fun "core::num::{u64}::is_multiple_of" "core.num.U64.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 37 *)
  mk_fun "core::num::{u64}::wrapping_shl" "core.num.U64.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 38 *)
  mk_fun "core::num::{u64}::wrapping_shr" "core.num.U64.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 734 *)
  mk_fun "core::num::{u8}::cast_signed" "core.num.U8.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 839 *)
  mk_fun "core::num::{u8}::is_multiple_of" "core.num.U8.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 34 *)
  mk_fun "core::num::{u8}::wrapping_shl" "core.num.U8.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 35 *)
  mk_fun "core::num::{u8}::wrapping_shr" "core.num.U8.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 764 *)
  mk_fun "core::num::{usize}::cast_signed" "core.num.Usize.cast_signed";
  (* file: "Aeneas/Std/Scalar/CoreConvertNum.lean", line: 854 *)
  mk_fun "core::num::{usize}::is_multiple_of" "core.num.Usize.is_multiple_of";
  (* file: "Aeneas/Std/Scalar/Pow.lean", line: 7 *)
  mk_fun "core::num::{usize}::is_power_of_two" "core.num.Usize.is_power_of_two";
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shl.lean", line: 39 *)
  mk_fun "core::num::{usize}::wrapping_shl" "core.num.Usize.wrapping_shl" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/WrappingOps/Shr.lean", line: 40 *)
  mk_fun "core::num::{usize}::wrapping_shr" "core.num.Usize.wrapping_shr" ~can_fail:false;
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1335 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<i128, i128, i128>}::add" "core.ops.arith.I128.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 939 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<i16, i16, i16>}::add" "core.ops.arith.I16.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1071 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<i32, i32, i32>}::add" "core.ops.arith.I32.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1203 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<i64, i64, i64>}::add" "core.ops.arith.I64.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 807 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<i8, i8, i8>}::add" "core.ops.arith.I8.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1467 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<isize, isize, isize>}::add" "core.ops.arith.Isize.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 543 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<u128, u128, u128>}::add" "core.ops.arith.U128.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 147 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<u16, u16, u16>}::add" "core.ops.arith.U16.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 279 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<u32, u32, u32>}::add" "core.ops.arith.U32.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 411 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<u64, u64, u64>}::add" "core.ops.arith.U64.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 15 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<u8, u8, u8>}::add" "core.ops.arith.U8.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 675 *)
  mk_fun "core::ops::arith::{core::ops::arith::Add<usize, usize, usize>}::add" "core.ops.arith.Usize.add";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1347 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<i128, i128, i128>}::div" "core.ops.arith.I128.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 951 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<i16, i16, i16>}::div" "core.ops.arith.I16.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1083 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<i32, i32, i32>}::div" "core.ops.arith.I32.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1215 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<i64, i64, i64>}::div" "core.ops.arith.I64.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 819 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<i8, i8, i8>}::div" "core.ops.arith.I8.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1479 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<isize, isize, isize>}::div" "core.ops.arith.Isize.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 555 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<u128, u128, u128>}::div" "core.ops.arith.U128.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 159 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<u16, u16, u16>}::div" "core.ops.arith.U16.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 291 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<u32, u32, u32>}::div" "core.ops.arith.U32.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 423 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<u64, u64, u64>}::div" "core.ops.arith.U64.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 27 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<u8, u8, u8>}::div" "core.ops.arith.U8.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 687 *)
  mk_fun "core::ops::arith::{core::ops::arith::Div<usize, usize, usize>}::div" "core.ops.arith.Usize.div";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1343 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<i128, i128, i128>}::mul" "core.ops.arith.I128.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 947 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<i16, i16, i16>}::mul" "core.ops.arith.I16.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1079 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<i32, i32, i32>}::mul" "core.ops.arith.I32.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1211 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<i64, i64, i64>}::mul" "core.ops.arith.I64.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 815 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<i8, i8, i8>}::mul" "core.ops.arith.I8.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1475 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<isize, isize, isize>}::mul" "core.ops.arith.Isize.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 551 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<u128, u128, u128>}::mul" "core.ops.arith.U128.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 155 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<u16, u16, u16>}::mul" "core.ops.arith.U16.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 287 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<u32, u32, u32>}::mul" "core.ops.arith.U32.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 419 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<u64, u64, u64>}::mul" "core.ops.arith.U64.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 23 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<u8, u8, u8>}::mul" "core.ops.arith.U8.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 683 *)
  mk_fun "core::ops::arith::{core::ops::arith::Mul<usize, usize, usize>}::mul" "core.ops.arith.Usize.mul";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1339 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<i128, i128, i128>}::sub" "core.ops.arith.I128.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 943 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<i16, i16, i16>}::sub" "core.ops.arith.I16.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1075 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<i32, i32, i32>}::sub" "core.ops.arith.I32.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1207 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<i64, i64, i64>}::sub" "core.ops.arith.I64.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 811 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<i8, i8, i8>}::sub" "core.ops.arith.I8.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1471 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<isize, isize, isize>}::sub" "core.ops.arith.Isize.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 547 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<u128, u128, u128>}::sub" "core.ops.arith.U128.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 151 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<u16, u16, u16>}::sub" "core.ops.arith.U16.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 283 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<u32, u32, u32>}::sub" "core.ops.arith.U32.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 415 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<u64, u64, u64>}::sub" "core.ops.arith.U64.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 19 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<u8, u8, u8>}::sub" "core.ops.arith.U8.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 679 *)
  mk_fun "core::ops::arith::{core::ops::arith::Sub<usize, usize, usize>}::sub" "core.ops.arith.Usize.sub";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1351 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<i128, i128, i128>}::bitand" "core.ops.bit.I128.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 955 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<i16, i16, i16>}::bitand" "core.ops.bit.I16.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1087 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<i32, i32, i32>}::bitand" "core.ops.bit.I32.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1219 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<i64, i64, i64>}::bitand" "core.ops.bit.I64.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 823 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<i8, i8, i8>}::bitand" "core.ops.bit.I8.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1483 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<isize, isize, isize>}::bitand" "core.ops.bit.Isize.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 559 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<u128, u128, u128>}::bitand" "core.ops.bit.U128.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 163 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<u16, u16, u16>}::bitand" "core.ops.bit.U16.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 295 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<u32, u32, u32>}::bitand" "core.ops.bit.U32.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 427 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<u64, u64, u64>}::bitand" "core.ops.bit.U64.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 31 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<u8, u8, u8>}::bitand" "core.ops.bit.U8.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 691 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitAnd<usize, usize, usize>}::bitand" "core.ops.bit.Usize.bitand";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1355 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<i128, i128, i128>}::bitor" "core.ops.bit.I128.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 959 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<i16, i16, i16>}::bitor" "core.ops.bit.I16.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1091 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<i32, i32, i32>}::bitor" "core.ops.bit.I32.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1223 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<i64, i64, i64>}::bitor" "core.ops.bit.I64.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 827 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<i8, i8, i8>}::bitor" "core.ops.bit.I8.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1487 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<isize, isize, isize>}::bitor" "core.ops.bit.Isize.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 563 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<u128, u128, u128>}::bitor" "core.ops.bit.U128.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 167 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<u16, u16, u16>}::bitor" "core.ops.bit.U16.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 299 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<u32, u32, u32>}::bitor" "core.ops.bit.U32.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 431 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<u64, u64, u64>}::bitor" "core.ops.bit.U64.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 35 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<u8, u8, u8>}::bitor" "core.ops.bit.U8.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 695 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOr<usize, usize, usize>}::bitor" "core.ops.bit.Usize.bitor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1363 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i128, i128>}::bitor_assign" "core.ops.bit.I128.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 967 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i16, i16>}::bitor_assign" "core.ops.bit.I16.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1099 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i32, i32>}::bitor_assign" "core.ops.bit.I32.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1231 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i64, i64>}::bitor_assign" "core.ops.bit.I64.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 835 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<i8, i8>}::bitor_assign" "core.ops.bit.I8.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1495 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<isize, isize>}::bitor_assign" "core.ops.bit.Isize.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 571 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u128, u128>}::bitor_assign" "core.ops.bit.U128.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 175 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u16, u16>}::bitor_assign" "core.ops.bit.U16.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 307 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u32, u32>}::bitor_assign" "core.ops.bit.U32.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 439 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u64, u64>}::bitor_assign" "core.ops.bit.U64.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 43 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<u8, u8>}::bitor_assign" "core.ops.bit.U8.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 703 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitOrAssign<usize, usize>}::bitor_assign" "core.ops.bit.Usize.bitor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1359 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<i128, i128, i128>}::bitxor" "core.ops.bit.I128.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 963 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<i16, i16, i16>}::bitxor" "core.ops.bit.I16.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1095 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<i32, i32, i32>}::bitxor" "core.ops.bit.I32.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1227 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<i64, i64, i64>}::bitxor" "core.ops.bit.I64.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 831 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<i8, i8, i8>}::bitxor" "core.ops.bit.I8.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1491 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<isize, isize, isize>}::bitxor" "core.ops.bit.Isize.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 567 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<u128, u128, u128>}::bitxor" "core.ops.bit.U128.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 171 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<u16, u16, u16>}::bitxor" "core.ops.bit.U16.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 303 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<u32, u32, u32>}::bitxor" "core.ops.bit.U32.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 435 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<u64, u64, u64>}::bitxor" "core.ops.bit.U64.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 39 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<u8, u8, u8>}::bitxor" "core.ops.bit.U8.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 699 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXor<usize, usize, usize>}::bitxor" "core.ops.bit.Usize.bitxor";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1367 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i128, i128>}::bitxor_assign" "core.ops.bit.I128.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 971 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i16, i16>}::bitxor_assign" "core.ops.bit.I16.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1103 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i32, i32>}::bitxor_assign" "core.ops.bit.I32.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1235 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i64, i64>}::bitxor_assign" "core.ops.bit.I64.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 839 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<i8, i8>}::bitxor_assign" "core.ops.bit.I8.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1499 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<isize, isize>}::bitxor_assign" "core.ops.bit.Isize.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 575 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u128, u128>}::bitxor_assign" "core.ops.bit.U128.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 179 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u16, u16>}::bitxor_assign" "core.ops.bit.U16.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 311 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u32, u32>}::bitxor_assign" "core.ops.bit.U32.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 443 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u64, u64>}::bitxor_assign" "core.ops.bit.U64.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 47 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<u8, u8>}::bitxor_assign" "core.ops.bit.U8.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 707 *)
  mk_fun "core::ops::bit::{core::ops::bit::BitXorAssign<usize, usize>}::bitxor_assign" "core.ops.bit.Usize.bitxor_assign";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1411 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, i128, i128>}::shl" "core.ops.bit.I128.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1399 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, i16, i128>}::shl" "core.ops.bit.I128.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1403 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, i32, i128>}::shl" "core.ops.bit.I128.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1407 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, i64, i128>}::shl" "core.ops.bit.I128.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1395 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, i8, i128>}::shl" "core.ops.bit.I128.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1415 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, isize, i128>}::shl" "core.ops.bit.I128.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1387 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, u128, i128>}::shl" "core.ops.bit.I128.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1375 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, u16, i128>}::shl" "core.ops.bit.I128.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1379 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, u32, i128>}::shl" "core.ops.bit.I128.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1383 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, u64, i128>}::shl" "core.ops.bit.I128.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1371 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, u8, i128>}::shl" "core.ops.bit.I128.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1391 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i128, usize, i128>}::shl" "core.ops.bit.I128.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1015 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, i128, i16>}::shl" "core.ops.bit.I16.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1003 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, i16, i16>}::shl" "core.ops.bit.I16.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1007 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, i32, i16>}::shl" "core.ops.bit.I16.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1011 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, i64, i16>}::shl" "core.ops.bit.I16.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 999 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, i8, i16>}::shl" "core.ops.bit.I16.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1019 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, isize, i16>}::shl" "core.ops.bit.I16.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 991 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, u128, i16>}::shl" "core.ops.bit.I16.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 979 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, u16, i16>}::shl" "core.ops.bit.I16.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 983 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, u32, i16>}::shl" "core.ops.bit.I16.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 987 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, u64, i16>}::shl" "core.ops.bit.I16.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 975 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, u8, i16>}::shl" "core.ops.bit.I16.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 995 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i16, usize, i16>}::shl" "core.ops.bit.I16.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1147 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, i128, i32>}::shl" "core.ops.bit.I32.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1135 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, i16, i32>}::shl" "core.ops.bit.I32.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1139 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, i32, i32>}::shl" "core.ops.bit.I32.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1143 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, i64, i32>}::shl" "core.ops.bit.I32.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1131 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, i8, i32>}::shl" "core.ops.bit.I32.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1151 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, isize, i32>}::shl" "core.ops.bit.I32.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1123 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, u128, i32>}::shl" "core.ops.bit.I32.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1111 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, u16, i32>}::shl" "core.ops.bit.I32.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1115 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, u32, i32>}::shl" "core.ops.bit.I32.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1119 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, u64, i32>}::shl" "core.ops.bit.I32.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1107 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, u8, i32>}::shl" "core.ops.bit.I32.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1127 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i32, usize, i32>}::shl" "core.ops.bit.I32.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1279 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, i128, i64>}::shl" "core.ops.bit.I64.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1267 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, i16, i64>}::shl" "core.ops.bit.I64.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1271 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, i32, i64>}::shl" "core.ops.bit.I64.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1275 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, i64, i64>}::shl" "core.ops.bit.I64.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1263 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, i8, i64>}::shl" "core.ops.bit.I64.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1283 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, isize, i64>}::shl" "core.ops.bit.I64.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1255 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, u128, i64>}::shl" "core.ops.bit.I64.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1243 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, u16, i64>}::shl" "core.ops.bit.I64.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1247 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, u32, i64>}::shl" "core.ops.bit.I64.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1251 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, u64, i64>}::shl" "core.ops.bit.I64.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1239 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, u8, i64>}::shl" "core.ops.bit.I64.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1259 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i64, usize, i64>}::shl" "core.ops.bit.I64.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 883 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, i128, i8>}::shl" "core.ops.bit.I8.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 871 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, i16, i8>}::shl" "core.ops.bit.I8.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 875 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, i32, i8>}::shl" "core.ops.bit.I8.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 879 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, i64, i8>}::shl" "core.ops.bit.I8.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 867 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, i8, i8>}::shl" "core.ops.bit.I8.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 887 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, isize, i8>}::shl" "core.ops.bit.I8.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 859 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, u128, i8>}::shl" "core.ops.bit.I8.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 847 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, u16, i8>}::shl" "core.ops.bit.I8.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 851 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, u32, i8>}::shl" "core.ops.bit.I8.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 855 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, u64, i8>}::shl" "core.ops.bit.I8.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 843 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, u8, i8>}::shl" "core.ops.bit.I8.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 863 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<i8, usize, i8>}::shl" "core.ops.bit.I8.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1543 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, i128, isize>}::shl" "core.ops.bit.Isize.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1531 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, i16, isize>}::shl" "core.ops.bit.Isize.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1535 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, i32, isize>}::shl" "core.ops.bit.Isize.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1539 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, i64, isize>}::shl" "core.ops.bit.Isize.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1527 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, i8, isize>}::shl" "core.ops.bit.Isize.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1547 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, isize, isize>}::shl" "core.ops.bit.Isize.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1519 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, u128, isize>}::shl" "core.ops.bit.Isize.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1507 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, u16, isize>}::shl" "core.ops.bit.Isize.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1511 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, u32, isize>}::shl" "core.ops.bit.Isize.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1515 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, u64, isize>}::shl" "core.ops.bit.Isize.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1503 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, u8, isize>}::shl" "core.ops.bit.Isize.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1523 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<isize, usize, isize>}::shl" "core.ops.bit.Isize.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 619 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, i128, u128>}::shl" "core.ops.bit.U128.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 607 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, i16, u128>}::shl" "core.ops.bit.U128.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 611 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, i32, u128>}::shl" "core.ops.bit.U128.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 615 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, i64, u128>}::shl" "core.ops.bit.U128.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 603 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, i8, u128>}::shl" "core.ops.bit.U128.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 623 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, isize, u128>}::shl" "core.ops.bit.U128.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 595 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, u128, u128>}::shl" "core.ops.bit.U128.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 583 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, u16, u128>}::shl" "core.ops.bit.U128.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 587 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, u32, u128>}::shl" "core.ops.bit.U128.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 591 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, u64, u128>}::shl" "core.ops.bit.U128.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 579 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, u8, u128>}::shl" "core.ops.bit.U128.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 599 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u128, usize, u128>}::shl" "core.ops.bit.U128.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 223 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, i128, u16>}::shl" "core.ops.bit.U16.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 211 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, i16, u16>}::shl" "core.ops.bit.U16.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 215 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, i32, u16>}::shl" "core.ops.bit.U16.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 219 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, i64, u16>}::shl" "core.ops.bit.U16.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 207 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, i8, u16>}::shl" "core.ops.bit.U16.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 227 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, isize, u16>}::shl" "core.ops.bit.U16.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 199 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, u128, u16>}::shl" "core.ops.bit.U16.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 187 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, u16, u16>}::shl" "core.ops.bit.U16.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 191 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, u32, u16>}::shl" "core.ops.bit.U16.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 195 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, u64, u16>}::shl" "core.ops.bit.U16.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 183 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, u8, u16>}::shl" "core.ops.bit.U16.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 203 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u16, usize, u16>}::shl" "core.ops.bit.U16.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 355 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, i128, u32>}::shl" "core.ops.bit.U32.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 343 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, i16, u32>}::shl" "core.ops.bit.U32.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 347 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, i32, u32>}::shl" "core.ops.bit.U32.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 351 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, i64, u32>}::shl" "core.ops.bit.U32.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 339 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, i8, u32>}::shl" "core.ops.bit.U32.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 359 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, isize, u32>}::shl" "core.ops.bit.U32.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 331 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, u128, u32>}::shl" "core.ops.bit.U32.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 319 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, u16, u32>}::shl" "core.ops.bit.U32.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 323 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, u32, u32>}::shl" "core.ops.bit.U32.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 327 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, u64, u32>}::shl" "core.ops.bit.U32.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 315 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, u8, u32>}::shl" "core.ops.bit.U32.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 335 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u32, usize, u32>}::shl" "core.ops.bit.U32.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 487 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, i128, u64>}::shl" "core.ops.bit.U64.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 475 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, i16, u64>}::shl" "core.ops.bit.U64.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 479 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, i32, u64>}::shl" "core.ops.bit.U64.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 483 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, i64, u64>}::shl" "core.ops.bit.U64.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 471 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, i8, u64>}::shl" "core.ops.bit.U64.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 491 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, isize, u64>}::shl" "core.ops.bit.U64.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 463 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, u128, u64>}::shl" "core.ops.bit.U64.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 451 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, u16, u64>}::shl" "core.ops.bit.U64.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 455 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, u32, u64>}::shl" "core.ops.bit.U64.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 459 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, u64, u64>}::shl" "core.ops.bit.U64.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 447 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, u8, u64>}::shl" "core.ops.bit.U64.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 467 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u64, usize, u64>}::shl" "core.ops.bit.U64.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 91 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, i128, u8>}::shl" "core.ops.bit.U8.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 79 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, i16, u8>}::shl" "core.ops.bit.U8.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 83 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, i32, u8>}::shl" "core.ops.bit.U8.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 87 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, i64, u8>}::shl" "core.ops.bit.U8.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 75 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, i8, u8>}::shl" "core.ops.bit.U8.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 95 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, isize, u8>}::shl" "core.ops.bit.U8.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 67 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, u128, u8>}::shl" "core.ops.bit.U8.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 55 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, u16, u8>}::shl" "core.ops.bit.U8.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 59 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, u32, u8>}::shl" "core.ops.bit.U8.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 63 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, u64, u8>}::shl" "core.ops.bit.U8.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 51 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, u8, u8>}::shl" "core.ops.bit.U8.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 71 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<u8, usize, u8>}::shl" "core.ops.bit.U8.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 751 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, i128, usize>}::shl" "core.ops.bit.Usize.shlI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 739 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, i16, usize>}::shl" "core.ops.bit.Usize.shlI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 743 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, i32, usize>}::shl" "core.ops.bit.Usize.shlI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 747 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, i64, usize>}::shl" "core.ops.bit.Usize.shlI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 735 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, i8, usize>}::shl" "core.ops.bit.Usize.shlI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 755 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, isize, usize>}::shl" "core.ops.bit.Usize.shlIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 727 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, u128, usize>}::shl" "core.ops.bit.Usize.shlU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 715 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, u16, usize>}::shl" "core.ops.bit.Usize.shlU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 719 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, u32, usize>}::shl" "core.ops.bit.Usize.shlU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 723 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, u64, usize>}::shl" "core.ops.bit.Usize.shlU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 711 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, u8, usize>}::shl" "core.ops.bit.Usize.shlU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 731 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shl<usize, usize, usize>}::shl" "core.ops.bit.Usize.shlUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1459 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, i128, i128>}::shr" "core.ops.bit.I128.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1447 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, i16, i128>}::shr" "core.ops.bit.I128.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1451 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, i32, i128>}::shr" "core.ops.bit.I128.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1455 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, i64, i128>}::shr" "core.ops.bit.I128.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1443 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, i8, i128>}::shr" "core.ops.bit.I128.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1463 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, isize, i128>}::shr" "core.ops.bit.I128.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1435 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, u128, i128>}::shr" "core.ops.bit.I128.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1423 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, u16, i128>}::shr" "core.ops.bit.I128.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1427 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, u32, i128>}::shr" "core.ops.bit.I128.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1431 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, u64, i128>}::shr" "core.ops.bit.I128.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1419 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, u8, i128>}::shr" "core.ops.bit.I128.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1439 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i128, usize, i128>}::shr" "core.ops.bit.I128.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1063 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, i128, i16>}::shr" "core.ops.bit.I16.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1051 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, i16, i16>}::shr" "core.ops.bit.I16.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1055 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, i32, i16>}::shr" "core.ops.bit.I16.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1059 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, i64, i16>}::shr" "core.ops.bit.I16.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1047 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, i8, i16>}::shr" "core.ops.bit.I16.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1067 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, isize, i16>}::shr" "core.ops.bit.I16.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1039 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, u128, i16>}::shr" "core.ops.bit.I16.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1027 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, u16, i16>}::shr" "core.ops.bit.I16.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1031 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, u32, i16>}::shr" "core.ops.bit.I16.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1035 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, u64, i16>}::shr" "core.ops.bit.I16.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1023 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, u8, i16>}::shr" "core.ops.bit.I16.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1043 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i16, usize, i16>}::shr" "core.ops.bit.I16.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1195 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, i128, i32>}::shr" "core.ops.bit.I32.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1183 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, i16, i32>}::shr" "core.ops.bit.I32.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1187 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, i32, i32>}::shr" "core.ops.bit.I32.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1191 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, i64, i32>}::shr" "core.ops.bit.I32.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1179 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, i8, i32>}::shr" "core.ops.bit.I32.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1199 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, isize, i32>}::shr" "core.ops.bit.I32.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1171 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, u128, i32>}::shr" "core.ops.bit.I32.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1159 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, u16, i32>}::shr" "core.ops.bit.I32.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1163 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, u32, i32>}::shr" "core.ops.bit.I32.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1167 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, u64, i32>}::shr" "core.ops.bit.I32.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1155 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, u8, i32>}::shr" "core.ops.bit.I32.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1175 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i32, usize, i32>}::shr" "core.ops.bit.I32.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1327 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, i128, i64>}::shr" "core.ops.bit.I64.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1315 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, i16, i64>}::shr" "core.ops.bit.I64.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1319 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, i32, i64>}::shr" "core.ops.bit.I64.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1323 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, i64, i64>}::shr" "core.ops.bit.I64.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1311 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, i8, i64>}::shr" "core.ops.bit.I64.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1331 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, isize, i64>}::shr" "core.ops.bit.I64.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1303 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, u128, i64>}::shr" "core.ops.bit.I64.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1291 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, u16, i64>}::shr" "core.ops.bit.I64.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1295 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, u32, i64>}::shr" "core.ops.bit.I64.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1299 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, u64, i64>}::shr" "core.ops.bit.I64.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1287 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, u8, i64>}::shr" "core.ops.bit.I64.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1307 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i64, usize, i64>}::shr" "core.ops.bit.I64.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 931 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, i128, i8>}::shr" "core.ops.bit.I8.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 919 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, i16, i8>}::shr" "core.ops.bit.I8.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 923 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, i32, i8>}::shr" "core.ops.bit.I8.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 927 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, i64, i8>}::shr" "core.ops.bit.I8.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 915 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, i8, i8>}::shr" "core.ops.bit.I8.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 935 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, isize, i8>}::shr" "core.ops.bit.I8.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 907 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, u128, i8>}::shr" "core.ops.bit.I8.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 895 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, u16, i8>}::shr" "core.ops.bit.I8.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 899 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, u32, i8>}::shr" "core.ops.bit.I8.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 903 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, u64, i8>}::shr" "core.ops.bit.I8.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 891 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, u8, i8>}::shr" "core.ops.bit.I8.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 911 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<i8, usize, i8>}::shr" "core.ops.bit.I8.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1591 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, i128, isize>}::shr" "core.ops.bit.Isize.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1579 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, i16, isize>}::shr" "core.ops.bit.Isize.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1583 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, i32, isize>}::shr" "core.ops.bit.Isize.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1587 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, i64, isize>}::shr" "core.ops.bit.Isize.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1575 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, i8, isize>}::shr" "core.ops.bit.Isize.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1595 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, isize, isize>}::shr" "core.ops.bit.Isize.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1567 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, u128, isize>}::shr" "core.ops.bit.Isize.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1555 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, u16, isize>}::shr" "core.ops.bit.Isize.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1559 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, u32, isize>}::shr" "core.ops.bit.Isize.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1563 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, u64, isize>}::shr" "core.ops.bit.Isize.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1551 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, u8, isize>}::shr" "core.ops.bit.Isize.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 1571 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<isize, usize, isize>}::shr" "core.ops.bit.Isize.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 667 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, i128, u128>}::shr" "core.ops.bit.U128.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 655 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, i16, u128>}::shr" "core.ops.bit.U128.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 659 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, i32, u128>}::shr" "core.ops.bit.U128.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 663 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, i64, u128>}::shr" "core.ops.bit.U128.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 651 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, i8, u128>}::shr" "core.ops.bit.U128.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 671 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, isize, u128>}::shr" "core.ops.bit.U128.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 643 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, u128, u128>}::shr" "core.ops.bit.U128.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 631 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, u16, u128>}::shr" "core.ops.bit.U128.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 635 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, u32, u128>}::shr" "core.ops.bit.U128.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 639 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, u64, u128>}::shr" "core.ops.bit.U128.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 627 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, u8, u128>}::shr" "core.ops.bit.U128.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 647 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u128, usize, u128>}::shr" "core.ops.bit.U128.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 271 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, i128, u16>}::shr" "core.ops.bit.U16.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 259 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, i16, u16>}::shr" "core.ops.bit.U16.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 263 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, i32, u16>}::shr" "core.ops.bit.U16.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 267 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, i64, u16>}::shr" "core.ops.bit.U16.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 255 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, i8, u16>}::shr" "core.ops.bit.U16.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 275 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, isize, u16>}::shr" "core.ops.bit.U16.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 247 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, u128, u16>}::shr" "core.ops.bit.U16.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 235 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, u16, u16>}::shr" "core.ops.bit.U16.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 239 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, u32, u16>}::shr" "core.ops.bit.U16.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 243 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, u64, u16>}::shr" "core.ops.bit.U16.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 231 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, u8, u16>}::shr" "core.ops.bit.U16.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 251 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u16, usize, u16>}::shr" "core.ops.bit.U16.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 403 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, i128, u32>}::shr" "core.ops.bit.U32.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 391 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, i16, u32>}::shr" "core.ops.bit.U32.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 395 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, i32, u32>}::shr" "core.ops.bit.U32.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 399 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, i64, u32>}::shr" "core.ops.bit.U32.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 387 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, i8, u32>}::shr" "core.ops.bit.U32.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 407 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, isize, u32>}::shr" "core.ops.bit.U32.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 379 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, u128, u32>}::shr" "core.ops.bit.U32.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 367 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, u16, u32>}::shr" "core.ops.bit.U32.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 371 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, u32, u32>}::shr" "core.ops.bit.U32.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 375 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, u64, u32>}::shr" "core.ops.bit.U32.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 363 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, u8, u32>}::shr" "core.ops.bit.U32.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 383 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u32, usize, u32>}::shr" "core.ops.bit.U32.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 535 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, i128, u64>}::shr" "core.ops.bit.U64.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 523 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, i16, u64>}::shr" "core.ops.bit.U64.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 527 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, i32, u64>}::shr" "core.ops.bit.U64.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 531 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, i64, u64>}::shr" "core.ops.bit.U64.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 519 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, i8, u64>}::shr" "core.ops.bit.U64.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 539 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, isize, u64>}::shr" "core.ops.bit.U64.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 511 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, u128, u64>}::shr" "core.ops.bit.U64.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 499 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, u16, u64>}::shr" "core.ops.bit.U64.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 503 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, u32, u64>}::shr" "core.ops.bit.U64.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 507 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, u64, u64>}::shr" "core.ops.bit.U64.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 495 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, u8, u64>}::shr" "core.ops.bit.U64.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 515 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u64, usize, u64>}::shr" "core.ops.bit.U64.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 139 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, i128, u8>}::shr" "core.ops.bit.U8.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 127 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, i16, u8>}::shr" "core.ops.bit.U8.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 131 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, i32, u8>}::shr" "core.ops.bit.U8.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 135 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, i64, u8>}::shr" "core.ops.bit.U8.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 123 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, i8, u8>}::shr" "core.ops.bit.U8.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 143 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, isize, u8>}::shr" "core.ops.bit.U8.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 115 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, u128, u8>}::shr" "core.ops.bit.U8.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 103 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, u16, u8>}::shr" "core.ops.bit.U8.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 107 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, u32, u8>}::shr" "core.ops.bit.U8.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 111 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, u64, u8>}::shr" "core.ops.bit.U8.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 99 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, u8, u8>}::shr" "core.ops.bit.U8.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 119 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<u8, usize, u8>}::shr" "core.ops.bit.U8.shrUsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 799 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, i128, usize>}::shr" "core.ops.bit.Usize.shrI128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 787 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, i16, usize>}::shr" "core.ops.bit.Usize.shrI16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 791 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, i32, usize>}::shr" "core.ops.bit.Usize.shrI32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 795 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, i64, usize>}::shr" "core.ops.bit.Usize.shrI64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 783 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, i8, usize>}::shr" "core.ops.bit.Usize.shrI8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 803 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, isize, usize>}::shr" "core.ops.bit.Usize.shrIsize";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 775 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, u128, usize>}::shr" "core.ops.bit.Usize.shrU128";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 763 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, u16, usize>}::shr" "core.ops.bit.Usize.shrU16";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 767 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, u32, usize>}::shr" "core.ops.bit.Usize.shrU32";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 771 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, u64, usize>}::shr" "core.ops.bit.Usize.shrU64";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 759 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, u8, usize>}::shr" "core.ops.bit.Usize.shrU8";
  (* file: "Aeneas/Std/Scalar/CoreOps.lean", line: 779 *)
  mk_fun "core::ops::bit::{core::ops::bit::Shr<usize, usize, usize>}::shr" "core.ops.bit.Usize.shrUsize";
  (* file: "Aeneas/Std/Core/Ops.lean", line: 51 *)
  mk_fun "core::ops::drop::Drop::drop" "core.ops.drop.Drop.drop.default";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 547 *)
  mk_fun "core::ops::range::{core::ops::range::RangeInclusive<@Idx>}::is_empty" "core.ops.range.RangeInclusive.is_empty";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 542 *)
  mk_fun "core::ops::range::{core::ops::range::RangeInclusive<@Idx>}::new" "core.ops.range.RangeInclusive.new";
  (* file: "Aeneas/Std/Core/CoreOption.lean", line: 8 *)
  mk_fun "core::option::{core::option::Option<@T>}::expect" "core.option.Option.expect";
  (* file: "Aeneas/Std/Core/Core.lean", line: 117 *)
  mk_fun "core::option::{core::option::Option<@T>}::is_none" "core.option.Option.is_none" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Core/Core.lean", line: 121 *)
  mk_fun "core::option::{core::option::Option<@T>}::is_some" "core.option.Option.is_some" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Core/Core.lean", line: 114 *)
  mk_fun "core::option::{core::option::Option<@T>}::take" "core.option.Option.take" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Core/Core.lean", line: 93 *)
  mk_fun "core::option::{core::option::Option<@T>}::unwrap" "core.option.Option.unwrap";
  (* file: "Aeneas/Std/Core/Core.lean", line: 102 *)
  mk_fun "core::option::{core::option::Option<@T>}::unwrap_or" "core.option.Option.unwrap_or" ~can_fail:false;
  (* file: "Aeneas/Std/Core/Convert.lean", line: 114 *)
  mk_fun "core::result::{core::ops::try_trait::FromResidual<core::result::Result<@T, @F>, core::result::Result<core::convert::Infallible, @E>>}::from_residual" "core.result.Result.Insts.CoreOpsTryTraitFromResidualResultInfallible.from_residual";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 102 *)
  mk_fun "core::result::{core::ops::try_trait::Try<core::result::Result<@T, @E>>}::branch" "core.result.Result.Insts.CoreOpsTry.branch";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 114 *)
  mk_fun "core::result::{core::result::Result<@T, @E>}::expect" "core.result.Result.expect";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 82 *)
  mk_fun "core::result::{core::result::Result<@T, @E>}::is_ok" "core.result.Result.is_ok";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 20 *)
  mk_fun "core::result::{core::result::Result<@T, @E>}::unwrap" "core.result.Result.unwrap";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 153 *)
  mk_fun "core::slice::cmp::{core::cmp::PartialEq<[@T], [@U]>}::eq" "core.slice.cmp.PartialEqSlice.eq";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 221 *)
  mk_fun "core::slice::cmp::{core::cmp::PartialEq<[@T], [@U]>}::ne" "core.slice.cmp.PartialEqSlice.ne";
  (* file: "Aeneas/Std/Slice.lean", line: 350 *)
  mk_fun "core::slice::index::{core::ops::index::Index<[@T], @I, @O>}::index" "core.slice.index.Slice.index";
  (* file: "Aeneas/Std/Slice.lean", line: 428 *)
  mk_fun "core::slice::index::{core::ops::index::IndexMut<[@T], @I, @O>}::index_mut" "core.slice.index.Slice.index_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 376 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::get" "core.slice.index.SliceIndexRangeUsizeSlice.get";
  (* file: "Aeneas/Std/Slice.lean", line: 383 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::get_mut" "core.slice.index.SliceIndexRangeUsizeSlice.get_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 397 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::get_unchecked" "core.slice.index.SliceIndexRangeUsizeSlice.get_unchecked";
  (* file: "Aeneas/Std/Slice.lean", line: 403 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::get_unchecked_mut" "core.slice.index.SliceIndexRangeUsizeSlice.get_unchecked_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 409 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::index" "core.slice.index.SliceIndexRangeUsizeSlice.index";
  (* file: "Aeneas/Std/Slice.lean", line: 415 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>}::index_mut" "core.slice.index.SliceIndexRangeUsizeSlice.index_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 598 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::get" "core.slice.index.SliceIndexRangeFromUsizeSlice.get";
  (* file: "Aeneas/Std/Slice.lean", line: 604 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::get_mut" "core.slice.index.SliceIndexRangeFromUsizeSlice.get_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 618 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::get_unchecked" "core.slice.index.SliceIndexRangeFromUsizeSlice.get_unchecked";
  (* file: "Aeneas/Std/Slice.lean", line: 624 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::get_unchecked_mut" "core.slice.index.SliceIndexRangeFromUsizeSlice.get_unchecked_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 630 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::index" "core.slice.index.SliceIndexRangeFromUsizeSlice.index";
  (* file: "Aeneas/Std/Slice.lean", line: 637 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>}::index_mut" "core.slice.index.SliceIndexRangeFromUsizeSlice.index_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 455 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::get" "core.slice.index.SliceIndexRangeToUsizeSlice.get";
  (* file: "Aeneas/Std/Slice.lean", line: 462 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::get_mut" "core.slice.index.SliceIndexRangeToUsizeSlice.get_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 477 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::get_unchecked" "core.slice.index.SliceIndexRangeToUsizeSlice.get_unchecked";
  (* file: "Aeneas/Std/Slice.lean", line: 483 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::get_unchecked_mut" "core.slice.index.SliceIndexRangeToUsizeSlice.get_unchecked_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 490 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::index" "core.slice.index.SliceIndexRangeToUsizeSlice.index";
  (* file: "Aeneas/Std/Slice.lean", line: 497 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>}::index_mut" "core.slice.index.SliceIndexRangeToUsizeSlice.index_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 538 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::get" "core.slice.index.Usize.get";
  (* file: "Aeneas/Std/Slice.lean", line: 543 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::get_mut" "core.slice.index.Usize.get_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 548 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::get_unchecked" "core.slice.index.Usize.get_unchecked";
  (* file: "Aeneas/Std/Slice.lean", line: 554 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::get_unchecked_mut" "core.slice.index.Usize.get_unchecked_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 560 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::index" "core.slice.index.Usize.index";
  (* file: "Aeneas/Std/Slice.lean", line: 564 *)
  mk_fun "core::slice::index::{core::slice::index::SliceIndex<usize, [@T], @T>}::index_mut" "core.slice.index.Usize.index_mut";
  (* file: "Aeneas/Std/SliceIter.lean", line: 110 *)
  mk_fun "core::slice::iter::{core::iter::traits::collect::IntoIterator<&'a [@T], &'a @T, core::slice::iter::Iter<'a, @T>>}::into_iter" "SharedSlice.Insts.CoreIterTraitsCollectIntoIteratorSharedIter.into_iter";
  (* file: "Aeneas/Std/SliceIter.lean", line: 136 *)
  mk_fun "core::slice::iter::{core::iter::traits::iterator::Iterator<core::slice::iter::ChunksExact<'a, @T>, &'a [@T]>}::next" "core.slice.iter.IteratorChunksExact.next";
  (* file: "Aeneas/Std/SliceIter.lean", line: 59 *)
  mk_fun "core::slice::iter::{core::iter::traits::iterator::Iterator<core::slice::iter::Iter<'a, @T>, &'a @T>}::next" "core.slice.iter.IteratorSliceIter.next";
  (* file: "Aeneas/Std/SliceIter.lean", line: 36 *)
  mk_fun "core::slice::iter::{core::iter::traits::iterator::Iterator<core::slice::iter::IterMut<'a, @T>, &'a mut @T>}::next" "core.slice.iter.IteratorIterMut.next";
  (* file: "Aeneas/Std/SliceIter.lean", line: 130 *)
  mk_fun "core::slice::iter::{core::slice::iter::ChunksExact<'a, @T>}::remainder" "core.slice.iter.ChunksExact.getRemainder";
  (* file: "Aeneas/Std/SliceIter.lean", line: 197 *)
  mk_fun "core::slice::{[@T]}::chunks_exact" "core.slice.Slice.chunks_exact";
  (* file: "Aeneas/Std/SliceIter.lean", line: 31 *)
  mk_fun "core::slice::{[@T]}::contains" "core.slice.Slice.contains";
  (* file: "Aeneas/Std/Slice.lean", line: 592 *)
  mk_fun "core::slice::{[@T]}::copy_from_slice" "core.slice.Slice.copy_from_slice";
  (* file: "Aeneas/Std/Slice.lean", line: 1057 *)
  mk_fun "core::slice::{[@T]}::fill" "core.slice.Slice.fill";
  (* file: "Aeneas/Std/Slice.lean", line: 356 *)
  mk_fun "core::slice::{[@T]}::get" "core.slice.Slice.get";
  (* file: "Aeneas/Std/Slice.lean", line: 370 *)
  mk_fun "core::slice::{[@T]}::get_mut" "core.slice.Slice.get_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 362 *)
  mk_fun "core::slice::{[@T]}::get_unchecked" "core.slice.Slice.get_unchecked";
  (* file: "Aeneas/Std/Slice.lean", line: 123 *)
  mk_fun "core::slice::{[@T]}::is_empty" "core.slice.Slice.is_empty";
  (* file: "Aeneas/Std/SliceIter.lean", line: 27 *)
  mk_fun "core::slice::{[@T]}::iter" "core.slice.Slice.iter";
  (* file: "Aeneas/Std/SliceIter.lean", line: 54 *)
  mk_fun "core::slice::{[@T]}::iter_mut" "core.slice.Slice.iter_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 49 *)
  mk_fun "core::slice::{[@T]}::len" "Slice.len" ~can_fail:false ~lift:false;
  (* file: "Aeneas/Std/Slice.lean", line: 333 *)
  mk_fun "core::slice::{[@T]}::reverse" "core.slice.Slice.reverse" ~can_fail:false;
  (* file: "Aeneas/Std/Slice.lean", line: 701 *)
  mk_fun "core::slice::{[@T]}::split_at" "core.slice.Slice.split_at";
  (* file: "Aeneas/Std/Slice.lean", line: 712 *)
  mk_fun "core::slice::{[@T]}::split_at_mut" "core.slice.Slice.split_at_mut";
  (* file: "Aeneas/Std/Slice.lean", line: 772 *)
  mk_fun "core::slice::{[@T]}::swap" "core.slice.Slice.swap";
  (* file: "Aeneas/Std/StringIter.lean", line: 14 *)
  mk_fun "core::str::iter::{core::iter::traits::iterator::Iterator<core::str::iter::Chars<'a>, char>}::collect" "core.str.iter.IteratorChars.collect";
  (* file: "Aeneas/Std/StringIter.lean", line: 11 *)
  mk_fun "core::str::iter::{core::iter::traits::iterator::Iterator<core::str::iter::Chars<'a>, char>}::next" "core.str.iter.IteratorChars.next";
  (* file: "Aeneas/Std/StringIter.lean", line: 27 *)
  mk_fun "core::str::{str}::chars" "core.str.Str.chars";
  (* file: "Aeneas/Std/Std/Io.lean", line: 5 *)
  mk_fun "std::io::stdio::_print" "std.io.stdio._print";
]

let lean_builtin_trait_decls = [
  (* file: "Aeneas/Std/Core/Ptr.lean", line: 83 *)
  mk_trait_decl "core::alloc::global::GlobalAlloc" "core.alloc.global.GlobalAlloc" ~methods:[("alloc", "alloc"); ("dealloc", "dealloc")];
  (* file: "Aeneas/Std/Core/Core.lean", line: 25 *)
  mk_trait_decl "core::clone::Clone" "core.clone.Clone" ~methods:[("clone", "clone"); ("clone_from", "clone_from")] ~default_methods:["clone_from"];
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 16 *)
  mk_trait_decl "core::cmp::Eq" "core.cmp.Eq" ~parent_clauses:["partialEqInst"] ~methods:[("assert_fields_are_eq", "assert_fields_are_eq")];
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 142 *)
  mk_trait_decl "core::cmp::Ord" "core.cmp.Ord" ~parent_clauses:["eqInst"; "partialOrdInst"] ~methods:[("cmp", "cmp"); ("max", "max"); ("min", "min"); ("clamp", "clamp")];
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 11 *)
  mk_trait_decl "core::cmp::PartialEq" "core.cmp.PartialEq" ~methods:[("eq", "eq"); ("ne", "ne")];
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 89 *)
  mk_trait_decl "core::cmp::PartialOrd" "core.cmp.PartialOrd" ~parent_clauses:["partialEqInst"] ~methods:[("partial_cmp", "partial_cmp"); ("lt", "lt"); ("le", "le"); ("gt", "gt"); ("ge", "ge")];
  (* file: "Aeneas/Std/Core/Convert.lean", line: 72 *)
  mk_trait_decl "core::convert::AsMut" "core.convert.AsMut" ~methods:[("as_mut", "as_mut")];
  (* file: "Aeneas/Std/Core/Convert.lean", line: 28 *)
  mk_trait_decl "core::convert::AsRef" "core.convert.AsRef" ~methods:[("as_ref", "as_ref")];
  (* file: "Aeneas/Std/Core/Core.lean", line: 21 *)
  mk_trait_decl "core::convert::From" "core.convert.From" ~methods:[("from", "«from»")];
  (* file: "Aeneas/Std/Core/Convert.lean", line: 13 *)
  mk_trait_decl "core::convert::Into" "core.convert.Into" ~methods:[("into", "into")];
  (* file: "Aeneas/Std/Core/Convert.lean", line: 40 *)
  mk_trait_decl "core::convert::TryFrom" "core.convert.TryFrom" ~methods:[("try_from", "try_from")];
  (* file: "Aeneas/Std/Core/Convert.lean", line: 50 *)
  mk_trait_decl "core::convert::TryInto" "core.convert.TryInto" ~methods:[("try_into", "try_into")];
  (* file: "Aeneas/Std/Core/Default.lean", line: 5 *)
  mk_trait_decl "core::default::Default" "core.default.Default" ~methods:[("default", "default")];
  (* file: "Aeneas/Std/Core/Error.lean", line: 5 *)
  mk_trait_decl "core::error::Error" "core.error.Error" ~parent_clauses:["fmtDebugInst"; "fmtDisplayInst"];
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 15 *)
  mk_trait_decl "core::fmt::Debug" "core.fmt.Debug" ~methods:[("fmt", "fmt")];
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 68 *)
  mk_trait_decl "core::fmt::Display" "core.fmt.Display" ~methods:[("fmt", "fmt")];
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 72 *)
  mk_trait_decl "core::fmt::LowerHex" "core.fmt.LowerHex" ~methods:[("fmt", "fmt")];
  (* file: "Aeneas/Std/Core/Hash.lean", line: 11 *)
  mk_trait_decl "core::hash::Hash" "core.hash.Hash" ~methods:[("hash", "hash")];
  (* file: "Aeneas/Std/Core/Hash.lean", line: 6 *)
  mk_trait_decl "core::hash::Hasher" "core.hash.Hasher" ~methods:[("finish", "finish"); ("write", "write")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 24 *)
  mk_trait_decl "core::iter::adapters::zip::TrustedRandomAccessNoCoerce" "core.iter.adapters.zip.TrustedRandomAccessNoCoerce" ~consts:[("MAY_HAVE_SIDE_EFFECT", "MAY_HAVE_SIDE_EFFECT")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 13 *)
  mk_trait_decl "core::iter::range::Step" "core.iter.range.Step" ~parent_clauses:["cloneInst"; "partialOrdInst"] ~methods:[("steps_between", "steps_between"); ("forward_checked", "forward_checked"); ("backward_checked", "backward_checked")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 160 *)
  mk_trait_decl "core::iter::traits::accum::Product" "core.iter.traits.accum.Product" ~methods:[("product", "product")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 156 *)
  mk_trait_decl "core::iter::traits::accum::Sum" "core.iter.traits.accum.Sum" ~methods:[("sum", "sum")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 203 *)
  mk_trait_decl "core::iter::traits::collect::Extend" "core.iter.traits.collect.Extend" ~methods:[("extend", "extend")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 171 *)
  mk_trait_decl "core::iter::traits::collect::FromIterator" "core.iter.traits.collect.FromIterator" ~methods:[("from_iter", "from_iter")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 164 *)
  mk_trait_decl "core::iter::traits::collect::IntoIterator" "core.iter.traits.collect.IntoIterator" ~parent_clauses:["iteratorInst"] ~methods:[("into_iter", "into_iter")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 208 *)
  mk_trait_decl "core::iter::traits::double_ended::DoubleEndedIterator" "core.iter.traits.double_ended.DoubleEndedIterator" ~parent_clauses:["iteratorInst"] ~methods:[("next_back", "next_back")];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 214 *)
  mk_trait_decl "core::iter::traits::exact_size::ExactSizeIterator" "core.iter.traits.exact_size.ExactSizeIterator" ~parent_clauses:["iteratorInst"];
  (* file: "Aeneas/Std/Core/Iter.lean", line: 76 *)
  mk_trait_decl "core::iter::traits::iterator::Iterator" "core.iter.traits.iterator.Iterator" ~methods:[("next", "next"); ("step_by", "step_by"); ("enumerate", "enumerate"); ("take", "take")];
  (* file: "Aeneas/Std/Core/Core.lean", line: 61 *)
  mk_trait_decl "core::marker::Copy" "core.marker.Copy" ~parent_clauses:["cloneInst"];
  (* file: "Aeneas/Std/Core/Discriminant.lean", line: 8 *)
  mk_trait_decl "core::marker::DiscriminantKind" "DiscriminantKind" ~parent_clauses:["cloneInst"; "copyInst"; "debugInst"; "partialEqInst"; "eqInst"; "hashInst"] ~types:[("Discriminant", "Discriminant")];
  (* file: "Aeneas/Std/Core/Marker.lean", line: 8 *)
  mk_trait_decl "core::marker::Freeze" "core.marker.Freeze";
  (* file: "Aeneas/Std/Core/Marker.lean", line: 5 *)
  mk_trait_decl "core::marker::StructuralPartialEq" "core.marker.StructuralPartialEq";
  (* file: "Aeneas/Std/Core/Ops.lean", line: 43 *)
  mk_trait_decl "core::ops::bit::BitAnd" "core.ops.bit.BitAnd" ~methods:[("bitand", "bitand")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 19 *)
  mk_trait_decl "core::ops::deref::Deref" "core.ops.deref.Deref" ~methods:[("deref", "deref")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 23 *)
  mk_trait_decl "core::ops::deref::DerefMut" "core.ops.deref.DerefMut" ~parent_clauses:["derefInst"] ~methods:[("deref_mut", "deref_mut")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 47 *)
  mk_trait_decl "core::ops::drop::Drop" "core.ops.drop.Drop" ~methods:[("drop", "drop")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 65 *)
  mk_trait_decl "core::ops::function::Fn" "core.ops.function.Fn" ~parent_clauses:["FnMutInst"] ~methods:[("call", "call")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 60 *)
  mk_trait_decl "core::ops::function::FnMut" "core.ops.function.FnMut" ~parent_clauses:["FnOnceInst"] ~methods:[("call_mut", "call_mut")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 56 *)
  mk_trait_decl "core::ops::function::FnOnce" "core.ops.function.FnOnce" ~methods:[("call_once", "call_once")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 10 *)
  mk_trait_decl "core::ops::index::Index" "core.ops.index.Index" ~methods:[("index", "index")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 14 *)
  mk_trait_decl "core::ops::index::IndexMut" "core.ops.index.IndexMut" ~parent_clauses:["indexInst"] ~methods:[("index_mut", "index_mut")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 88 *)
  mk_trait_decl "core::ops::try_trait::FromResidual" "core.ops.try_trait.FromResidual" ~methods:[("from_residual", "from_residual")];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 103 *)
  mk_trait_decl "core::ops::try_trait::Residual" "core.ops.try_trait.Residual" ~parent_clauses:["TryInst"];
  (* file: "Aeneas/Std/Core/Ops.lean", line: 97 *)
  mk_trait_decl "core::ops::try_trait::Try" "core.ops.try_trait.Try" ~parent_clauses:["FromResidualInst"] ~methods:[("from_output", "from_output"); ("branch", "branch")];
  (* file: "Aeneas/Std/Slice.lean", line: 340 *)
  mk_trait_decl "core::slice::index::SliceIndex" "core.slice.index.SliceIndex" ~parent_clauses:["sealedInst"] ~methods:[("get", "get"); ("get_mut", "get_mut"); ("get_unchecked", "get_unchecked"); ("get_unchecked_mut", "get_unchecked_mut"); ("index", "index"); ("index_mut", "index_mut")];
  (* file: "Aeneas/Std/Slice.lean", line: 337 *)
  mk_trait_decl "core::slice::index::private_slice_index::Sealed" "core.slice.index.private_slice_index.Sealed";
]

let lean_builtin_trait_impls = [
  (* file: "Aeneas/Std/Core/Core.lean", line: 55 *)
  mk_trait_impl "core::clone::Clone<Box<@T>>" "core.core.clone.CloneBox" ~keep_params:(Some [true; false]) ~keep_trait_clauses:(Some [true; false]);
  (* file: "Aeneas/Std/Array/Array.lean", line: 321 *)
  mk_trait_impl "core::clone::Clone<[@T; @N]>" "core.clone.CloneArray";
  (* file: "Aeneas/Std/Core/Core.lean", line: 35 *)
  mk_trait_impl "core::clone::Clone<alloc::alloc::Global>" "core.core.clone.CloneGlobal";
  (* file: "Aeneas/Std/Vec.lean", line: 543 *)
  mk_trait_impl "core::clone::Clone<alloc::vec::Vec<@T>>" "core.clone.CloneallocvecVec" ~keep_params:(Some [true; false]) ~keep_trait_clauses:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Core.lean", line: 44 *)
  mk_trait_impl "core::clone::Clone<bool>" "core.clone.CloneBool";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 223 *)
  mk_trait_impl "core::cmp::PartialEq<&'a @A, &'b @B>" "core.cmp.PartialEqShared";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 191 *)
  mk_trait_impl "core::cmp::PartialEq<(), ()>" "core.cmp.PartialEqUnit";
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 235 *)
  mk_trait_impl "core::cmp::PartialEq<Box<@T>, Box<@T>>" "core.cmp.PartialEqBox" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 571 *)
  mk_trait_impl "core::cmp::PartialEq<alloc::vec::Vec<@T>, alloc::vec::Vec<@U>>" "core.cmp.PartialEqVec" ~keep_params:(Some [true; true; false; false]);
  (* file: "Aeneas/Std/Core/Cmp.lean", line: 208 *)
  mk_trait_impl "core::cmp::PartialEq<bool, bool>" "core.cmp.PartialEqBool";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 76 *)
  mk_trait_impl "core::convert::AsMut<Box<@T>, @T>" "core.convert.AsMutBox";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 501 *)
  mk_trait_impl "core::convert::AsMut<[@T; @N], [@T]>" "Array.Insts.CoreConvertAsMutSlice";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 495 *)
  mk_trait_impl "core::convert::AsRef<[@T; @N], [@T]>" "Array.Insts.CoreConvertAsRefSlice";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 35 *)
  mk_trait_impl "core::convert::From<@Self, @Self>" "core.convert.FromSame";
  (* file: "Aeneas/Std/Vec.lean", line: 467 *)
  mk_trait_impl "core::convert::From<Box<[@T]>, alloc::vec::Vec<@T>>" "core.convert.FromBoxSliceVec" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 451 *)
  mk_trait_impl "core::convert::From<alloc::vec::Vec<@T>, [@T; @N]>" "core.convert.FromVecArray";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 22 *)
  mk_trait_impl "core::convert::Into<@Self, @T>" "core.convert.IntoFrom";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 320 *)
  mk_trait_impl "core::convert::TryFrom<&'a [@T; @N], &'a [@T], core::array::TryFromSliceError>" "core.convert.TryFromSharedArraySliceTryFromSliceError";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 65 *)
  mk_trait_impl "core::convert::TryInto<@T, @U, @E>" "core.convert.TryInto.Blanket";
  (* file: "Aeneas/Std/Core/Convert.lean", line: 59 *)
  mk_trait_impl "core::convert::{core::convert::TryInto<@T, @U>}" "core.convert.TryIntoFrom";
  (* file: "Aeneas/Std/Array/Array.lean", line: 409 *)
  mk_trait_impl "core::default::Default<[@T; 0]>" "core.default.DefaultArrayEmpty";
  (* file: "Aeneas/Std/Array/Array.lean", line: 398 *)
  mk_trait_impl "core::default::Default<[@T; @N]>" "core.default.DefaultArray";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 177 *)
  mk_trait_impl "core::fmt::Debug<&'0 @T>" "core.fmt.DebugShared";
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 183 *)
  mk_trait_impl "core::fmt::Debug<()>" "core.fmt.DebugUnit";
  (* file: "Aeneas/Std/Array/ArrayDebug.lean", line: 16 *)
  mk_trait_impl "core::fmt::Debug<[@T; @N]>" "Array.Insts.CoreFmtDebug";
  (* file: "Aeneas/Std/Vec.lean", line: 592 *)
  mk_trait_impl "core::fmt::Debug<alloc::vec::Vec<@T>>" "core.fmt.DebugVec" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Fmt.lean", line: 188 *)
  mk_trait_impl "core::fmt::Debug<bool>" "core.fmt.DebugBool";
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 286 *)
  mk_trait_impl "core::fmt::Debug<core::array::TryFromSliceError>" "core.fmt.DebugTryFromSliceError";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 134 *)
  mk_trait_impl "core::fmt::Debug<i128>" "core.fmt.DebugI128";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 119 *)
  mk_trait_impl "core::fmt::Debug<i16>" "core.fmt.DebugI16";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 124 *)
  mk_trait_impl "core::fmt::Debug<i32>" "core.fmt.DebugI32";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 129 *)
  mk_trait_impl "core::fmt::Debug<i64>" "core.fmt.DebugI64";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 114 *)
  mk_trait_impl "core::fmt::Debug<i8>" "core.fmt.DebugI8";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 139 *)
  mk_trait_impl "core::fmt::Debug<isize>" "core.fmt.DebugIsize";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 68 *)
  mk_trait_impl "core::fmt::Debug<u128>" "core.fmt.DebugU128";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 53 *)
  mk_trait_impl "core::fmt::Debug<u16>" "core.fmt.DebugU16";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 58 *)
  mk_trait_impl "core::fmt::Debug<u32>" "core.fmt.DebugU32";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 63 *)
  mk_trait_impl "core::fmt::Debug<u64>" "core.fmt.DebugU64";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 48 *)
  mk_trait_impl "core::fmt::Debug<u8>" "core.fmt.DebugU8";
  (* file: "Aeneas/Std/Scalar/Fmt.lean", line: 73 *)
  mk_trait_impl "core::fmt::Debug<usize>" "core.fmt.DebugUsize";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 420 *)
  mk_trait_impl "core::iter::range::Step<i128>" "core.iter.range.StepI128";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 393 *)
  mk_trait_impl "core::iter::range::Step<i16>" "core.iter.range.StepI16";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 402 *)
  mk_trait_impl "core::iter::range::Step<i32>" "core.iter.range.StepI32";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 411 *)
  mk_trait_impl "core::iter::range::Step<i64>" "core.iter.range.StepI64";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 384 *)
  mk_trait_impl "core::iter::range::Step<i8>" "core.iter.range.StepI8";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 375 *)
  mk_trait_impl "core::iter::range::Step<isize>" "core.iter.range.StepIsize";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 366 *)
  mk_trait_impl "core::iter::range::Step<u128>" "core.iter.range.StepU128";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 339 *)
  mk_trait_impl "core::iter::range::Step<u16>" "core.iter.range.StepU16";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 348 *)
  mk_trait_impl "core::iter::range::Step<u32>" "core.iter.range.StepU32";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 357 *)
  mk_trait_impl "core::iter::range::Step<u64>" "core.iter.range.StepU64";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 330 *)
  mk_trait_impl "core::iter::range::Step<u8>" "core.iter.range.StepU8";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 321 *)
  mk_trait_impl "core::iter::range::Step<usize>" "core.iter.range.StepUsize";
  (* file: "Aeneas/Std/VecIter.lean", line: 72 *)
  mk_trait_impl "core::iter::traits::collect::FromIterator<alloc::vec::Vec<@T>, @T>" "core.iter.traits.collect.FromIteratorVec";
  (* file: "Aeneas/Std/SliceIter.lean", line: 95 *)
  mk_trait_impl "core::iter::traits::collect::IntoIterator<&'a [@T; @N], &'a @T, core::slice::iter::Iter<'a, @T>>" "SharedArray.Insts.CoreIterTraitsCollectIntoIteratorSharedIter";
  (* file: "Aeneas/Std/SliceIter.lean", line: 116 *)
  mk_trait_impl "core::iter::traits::collect::IntoIterator<&'a [@T], &'a @T, core::slice::iter::Iter<'a, @T>>" "SharedSlice.Insts.CoreIterTraitsCollectIntoIteratorSharedIter";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 185 *)
  mk_trait_impl "core::iter::traits::collect::IntoIterator<@I, @Item, @I>" "core.iter.traits.collect.IntoIterator.Blanket";
  (* file: "Aeneas/Std/VecIter.lean", line: 39 *)
  mk_trait_impl "core::iter::traits::collect::IntoIterator<alloc::vec::Vec<@T>, @T, alloc::vec::into_iter::IntoIter<@T, @A>>" "core.iter.traits.collect.IntoIteratorVec" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/RangeIter.lean", line: 551 *)
  mk_trait_impl "core::iter::traits::double_ended::DoubleEndedIterator<core::ops::range::Range<@A>, @A>" "core.ops.range.Range.Insts.DoubleEndedIterator";
  (* file: "Aeneas/Std/VecIter.lean", line: 20 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<alloc::vec::into_iter::IntoIter<@T, @A>, @T>" "core.iter.traits.iterator.IteratorVecIntoIter" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Iter.lean", line: 442 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::iter::adapters::enumerate::Enumerate<@I>, (usize, @Clause0_Item)>" "core.iter.traits.iterator.IteratorEnumerate";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 142 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::iter::adapters::step_by::StepBy<@I>, @Clause0_Item>" "core.iter.traits.iterator.IteratorStepBy";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 475 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::iter::adapters::take::Take<@I>, @Clause0_Item>" "core.iter.traits.iterator.IteratorTake";
  (* file: "Aeneas/Std/Core/Iter.lean", line: 504 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::ops::range::Range<@A>, @A>" "core.iter.traits.iterator.IteratorRange";
  (* file: "Aeneas/Std/RangeIter.lean", line: 562 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::ops::range::RangeInclusive<@A>, @A>" "core.ops.range.RangeInclusive.Insts.CoreIterTraitsIteratorIterator";
  (* file: "Aeneas/Std/SliceIter.lean", line: 145 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::slice::iter::ChunksExact<'a, @T>, &'a [@T]>" "core.iter.traits.iterator.IteratorChunksExact";
  (* file: "Aeneas/Std/SliceIter.lean", line: 69 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::slice::iter::Iter<'a, @T>, &'a @T>" "core.iter.traits.iterator.IteratorSliceIter";
  (* file: "Aeneas/Std/StringIter.lean", line: 20 *)
  mk_trait_impl "core::iter::traits::iterator::Iterator<core::str::iter::Chars<'a>, char>" "core.iter.traits.iterator.IteratorChars";
  (* file: "Aeneas/Std/Array/Array.lean", line: 414 *)
  mk_trait_impl "core::marker::Copy<[@T; @N]>" "Array.Insts.CoreMarkerCopy";
  (* file: "Aeneas/Std/Core/Core.lean", line: 65 *)
  mk_trait_impl "core::marker::Copy<bool>" "core.core.marker.CopyBool";
  (* file: "Aeneas/Std/Core/Ops.lean", line: 29 *)
  mk_trait_impl "core::ops::deref::Deref<Box<@T>, @T>" "core.ops.deref.DerefBoxInst" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 368 *)
  mk_trait_impl "core::ops::deref::Deref<alloc::vec::Vec<@T>, [@T]>" "core.ops.deref.DerefVec" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Core/Ops.lean", line: 36 *)
  mk_trait_impl "core::ops::deref::DerefMut<Box<@T>, @T>" "core.ops.deref.DerefMutBoxInst" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Vec.lean", line: 379 *)
  mk_trait_impl "core::ops::deref::DerefMut<alloc::vec::Vec<@T>, [@T]>" "core.ops.deref.DerefMutVec" ~keep_params:(Some [true; false]);
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 108 *)
  mk_trait_impl "core::ops::index::Index<[@T; @N], @I, @O>" "core.ops.index.IndexArray";
  (* file: "Aeneas/Std/Slice.lean", line: 523 *)
  mk_trait_impl "core::ops::index::Index<[@T], @I, @O>" "core.ops.index.IndexSlice";
  (* file: "Aeneas/Std/Vec.lean", line: 209 *)
  mk_trait_impl "core::ops::index::Index<alloc::vec::Vec<@T>, @T, @O>" "alloc.vec.Vec.Index" ~keep_params:(Some [true; true; false; true]);
  (* file: "Aeneas/Std/Array/ArraySlice.lean", line: 115 *)
  mk_trait_impl "core::ops::index::IndexMut<[@T; @N], @I, @O>" "core.ops.index.IndexMutArray";
  (* file: "Aeneas/Std/Slice.lean", line: 530 *)
  mk_trait_impl "core::ops::index::IndexMut<[@T], @I, @O>" "core.ops.index.IndexMutSlice";
  (* file: "Aeneas/Std/Vec.lean", line: 217 *)
  mk_trait_impl "core::ops::index::IndexMut<alloc::vec::Vec<@T>, @T, @O>" "alloc.vec.Vec.IndexMut" ~keep_params:(Some [true; true; false; true]);
  (* file: "Aeneas/Std/Slice.lean", line: 438 *)
  mk_trait_impl "core::slice::index::SliceIndex<core::ops::range::Range<usize>, [@T], [@T]>" "core.slice.index.SliceIndexRangeUsizeSlice";
  (* file: "Aeneas/Std/Slice.lean", line: 663 *)
  mk_trait_impl "core::slice::index::SliceIndex<core::ops::range::RangeFrom<usize>, [@T], [@T]>" "core.slice.index.SliceIndexRangeFromUsizeSlice";
  (* file: "Aeneas/Std/Slice.lean", line: 510 *)
  mk_trait_impl "core::slice::index::SliceIndex<core::ops::range::RangeTo<usize>, [@T], [@T]>" "core.slice.index.SliceIndexRangeToUsizeSlice";
  (* file: "Aeneas/Std/Slice.lean", line: 573 *)
  mk_trait_impl "core::slice::index::SliceIndex<usize, [@T], @T>" "core.slice.index.SliceIndexUsizeSlice";
  (* file: "Aeneas/Std/Slice.lean", line: 434 *)
  mk_trait_impl "core::slice::index::private_slice_index::Sealed<core::ops::range::Range<usize>>" "core.slice.index.private_slice_index.SealedRangeUsize";
  (* file: "Aeneas/Std/Slice.lean", line: 658 *)
  mk_trait_impl "core::slice::index::private_slice_index::Sealed<core::ops::range::RangeFrom<usize>>" "core.slice.index.private_slice_index.SealedRangeFromUsize";
  (* file: "Aeneas/Std/Slice.lean", line: 450 *)
  mk_trait_impl "core::slice::index::private_slice_index::Sealed<core::ops::range::RangeTo<usize>>" "core.slice.index.private_slice_index.SealedRangeToUsize";
  (* file: "Aeneas/Std/Slice.lean", line: 569 *)
  mk_trait_impl "core::slice::index::private_slice_index::Sealed<usize>" "core.slice.index.private_slice_index.SealedUsize";
]

