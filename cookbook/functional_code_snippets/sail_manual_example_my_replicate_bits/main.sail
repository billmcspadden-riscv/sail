// vim: set tabstop=4 shiftwidth=4 expandtab

default Order dec
$include <prelude.sail>

val "print" : string -> unit

$include "my_replicate_bits_function_signatures.sail"


val main : unit -> unit
function main() = 
    {
    v1 : bits(8)  = 0x55;
    v2 : bits(32) = 0x00000000;

    // Sail has a powerful type-checking system,  but understanding it
    //  is best learned by examining some examples.

//    num : int = 4;            // CE
//    let num : int(4) = 4;     // Works
//    let num : int(4) = 5;     // CE
//    let num : int(5) = 5;     
//    let num : int(4) = 3;     // CE
    let num : int(4) = 3 + 1;

    print("calling my_replicate_bits() .....\n");

    // The compiler needs to evaluate 
//    v2 = my_replicate_bits (num, v1);
    v3 : bits(32) = my_replicate_bits (num, v1);
//    v3 : bits(32) = my_replicate_bits (4, v1);

    print_bits("replicated bits: ", v3);

    print("returned from my_replicate_bits() .....\n");
    }


