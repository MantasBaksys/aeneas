//@ [!lean] skip

// Regression test: labelled `continue 'outer` out of a nested loop (LLBC
// `continue i` with i > 0). One of the constructs used by
// `regex_syntax::utf8::Utf8Sequences::next`.
//
// The symbolic interpreter only supports `continue 0` (re-enter the innermost
// loop). `PrePasses` therefore flattens non-local exits (labelled
// `break`/`continue` and early `return`) into a state machine: a synthetic
// exit-reason flag is threaded out of the loop and dispatched on after it. This
// test pins that the flattening works for a scalar (borrow-free) loop state.
// Loops that carry a borrow across such an exit are still rejected honestly
// (see the guard in `PrePasses.update_loops` and REPORT-outer-loop-control-flow.md).
//
// Expected: successful extraction.
pub fn labelled_continue(m: u32, n: u32) -> u32 {
    let mut total = 0u32;
    let mut i = 0u32;
    'outer: while i < m {
        let mut j = 0u32;
        while j < n {
            if j == 3 {
                i += 1;
                continue 'outer;
            }
            total += 1;
            j += 1;
        }
        i += 1;
    }
    total
}
