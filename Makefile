SRC:=$(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(SRC)/make/bootstrap.mk
######################################################################

include $(SRC)/module.mk
