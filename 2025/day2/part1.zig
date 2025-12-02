const std = @import("std");

const data = @embedFile("input.txt");

pub fn is_valid(num: usize) !bool {
    var buf = [_]u8{0} ** 1024;

    const seq = try std.fmt.bufPrint(&buf, "{d}", .{num});
    if (seq.len % 2 == 0) {
        if (std.mem.eql(u8, seq[0 .. seq.len / 2], seq[seq.len / 2 .. seq.len])) {
            return false;
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
