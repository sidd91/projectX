def register_all_toolchains():
    native.register_toolchains(
        "//infrastructure/bazel/toolchains/arm-none-eabi:armv-7_linux_toolchain",
    )

