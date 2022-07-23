// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    b.sail

//$include <prelude.sail>
//$include "./prelude.sail"
$include "scattered_definitions_include.sail"

function clause func(b_enum_e) =
    {
    print("b.sail string: ");
    print("\n");
    }

mapping clause enum_to_string = b_enum_e    <->     "b"
//  {                               // Brackets with a single mapping item gives compile error
//  b_enum_e    <->     "b"
//  }

// TODO:  Need a method for iterating through a mapping
function clause print_enum_to_string(b_enum_e) =
    {
    print("");
    }




