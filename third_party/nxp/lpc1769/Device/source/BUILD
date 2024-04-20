cc_library(
    name = "system_src",
    srcs = [
        "cr_startup_lpc175x_6x.c",
        "system_LPC17xx.c",
    ],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/nxp/lpc1769/Core/Include:core_m3_headers",
        "//third_party/nxp/lpc1769/Device/include:device_hdrs",
        "//third_party/nxp/lpc1769/Device/source/ARM:startup_lpc1769",
    ],
)
