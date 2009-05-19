pwd := $(pwd)

include $(make-common.dir)/tool/cc.mk
include $(make-common.dir)/tool/cp.mk
include $(make-common.dir)/layout.mk

# Build ccdv:
_exe  := $(bin.dir)/ccdv
_objs := $(call cc.c.to.o,$(addprefix $(SRC)/util/, \
    ccdv.c \
))

all: | $(_exe)
$(_exe): $(_objs)
	$(cc.exe.rule)

# Copy bin and make directories:
$(call cp.eval,$(SRC)/bin,$(bin.dir))
$(call cp.eval,$(SRC)/make,$(BUILD)/make)
