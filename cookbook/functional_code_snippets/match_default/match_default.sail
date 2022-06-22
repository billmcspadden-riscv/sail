// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    match_default.sail
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
    let i : int = 0 ;

    match i 
        {
        1 => print (" test a: 1\n"),
        2 => print (" test a: 2\n"),
        3 => print (" test a: 3\n"),
        4 => print (" test a: 4\n"),
        5 => print (" test a: 5\n"),
        6 => print (" test a: 6\n"),
        7 => print (" test a: 7\n"),
        8 => print (" test a: 8\n"),
        9 => print (" test a: 9\n"),
        _ => print (" test a: no match\n")
        };                  // Needs semicolon.  Why?



    print("end of test\n");
    }



