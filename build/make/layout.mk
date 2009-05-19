ifndef layout.mk
layout.mk := $(pwd)

# Defines the layout of your build directory.  All configuration is
# defined with ?= so you can easily override these values:

lib.dir        ?= $(BUILD)/lib
include.dir    ?= $(BUILD)/include
bin.dir        ?= $(BUILD)/bin
lua.lib.dir    ?= $(BUILD)/lua/lib
tmp.dir        ?= $(BUILD)/tmp
tmp.c.dir      ?= $(BUILD)/tmp/c
tmp.src.dir    ?= $(BUILD)/tmp/src

endif