load("//infrastructure/bazel:rules/setup_project.bzl", "lpc17xx_firmware", "setup_project")

setup_project(
    name = "lpc1769_blinky",
    base_firmware = "//firmware/example/lpc1769:test",
)

#TODO: I would like this to be cc_library and the setup project to just build the deps in setup_project but for now this works. Also I would like the setup project to just build with
# debug symbols
lpc17xx_firmware(
    name = "test",
    srcs = ["blinky.c"],
    deps = [
        "//third_party/nxp/lpc1769:lpc17xx",
    ],
)