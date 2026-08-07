//@ [!lean] skip
#![feature(register_tool)]
#![register_tool(verify)]

pub fn early_return_in_loop(stop: u32) -> u32 {
    let mut i = 0;
    loop {
        if i == stop {
            return i + 10;
        }
        if i == 4 {
            break;
        }
        i += 1;
    }
    i
}

pub fn return_from_nested_loop() -> u32 {
    let mut outer = 0;
    loop {
        let mut inner = 0;
        loop {
            if inner == 1 {
                return outer + inner;
            }
            inner += 1;
        }
    }
}
pub fn continue_to_outer_loop() -> u32 {
    let mut acc = 0;
    let mut i = 0;
    'outer: while i < 3 {
        let mut j = 0;
        while j < 3 {
            acc += 10;
            j += 1;
            if j == 2 {
                i += 1;
                continue 'outer;
            }
        }
        acc += 100;
        i += 1;
    }
    acc
}

pub fn break_to_outer_loop() -> u32 {
    let mut acc = 0;
    let mut i = 0;
    'outer: while i < 4 {
        let mut j = 0;
        while j < 4 {
            if i == 2 && j == 1 {
                break 'outer;
            }
            acc += 1;
            j += 1;
        }
        i += 1;
    }
    acc
}

#[verify::test]
fn test_early_return_in_loop_hit() {
    assert!(early_return_in_loop(2) == 12);
}

#[verify::test]
fn test_early_return_in_loop_break() {
    assert!(early_return_in_loop(8) == 4);
}

#[verify::test]
fn test_return_from_nested_loop_hit() {
    assert!(return_from_nested_loop() == 1);
}

#[verify::test]
fn test_continue_to_outer_loop() {
    assert!(continue_to_outer_loop() == 60);
}

#[verify::test]
fn test_break_to_outer_loop() {
    assert!(break_to_outer_loop() == 9);
}
