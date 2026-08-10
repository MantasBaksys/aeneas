//@ [lean] known-failure
//@ [!lean] skip

// Regression test: early `return` from a loop that is NOT directly followed by
// the function's return/panic (here the loop is nested inside an `if`, and the
// function tail is after the `if`). This is the shape of `grep_regex::ban::check`.
//
// `PrePasses.update_loops` transformation 2/3 can rewrite an early return into a
// break only when the loop is immediately followed by the function's
// return/panic (so every exit path can be made to end in a single post-loop
// return). When the loop is nested inside an `if`/`match`/another loop, the
// continuation is non-local and shared with other paths, so a sound rewrite
// needs control-flow flattening (a synthetic exit reason). See
// REPORT-outer-loop-control-flow.md and `loops-flag-threaded.rs`.
//
// Expected: honest rejection "Early returns out of loops ...".
pub fn return_from_loop_in_branch(n: u32, sel: bool) -> u32 {
    let mut total = 0u32;
    if sel {
        let mut i = 0u32;
        while i < n {
            if i == 7 {
                return 99;
            }
            total += i;
            i += 1;
        }
    }
    total
}
