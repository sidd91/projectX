"""Module extension for registering ARM toolchains."""

def _toolchain_impl(module_ctx):
    """Register ARM toolchains based on exec platform."""
    # Register the toolchains - they will be selected by Bazel based on constraints
    pass

toolchain_extension = module_extension(
    implementation = _toolchain_impl,
)
