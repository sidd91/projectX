package(default_visibility = ["//visibility:public"])
load(":cc_toolchain_config.bzl", "cc_toolchain_config")

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_config(
    name = "linux_arm_none_toolchain_config",
    toolchain_bins = "@arm_none_eabi_linux_x86//:toolchain",
)
cc_toolchain_config(
    name = "mac_arm_none_toolchain_config",
    toolchain_bins = "@arm_none_eabi_macos_aarch64//:toolchain",
)

cc_toolchain(
    name = "linux_arm_none_eabi_toolchain",
    toolchain_identifier = "linux_arm_none_toolchain",
    toolchain_config = ":linux_arm_none_toolchain_config",
    all_files = "@arm_none_eabi_linux_x86//:toolchain",
    compiler_files = "@arm_none_eabi_linux_x86//:toolchain",
    dwp_files = ":empty",
    linker_files = "@arm_none_eabi_linux_x86//:toolchain",
    objcopy_files = "@arm_none_eabi_linux_x86//:toolchain",
    strip_files = "@arm_none_eabi_linux_x86//:toolchain",
    supports_param_files = 0,
)

cc_toolchain(
    name = "mac_arm_none_eabi_toolchain",
    toolchain_identifier = "mac_arm_none_toolchain",
    toolchain_config = ":mac_arm_none_toolchain_config",
    all_files = "@arm_none_eabi_macos_aarch64//:toolchain",
    compiler_files = "@arm_none_eabi_macos_aarch64//:toolchain",
    dwp_files = ":empty",
    linker_files = "@arm_none_eabi_macos_aarch64//:toolchain",
    objcopy_files = "@arm_none_eabi_macos_aarch64//:toolchain",
    strip_files = "@arm_none_eabi_macos_aarch64//:toolchain",
    supports_param_files = 0,
)

toolchain(
    name = "cc_arm_none_eabi_linux_x86",
    toolchain = ":linux_arm_none_eabi_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7-m",
        "@platforms//os:none",
    ],
    visibility = ["//visibility:public"],
)

toolchain(
    name = "cc_arm_none_eabi_macos_aarch64",
    toolchain = ":mac_arm_none_eabi_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:macos",
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7-m",
        "@platforms//os:none",
    ],
    visibility = ["//visibility:public"],
)