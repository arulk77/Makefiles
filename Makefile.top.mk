## This is the top level makefile for the design
ifndef INCLUDE_TOP
INCLUDE_TOP := $(HOME)/Makefiles/design
endif

verdi_mk_file := $(INCLUDE_TOP)/Makefile.verdi.mk

## Include the bsub command Makefile
include $(INCLUDE_TOP)/Makefile.bsub.mk

## Variable for the help command
define HLP
  TOP : This is the top level help
endef

MAKE_CMD := @$(MAKE) -f $(INCLUDE_TOP)/Makefile.bsub.mk

##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Targets for the top level
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY: clean help this* verd*

clean: verdi_clean

help: this_help verdi_help

this_help:
	@echo "TOP : This includes all the help routine"

verd%: 
	$(MAKE_CMD) -f $(INCLUDE_TOP)/Makefile.verdi.mk $@

