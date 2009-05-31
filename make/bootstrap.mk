# This is the makefile included by anyone using make-common.  Don't
# include anything unnecessary in here!

# Force make to do as one would expect and delete the target if a
# target fails:
.DELETE_ON_ERROR:

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

# If you have pkg-deploy on your PATH, then you can get your build
# tools automatically.
ifneq ($(shell which pkg-deploy 2> /dev/null),)
ifneq ($(wildcard $(SRC)/build.config),)

  # Get build tools set-up:
  export PATH
  include $(BUILD)/tmp/make-common/build.config.mk

  $(BUILD)/tmp/make-common/build.config.mk: $(SRC)/build.config
	cd $(BUILD) && pkg-deploy -mk $@ -config $(SRC)/build.config

endif
endif