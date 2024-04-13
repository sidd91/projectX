load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

ARM_NONE_TOOLCHAIN_URL =  "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=688C370BF08399033CA9DE3C1CC8CF8E31D8C441"

def toolchains():
    if "arm-none-eabi-linux" not in native.existing_rules():
        http_archive(
            name = "arm-none-eabi-linux",
            build_file = Label("//infrastructure/bazel/toolchains/aarch32-arm-none-eabi-linux.BUILD"),
            url = ARM_NONE_TOOLCHAIN_URL,
            # sha256 = "35a093524e35061d0f10e302b99d164255dc285898d00a2b6ab14bfb64af3a45",
        )