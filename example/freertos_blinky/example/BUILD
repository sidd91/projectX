linker_script = "//third_party/nxp/lpc1769/linker_scripts:lpc1769_ld"

cc_binary(
    name = "example",
    srcs = glob(["src/*.c"]),
    additional_linker_inputs = [linker_script],
    copts = [
        "-mcpu=cortex-m3",
        "-mthumb",
        "-mno-thumb-interwork",
        "-DCORE_M3",
        "-fno-exceptions",
        "-no-canonical-prefixes",
        "-g",
        "-D__CODE_RED",
    ],
    features = ["generate_linkmap"],
    linkopts = [
        "-g",
        "-nostdlib",
        "-lc",
        "-lgcc",
        "-specs=nano.specs",
        "-Wl,--gc-sections",
        "-Wl,-T$(location {})".format(linker_script),
    ],
    target_compatible_with = [
        "@platforms//cpu:armv7-m",
        "@platforms//os:none",
    ],
    deps = [
        "//os/freertos:freertos_lpc1769",
        "//third_party/nxp/lpc1769:lpc17xx",
    ],
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
    srcs = [":example"],
    outs = ["example.elf"],
    cmd = "cp $< $@",
)
