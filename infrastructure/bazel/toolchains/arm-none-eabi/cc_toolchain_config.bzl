load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

all_compile_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.c_compile,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.lto_backend,
    ACTION_NAMES.preprocess_assemble,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "ar",
            path = "/usr/bin/arm-none-eabi-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/usr/bin/arm-none-eabi-cpp",
        ),
        tool_path(
            name = "gcc",
            path = "/usr/bin/arm-none-eabi-gcc",
        ),
        tool_path(
            name = "gcov",
            path = "/usr/bin/arm-none-eabi-gcov",
        ),
        tool_path(
            name = "ld",
            path = "/usr/bin/arm-none-eabi-ld",
        ),
        tool_path(
            name = "nm",
            path = "/usr/bin/arm-none-eabi-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/usr/bin/arm-none-eabi-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/arm-none-eabi-strip",
        ),
    ]

    default_compiler_flags = feature(
        name = "default_compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-mcpu=cortex-m3",
                            "-mthumb",
                            "-mno-thumb-interwork",
                            "-DCORE_M3",
                            "-fno-exceptions",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_linker_flags = feature(
        name = "default_linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            # "-lstdc++",
                            "-specs=nosys.specs",
                            # "-specs=nosys.specs",
                            # "-specs=rdimon.specs",
                            "-lrdimon",
                            "-nostdlib",
                            "-lnosys",
                            "-specs=nano.specs",
                        ],
                    ),
                ]),
            ),
        ],
    )

    default_assembler_flags = feature(
        name = "default_assembler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-lstdc++",
                            "-specs=nosys.specs",
                            "-specs=nano.specs",
                            "-specs=nosys.specs",
                        ],
                    ),
                ]),
            ),
        ],
    )

    features = [
        default_compiler_flags,
        default_linker_flags,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "armv-7-toolchain",
        host_system_name = "local",
        target_system_name = "unknown",
        target_cpu = "unknown",
        target_libc = "unknown",
        compiler = "unknown",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = [
            "/usr/lib/gcc/arm-none-eabi/9.2.1/include/stdint.h",
        ],
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
