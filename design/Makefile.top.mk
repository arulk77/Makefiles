## This make file is a global makefile for my own use
bsub_opt := 

## Options related to bsub command
ifndef rlocal
## Run in a large queue or high queues
	b_hosts := 1
	b_mem   := 16000

	ifdef blarge
		bsub_cmd := bsub $(bsub_opt) -q large -R "b64 rusage[mem=$(b_mem)] span[hosts=$(b_hosts)]" 
	else
		bsub_cmd := bsub $(bsub_opt) -q high -R "b64 span[hosts=$(b_hosts)]" 
	endif

	ifdef I
		bsub_cmd := $(bsub_cmd) -I 
	else 
		bsub_cmd := $(bsub_cmd) -oo $@.log
	endif

# Finally assemble the bsub options
	bsub_cmd := $(bsub_cmd) $(bsub_opt)
endif

##---------------------------------------------------------------
## Compilation options for the vcs tool 
##---------------------------------------------------------------
## By default do not do anything
all:
	echo "Do not have the all function" 	

## Help routine for the make file
help:
	echo <<EOF
	Help for the global file 
EOF		

## Include all the sub Makefiles
include Makefile.verdi.mk