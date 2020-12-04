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

open Ast
open Ast_defs
open Ast_util
open Printf

let opt_interactive = ref false
let opt_emacs_mode = ref false
let opt_suppress_banner = ref false
let opt_auto_interpreter_rewrites = ref false

let env = ref Type_check.initial_env

let ast = ref empty_ast

let arg str =
  ("<" ^ str ^ ">") |> Util.yellow |> Util.clear

let command str =
  str |> Util.green |> Util.clear

type action =
  | ArgString of string * (string -> action)
  | ArgInt of string * (int -> action)
  | Action of (unit -> unit)

let commands = ref []

let reflect_typ action =
  let open Type_check in
  let rec arg_typs = function
    | ArgString (_, next) -> string_typ :: arg_typs (next "")
    | ArgInt (_, next) -> int_typ :: arg_typs (next 0)
    | Action _ -> []
  in
  match action with
  | Action _ -> function_typ [unit_typ] unit_typ no_effect
  | _ -> function_typ (arg_typs action) unit_typ no_effect

let generate_help name help action =
  let rec args = function
    | ArgString (hint, next) -> arg hint :: args (next "")
    | ArgInt (hint, next) -> arg hint :: args (next 0)
    | Action _ -> []
  in
  let args = args action in
  let help = match String.split_on_char ':' help with
    | [] -> assert false
    | (prefix :: splits) ->
       List.map (fun split ->
           match String.split_on_char ' ' split with
           | [] -> assert false
           | (subst :: rest) ->
              if Str.string_match (Str.regexp "^[0-9]+") subst 0 then
                let num_str = Str.matched_string subst in
                let num_end = Str.match_end () in
                let punct = String.sub subst num_end (String.length subst - num_end) in
                List.nth args (int_of_string num_str) ^ punct ^ " " ^ String.concat " " rest
              else
                command (":" ^ subst) ^ " " ^ String.concat " " rest
         ) splits
       |> String.concat ""
       |> (fun rest -> prefix ^ rest)
  in
  sprintf "%s %s - %s" Util.(name |> green |> clear) (String.concat ", " args) help

let run_action cmd argument action =
  let args = String.split_on_char ',' argument in
  let rec call args action =
    match args, action with
    | (x :: xs), ArgString (hint, next) ->
       call xs (next (String.trim x))
    | (x :: xs), ArgInt (hint, next) ->
       let x = String.trim x in
       if Str.string_match (Str.regexp "^[0-9]+$") x 0 then
         call xs (next (int_of_string x))
       else
         print_endline (sprintf "%s argument %s must be an non-negative integer" (command cmd) (arg hint))
    | _, Action act ->
       act ()
    | _, _ ->
       print_endline (sprintf "Bad arguments for %s, see (%s %s)" (command cmd) (command ":help") (command cmd))
  in
  call args action
  
let register_command ~name:name ~help:help action =
  commands := (":" ^ name, (help, action)) :: !commands
