ifndef tool/cc.mk
tool/cc.mk:=$(pwd)

include $(make-common.dir)/tool/mkdir.mk
include $(make-common.dir)/constants.mk
include $(make-common.dir)/layout.mk

# Variables defined differently by platform:
ifeq ($(shell uname -s),Darwin)
  cc.link.shared     ?= -dylib
  cc.dl_path_var     ?= DYLD_LIBRARY_PATH
else
  cc.link.shared     ?= -shared
  cc.dl_path_var     ?= LD_LIBRARY_PATH
endif

# Use these variables to specify customizations:
cc.compiler          ?= $(CC)
cc.macro.flags       ?= $(CPPFLAGS)
cc.include.dirs      ?= $(include.dir)
cc.linker.flags      ?= $(LDFLAGS)
cc.linker            ?= $(LD)
cc.libs              ?= c
cc.exe.libs          ?= crt1.o
cc.lib.dirs          ?= $(lib.dir) $(patsubst :,$(SPACE),$($(cc.dl_path_var)))
cc.compiler.flags    ?= $(or $(CFLAGS),-Wall -fPIC -std=c99 -pedantic -g)

# Make it easy to define the path needed for running:
cc.run = \
   $(cc.dl_path_var)="$(patsubst $(SPACE),:,$(cc.lib.dirs)):$$$(cc.dl_path_var)" \
   PATH="$(bin.dir):$$PATH"

# Define rules for building object files with the C compiler.
cc.o.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(call at,CC)$(cc.compiler) -c $(cc.compiler.flags) \
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
  $(call at,LINK-SO)$(cc.linker) $(cc.link.shared) \
    $(addprefix -L,$(cc.lib.dirs)) \
    $(addprefix -l,$(cc.libs)) \
    $(cc.linker.flags) $(or $(cc.objs),$^) -o $@

# Rule for building executable:
cc.exe.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(call at,LINK-EXE)$(cc.linker) \
    $(addprefix -L,$(cc.lib.dirs)) \
    $(addprefix -l,$(cc.libs) $(cc.exe.libs)) \
    $(cc.linker.flags) $(or $(cc.objs),$^) -o $@

endif