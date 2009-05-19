ifndef tool/cc.mk
tool/cc.mk:=$(pwd)

include $(make-common.dir)/tool/mkdir.mk
include $(make-common.dir)/tool/ccdv.mk
include $(make-common.dir)/constants.mk
include $(make-common.dir)/layout.mk

# Use these variables to specify customizations:
cc.compiler          ?= $(CC)
cc.macro.flags       ?= $(CPPFLAGS)
cc.include.dirs      ?=
cc.linker.flags      ?= $(LDFLAGS)
cc.linker            ?= $(LD)
cc.lib.dirs          ?=
cc.compiler.flags    ?= $(or $(CFLAGS),-Wall -fPIC -std=c99 -pedantic -g)

# Variables defined differently by platform:
ifeq ($(shell uname -s),Darwin)
  cc.link.shared     ?= -dylib
  cc.libs            ?= c crt1.o
else
  cc.link.shared     ?= -shared
  cc.libs            ?= c
endif

# Define rules for building object files with the C compiler.
cc.o.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(ccdv) $(cc.compiler) -c $(cc.compiler.flags) \
    $(addprefix -I,$(cc.include.dirs)) \
    $(cc.macro.flags) $< -o $@

$(tmp.c.dir)/%.o: $(SRC)/%.c         ; $(cc.o.rule)
$(tmp.c.dir)/%.o: $(tmp.src.dir)/%.c ; $(cc.o.rule)

# Call this macro to determine the .o file for a .c file.
cc.c.to.o = \
  $(patsubst $(tmp.src.dir)/%.c,$(tmp.c.dir)/%.o,$(filter $(tmp.src.dir)/%.c,$1)) \
  $(patsubst $(SRC)/%.c,        $(tmp.c.dir)/%.o,$(filter $(SRC)/%.c,$1))

# Rule for building shared objects:
cc.so.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(ccdv) $(cc.linker) $(cc.link.shared) \
    $(addprefix -L,$(cc.lib.dirs)) \
    $(addprefix -l,$(cc.libs)) \
    $(cc.linker.flags) $< -o $@

# Rule for building executable:
cc.exe.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(ccdv) $(cc.linker) \
    $(addprefix -L,$(cc.lib.dirs)) \
    $(addprefix -l,$(cc.libs)) \
    $(cc.linker.flags) $< -o $@

endif