// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    vlen_configuration.sail
//
// Description: Example sail file calling C functions
// 
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See revision control log
// ============================================================================

default Order dec
$include <prelude.sail>

type xlenbits : Type = bits(32)

val "print"         : string -> unit
val "print_int"     : int -> unit

//===================================================
// The following "works"
//val get_vlen = { c: "get_vlen" } : unit -> int  // works.  no seg fault
val get_vlen = { c: "get_vlen" } : unit -> {| 128, 256, 512 |}    // 'unit' is a C void equivalent

// The following gives a "too few arguments to function get_vlen" error message
//val get_vlen = { c: "get_vlen" } : unit -> int  // works.  no seg fault
//val get_vlen = { c: "get_vlen" } : unit -> {| 128, 256, 512 |}    // 'unit' is a C void equivalent

// This implies that multiple function signatures
//  (function prototypes) are allowed in Sail. True?
//===================================================


val main : unit -> unit

function main() = 
    {
    print("hello, world!\n") ;

    let ret : int = get_vlen();
    print_int("get_vlen: ", ret );
    print("\n");


    }



