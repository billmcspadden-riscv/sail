// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    sail_calls_cfunc.sail
//
// Description: Example sail file calling C functions
//
// Author(s):   Bill McSpadden (william.c.mcspadden@gmail.com)
//
// Revision:    See revision control log
// ============================================================================

default Order dec
$include <prelude.sail>

type xlenbits : Type = bits(32)

val "print"         : string -> unit
val "print_int"     : int -> unit

val cfunc_int = { c: "cfunc_int" } : bool -> int    // TODO: get rid of bool
val cfunc_str = { c: "cfunc_str" } : bool -> string // TODO: get rid of bool

val main : unit -> unit

function main() = 
    {
    print("hello, world!\n") ;
    print("hello, another world!\n") ;

    let ret : int = cfunc_int(true);        // TODO: get rid of argument 'true'
    print_int("cfunc_int: ", ret );

    let ret_str : string = cfunc_str(true); // TODO: get rid of argument 'true'
    print("ret_str: ");
    print(ret_str);
    print("\n");

    }



