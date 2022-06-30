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
cfunc_int(sail_int *zret_int,  bool foo)
    {
//    mpz_set_ui(zret_int, 142);
    mpz_set_ui(*zret_int, 142);
//    mpz_set_ui(zret_int, 9223372036854775808 );                       // 2 ^ 64           // works
//    mpz_set_ui(zret_int, (9223372036854775808 + 1) );                 // (2 ^ 64) + 1     // works
//    mpz_set_ui(zret_int, (123456789012345678901234567890) );          // fails: sail.test prints out incorrect number But the next example works.
//    mpz_init_set_str(*zret_int, "123 456 789 012 345 678 901 234 567 890", 10 );  // NOTE: white space allowed in string // works

    return(42); // TODO: Nothing is done with this return value, right?
    }


void
cfunc_str(sail_string * zret_str, bool foo)
    {
    //=========================
    //  The following code ......
    //
    //    *zret_str =  "i'm baaaack...\n";
    //
    //    return;
    //
    //  ... yields a segmentation fault when killing
    //  the sail_string variable (pointed to by zret_str)
    //  in the calling code.  The calling code assumes that
    //  memory has been malloc'd for the string,  and when
    //  it's free'd,  you get a seg fault.  So,  I re-wrote
    //  the code to do the actual malloc. But note the 
    //  assymetry of the memory management:  the space is
    //  allocated here,  but free'd at the calling level.
    //  This is,  at least,  ugly code.  And,  at worst,
    //  prone to error.
    //=========================
    char *  str = "i'm baaaack....\n";
    char *  s;

    s = malloc(strlen(str));
    strcpy(s, str);
    *zret_str =  s;
    return;
    }

// TODO:  Add many more return types such as...
//          void *
//          struct *
//          float
//          double
//




