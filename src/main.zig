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

    const js_code =
        \\const game = {
        \\  currentRoom: 'start',
        \\  inventory: [],
        \\  rooms: {
        \\    start: { description: 'You are in a dark room. There is a door to the north.', exits: { north: 'corridor' } },
        \\    corridor: { description: 'You are in a long corridor. There is a door to the south and a door to the east.', exits: { south: 'start', east: 'treasure' } },
        \\    treasure: { description: 'You found the treasure room! There is a golden key here.', exits: { west: 'corridor' }, items: ['golden key'] }
        \\  },
        \\  move: function(direction) {
        \\    const nextRoom = this.rooms[this.currentRoom].exits[direction];
        \\    if (nextRoom) {
        \\      this.currentRoom = nextRoom;
        \\      this.look();
        \\    } else {
        \\      console.log("You can't go that way.");
        \\    }
        \\  },
        \\  look: function() {
        \\    console.log(this.rooms[this.currentRoom].description);
        \\    const items = this.rooms[this.currentRoom].items;
        \\    if (items && items.length > 0) {
        \\      console.log(`You see: ${items.join(', ')}`);
        \\    }
        \\  },
        \\  take: function(item) {
        \\    const roomItems = this.rooms[this.currentRoom].items;
        \\    if (roomItems && roomItems.includes(item)) {
        \\      this.inventory.push(item);
        \\      this.rooms[this.currentRoom].items = roomItems.filter(i => i !== item);
        \\      console.log(`You picked up the ${item}.`);
        \\    } else {
        \\      console.log("You don't see that item here.");
        \\    }
        \\  }
        \\};
        \\
        \\console.log("Welcome to the Text Adventure!");
        \\game.look();
        \\game.move('north');
        \\game.move('east');
        \\game.take('golden key');
        \\console.log(`Inventory: ${game.inventory.join(', ')}`);
        \\
        \\game.inventory.length; // Return the number of items in inventory
    ;

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
            std.debug.print("Number of items in inventory: {}\n", .{result});
        } else {
            std.debug.print("Failed to convert result to int32\n", .{});
        }
    }

    c.JS_FreeValue(ctx, val);
}
