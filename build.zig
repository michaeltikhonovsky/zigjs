const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "math",
        .target = target,
        .optimize = optimize,
    });

    lib.addCSourceFile(.{ .file = b.path("src/math.c") });
    lib.root_module.addIncludePath(b.path("src"));
    // b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "zig",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // exe.root_module.addIncludePath(b.path("src"));
    // b.installArtifact(exe);

    exe.linkLibrary(lib);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
