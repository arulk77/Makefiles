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

ifdef verdicom_opt
verdicom_opt   := $(verdicom_opt) $(vcom_def_opt)
endif

verdi_def_opt  := -nologo -WorkMode hardwareDebug
ifdef verdi_opt
verdi_opt      := $(verdi_opt) $(verdi_def_opt)
endif


##++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Verdi specific options
##++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Remove the logs and the directory created by this script
clean:
	rm -rf $(libname)* vericom* verdicomp* verdiLog

verdicom:
	$(bsub_cmd) \vericom $(vcom_opt) -f $(file)

## Invoke the verdi in ghi mode
verdi: 
	$(bsub_cmd) \verdi $(verdi_opt) $(rc_opt) -ssf $(fsdb) $(vtop_opt) -lib $(VERDI_LIB).lib++ 

## Help for the verdi compilation
help:
        echo <<EOF
        $(THIS_FILE) : Usage for the verdi commands are
        $(THIS_FILE) : make file=<filename> verdicom --> To compile only
        $(THIS_FILE) : make fsdb=<fsdbfilename>
EOF
