const std = @import("std");

const data = @embedFile("input.txt");

pub fn main() !void {
    var password: i32 = 0;
    var dial: i32 = 50;

    var iterator = std.mem.tokenizeAny(u8, data, "\n\r");
    while (iterator.next()) |r| {
        const dir: i32 = if (r.ptr[0] == 'R') 1 else -1;
        const quant = try std.fmt.parseInt(i32, r[1..], 10) * dir;
        dial = @mod(dial + quant, 100);

        if (dial == 0) {
            password = password + 1;
        }
    }

    std.log.info("Password: {d}", .{password});
}
