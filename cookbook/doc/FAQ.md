# Frequently Asked Questions about the Sail Programming Language

- [Q: What are the purposes of "$\<text\>" constructs,  things like $include, $optimize, etc?](#q-what-are-the-purposes-of-text-constructs-things-like-include-optimize-etc)
- [Q: Is there a library methodology for Sail?](#q-is-there-a-library-methodology-for-sail)
- [Q: RVFI_DII:  What is it?](#q-rvfidii-what-is-it)


## Q: What are the purposes of "$\<text\>" constructs,  things like $include, $optimize, etc?

A: $<...> runs what might be called the preprocessor (for directives like `$include <prelude.sail>`. Note that, unlike C, the Sail preprocessor works (recursively) on Sail ASTs rather than strings. Note that such directives that are used are preserved in the AST, so they also function as a useful way to pass auxiliary information to the various Sail backends.

Sail also calls those pragmas. Sail has a few pragmas that can be invoked with $..., see 

   https://github.com/rems-project/sail/blob/sail2/src/process_file.ml#L164-L181

Pragmas are useful if you want to extend the existing Sail system. We have some extensions in our internal version of Sail that are using $...

"$\<text\>" is also called a "splice" because it's used to 'splice' code in.

## Q: Is there a library methodology for Sail?

A: Use $include for common code

Ideally, Sail would support a proper module system. This would be especially useful for a modular architecture like RISCV. Form a pure Sail language perspective, it is not problem adding a well-designed module system (like OCaml's) to Sail. However, it's an open problem how to compile such a module system to Coq (IIRC). It's probably a solvable research question but nobody seems to be working on this. So for the time being, we will have to stay with "$include <...>"

## Q: RVFI_DII:  What is it?

A: See https://github.com/CTSRD-CHERI/TestRIG/blob/master/RVFI-DII.md 


