ifndef tool/mkdir.mk
tool/mkdir.mk:=$(pwd)

mkdir.rule = $(at)mkdir -p $(dir $@)


endif
