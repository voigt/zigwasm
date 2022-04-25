const std = @import("std");

fn process(file_input: []const u8, allocator: std.mem.Allocator) !std.StringHashMap(u8) {
    var file = try std.fs.cwd().openFile(file_input, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;

    var counts = std.StringHashMap(u8).init(allocator);

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var words = std.mem.split(u8, line, " ");
        while (words.next()) |word| {
            const duped = try allocator.dupe(u8, word);
            var v = try counts.getOrPut(duped);
            if (!v.found_existing) {
                v.value_ptr.* = 1;
            } else {
                v.value_ptr.* += 1;
            }
        }
    }

    return counts;
}

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = general_purpose_allocator.allocator();

    var preopens = std.fs.wasi.PreopenList.init(allocator);
    defer preopens.deinit();
    try preopens.populate();
    try std.os.initPreopensWasi(allocator, ".");

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const program = args[0];

    if (args.len < 2) {
        std.debug.print("usage: {s} <input_file>\n", .{ program });
        return;
    }

    var counts = try process(args[1], allocator);

    try renderCount(&counts);
}

fn renderCount(counts: *std.StringHashMap(u8)) !void {
    var it = counts.iterator();
    while (it.next()) |word| {
        std.debug.print("{s} {d}\n", .{ word.key_ptr.*, word.value_ptr.* });
    }
}