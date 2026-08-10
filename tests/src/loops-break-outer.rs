//@ [lean] known-failure
//@ [!lean] skip

// Regression test: labelled `break 'outer` out of a nested loop (LLBC `break i`
// with i > 0). One of the constructs used by
// `regex_syntax::utf8::Utf8Sequences::next`.
//
// The symbolic interpreter only supports `break 0` (exit the innermost loop);
// `PrePasses` rejects `break i` (i > 0). A non-local break exits several loops
// at once, which requires control-flow flattening (a synthetic exit reason
// threaded out of each loop). See REPORT-outer-loop-control-flow.md and the
// working manual encoding in `loops-flag-threaded.rs`.
//
// Expected: honest rejection "Breaks to outer loops ...".
pub fn labelled_break(m: u32, n: u32) -> u32 {
    let mut total = 0u32;
    let mut i = 0u32;
    'outer: while i < m {
        let mut j = 0u32;
        while j < n {
            if i * j > 50 {
                break 'outer;
            }
            total += 1;
            j += 1;
        }
        i += 1;
    }
    total
}
