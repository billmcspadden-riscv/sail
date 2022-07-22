// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    scattered_definitions.sail

$include <prelude.sail>
// Enums must be defined after prelude.sail (which is included
//  in "scattered_definitions_include.sail") for some reason.
//  Question sent to Alasdair about this on 2022-07-22
//
// This enum must be definded before the function signatures 
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

