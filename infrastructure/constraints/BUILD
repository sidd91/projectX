constraint_setting(
    name = "cpu",
    visibility = ["//visibility:public"],
)

config_value(
    name = "on_mac",
    constraint_values = ["@platforms//os:macos"],
    constraint_setting = ":cpu",

)

config_setting(
    name = "on_linux",
    constraint_values = ["@platforms//os:linux"],
)