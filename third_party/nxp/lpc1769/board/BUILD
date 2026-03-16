cc_library(
    name = "board",
    srcs = glob(["src/*.c"]),
    hdrs = glob(["inc/*.h"]),
    includes = ["inc/", "src/"],
    visibility = ["//visibility:public"],
    deps = ["//third_party/nxp/lpc1769/chip"],
    target_compatible_with = ["@platforms//cpu:armv7-m"],
    copts = [
        "-DCORE_M3",
        "-mcpu=cortex-m3",
        "-mthumb",
    ],
    

)