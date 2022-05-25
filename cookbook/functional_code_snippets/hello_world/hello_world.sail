// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    hello_world.sail
//
// Description: Example sail file
//
// Author(s):   Bill McSpadden (william.c.mcspadden@gmail.com)
//
// Revision:    See revision control log
// ============================================================================

default Order dec
$include <prelude.sail>

val "print" : string -> unit

val main : unit -> unit

function main() = 
    {
    print("hello, world!\n") ;
    print("hello, another world!\n") ;
    }



