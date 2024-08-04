const std = @import("std");

extern fn add(a: i32, b: i32) i32;

extern fn increment(a: i32) i32;

pub fn main() !void {
    const a = 1;
    const b = 2;
    const c = add(a, b);
    std.debug.print("{d}\n", .{c});
    std.debug.print("{d}\n", .{increment(c)});
}
