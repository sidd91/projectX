load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
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
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.cpp_header_parsing,
]

def _find_tool(toolchain_bins, tool_name):
    """Find a tool binary from the toolchain_bins filegroup."""
    for file in toolchain_bins:
        if file.basename == tool_name or file.basename == tool_name + ".exe":
            return file
    return None

def _get_cxx_include_directories(toolchain_bins):
    """Extract C++ include directories from toolchain."""
    include_dirs = {}
    
    for file in toolchain_bins:
        path = file.path
        
        # Extract all include directories from the toolchain
        if "/include/" in path:
            # Find the include directory
            inc_idx = path.rfind("/include/")
            if inc_idx >= 0:
                inc_dir = path[:inc_idx + 8]  # Include up to "/include"
                include_dirs[inc_dir] = True
                
                # Also add subdirectories
                remaining = path[inc_idx + 9:]  # Everything after "/include/"
                if "/" in remaining:
                    # There's a subdirectory
                    first_subdir = remaining.split("/")[0]
                    subdir = inc_dir + "/" + first_subdir
                    include_dirs[subdir] = True
    
    result = sorted(include_dirs.keys())
    return result if result else []

def _impl(ctx):
    toolchain_bins = ctx.files.toolchain_bins
    cxx_include_dirs = _get_cxx_include_directories(toolchain_bins)
    
    tool_paths = [
        tool_path(name = "gcc", path = "bin/arm-none-eabi-gcc"),
        tool_path(name = "g++", path = "bin/arm-none-eabi-g++"),
        tool_path(name = "ld", path = "bin/arm-none-eabi-ld"),
        tool_path(name = "ar", path = "bin/arm-none-eabi-ar"),
        tool_path(name = "cpp", path = "bin/arm-none-eabi-cpp"),
        tool_path(name = "nm", path = "bin/arm-none-eabi-nm"),
        tool_path(name = "objdump", path = "bin/arm-none-eabi-objdump"),
        tool_path(name = "strip", path = "bin/arm-none-eabi-strip"),
    ]
    
    # Create action configs with direct file references using structs
    c_compile_action = action_config(
        action_name = ACTION_NAMES.c_compile,
        tools = [
            struct(
                type_name = "tool",
                tool = _find_tool(toolchain_bins, "arm-none-eabi-gcc"),
            ),
        ],
    )

    cpp_compile_action = action_config(
        action_name = ACTION_NAMES.cpp_compile,
        tools = [
            struct(
                type_name = "tool",
                tool = _find_tool(toolchain_bins, "arm-none-eabi-g++"),
            ),
        ],
    )

    cpp_link_executable_action = action_config(
        action_name = ACTION_NAMES.cpp_link_executable,
        tools = [
            struct(
                type_name = "tool",
                tool = _find_tool(toolchain_bins, "arm-none-eabi-g++"),
            ),
        ],
    )

    cpp_link_dynamic_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_dynamic_library,
        tools = [
            struct(
                type_name = "tool",
                tool = _find_tool(toolchain_bins, "arm-none-eabi-g++"),
            ),
        ],
    )

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
                            "-fno-exceptions",
                            "-DCORE_M3",
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
                flag_groups = [
                    flag_group(
                        flags = [
                            "-specs=nosys.specs",
                            "-specs=nano.specs",
                            "-nostdlib",
                        ],
                    ),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "arm-none-eabi",
        host_system_name = "local",
        target_system_name = "baremetal",
        target_cpu = "cortex-m3",
        target_libc = "newlib",
        compiler = "arm-none-eabi-gcc",
        abi_version = "eabi",
        abi_libc_version = "newlib",
        action_configs = [
            c_compile_action,
            cpp_compile_action,
            cpp_link_executable_action,
            cpp_link_dynamic_library_action,
        ],
        cxx_builtin_include_directories = cxx_include_dirs + ["."],
        tool_paths = tool_paths,
        features = [
            default_compiler_flags,
            default_linker_flags,
        ],
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_bins": attr.label(mandatory = True, allow_files = True),
    },
    provides = [CcToolchainConfigInfo],
)