structure Box where val : Nat → Option Nat
mutual
  def f (n : Nat) : Option Nat :=
    match n with | 0 => some 0 | m+1 => do let r ← Box.val theBox m; some (r+1)
  partial_fixpoint
  def theBox : Box := { val := f }
end
#check @f
