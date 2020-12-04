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

open Sail_lem
open Ast
open Ast_util
open Jib
open Jib_util
open Value2
open Printf

let zencode_id id = Util.zencode_string (string_of_id id)

module StringMap = Map.Make(String)

let string_of_name =
  let ssa_num n = if n = -1 then "" else ("/" ^ string_of_int n) in
  function
  | Name (id, n) | Global (id, n) -> zencode_id id ^ ssa_num n
  | Have_exception n ->
     "have_exception" ^ ssa_num n
  | Return n ->
     "return" ^ ssa_num n
  | Current_exception n ->
     "current_exception" ^ ssa_num n
  | Throw_location n ->
     "throw_location" ^ ssa_num n
    
let rec string_of_clexp = function
  | CL_id (id, ctyp) -> string_of_name id
  | CL_field (clexp, field) -> string_of_clexp clexp ^ "." ^ string_of_uid field
  | CL_addr clexp -> string_of_clexp clexp ^ "*"
  | CL_tuple (clexp, n) -> string_of_clexp clexp ^ "." ^ string_of_int n
  | CL_void -> "void"
  | CL_rmw _ -> assert false

let add_instr n buf indent str =
  Buffer.add_string buf (String.make indent ' ');
  Buffer.add_string buf str;
  Buffer.add_string buf ";\n"

module Ir_formatter = struct
  module type Config = sig
    type label
    val make_label_map : instr list -> label StringMap.t
    val output_label_instr : Buffer.t -> label StringMap.t -> string -> unit
    val string_of_label : label -> string
    val modify_instrs : instr list -> instr list
    val keyword : string -> string
    val typ : ctyp -> string
    val value : cval -> string
  end

  module Make (C : Config) = struct
    let rec output_instr n buf indent label_map (I_aux (instr, (_, l))) =
      match instr with
      | I_decl (ctyp, id) | I_reset (ctyp, id) ->
         add_instr n buf indent (string_of_name id ^ " : " ^ C.typ ctyp)
      | I_init (ctyp, id, cval) | I_reinit (ctyp, id, cval) ->
         add_instr n buf indent (string_of_name id ^ " : " ^ C.typ ctyp ^ " = " ^ C.value cval)
      | I_clear (ctyp, id) ->
         add_instr n buf indent ("!" ^ string_of_name id)
      | I_label label ->
         C.output_label_instr buf label_map label
      | I_jump (cval, label) ->
         add_instr n buf indent (C.keyword "jump" ^ " " ^ C.value cval ^ " "
                                 ^ C.keyword "goto" ^ " " ^ C.string_of_label (StringMap.find label label_map)
                                 ^ " ` \"" ^ Reporting.short_loc_to_string l ^ "\"")
      | I_goto label ->
         add_instr n buf indent (C.keyword "goto" ^ " " ^ C.string_of_label (StringMap.find label label_map))
      | I_match_failure ->
         add_instr n buf indent (C.keyword "failure")
      | I_undefined _ ->
         add_instr n buf indent (C.keyword "arbitrary")
      | I_end _ ->
         add_instr n buf indent (C.keyword "end")
      | I_copy (clexp, cval) ->
         add_instr n buf indent (string_of_clexp clexp ^ " = " ^ C.value cval)
      | I_funcall (clexp, false, id, args) ->
         add_instr n buf indent (string_of_clexp clexp ^ " = " ^ string_of_uid id ^ "(" ^ Util.string_of_list ", " C.value args ^ ")")
      | I_funcall (clexp, true, id, args) ->
         add_instr n buf indent (string_of_clexp clexp ^ " = $" ^ string_of_uid id ^ "(" ^ Util.string_of_list ", " C.value args ^ ")")
      | I_return cval ->
         add_instr n buf indent (C.keyword "return" ^ " " ^ C.value cval)
      | I_comment str ->
         Buffer.add_string buf (String.make indent ' ' ^ "/*" ^ str ^ "*/\n")
      | I_raw str ->
         Buffer.add_string buf str
      | I_throw cval ->
         add_instr n buf indent (C.keyword "throw" ^ " "  ^ C.value cval)
      | I_if _ | I_block _ | I_try_block _ ->
         Reporting.unreachable Parse_ast.Unknown __POS__ "Can only format flat IR"

    and output_instrs n buf indent label_map = function
      | (I_aux (I_label _, _) as instr) :: instrs ->
         output_instr n buf indent label_map instr;
         output_instrs n buf indent label_map instrs
      | instr :: instrs ->
         output_instr n buf indent label_map instr;
         output_instrs (n + 1) buf indent label_map instrs
      | [] -> ()

    let id_ctyp (id, ctyp) =
      sprintf "%s: %s" (zencode_id id) (C.typ ctyp)

    let uid_ctyp (uid, ctyp) =
      sprintf "%s: %s" (string_of_uid uid) (C.typ ctyp)

    let output_def buf = function
      | CDEF_reg_dec (id, ctyp, _) ->
         Buffer.add_string buf (sprintf "%s %s : %s" (C.keyword "register") (zencode_id id) (C.typ ctyp))
      | CDEF_spec (id, None, ctyps, ctyp) ->
         Buffer.add_string buf (sprintf "%s %s : (%s) ->  %s" (C.keyword "val") (zencode_id id) (Util.string_of_list ", " C.typ ctyps) (C.typ ctyp));
      | CDEF_spec (id, Some extern, ctyps, ctyp) ->
         Buffer.add_string buf (sprintf "%s %s = \"%s\" : (%s) ->  %s" (C.keyword "val") (zencode_id id) extern (Util.string_of_list ", " C.typ ctyps) (C.typ ctyp));
      | CDEF_fundef (id, ret, args, instrs) ->
         let instrs = C.modify_instrs instrs in
         let label_map = C.make_label_map instrs in
         let  ret = match ret with
           | None -> ""
           | Some id -> " " ^ zencode_id id
         in
         Buffer.add_string buf (sprintf "%s %s%s(%s) {\n" (C.keyword "fn") (zencode_id id) ret (Util.string_of_list ", " zencode_id args));
         output_instrs 0 buf 2 label_map instrs;
         Buffer.add_string buf "}"
      | CDEF_type (CTD_enum (id, ids)) ->
         Buffer.add_string buf (sprintf "%s %s {\n  %s\n}" (C.keyword "enum") (zencode_id id) (Util.string_of_list ",\n  " zencode_id ids))
      | CDEF_type (CTD_struct (id, ids)) ->
         Buffer.add_string buf (sprintf "%s %s {\n  %s\n}" (C.keyword "struct") (zencode_id id) (Util.string_of_list ",\n  " uid_ctyp ids))
      | CDEF_type (CTD_variant (id, ids)) ->
         Buffer.add_string buf (sprintf "%s %s {\n  %s\n}" (C.keyword "union") (zencode_id id) (Util.string_of_list ",\n  " uid_ctyp ids))
      | CDEF_let (_, bindings, instrs) ->
         let instrs = C.modify_instrs instrs in
         let label_map = C.make_label_map instrs in
         Buffer.add_string buf (sprintf "%s (%s) {\n" (C.keyword "let") (Util.string_of_list ", " id_ctyp bindings));
         output_instrs 0 buf 2 label_map instrs;
         Buffer.add_string buf "}"
      | CDEF_startup _ | CDEF_finish _ ->
         Reporting.unreachable Parse_ast.Unknown __POS__ "Unexpected startup / finish"

    let rec output_defs buf = function
      | def :: defs ->
         output_def buf def;
         Buffer.add_string buf "\n\n";
         output_defs buf defs
      | [] -> ()

  end
end

let colored_ir = ref false

let with_colors f =
  let is_colored = !colored_ir in
  colored_ir := true;
  f ();
  colored_ir := is_colored

module Flat_ir_config : Ir_formatter.Config = struct
  type label = int

  let make_label_map instrs =
    let rec make_label_map' n = function
      | I_aux (I_label label, _) :: instrs ->
         StringMap.add label n (make_label_map' n instrs)
      | _ :: instrs ->
         make_label_map' (n + 1) instrs
      | [] -> StringMap.empty
    in
    make_label_map' 0 instrs

  let modify_instrs instrs =
    let open Jib_optimize in
    reset_flat_counter ();
    instrs
    |> flatten_instrs
    |> remove_clear
    |> remove_dead_code

  let string_of_label = string_of_int

  let output_label_instr buf _ label = ()

  let color f =
    if !colored_ir then
      f
    else
      (fun str -> str)

  let keyword str =
    str |> color Util.red |> color Util.clear

  let typ str =
    string_of_ctyp str |> color Util.yellow |> color Util.clear

  let value str =
    string_of_cval str |> color Util.cyan |> color Util.clear

end

module Flat_ir_formatter = Ir_formatter.Make(Flat_ir_config)

let () =
  let open Interactive in
  let open Jib_interactive in

  ArgString ("(val|register)? identifier", fun arg -> Action (fun () ->
    let is_def id = function
      | CDEF_fundef (id', _, _, _) -> Id.compare id id' = 0
      | CDEF_spec (id', _, _, _) -> Id.compare id (prepend_id "val " id') = 0
      | CDEF_reg_dec (id', _, _) -> Id.compare id (prepend_id "register " id') = 0
      | _ -> false
    in
    let id = mk_id arg in
    match List.find_opt (is_def id) !ir with
    | None -> print_endline ("Could not find definition " ^ string_of_id id)
    | Some cdef ->
       let buf = Buffer.create 256 in
       with_colors (fun () -> Flat_ir_formatter.output_def buf cdef);
       print_endline (Buffer.contents buf)
  )) |> Interactive.register_command ~name:"ir" ~help:"Print the ir representation of a toplevel definition";

  ArgString ("file", fun file -> Action (fun () ->
    let buf = Buffer.create 256 in
    let out_chan = open_out file in
    Flat_ir_formatter.output_defs buf !ir;
    output_string out_chan (Buffer.contents buf);
    close_out out_chan
  )) |> Interactive.register_command ~name:"dump_ir" ~help:"Dump the ir to a file"
