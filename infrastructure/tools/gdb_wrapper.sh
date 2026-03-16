#!/bin/bash
exec $(bazel run --run_under=echo @arm_none_eabi//:gdb 2>/dev/null) "$@"