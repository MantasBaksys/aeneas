import Aeneas.Tactic.Elab.TraitDefault.Init

namespace Aeneas.TraitDefault.Test

namespace Test1

  /-! ## Test: basic structure with trait_default -/

  structure Trait where
    N : Nat
    P : Nat
    Q : Nat := 5
    R : Nat := N + 1

  @[trait_default]
  def Trait.P.default (self : Trait) : Nat := self.N + 3

  def Inst : Trait := {
    N := 5
    P := 3
  }

  /-- Test -/
  @[simp]
  impl_def TraitInst : Trait := {
    N := 5
    P := Trait.P.default TraitInst,
  }

  /-- Test -/
  impl_def TraitInst1 : Trait := {
    N := 5,
    P := Trait.P.default TraitInst1
  }

end Test1

namespace Test2

  /-! ## Test: parameterized structures -/

  structure Trait1 (N : Nat) (α : Type u) where
    A := N
    B := A + N
    C : Bool
    D : Nat
    E : α

  @[trait_default]
  def Trait1.D.default (self : Trait1 N α) : Nat :=
    self.A + self.B

  impl_def Trait1Inst (n : Nat) : Trait1 n Bool := {
    C := true
    D := Trait1.D.default (Trait1Inst n)
    E := true
  }

end Test2

namespace Test3

  structure Trait1 (N : Nat) (α : Type u) where
    A := N
    B := A + N
    C : Bool
    D : Nat
    E : α

  @[irreducible, trait_default]
  def Trait1.D.default (self : Trait1 N α) : Nat :=
    self.A + self.B

  impl_def Trait1Inst (n : Nat) : Trait1 n Bool := {
    C := true
    D := Trait1.D.default (Trait1Inst n)
    E := true
  }

end Test3

namespace Test4

  /-! ## Test: a default that passes the whole instance to a helper

      This is the shape Aeneas generates when a trait default method body contains
      a closure: the closure's `Fn*` instance is parameterised by the *enclosing
      trait instance*, so the instance is threaded through unprojected rather than
      as a field projection. `substituteProjections` alone cannot eliminate such a
      self-reference; `unfoldSelfApplications` peels the helper to expose the
      projection underneath. -/

  structure Trait2 (α : Type) where
    len : α → Nat
    get : α → Nat → Option Nat
    isEmpty : α → Bool
    interpolate : {F : Type} → (F → Nat) → α → Nat

  /-- A nested "closure instance", parameterised by the whole trait instance. -/
  structure ClosureInst (α : Type) where
    callMut : α → Nat → Option Nat

  def Trait2.closureInst (inst : Trait2 α) : ClosureInst α :=
    { callMut := fun a i => inst.get a i }

  @[trait_default]
  def Trait2.isEmpty.default (inst : Trait2 α) (a : α) : Bool :=
    inst.len a == 0

  /-- Polymorphic default whose body hands `inst` to `Trait2.closureInst`
      unprojected. -/
  @[trait_default]
  def Trait2.interpolate.default (inst : Trait2 α) {F : Type} (_f : F → Nat) (a : α) : Nat :=
    ((Trait2.closureInst inst).callMut a 0).getD 0

  impl_def Trait2Inst : Trait2 (List Nat) := {
    len := List.length
    get := fun l i => l[i]?
    isEmpty := Trait2.isEmpty.default Trait2Inst
    interpolate := fun {F : Type} (f : F → Nat) => Trait2.interpolate.default Trait2Inst f
  }

  -- The instance must be a genuine, kernel-accepted definition that computes.
  example : Trait2Inst.isEmpty [] = true := by native_decide
  example : Trait2Inst.interpolate (F := Nat) id [7, 8] = 7 := by native_decide
  example : Trait2Inst.interpolate (F := Nat) id [] = 0 := by native_decide

end Test4

end Aeneas.TraitDefault.Test
