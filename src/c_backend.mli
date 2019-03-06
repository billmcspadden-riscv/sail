(**************************************************************************)
(*     Sail                                                               *)
(*                                                                        *)
(*  Copyright (c) 2013-2017                                               *)
(*    Kathyrn Gray                                                        *)
(*    Shaked Flur                                                         *)
(*    Stephen Kell                                                        *)
(*    Gabriel Kerneis                                                     *)
(*    Robert Norton-Wright                                                *)
(*    Christopher Pulte                                                   *)
(*    Peter Sewell                                                        *)
(*    Alasdair Armstrong                                                  *)
(*    Brian Campbell                                                      *)
(*    Thomas Bauereiss                                                    *)
(*    Anthony Fox                                                         *)
(*    Jon French                                                          *)
(*    Dominic Mulligan                                                    *)
(*    Stephen Kell                                                        *)
(*    Mark Wassell                                                        *)
(*                                                                        *)
(*  All rights reserved.                                                  *)
(*                                                                        *)
(*  This software was developed by the University of Cambridge Computer   *)
(*  Laboratory as part of the Rigorous Engineering of Mainstream Systems  *)
(*  (REMS) project, funded by EPSRC grant EP/K008528/1.                   *)
(*                                                                        *)
(*  Redistribution and use in source and binary forms, with or without    *)
(*  modification, are permitted provided that the following conditions    *)
(*  are met:                                                              *)
(*  1. Redistributions of source code must retain the above copyright     *)
(*     notice, this list of conditions and the following disclaimer.      *)
(*  2. Redistributions in binary form must reproduce the above copyright  *)
(*     notice, this list of conditions and the following disclaimer in    *)
(*     the documentation and/or other materials provided with the         *)
(*     distribution.                                                      *)
(*                                                                        *)
(*  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''    *)
(*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED     *)
(*  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A       *)
(*  PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR   *)
(*  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,          *)
(*  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT      *)
(*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF      *)
(*  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND   *)
(*  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,    *)
(*  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT    *)
(*  OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF    *)
(*  SUCH DAMAGE.                                                          *)
(**************************************************************************)

open Bytecode
open Type_check

(** Global compilation options *)

(** Output a dataflow graph for each generated function in Graphviz
   (dot) format. *)
val opt_debug_flow_graphs : bool ref

(** Print the ANF and IR representations of a specific function. *)
val opt_debug_function : string ref

(** Instrument generated code to output a trace. opt_smt_trace is WIP
   but intended to enable generating traces suitable for concolic
   execution with SMT. *)
val opt_trace : bool ref
val opt_smt_trace : bool ref

(** Define generated functions as static *)
val opt_static : bool ref

(** Do not generate a main function *)
val opt_no_main : bool ref

(** (WIP) Do not include rts.h (the runtime), and do not generate code
   that requires any setup or teardown routines to be run by a runtime
   before executing any instruction semantics. *)
val opt_no_rts : bool ref

(** Ordinarily we use plain z-encoding to name-mangle generated Sail
   identifiers into a form suitable for C. If opt_prefix is set, then
   the "z" which is added on the front of each generated C function
   will be replaced by opt_prefix. E.g. opt_prefix := "sail_" would
   give sail_my_function rather than zmy_function. *)
val opt_prefix : string ref

(** opt_extra_params and opt_extra_arguments allow additional state to
   be threaded through the generated C code by adding an additional
   parameter to each function type, and then giving an extra argument
   to each function call. For example we could have

   opt_extra_params := Some "CPUMIPSState *env"
   opt_extra_arguments := Some "env"

   and every generated function will take a pointer to a QEMU MIPS
   processor state, and each function will be passed the env argument
   when it is called. *)
val opt_extra_params : string option ref
val opt_extra_arguments : string option ref

(** (WIP) [opt_memo_cache] will store the compiled function
   definitions in file _sbuild/ccacheDIGEST where DIGEST is the md5sum
   of the original function to be compiled. Enabled using the -memo
   flag. Uses Marshal so it's quite picky about the exact version of
   the Sail version. This cache can obviously become stale if the C
   backend changes - it'll load an old version compiled without said
   changes. *)
val opt_memo_cache : bool ref

(** Optimization flags *)

val optimize_primops : bool ref
val optimize_hoist_allocations : bool ref
val optimize_struct_updates : bool ref
val optimize_alias : bool ref
val optimize_experimental : bool ref

(** The compilation context. *)
type ctx

(** Create a context from a typechecking environment. This environment
   should be the environment returned by typechecking the full AST. *)
val initial_ctx : Env.t -> ctx

(** Same as initial ctx, but iterate to find more precise bounds on
   integers. *)
val initial_ctx_iterate : Env.t -> ctx

(** Convert a typ to a IR ctyp *)
val ctyp_of_typ : ctx -> Ast.typ -> ctyp

val compile_aexp : ctx -> Ast.typ Anf.aexp -> instr list * (clexp -> instr) * instr list

val compile_ast : ctx -> out_channel -> string list -> tannot Ast.defs -> unit

val bytecode_ast : ctx -> (cdef list -> cdef list) -> tannot Ast.defs -> cdef list

(** Rewriting steps for compiled ASTs *)
val flatten_instrs : instr list -> instr list

val flatten_cdef : cdef -> cdef
