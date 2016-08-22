## This Make file is for verdi specific options only
## This script assumes that the bsub command is set in a different Makefile

THIS_FILE := Makefile.verdi

ifndef file
file := 
endif

## Just declare an empty bsub command 
ifndef bsub_cmd
       bsub_cmd :=
endif

## Verdi tool specific options
verdi_lib      := verdilib
vcom_def_opt   := -ssy -ssv -sverilog -assert svaext -lib $(verdi_lib)
verdi_def_opt  := -nologo -WorkMode hardwareDebug

verdi_timeout := 1200

##++++++++++++++++++++++++++++++++++++++++++++++++++++
## verdi GUI options
##++++++++++++++++++++++++++++++++++++++++++++++++++++
## Give fsdb file only if fsdb file is passed
ifdef fsdb
verdi_def_opt := $(verdi_def_opt) -ssf $(fsdb)
else
## Get the latest fsdb if available
verdi_def_opt := $(verdi_def_opt) -ssf $(shell ls -t *.fsdb | head -n 1)
endif

## Give the rcfile only if it is defined
ifdef rc_file
verdi_def_opt := $(verdi_def_opt) -sswr $(rc_file)
endif

## vtop options
ifdef vtop
verdi_def_opt := $(verdi_def_opt) -vtop $(vtop)
endif

## top options
ifdef top
verdi_def_opt := $(verdi_def_opt) -top $(top)
endif


##++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Verdi specific options
##++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY : verdi_clean verdi_help verdicom verdi verdi_gui

## Remove the logs and the directory created by this script
verdi_clean::
	rm -rf $(verdi_lib)* vericom* verdicomp* verdiLog

## Verdicom and vericom are the same
vericom:: verdicom
verdicom:: $(file)
	$(bsub_cmd) \vericom $(verdicom_opt) $(vcom_def_opt) -f $(file)

## Invoke the verdi in ghi mode
ifdef fsdb
verdi_gui:: verdi_wait_fsdb
else
verdi_gui::
endif
	$(bsub_cmd) \verdi $(verdi_opt) $(verdi_def_opt) -lib $(verdi_lib).lib++ 

verdi_wait_fsdb::
	timeout $(verdi_timeout) bash -c	-- 'while [ ! -e $(fsdb) ]; \
   do echo "Waiting for the file $(fsdb) to be created";	sleep 10; done;'

## Invoke both verdi compilation and gui
verdi::
	$(MAKE) $(MFLAGS) I=1 verdicom 
   ifdef fsdb
   endif
	$(MAKE) $(MFLAGS) verdi_gui

## Help for the verdi compilation
verdi_help::
	@echo "Makefile.verdi -> Usage for the verdi commandas are "
	@echo "                  make file=<vlist_file_name> verdicom   --> To compile"
	@echo "                  make fsdb=<fsdbfilename? rc_file=[rc file] vtop=[vtop file] verdi"

## Clean and help are same as verdi commands
clean:: verdi_clean
help:: verdi_help
