// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    cfunc.h
//
// Description: Functions prototype support for cfunc
//
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See revision control log
// ============================================================================
//

#pragma once

#include "sail.h" 

#define INT_RET_TYPE    int

// Sail may or may not do anything with the return value. The general
//  solution (for integers greater than 64 bits),  is to use the multi-precision
//  integer in the mpz library.  HOWEVER,  if the integar can be packed
//  into a native datatype,  the Sail compiler will optimize and provide a
//  return value.
//
//  In this example, here is the Sail function signature:
//
//      val get_vlen = { c: "get_vlen" } : unit -> {| 128, 256, 512 |} 
//
//  Note that the allowed returned values are 128. 256 and 512.  All of
//  these can be packed into a native C datatype (int).  As such, the C
//  functions need to specify this.

INT_RET_TYPE    get_vlen(int);

//#endif
