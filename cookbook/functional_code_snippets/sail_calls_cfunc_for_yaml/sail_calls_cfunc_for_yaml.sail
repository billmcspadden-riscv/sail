// vim: set tabstop=4 shiftwidth=4 expandtab

default Order dec
$include <prelude.sail>

type xlenbits : Type = bits(32)

val "print"         : string -> unit
val "print_int"     : int -> unit

val cfunc_int           = { c: "cfunc_int" }        : (string, string)  -> int
val cfunc_string        = { c: "cfunc_string" }     : (string, string)  -> string

val cfunc_dump_yaml     = { c: "cfunc_dump_yaml" }  : (string)          -> unit

val main : unit -> unit

function main() = 
    {
    let yaml_filename : string = "./rv32i_isa.yaml";

    print("hello, world!\n") ;

    cfunc_dump_yaml(yaml_filename);

    //let ret : int = cfunc_int(yaml_filename, "/hart0/physical_addr_sz");
    let ret : int = cfunc_int(yaml_filename, "/hart0/misa/reset-val");
    print_int("cfunc_int: ", ret );
    print("\n");

    let ret2 : string = cfunc_string(yaml_filename, "/hart0/ISA");
    print("cfunc_string: "); print(ret2);
    print("\n");


    }



