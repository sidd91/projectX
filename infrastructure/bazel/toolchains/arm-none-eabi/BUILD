package(default_visibility = ["//visibility:public"])

load(":cc_toolchain_config.bzl", "cc_toolchain_config")

filegroup(name = "empty")

filegroup(
  name = 'wrappers',
  srcs = glob([
    'wrappers/**',
  ]),
)

filegroup(
  name = 'all_files',
  srcs = [
    '@arm-none-eabi//:toolchain',
    ':wrappers',
  ],
)

cc_toolchain_config(name = "armv-7_toolchain_config")

cc_toolchain(
    name = "armv-7_toolchain",
    toolchain_identifier = "armv-7-toolchain",
    toolchain_config = ":armv-7_toolchain_config",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":empty",
    linker_files = ":all_files",
    objcopy_files = ":all_files",
    strip_files = ":all_files",
    as_files = ":all_files",
)

cc_toolchain_suite(
    name = "gcc_toolchain",
    toolchains = {
        "armv7-m": ":armv-7_toolchain",
    },
    tags = ["manual"]
)

toolchain(
    name = "armv-7_linux_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:armv7-m",
    ],
    toolchain = ":armv-7_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
