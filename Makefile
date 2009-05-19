SRC:=$(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(SRC)/make/bootstrap.mk
######################################################################

# Force verbose output since we don't have ccdv built yet.
at=

include $(SRC)/module.mk
