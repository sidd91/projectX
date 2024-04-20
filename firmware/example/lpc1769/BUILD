cc_binary(
    name = "blinky_led",
    srcs = ["blinky.cpp"],
    additional_linker_inputs = ["//third_party/nxp/lpc1769/linker_scripts:lpc1769_ld"],
    linkopts = ["-Wl,-T$(location //third_party/nxp/lpc1769/linker_scripts:lpc1769_ld)"],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/nxp/lpc1769:lpc17xx",
    ],
)
