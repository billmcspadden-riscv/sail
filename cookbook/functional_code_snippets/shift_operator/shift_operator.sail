//===========================================================================
// The purpose of this code fragment is to demonstrate operator overloading
//  for those operators that are not natively supported.  In this example,
//  we will be demonstrating the creation of,  and the overloading of, the
//  shift operators, << and >>.
//===========================================================================
default Order dec
$include <prelude.sail>
$include "shift_operator_support.sail"

// Fixity must be specified in every file in which it is used.
infix 7 >>
infix 7 <<

// ========================================================
// Function signatures (same idea as C's function prototype)
// ========================================================

val "print" : string -> unit

val main : unit -> unit

// ========================================================
// The entry point into the program starts at the function, main.
// ========================================================
function main() = 
    {
    print("hello, world!\n") ;
    print("hello, another world!\n") ;

    v : bits(8) = 0x1e ;

    v = v << 4;

    print_bits("v: ", v);

    }

