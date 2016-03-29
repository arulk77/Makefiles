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

##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Targets for the top level
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY: clean help verdi*

clean: verdi_clean

help: verdi_help

verdi%: 
	@$(MAKE) -f $(INCLUDE_TOP)/Makefile.verdi.mk -f $(INCLUDE_TOP)/Makefile.bsub.mk $@

