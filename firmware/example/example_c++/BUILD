load("@rules_cc//cc:defs.bzl", "cc_binary")

cc_binary(
    name = "example_c++",
    srcs = ["hello_world.cpp"],
    additional_linker_inputs = ["//third_party/nxp/lpc1769/linker_scripts:lpc1769_ld"],
    copts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mno-thumb-interwork",
        "-DCORE_M3",
        "-fno-exceptions",
        "-no-canonical-prefixes",
    ],
    features = ["generate_linkmap"],
    linkopts = [
        "-specs=nosys.specs",
        "-specs=rdimon.specs",
        "-lrdimon",
        "-nostdlib",
        "-lnosys",
        "-specs=nano.specs",
        "-lgcc",
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7-m",
        "@platforms//os:none",
    ],
    deps = ["//third_party/nxp/lpc1769:lpc17xx"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["example.hex"],
    cmd = "$(execpath @arm_none_eabi//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi//:objcopy"],
)

genrule(
    name = "elf",
    srcs = [":example_c++"],
    outs = ["example.elf"],
    cmd = "cp $< $@",
)