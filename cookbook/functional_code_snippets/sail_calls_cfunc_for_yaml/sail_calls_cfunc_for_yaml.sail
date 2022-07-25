// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    sail_calls_cfunc.sail
//
// Description: Example sail file calling C functions that access riscv yaml 
//              config file
//
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See git log
// ============================================================================

default Order dec
$include <prelude.sail>

type xlenbits : Type = bits(32)

val "print"         : string -> unit
val "print_int"     : int -> unit

val cfunc_int = { c: "cfunc_int" } : string -> int

val main : unit -> unit

function main() = 
    {
    print("hello, world!\n") ;

    let ret : int = cfunc_int("/hart0/physical_addr_sz");
    print_int("cfunc_int: ", ret );


    }



