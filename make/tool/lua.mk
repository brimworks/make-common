ifndef tool/lua.mk
tool/lua.mk := $(pwd)

include $(make-common.dir)/constants.mk
include $(make-common.dir)/layout.mk
include $(make-common.dir)/tool/cc.mk

lua.cpath ?= $(lua.lib.dir) $(patsubst %/?.so,%,$(subst ;,$(SPACE),$(LUA_CPATH)))
lua.path  ?= $(lua.lib.dir) $(patsubst %/?.lua,%,$(subst ;,$(SPACE),$(LUA_PATH)))

lua.run = $(cc.run) \
  LUA_CPATH="$(subst $(SPACE),;,$(patsubst %,%/?.so,$(lua.cpath)))" \
  LUA_PATH="$(subst $(SPACE),;,$(patsubst %,%/?.lua,$(lua.path)))"

endif
