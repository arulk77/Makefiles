## This is the top level makefile for the design
ifndef INCLUDE_TOP
INCLUDE_TOP := $(HOME)/Makefiles
endif

verdi_mk_file := $(INCLUDE_TOP)/design/Makefile.verdi.mk


## Makefile specific variables and options
MAKE_FILES := $(wildcard $(INCLUDE_TOP)/bsub/*.mk)
MAKE_FILES := $(MAKE_FILES) $(wildcard $(INCLUDE_TOP)/design/*.mk)

## Makefile command
## MAKE_CMD := @$(MAKE) $(MFLAGS) -f $(INCLUDE_TOP)/bsub/Makefile.bsub.mk 

MAKE_CMD := @$(MAKE) $(MFLAGS)

##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Targets for the top level
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY: clean help this* verd*

## Clean everything
clean_all:
	$(foreach mfile,$(MAKE_FILES),@$(MAKE_CMD) -f $(mfile) clean;)

## Print all the help menu
help::
	@echo "Help from the top file"

## Include all other makfeiles
include $(MAKE_FILES)