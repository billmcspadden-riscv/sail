// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    scattered_definitions.sail

default Order dec

// TODO: $SAIL_DIR/lib/prelude.sail does not contain the function
//  'string_length()'.  There may be other functions missing as well
//  but I have not investigated the list.  I copied over the file
//  prelude.sail from the sail-riscv repository an added it to this
//  directory in order to resolve the call to string_length().  Where
//  does the call to string_length() come from?   The example itself
//  does not use it directly.  It appears to have crept in when I
//  added "mapping clause enum_to_string = b_enum_e <-> "b" "
//  mappings in a.sail and b.sail.
//$include <prelude.sail>
$include "./prelude.sail"

// Enums must be defined after prelude.sail for some reason.
//  Question sent to Alasdair about this on 2022-07-22
//
// This enum must be defined before the function signatures 
//  in "scattered_definitions_include.sail" else we get a
//  compilation error
enum enum_e = a_enum_e | b_enum_e | c_enum_e        // No Compile error
$include "scattered_definitions_include.sail"

scattered function func

function main() = 
    {
    print("hello, world!\n") ;
    print("calling function 'func'....\n");
    func(a_enum_e);
    func(b_enum_e);
    }

