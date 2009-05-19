# This is the makefile included by anyone using make-common.  Don't
# include anything unnecessary in here!

# This macro must be expanded *before* any other makefile is included
# in order for it to work properly.
pwd = $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# This macro is used for finding the makefiles vended by this package.
make-common.dir := $(pwd)

# By default set the build directory.
BUILD ?= $(SRC)/build

# The default target.
default:

# Make the default set of targets:
.PHONY: all test default phony
all:
test: | all
default: | test

clean:
	rm -rf $(BUILD)

# Default to silencing many rules, but allow users to override this
# silencing by running `make at=`
at ?= @
