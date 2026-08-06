//@ [lean] known-failure
//@ [!lean] skip

trait Trait {
    fn get(&self) -> u32;
}

impl Trait for &bool {
    fn get(&self) -> u32 {
        **self as u32
    }
}

// Unsizing a nested shared reference `&&bool` to a trait object `&dyn Trait`,
// where the inner value is itself a shared borrow. This exercises the
// shared-borrow collection + `ctx_lookup_shared_value` recursion in the
// unsizing cast.
fn unsize_nested_ref<'a>(x: &'a &'a bool) -> &'a dyn Trait {
    x
}
