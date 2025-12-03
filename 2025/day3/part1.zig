const std = @import("std");

const data = @embedFile("input.txt");

fn highest_digit(string: []const u8) !struct { digit: u8, index: usize } {
    var highestDigit: u8 = 0;
    var highestDigitIndex: usize = 0;

    for (string, 0..) |c, i| {
        const digit = try std.fmt.charToDigit(c, 10);
        if (digit > highestDigit) {
            highestDigit = digit;
            highestDigitIndex = i;
        }
    }

    return .{ .digit = highestDigit, .index = highestDigitIndex };
}

pub fn main() !void {
    var password: usize = 0;

    var it1 = std.mem.tokenizeAny(u8, data, "\n\r");
    while (it1.next()) |r| {
        const first = try highest_digit(r[0 .. r.len - 1]);
        const second = try highest_digit(r[first.index + 1 ..]);
        password = password + (first.digit * 10) + second.digit;
    }

    std.log.info("Password: {d}", .{password});
}
