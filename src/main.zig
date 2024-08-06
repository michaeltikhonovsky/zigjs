const std = @import("std");
const c = @cImport({
    @cInclude("quickjs.h");
    @cInclude("quickjs-libc.h");
});

pub fn main() !void {
    const rt = c.JS_NewRuntime() orelse {
        std.debug.print("Failed to create QuickJS runtime\n", .{});
        return error.RuntimeCreationFailed;
    };
    defer c.JS_FreeRuntime(rt);

    const ctx = c.JS_NewContext(rt) orelse {
        std.debug.print("Failed to create QuickJS context\n", .{});
        return error.ContextCreationFailed;
    };
    defer c.JS_FreeContext(ctx);

    c.js_std_init_handlers(rt);
    c.js_std_add_helpers(ctx, 0, null);

    const js_code = "console.log('Hello from JavaScript!'); 2 + 2;";

    const val = c.JS_Eval(ctx, js_code, js_code.len, "example.js", c.JS_EVAL_TYPE_GLOBAL);

    if (c.JS_IsException(val) != 0) {
        const err = c.JS_GetException(ctx);
        defer c.JS_FreeValue(ctx, err);

        const err_msg = c.JS_ToCString(ctx, err);
        if (err_msg != null) {
            std.debug.print("JavaScript error: {s}\n", .{err_msg});
            c.JS_FreeCString(ctx, err_msg);
        } else {
            std.debug.print("Unknown JavaScript error occurred\n", .{});
        }
    } else {
        var result: c_int = undefined;
        if (c.JS_ToInt32(ctx, &result, val) == 0) {
            std.debug.print("Result: {}\n", .{result});
        } else {
            std.debug.print("Failed to convert result to int32\n", .{});
        }
    }

    c.JS_FreeValue(ctx, val);
}
