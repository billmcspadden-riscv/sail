// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    cfunc.c
//
// Description: Functions to be called by Sail.
//
// Author(s):   Bill McSpadden (william.c.mcspadden@gmail.com)
//
// Revision:    See revision control log
// ============================================================================

#include <sail.h>
#include "cfunc.h"
#include "string.h"


INT_RET_TYPE
//get_vlen(sail_int *zret_int,  bool foo)
//get_vlen(sail_int *zret_int)
//get_vlen(sail_int *zret_int, int u)
get_vlen(                    int u)

    {

//    mpz_set_ui(*zret_int, 128);
    return(128);
    }




