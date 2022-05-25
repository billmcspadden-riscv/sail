# vim: set tabstop=4 shiftwidth=4 noexpandtab
# ================================================================
# Filename:		Makefile
#
# Description:	Makefile for building.....
#
# Author(s):	Bill McSpadden (william.c.mcspadden@gmail.com)
#
# Revision:		See revision control log 
#
# ================================================================


#==============
# Includes
#==============



#==============
# Make variables
#==============
SAIL_PATH 		:= /home/billmc/.opam/default
SAIL_BIN		:= ${SAIL_PATH}/bin
SAIL_LIB		:= ${SAIL_PATH}/lib/sail
SAIL			:= ${SAIL_BIN}/sail
SAIL_OUTFILE	:= out
SAIL_FLAGS		:= -c -o ${SAIL_OUTFILE}

# TODO:  fix this.  Need to find an installation home for these C files.
# 		Perhaps compile a library?
#SAIL_DIR		:= /home/billmc/riscv/billmcspadden-riscv_sail.git
SAIL_DIR		:= /home/billmc/riscv/billmcspadden-riscv_sail.git
# TODO:  I don't like the following.  I'm doing this to resolve
#	the symbol "string_length" which is not found in $SAIL_DIR/lib/*.sail
RISCV_SAIL_DIR	:= /home/billmc/riscv/sail-riscv_br_billmcspadden-riscv.git/model

#SAIL_SRC		:= ${RISCV_SAIL_DIR}/prelude.sail test.sail
SAIL_SRC		:=                                test.sail

CC				:= gcc
CCFLAGS			:= -lgmp -lz -I ${SAIL_DIR}/lib/ -o out
C_SRC			:= out.c ${SAIL_DIR}/lib/*.c


TARGET			:= out

#==============
# Targets and Rules
#==============

all: run


build: out


install:

run: out
	./out


out: out.c
	gcc out.c ${SAIL_DIR}/lib/*.c -lgmp -lz -I ${SAIL_DIR}/lib -o $@


#	${CC} ${CCFLAGS} $<

out.c: ${SAIL_SRC}
	SAIL_DIR=${SAIL_DIR} ; export SAIL_DIR ; \
	${SAIL} ${SAIL_FLAGS} ${SAIL_SRC}




# clean:  cleans only local artifacts
clean:
	rm -f out out.c out.ml

# Cleans local artifacts and the install location
clean_all:



