// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    scattered_definitions_include.sail

// Enums can't be in a general include file in that their definitiosn
//  are bound once.
//
//enum enum_e = a_enum_e | b_enum_e | c_enum_e

val "print"                 : string    -> unit
val func                    : enum_e    -> unit
val print_enum_to_string    : enum_e    -> unit
val main                    : unit      -> unit
val enum_to_string          : enum_e    <-> string
//val "string_length"         : string    -> int
val string_length = "string_length" : string -> nat
