cc_library(
    name = "startup_lpc1769",
    srcs = ["startup_LPC17xx.s"],
    includes = ["."],
    visibility = ["//visibility:public"],
    copts = [
        "-mcpu=cortex-m3",
        "-mthumb",
    ],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
)