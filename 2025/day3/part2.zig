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
    var buffer = [_]u8{0} ** 12;

    var it1 = std.mem.tokenizeAny(u8, data, "\n\r");
    while (it1.next()) |r| {
        var list = std.ArrayListUnmanaged(u8).initBuffer(&buffer);
        var nextStartIndex: usize = 0;
        for (0..12) |i| {
            const v = try highest_digit(r[nextStartIndex .. r.len - (11 - i)]);
            list.appendAssumeCapacity(std.fmt.digitToChar(v.digit, .lower));
            nextStartIndex = nextStartIndex + v.index + 1;
        }

        password = password + try std.fmt.parseInt(usize, list.items, 10);
    }

    std.log.info("Password: {d}", .{password});
}
