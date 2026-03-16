cc_library(
    name = "freertos_lpc1769",
    srcs = glob(["src/*.c"]),
    hdrs = glob(["inc/*.h"]) + glob(["config/*.h"]),
    includes = [
        ".",
        "config/",
        "inc/",
        "src",
    ],
    visibility = ["//visibility:public"],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
    deps = [
        "//third_party/nxp/lpc1769/board",
        "//third_party/nxp/lpc1769/chip",
    ],
    copts = [
        "-DCORE_M3",
        "-mcpu=cortex-m3",
        "-mthumb",
        "-DCORE_M3",
        "-fno-exceptions",
        "-no-canonical-prefixes",
        "-g",
        "-D__CODE_RED",
    ],
)
