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

val cfunc_int           = { c: "cfunc_int" }        : (string, string)  -> int

//val "func_dump_yaml"    = { c: "cfunc_dump_yaml" }  : (string)          -> unit   // syntax error
//val func_dump_yaml    = { c: "cfunc_dump_yaml" }  : (string)          ->        // syntax error
val cfunc_dump_yaml     = { c: "cfunc_dump_yaml" }  : (string)          -> unit

val main : unit -> unit

function main() = 
    {
    let yaml_filename : string = "./rv32i_isa.yaml";

    print("hello, world!\n") ;

    cfunc_dump_yaml(yaml_filename);

    let ret : int = cfunc_int(yaml_filename, "/hart0/physical_addr_sz");
    print_int("cfunc_int: ", ret );


    }



