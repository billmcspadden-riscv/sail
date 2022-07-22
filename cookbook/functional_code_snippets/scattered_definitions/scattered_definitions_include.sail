// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// File:    scattered_definitions_include.sail

// Enums can't be in a general include file in that their definitiosn
//  are bound once.
//
//enum enum_e = a_enum_e | b_enum_e | c_enum_e

val "print" :   string      -> unit
val func :      enum_e      -> unit
val main :      unit        -> unit

// TODO: should this be specified here or in scattered_definitions.sail???
//scattered function func

