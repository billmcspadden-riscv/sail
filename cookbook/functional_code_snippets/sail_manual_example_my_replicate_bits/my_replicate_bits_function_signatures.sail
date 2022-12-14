// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    my_replicate_bvits_function_signatures.sail
//
// Description: 
//
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See revision control log
// ============================================================================

$include <prelude.sail>

val "print" : string -> unit

val my_replicate_bits : forall 'n 'm, 'm >= 1 & 'n >= 1. 
        (int('n), bits('m)) -> bits('n * 'm)

val main : unit -> unit




