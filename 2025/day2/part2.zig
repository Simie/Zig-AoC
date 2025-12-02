const std = @import("std");

const data = @embedFile("input.txt");

pub fn is_valid(num: usize) !bool {
    var buf = [_]u8{0} ** 1024;
    const seq = try std.fmt.bufPrint(&buf, "{d}", .{num});
    const divisor = seq.len / 2;

    for (0..divisor) |i| {
        const pattern = seq[0..(divisor - i)];

        if (seq.len % pattern.len == 0) {
            if (for (0..seq.len / pattern.len) |j| {
                if (!std.mem.eql(u8, seq[j * pattern.len .. (j + 1) * pattern.len], pattern)) {
                    break false;
                }
            } else true) {
                return false;
            }
        }
    }
    return true;
}

pub fn main() !void {
    var password: usize = 0;

    var it1 = std.mem.tokenizeAny(u8, data, ",");
    while (it1.next()) |r| {
        var it2 = std.mem.tokenizeAny(u8, r, "-");
        const start = try std.fmt.parseInt(u32, it2.next() orelse "", 10);
        const end = try std.fmt.parseInt(u32, it2.next() orelse "", 10);

        for (start..end + 1) |i| {
            if (!try is_valid(i)) {
                std.log.debug("Invalid: {d}", .{i});
                password += i;
            }
        }
    }

    std.log.info("Password: {d}", .{password});
}
