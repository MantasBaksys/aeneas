//@ [!lean] skip
// Regression test for the `Iterator::copied` extraction cascade.
//
// A trait provided-method whose `where`-clause constrains an associated type of
// `Self` (here `Self::Item = &'a T`) produces a non-empty
// `trait_type_constraints` on the *method signature*. `translate_fun_sigs`
// (SymbolicToPureTypes.ml) used to abort on any such signature with a blanket
// sanity check, which made the whole trait declaration fail to translate and
// emitted `sorry /- Could not find: trait_decl_id -/` into the generated code.
//
// This mirrors `<slice::Iter<'a, T> as Iterator>::copied`, whose where-clause
// `Self: Iterator<Item = &'a T>` is what made ripgrep extraction emit `sorry`.
// The associated-type-projection constraint is inert for extraction (it is
// preserved in the pure predicates and reconstructed by the interpreter), so it
// is sound to allow it here; this test must translate without error.

pub trait MyIter {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;

    fn count_copied<'a, T: 'a>(mut self) -> usize
    where
        Self: MyIter<Item = &'a T> + Sized,
        T: Copy,
    {
        let mut n = 0;
        while let Some(_) = self.next() {
            n += 1;
        }
        n
    }
}
