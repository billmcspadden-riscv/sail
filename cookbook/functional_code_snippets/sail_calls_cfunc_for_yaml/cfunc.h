// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    cfunc.h
//
// Description: Functions prototype support for cfunc
//
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See git log
// ============================================================================
//#ifndef __CFUNC_H__
//#define __CFUNC_H__
//

#pragma once

#include "sail.h" 

//#define INT_RET_TYPE    sail_int
#define INT_RET_TYPE    int

// It doesn't appear that Sail does anything with the
//  function's return value.  "return values" are done
//  by passing a pointer to a return value struct, which
//  is the first element in the function's argument list.
//
//  TODO: make the return value of type void.

//INT_RET_TYPE    cfunc_int(sail_int *, char *,  unit);     // TODO:  find out why unit is sometimes required, sometimes not INT_RET_TYPE    cfunc_int(sail_int *, char *);

INT_RET_TYPE    cfunc_int(sail_int *, char *);

//#endif
