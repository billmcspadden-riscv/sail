// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    a.sail

//$include <prelude.sail>
//$include "./prelude.sail"
$include "scattered_definitions_include.sail"

function clause func(a_enum_e) =
    {
    print("a.sail string: ") ;
    print("\n") ;
    }

mapping clause enum_to_string = a_enum_e    <->     "a"
//  {                               // Brackets with a single mapping item gives compile error
//  a_enum_e    <->     "a"
//  }

// TODO:  Need a method for iterating through a mapping
function clause print_enum_to_string(a_enum_e) =
    {
    print("");
    }



