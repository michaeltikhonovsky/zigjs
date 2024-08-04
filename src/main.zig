const std = @import("std");
const math = @import("bindings.zig").math;

pub fn main() !void {
    const a = 1;
    const b = 2;
    const c = math.add(a, b);
    std.debug.print("{d}\n", .{c});
    std.debug.print("{d}\n", .{math.increment(c)});
}
