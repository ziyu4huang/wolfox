// build.zig
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "tmp",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();
    exe.linkLibCpp();    
    exe.addIncludePath("src");
    exe.addCSourceFile("src/bindings.cpp", &.{});

    b.installArtifact(exe);
}
