def _setup_project_impl(ctx):
    hex_file_name = ctx.actions.declare_file(ctx.label.name + ".hex")
    elf_file_name = ctx.actions.declare_file(ctx.label.name + ".elf")

    elf_file = ctx.attr.base_firmware.files.to_list()[0]
    objcopy = ctx.toolchains["@bazel_tools//tools/cpp:toolchain_type"].cc.objcopy_executable

    ctx.actions.run(
        outputs = [hex_file_name],
        inputs = [elf_file],
        executable = objcopy,
        arguments = [
            "-O",
            "ihex",
            elf_file.path,
            hex_file_name.path,
        ],
        progress_message = "Generating file with objcopy...",
    )

    ctx.actions.run_shell(
        outputs = [elf_file_name],
        inputs = [elf_file],
        command = "cp {input} {output}".format(input = elf_file.path, output = elf_file_name.path),
        progress_message = "Renaming binary to .elf...",
    )
    return [DefaultInfo(files = depset([hex_file_name, elf_file_name]))]

setup_project = rule(
    implementation = _setup_project_impl,
    attrs = dict(
        srcs = attr.label(allow_files = True),
        deps = attr.label_list(allow_files=True),
        base_firmware=attr.label(),
    ),
    # this attribute defines a toolchain type
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)

def lpc17xx_firmware(name, srcs, deps = []):
    """Macro to define a C++ binary with default settings."""
    linker_script = "//third_party/nxp/lpc1769/linker_scripts:lpc1769_ld"
    native.cc_binary(
        name = name,
        srcs = srcs,
        additional_linker_inputs = [linker_script],
        linkopts = [
            "-Wl,-T$(location {})".format(linker_script), 
        ],
        target_compatible_with = ["@platforms//cpu:armv7-m"],
        data = [],
        deps = deps,
        #TODO: remove this and just use the setup_project to build with debug symbols. And I am not sure why -c dbg wont generate elf with debug info
        copts = [
            "-g",
            "-O2",
        ],
    )

