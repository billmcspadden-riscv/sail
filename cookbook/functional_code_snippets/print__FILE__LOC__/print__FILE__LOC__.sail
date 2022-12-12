// Demonstrates the use of __FILE__,  __LOC__

$include <prelude.sail>

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
    print("file: "); print(__FILE__); print("\n");
    print("loc:  "); print(__LOC__);  print("\n");
    }

