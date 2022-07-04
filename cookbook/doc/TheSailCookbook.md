# A Sail Cookbook:  Recipes for Small Bytes (Bill)
Sail is a programming language that was developed for the purpose
of clearly, concisely and completely describing a computer's 
Instruction Set Architecture (ISA).  This includes...
- specifying the opcodes/instructions and their behaviours
- specifying the general purpose registers
- specifying the control space registers

Sail was the language chosen to formally specify the RISC-V open source
ISA.  This docuement,  while not RISC-V specific,  is especially targeted for engineers who are working on specifying the RISC-V
ISA. 

This cookbook is intended to supply the beginning Sail programmer with
some simple, well-commented, bite-size program fragments that can
be compiled and run.

**github** is used to host the development of Sail.  You can find the 
repository at the following URL:

https://github.com/rems-project/sail

Currently,  the work on this cookbook can be found on a branch in the
above repo.  This branch is:

https://github.com/billmcspadden-riscv/sail/tree/cookbook_br

So this is the place you should probably clone.  (Eventually,  this
branch will be merged to the release branch.)

Other documentation:

There is another useful Sail document that you should know about.  It is
"The Sail instruction-set semantics specification language" by Armstrong, et. al.  It can be found at:

https://github.com/billmcspadden-riscv/sail/blob/cookbook_br/manual.pdf




## How to contribute (Bill)


### pull requests (Bill)

### RISC-V working groups (Bill)

### style and contribution guide

### brevity

### short executable

### standalone

### maintainership (when something breaks)

## Sail installation
### Docker
### Ubuntu (Bill Mc.)
### MacOS (Martin)
### Windows 
Support of a native command line interface is not planned.  If you
want to run Sail under Windows,  plan on running it under Cygwin.

### Windows: Cygwin (Bill Mc.,  low priority)
If there is a demand,  a port to Cygwin will be attempted.

### Other?
Are there other OS platforms that should be supported?
Other Linux distis?  Or will Docker support?

## Basic description
### what sail is
- sequential model only
- non-parallel
### what sail is not 
- not a RTL language, etc
- Sail does not support any parallelism.  No threads.  No event sequences.  No clocking.

### version management and what to expect

## “Hello, World” program (Bill)
The following code snippet comes from: 

https://github.com/billmcspadden-riscv/sail/tree/cookbook_br/cookbook/functional_code_snippets/hello_world

hello_world.sail:

```
// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    hello_world.sail
//
// Description: Example sail file
//
// Author(s):   Bill McSpadden (william.c.mcspadden@gmail.com)
//
// Revision:    See revision control log
// ============================================================================

default Order dec
$include <prelude.sail>

val "print" : string -> unit

val main : unit -> unit

function main() = 
    {
    print("hello, world!\n") ;
    print("hello, another world!\n") ;
    }



```

## Data types
### effect annotations
### Integers
### Bits
### Strings
### Lists
### Structs
### mappings
### Liquid data types (Martin)

## Execution
### Functions
### Control flow
### Iteration 
### matches

## Description prelude.sail
### description of print, sext, equility etc.  standard template stuff
### the C interface

## CPU example
- From nand2tetris


## Formal tools that analyze Sail source code
<template>
coverage
