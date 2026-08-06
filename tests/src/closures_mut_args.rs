//@ [!lean] skip
//@ charon-args=--lift-associated-types=* --remove-adt-clauses --monomorphize-mut=except-types

pub fn call_mut_arg<A>(mut append: A, dst: &mut Vec<u8>)
where
    A: FnMut(usize, &mut Vec<u8>),
{
    append(0, dst);
}
