// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    cfunc.h
//
// Description: Functions prototype support for cfunc
//
// Author(s):   Bill McSpadden (william.c.mcspadden@gmail.com)
//
// Revision:    See revision control log
// ============================================================================
//#ifndef __CFUNC_H__
//#define __CFUNC_H__
//

#pragma once

#include "sail.h" 

//#define INT_RET_TYPE    sail_int
#define INT_RET_TYPE    int

INT_RET_TYPE    cfunc_int(sail_int *,       bool);
void            cfunc_str(sail_string * ,    bool);

//#endif
