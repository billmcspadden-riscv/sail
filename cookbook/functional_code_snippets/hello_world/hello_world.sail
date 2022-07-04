// Two types of comments...
// This type and ...

/*
...block comments
*/

// Whitespace is NOT significant. Yay!

default Order dec               // Required. Defines whether bit vectors are increasing (inc)
                                //  (MSB is index 0; AKA big-endian) or decreasing (dec)
                                //  (LSB is index 0; AKA little-endian)
// default Order inc

// The $include directive is used to pull in other Sail code.
//  It functions similarly, but not exactly the same, as the
//  C preproessor directrive.

$include <prelude.sail>         // Sail is a very small language.  In order to get a set
                                //  of useful functionality (eg - print to stdout), a set
                                //  of functions and datatypes are defined in the file
                                //  "prelude.sail"

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
    }


