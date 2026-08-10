inductive Result (a : Type) where | ok : a → Result a | fail : Result a
def Result.bind (x : Result a) (f : a → Result b) : Result b :=
  match x with | .ok v => f v | .fail => .fail
instance : Monad Result where pure := .ok; bind := Result.bind
def ok {a} (v : a) : Result a := .ok v

structure ClassUnicodeRange where
  s : Char
  e : Char
def ClassUnicodeRange.start (r : ClassUnicodeRange) : Result Char := ok r.s
def ClassUnicodeRange.end (r : ClassUnicodeRange) : Result Char := ok r.e

def closure_call (c : Char) (tupled_args : ClassUnicodeRange) : Result Bool := do
  let c1 ← ClassUnicodeRange.start tupled_args
  if c1 <= c
  then
    let c2 ← ClassUnicodeRange.end tupled_args
    ok (c <= c2)
  else ok false

def mk (lo hi : Char) : ClassUnicodeRange := { s := lo, e := hi }
#eval (match closure_call 'm' (mk 'a' 'z') with | .ok b => b | .fail => false)  -- true
#eval (match closure_call 'A' (mk 'a' 'z') with | .ok b => b | .fail => false)  -- false
