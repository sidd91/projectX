cc_library(
    name = "chip",
    srcs = glob(["src/**/*.c"]),
    hdrs = glob(["inc/**/*.h"]),
    includes = ["inc/"],
    copts = [
        "-DCORE_M3",
        "-mcpu=cortex-m3",
        "-mthumb",
    ],
    # deps = [""],
    visibility = ["//visibility:public"],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
)