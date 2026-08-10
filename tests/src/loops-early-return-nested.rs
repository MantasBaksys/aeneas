//@ [lean] known-failure
//@ [!lean] skip

// Regression test: early `return` from inside a *nested* loop (depth >= 2).
//
// Aeneas translates each loop into an isolated recursive function and its
// symbolic interpreter only supports control flow that stays within the
// innermost loop. `PrePasses.update_loops` can lift an early return out of a
// *single* enclosing loop, but not out of several. Propagating this return
// requires control-flow flattening (a synthetic exit reason threaded out of
// each loop). See REPORT-outer-loop-control-flow.md and the working manual
// encoding in `loops-flag-threaded.rs`.
//
// Expected: honest rejection "Early returns out of nested loops ...".
pub fn return_from_nested_loop(m: u32, n: u32) -> u32 {
    let mut i = 0;
    while i < m {
        let mut j = 0;
        while j < n {
            if i + j > 10 {
                return i + j;
            }
            j += 1;
        }
        i += 1;
    }
    0
}
