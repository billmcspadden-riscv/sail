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


//int
//cfunc_int(void)
//mach_bits
//int
INT_RET_TYPE
//cfunc_int(unit u, int foo)
//cfunc_int(        int foo)
//cfunc_int(        sail_int foo)
cfunc_int(sail_int *zret_int,  bool foo)
    {
//    mpz_set_ui(zret_int, 142);
//    mpz_set_ui(zret_int, 9223372036854775808 );                       // 2 ^ 64           // works
//    mpz_set_ui(zret_int, (9223372036854775808 + 1) );                 // (2 ^ 64) + 1     // works
//    mpz_set_ui(zret_int, (123456789012345678901234567890) );          // fails: sail.test prints out incorrect number But the next example works.
    mpz_init_set_str(zret_int, "123456789012345678901234567890", 10 );  // works

//    zret = 42;
    return(42);
    }


void
cfunc_str(sail_string * zret_str, bool foo)
    {
    *zret_str =  "i'm baaaack...\n";
    return;
    }

// TODO:  Add many more return types such as...
//          void *
//          struct *
//          float
//          double
//




