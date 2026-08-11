inductive Result (α : Type) where
  | ok : α → Result α | fail : Result α | div : Result α
open Result
def Result.bind {α β} (x : Result α) (f : α → Result β) : Result β :=
  match x with | ok a => f a | fail => fail | div => div
instance : Monad Result where pure := ok; bind := Result.bind
structure FnOnce (Self Args Output : Type) where
  call_once : Self → Args → Result Output
structure FnMut (Self Args Output : Type) where
  FnOnceInst : FnOnce Self Args Output
  call_mut : Self → Args → Result (Output × Self)
inductive Tree where | leaf : Nat → Tree | node : List Tree → Tree
def mapList {S A B : Type} (inst : FnMut S A B) (st : S) (xs : List A) : Result (List B) :=
  match xs with
  | [] => ok []
  | x :: tl => do
      let (y, st') ← inst.call_mut st x
      let ys ← mapList inst st' tl
      ok (y :: ys)
mutual
  partial def map_tree (t : Tree) : Result Tree :=
    match t with
    | .leaf x => ok (.leaf (x + 1))
    | .node v => do
        let v' ← mapList map_tree.closure.FnMutInst () v
        ok (.node v')
  partial def map_tree.closure.call_mut (_st : Unit) (arg : Tree) : Result (Tree × Unit) := do
    let r ← map_tree arg
    ok (r, ())
  partial def map_tree.closure.call_once (st : Unit) (arg : Tree) : Result Tree := do
    let (r, _) ← map_tree.closure.call_mut st arg
    ok r
end
def map_tree.closure.FnOnceInst : FnOnce Unit Tree Tree := { call_once := map_tree.closure.call_once }
def map_tree.closure.FnMutInst : FnMut Unit Tree Tree := { FnOnceInst := map_tree.closure.FnOnceInst, call_mut := map_tree.closure.call_mut }
#check @map_tree
