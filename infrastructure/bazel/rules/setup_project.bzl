def _setup_project_impl(ctx):

    hex_file_name = ctx.actions.declare_file(ctx.label.name + ".hex")
    elf_file_name = ctx.actions.declare_file(ctx.label.name + ".elf")

    elf_file=ctx.attr.elf_file.files.to_list()[0]
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
        command = "cp {input} {output}".format(input=elf_file.path, output=elf_file_name.path),
        progress_message = "Renaming binary to .elf...",
    )
    return [DefaultInfo(files = depset([hex_file_name, elf_file_name]))]

setup_project = rule(
    implementation = _setup_project_impl,
    attrs = dict(
        elf = attr.label(allow_single_file = True),
        srcs = attr.label(allow_files = True),
        deps = attr.label_list(allow_files=True),
        elf_file=attr.label(),
    ),
    # this attribute defines a toolchain type
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)
