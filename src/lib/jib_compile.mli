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

(** Compile Sail ASTs to Jib intermediate representation *)

open Anf
open Ast
open Ast_defs
open Ast_util
open Jib
open Type_check

(** This forces all integer struct fields to be represented as
   int64_t. Specifically intended for the various TLB structs in the
   ARM v8.5 spec. It is unsound in general. *)
val optimize_aarch64_fast_struct : bool ref

(** (WIP) [opt_memo_cache] will store the compiled function
   definitions in file _sbuild/ccacheDIGEST where DIGEST is the md5sum
   of the original function to be compiled. Enabled using the -memo
   flag. Uses Marshal so it's quite picky about the exact version of
   the Sail version. This cache can obviously become stale if the Sail
   changes - it'll load an old version compiled without said
   changes. *)
val opt_memo_cache : bool ref
  
(** {2 Jib context} *)

(** Dynamic context for compiling Sail to Jib. We need to pass a
   (global) typechecking environment given by checking the full
   AST. *)
type ctx =
  { records : (ctyp Jib_util.UBindings.t) Bindings.t;
    enums : IdSet.t Bindings.t;
    variants : (ctyp Jib_util.UBindings.t) Bindings.t;
    valspecs : (ctyp list * ctyp) Bindings.t;
    local_env : Env.t;
    tc_env : Env.t;
    locals : (mut * ctyp) Bindings.t;
    letbinds : int list;
    no_raw : bool;
  }

val initial_ctx : Env.t -> ctx

(** {2 Compilation functions} *)

(** The Config module specifies static configuration for compiling
   Sail into Jib.  We have to provide a conversion function from Sail
   types into Jib types, as well as a function that optimizes ANF
   expressions (which can just be the identity function) *)
module type Config = sig
  val convert_typ : ctx -> typ -> ctyp
  val optimize_anf : ctx -> typ aexp -> typ aexp
  (** Unroll all for loops a bounded number of times. Used for SMT
       generation. *)
  val unroll_loops : int option
  (** If false, function arguments must match the function
       type exactly. If true, they can be more specific. *)
  val specialize_calls : bool
  (** If false, will ensure that fixed size bitvectors are
       specifically less that 64-bits. If true this restriction will
       be ignored. *)
  val ignore_64 : bool
  (** If false we won't generate any V_struct values *)
  val struct_value : bool
  (** Allow real literals *)
  val use_real : bool
  (** Insert branch coverage operations *)
  val branch_coverage : out_channel option
  (** If true track the location of the last exception thrown, useful
     for debugging C but we want to turn it off for SMT generation
     where we can't use strings *)
  val track_throw : bool
end

module Make(C: Config) : sig
  (** Compile a Sail definition into a Jib definition. The first two
       arguments are is the current definition number and the total
       number of definitions, and can be used to drive a progress bar
       (see Util.progress). *)
  val compile_def : int -> int -> ctx -> tannot def -> cdef list * ctx

  val compile_ast : ctx -> tannot ast -> cdef list * ctx
end

(** Adds some special functions to the environment that are used to
   convert several Sail language features, these are sail_assert,
   sail_exit, and sail_cons. *)
val add_special_functions : Env.t -> Env.t

val name_or_global : ctx -> id -> name
