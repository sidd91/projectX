load("//infrastructure/bazel:rules/setup_project.bzl", "setup_project")

cc_binary(
    name = "blinky_led",
    srcs = ["blinky.c"],
    additional_linker_inputs = ["//third_party/nxp/lpc1769/linker_scripts:lpc1769_ld"],
    linkopts = ["-Wl,-T$(location //third_party/nxp/lpc1769/linker_scripts:lpc1769_ld)"],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/nxp/lpc1769:lpc17xx",
    ],
)

setup_project(
    name = "bin1",
    elf_file = "//firmware/example/lpc1769:blinky_led",
)
# foo_binary(name = "bin2")
