load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _impl(module_ctx):

    http_archive(
        name = "arm_none_eabi_linux_x86",
        build_file = "//third_party/toolchains:arm-none-eabi-linux.BUILD",
        url = "https://developer.arm.com/-/media/files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz",
        strip_prefix = "arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi",
        sha256 = "075faa4f3e8eb45e59144858202351a28706f54a6ec17eedd88c9fb9412372cc",
    )

    http_archive(
        name = "arm_none_eabi_macos_aarch64",
        build_file = "//third_party/toolchains:arm-none-eabi-macos.BUILD",
        url = "https://developer.arm.com/-/media/files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-darwin-arm64-arm-none-eabi.tar.xz",
        strip_prefix = "arm-gnu-toolchain-13.2.Rel1-darwin-arm64-arm-none-eabi",
        sha256 = "39c44f8af42695b7b871df42e346c09fee670ea8dfc11f17083e296ea2b0d279",
    )

arm_none_eabi = module_extension(
    implementation = _impl,
)