## This Make file is for verdi specific options only
## This script assumes that the bsub command is set in a different Makefile

THIS_FILE := Makefile.verdi

file := 

## Just declare an empty bsub command 
ifndef bsub_cmd
       bsub_cmd :=
endif

## VTOP file specification
ifndef vtop
	vtop_opt := 
else
	vtop_opt := -vtop $(vtop)
endif

## RC file
ifndef rc_file
	rc_opt :=
else
	rc_opt := -sswr $(rc_file)
endif

## Verdi tool specific options
verdi_lib      := verdilib
vcom_def_opt   := -ssy -ssv -sverilog -assert svaext -lib $(verdi_lib)
verdi_def_opt  := -nologo -WorkMode hardwareDebug

## If use specifies the option then add that as variable
ifdef verdicom_opt
verdicom_opt   := $(verdicom_opt) $(vcom_def_opt)
else
verdicom_opt   := $(vcom_def_opt)
endif

## If verdi option is specified by the user then append
ifdef verdi_opt
verdi_opt      := $(verdi_opt) $(verdi_def_opt)
else
verdi_opt      := $(verdi_def_opt)
endif

##++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Verdi specific options
##++++++++++++++++++++++++++++++++++++++++++++++++++++++
.PHONY : verdi_clean verdi_help verdicom verdi

## Remove the logs and the directory created by this script
verdi_clean:
	rm -rf $(verdi_lib)* vericom* verdicomp* verdiLog

## Verdicom and vericom are the same
vericom: verdicom

verdicom:
	$(bsub_cmd) \vericom $(verdicom_opt) -f $(file)

## Invoke the verdi in ghi mode
verdi: 
	$(bsub_cmd) \verdi $(verdi_opt) $(rc_opt) -ssf $(fsdb) $(vtop_opt) -lib $(verdi_lib).lib++ 

## Help for the verdi compilation
verdi_help:
	@echo "$(THIS_FILE) : Usage for the verdi commandas are "
	@echo "             : make file=<vlist_file_name> verdicom   --> To compile"
	@echo "             : make fsdb=<fsdbfilename? rc_file=[rc file] vtop=[vtop file] verdi"

## Clean and help are same as verdi commands
clean: verdi_clean
help: verdi_help
