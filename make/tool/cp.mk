ifndef tool/cp.mk
tool/cp.mk:=$(pwd)

include $(make-common.dir)/tool/mkdir.mk
include $(make-common.dir)/tool/ccdv.mk

# How to copy a file:
cp.rule = \
  $(mkdir.rule)$(NEWLINE) \
  $(ccdv) cp -f $< $@

cp.eval = $(eval $(call cp.tmpl,$1,$2))


define cp.tmpl
all: | $$(patsubst $1/%,$2/%,$$(shell find $1 -type f))
$2/%: $1/%
	$$(cp.rule)
endef


endif
