_pwd := $(pwd)

include $(make-common.dir)/tool/cp.mk
include $(make-common.dir)/layout.mk

# Copy bin and make directories:
$(call cp.eval,$(SRC)/bin,$(bin.dir))
$(call cp.eval,$(SRC)/make,$(BUILD)/make)
