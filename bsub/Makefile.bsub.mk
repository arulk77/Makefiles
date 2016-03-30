## This make file is a global makefile for my own use
bsub_opt := 

## Options related to bsub command
ifndef rlocal
## Run in a large queue or high queues
	b_hosts := 1
	b_mem   := 16000

	ifdef blarge
		bsub_def_cmd := bsub $(bsub_opt) -q large -R "b64 rusage[mem=$(b_mem)] span[hosts=$(b_hosts)]" 
	else
		bsub_def_cmd := bsub $(bsub_opt) -q high -R "b64 span[hosts=$(b_hosts)]" 
	endif

	ifdef I
		bsub_cmd = $(bsub_def_cmd) -I 
	else 
		bsub_cmd = $(bsub_def_cmd) -oo $(@).log
	endif

endif

define BSUB_HLP
	bsub : The bsub command help
endef

THIS_FILE := Makefile.bsub


##---------------------------------------------------------------
## Compilation options for the vcs tool 
##---------------------------------------------------------------
## By default do not do anything
.PHONY: bsub_*

## Help routine for the make file
bsub_help:
	@echo "Makefile.bsub -> The options for bsub are b_hosts bsub_opt b_mem"

bsub_clean:
	@echo "Makefile.bsub -> Dummy clean for the bsub"

## Helep and clean entry 
help:: bsub_help
clean:: bsub_clean