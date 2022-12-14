// vim: set tabstop=4 shiftwidth=4 expandtab

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

INT_RET_TYPE    cfunc_int(sail_int *, unit);
void            cfunc_str(sail_string *, unit);

//#endif
