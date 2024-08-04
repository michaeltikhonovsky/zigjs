const std = @import("std");

const math = @cImport({
    @cInclude("math.h");
});

pub fn main() !void {
    const a = 1;
    const b = 2;
    const c = math.add(a, b);
    std.debug.print("{d}", .{c});
    std.debug.print("{d}", .{math.increment(c)});
}
