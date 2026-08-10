//@ [lean] known-failure
//@ [!lean] skip

// Regression test: labelled `continue 'outer` out of a nested loop (LLBC
// `continue i` with i > 0). One of the constructs used by
// `regex_syntax::utf8::Utf8Sequences::next`.
//
// The symbolic interpreter only supports `continue 0` (re-enter the innermost
// loop); `PrePasses` rejects `continue i` (i > 0). A non-local continue exits
// one or more inner loops and re-enters an outer one, which requires
// control-flow flattening (a synthetic exit reason threaded out of each loop).
// See REPORT-outer-loop-control-flow.md and the working manual encoding in
// `loops-flag-threaded.rs`.
//
// Expected: honest rejection "Continues to outer loops ...".
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
