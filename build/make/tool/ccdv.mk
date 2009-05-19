ifndef tool/ccdv.mk
tool/ccdv.mk:=$(pwd)

ifneq ($(shell which ccdv 2> /dev/null),)
  ccdv ?= $(if $(at),$(at)ccdv)
endif

endif