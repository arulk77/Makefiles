## This Make file is for vcs specific commands
## This script assumes that the bsub command is set in a different Makefile

## Define a default vlist file
ifndef file
file    := tb.vlist
endif

## Define a default top module
ifndef top_mod
top_mod := tb
endif

## Just declare an empty bsub command 
ifndef bsub_cmd
       bsub_cmd :=
endif

## VCS tool specific options
ifdef VCS_HOME
vlogan = $(VCS_HOME)/bin/vlogan
vcs    = $(VCS_HOME)/bin/vcs
else
vlogan = \vlogan
vcs    = \vcs
endif

## vcs number of process
ifndef vcs_no_process
vcs_no_process := 20
endif

vlogan_def_opt = -sverilog -full64 +define+VCS -timescale=1ns/1ps 
vcs_def_opt    = -sverilog -full64 -j$(vcs_no_process) -timescale=1ns/1ps +vcs+lic+wait -l $(@).simv.log

## Assemble the vlogan_opt
ifdef vlogan_opt 
vlogan_lcl_opt = $(vlogan_opt) $(vlogan_def_opt)
else
vlogan_lcl_opt = $(vlogan_def_opt)
endif

## Assemble the vcs_opt
ifdef vcs_opt 
vcs_lcl_opt = $(vcs_opt) $(vcs_def_opt)
else
vcs_lcl_opt = $(vcs_def_opt)
endif

vlogan_cmd = $(vlogan) $(vlogan_lcl_opt)
vcs_cmd    = $(vcs)    $(vcs_lcl_opt)

##++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Verdi specific options
##++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY : vcs vlogan vcs_help vcs_clean

## Remove the logs and the directory created by this script
vcs_clean:
	rm -rf simv* AN.DB* csrc* *.simv* .simv* .vlog* vc_hdrs.h

## Help for the verdi compilation
vcs_help::
	@echo "Makefile.vcs -> Usage for the verdi commandas are "
	@echo "                make file=<vlist_file_name> vlogan_opt=[options] vlogan --> To compile"
	@echo "                make file=<vlist_file_name> vcs_opt=[options] vcs --> To simulate"

vlogan:
	$(bsub_cmd) $(vlogan_cmd) -f $(file) 

vcs:
	$(bsub_cmd) $(vcs_cmd) $(top_mod)

## Clean and help are same as verdi commands
clean:: vcs_clean
help:: vcs_help
