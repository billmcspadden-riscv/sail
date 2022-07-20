# vim: set tabstop=4 shiftwidth=4 noexpandtab
# ================================================================
# Filename:		Makefile
#
# Description:	Makefile for building.....
#
# Author(s):	Bill McSpadden (bill@riscv.org)
#
# Revision:		See revision control log 
#
# ================================================================


#==============
# Includes
#==============

DEBUG_FLAGS		:= -g


#==============
# Make variables
#==============
SAIL_PATH 		:= /home/billmc/.opam/default
SAIL_BIN		:= ${SAIL_PATH}/bin
SAIL_LIB		:= ${SAIL_PATH}/lib/sail
SAIL			:= ${SAIL_BIN}/sail
SAIL_OUTFILE	:= out
SAIL2C_INC		:= -c_include cfunc.h
#SAIL_FLAGS		:= -c ${SAIL2C_INC} -o ${SAIL_OUTFILE} 
SAIL_FLAGS		:=  ${SAIL2C_INC} -c -o ${SAIL_OUTFILE} 

# TODO:  fix this.  Need to find an installation home for these C files.
# 		Perhaps compile a library?
#SAIL_DIR		:= /home/billmc/riscv/riscv_sail.git
#SAIL_DIR		:= /home/billmc/riscv/riscv_sail__billmcspadden-riscv.git

SAIL_DIR		:= ../../..
SAIL_LIB		:= ${SAIL_DIR}/lib/sail
SAIL			:= ${SAIL_DIR}/sail
SAIL_OUTFILE	:= out
#SAIL_FLAGS		:= -c -o ${SAIL_OUTFILE}

SAIL_SRC		:= $(wildcard *.sail)


CC				:= gcc
CCFLAGS			:= ${DEBUG_FLAGS} -lgmp -lz -I ${SAIL_DIR}/lib/ -o out
#C_SRC			:= out.c ${SAIL_DIR}/lib/*.c cfunc.c
C_SRC			:= cfunc.c out.c ${SAIL_DIR}/lib/*.c


TARGET			:= out

#==============
# Targets and Rules
#==============

all: run


build: out


install:

run: out
	./out

ddd: out
	ddd ./out


out: out.c cfunc.c cfunc.h
	SAIL_DIR=${SAIL_DIR} ; export SAIL_DIR ; \
	gcc ${CCFLAGS} ${C_SRC} -lgmp -lz -I ${SAIL_DIR}/lib -o $@
	

#	gcc out.c ${SAIL_DIR}/lib/*.c -lgmp -lz -I ${SAIL_DIR}/lib -o $@


out.c: ${SAIL_SRC}
	SAIL_DIR=${SAIL_DIR} ; export SAIL_DIR ; \
	${SAIL} ${SAIL_FLAGS} $^




# clean:  cleans only local artifacts
clean:
	rm -f out out.c out.ml *.o

# Cleans local artifacts and the install location
clean_all:



