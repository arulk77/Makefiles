## This is the top level makefile for the design
ifndef INCLUDE_TOP
INCLUDE_TOP := $(HOME)/Makefiles
endif

verdi_mk_file := $(INCLUDE_TOP)/design/Makefile.verdi.mk

## Variable for the help command
define HLP
  TOP : This is the top level help
endef

MAKE_FILES := $(wildcard $(INCLUDE_TOP)/design/*.mk)

MAKE_CMD := @$(MAKE) $(MFLAGS) -f $(INCLUDE_TOP)/bsub/Makefile.bsub.mk 

##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Targets for the top level
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY: clean help this* verd*

## Clean everything
clean:
	$(foreach mfile,$(MAKE_FILES),@$(MAKE_CMD) -f $(mfile) $@;)

## Print all the help menu
help: 
	$(foreach mfile,$(MAKE_FILES),@$(MAKE_CMD) -f $(mfile) $@;)

this_help:
	@echo "TOP : This includes all the help routine"

ver%: 
	$(MAKE_CMD) -f $(verdi_mk_file) $@

