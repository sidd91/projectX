load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

ARM_NONE_TOOLCHAIN_URL =  "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=688C370BF08399033CA9DE3C1CC8CF8E31D8C441"

def toolchains():
    if "arm-none-eabi" not in native.existing_rules():
        http_archive(
            name = "arm-none-eabi",
            build_file = Label("//third_party/toolchains:arm-none-eabi.BUILD"),
            url = ARM_NONE_TOOLCHAIN_URL,
            strip_prefix = "arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi",
            sha256 = "6cd1bbc1d9ae57312bcd169ae283153a9572bd6a8e4eeae2fedfbc33b115fdbb",
        )
