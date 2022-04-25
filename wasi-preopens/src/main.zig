const std = @import("std");
const os = std.os;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = general_purpose_allocator.allocator();

    var preopens = std.fs.wasi.PreopenList.init(allocator);
    defer preopens.deinit();

    try preopens.populate();

    for (preopens.asSlice()) |preopen, i| {
        std.debug.print("{}: {}\n", .{ i, preopen });
    }

    try os.initPreopensWasi(allocator, ".");

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var file = try std.fs.cwd().openFile(args[1], .{});
    var stat = try file.stat();
    std.debug.print("{}\n", .{ stat });
    defer file.close();
}