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
//type vlenbits : Type = bits(32)
//type vlenbits : Int  = int
type vlenbits : Type  = int


//===================================================
// Function signatures

val get_vlen = { c: "get_vlen" } : unit -> {| 128, 256, 512 |}    // 'unit' is a C void equivalent
val main            : unit -> unit
val "print"         : string -> unit
val "print_int"     : int -> unit

// Function signatures
//===================================================

//register    vlen : vlenbits

function main() = 
    {
    print("hello, world!\n") ;

    let ret : int = get_vlen();
    print_int("get_vlen: ", ret );
    print("\n");

    vlen = ret;

    }


//val process_vle : forall ('b 'n : Int ), ('n < vlen). ( bits(1), bits(2) )  -> bits('b * 'n)
val process_vle : forall ('b 'n : Int )             . ( bits(1), bits(2) )  -> bits('b * 'n)


function process_vle (arg1, arg2) =
    {
    bits(128)
    }





