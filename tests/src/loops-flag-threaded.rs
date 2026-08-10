//@ [!lean] skip

// Companion to `loops-outer-control-flow.rs`.
//
// Each function here is a *manual* control-flow-flattening ("state machine")
// encoding of one of the unsupported patterns in that file: the non-local exit
// is replaced by a single-level `break` that sets a synthetic "exit reason"
// local, which the enclosing context then dispatches on. These all translate
// cleanly today — they are the shape a future automatic transformation in
// `PrePasses.update_loops` should produce. See REPORT-outer-loop-control-flow.md.

// Flag-threaded equivalent of `return_from_nested_loop`: the inner loop signals
// the early return through `ret`, the outer loop propagates it, and the
// function tail dispatches on it.
pub fn return_from_nested_loop(m: u32, n: u32) -> u32 {
    let mut ret: Option<u32> = None;
    let mut i = 0;
    while i < m {
        let mut j = 0;
        while j < n {
            if i + j > 10 {
                ret = Some(i + j);
                break;
            }
            j += 1;
        }
        if ret.is_some() {
            break;
        }
        i += 1;
    }
    match ret {
        Some(r) => r,
        None => 0,
    }
}

// Flag-threaded equivalent of `return_from_loop_in_branch`.
pub fn return_from_loop_in_branch(n: u32, sel: bool) -> u32 {
    let mut total = 0u32;
    let mut ret: Option<u32> = None;
    if sel {
        let mut i = 0u32;
        while i < n {
            if i == 7 {
                ret = Some(99);
                break;
            }
            total += i;
            i += 1;
        }
    }
    match ret {
        Some(r) => r,
        None => total,
    }
}

// Flag-threaded equivalent of `labelled_break`: `break 'outer` becomes an
// `exit` flag that the outer loop checks after the inner loop returns.
pub fn labelled_break(m: u32, n: u32) -> u32 {
    let mut total = 0u32;
    let mut i = 0u32;
    let mut exit = false;
    while i < m {
        let mut j = 0u32;
        while j < n {
            if i * j > 50 {
                exit = true;
                break;
            }
            total += 1;
            j += 1;
        }
        if exit {
            break;
        }
        i += 1;
    }
    total
}

// Flag-threaded equivalent of `labelled_continue`: `continue 'outer` becomes a
// `skip` flag; the outer loop skips its own tail when the flag is set.
pub fn labelled_continue(m: u32, n: u32) -> u32 {
    let mut total = 0u32;
    let mut i = 0u32;
    while i < m {
        let mut j = 0u32;
        let mut skip = false;
        while j < n {
            if j == 3 {
                i += 1;
                skip = true;
                break;
            }
            total += 1;
            j += 1;
        }
        if skip {
            continue;
        }
        i += 1;
    }
    total
}
