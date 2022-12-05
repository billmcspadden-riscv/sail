// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    vlen_configuration.sail
//
// Description: Example sail file calling C functions
// 
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See revision control log
// ============================================================================

default Order dec
$include <prelude.sail>

type xlenbits : Type = bits(32)
//type vlenbits : Type = bits(32)
//type vlenbits : Int  = int
type vlenbits : Type  = int


//===================================================
// Function signatures

val get_vlen = { c: "get_vlen" } : unit -> {| 128, 256, 512 |}    // 'unit' is a C void equivalent
val main            : unit -> unit
val "print"         : string -> unit
val "print_int"     : int -> unit
//val process_vle_2 : forall ('vlen : Int) . ('vlen, string) -> unit
//val process_vle_2 : forall 'vlen . (int, string) -> unit
//val process_vle_2 : forall 'vlen . (int, string) -> unit
//val process_vle_2 : forall  'vlen . ('vlen, string) -> unit     //  Type variable 'vlen in type 'vlen is Int rather than Type
//val process_vle_2 : forall ('vlen : Type)  . ('vlen, string) -> unit    // OK
val process_vle_2 : forall ('vlen : Int )  . (bits('vlen), string) -> unit

// Function signatures
//===================================================

//register    vlen : vlenbits

function main() = 
    {
    print("hello, world!\n") ;

    let ret : int = get_vlen();
    print_int("get_vlen: ", ret );
    print("\n");

//    vlen = ret;

//    process_vle_2(32, "hello");     // SCE: Could not resolve quantifiers for process_vle_2  * ('vlen : Int)
    process_vle_2(32, "hello\n");

    }


//val process_vle : forall ('b 'n : Int ), ('n < vlen). ( bits(1), bits(2) )  -> bits('b * 'n)
//val process_vle : forall ('b 'n : Int )             . ( bits(1), bits(2) )  -> bits('b * 'n)
//val process_vle : forall ('b 'n : Int )             . ( int('b), bits('n) )  -> bits('b * 'n)
//val process_vle : forall ('b 'n : Int ), ('n > 0 & 'b > 0) . ( int('b), bits('n), bits ('b * 'n) )  -> bits('b * 'n)
//val process_vle : forall ('b 'n : Int ), ('n > 0 & 'b > 0) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> bits('b * 'n)
//val process_vle : forall ('b 'n : Int ), ('n > 0 & 'b > 0) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> bits('b * 'n)

//val process_vle : forall ('b 'n : Int ), ('n > 0 & 'b > 0) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> vector(('b * 'n), dec, bit)  // works!!
//val process_vle : forall ('b 'n : Int ), ('n < vlen) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> vector(('b * 'n), dec, bit)
//val process_vle : forall ('b 'n : Int ), ('n < get_vlen()) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> vector(('b * 'n), dec, bit)
//val process_vle : forall ('b 'n : Int ) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> vector(('b * 'n), dec, bit)
val process_vle_1 : forall ('vlen 'b 'n : Int ) . ( int('b), bits('n), vector(('b * 'n),dec, bit), bits('vlen) )  -> vector(('b * 'n), dec, bit)


function process_vle_1 (arg1, arg2, arg3, arg4) =
    {
    //let v : bits( 'b * 'n ) = 0b11 ;      // Coercion failed
    //let v : bits( 'b * 'n ) = 0b11 ;      // Coercion failed
    //let v : bits( 'b * 'n ) = 'b * 'n ;   // No overloading for operator *
    //let v : bits( 'b * 'n ) = arg2 ;      // Coercion failed
    //let v : vector(('b * 'n), dec, bit) = 0b1 << 'b;  // Operartor fixity undeclared <<
    //v : vector(('b * 'n), dec, bit) ;       // Identifier v is unbound
    //v : vector(('b * 'n), dec, bit)  = 0b1; // Coercion failed
                                            //  bitvector(1, dec) is not a subtype of 
                                            //      vector(('b * 'n), dec, bit)
    //v : vector(('b * 'n), dec, bit)  = 0b1; // Coercion failed
    //v : vector(('b * 'n), dec, bit)  = bits('b); // No type declaration found for bits

//    if constraint ('n < get_vlen() )
//        {
//        print("here!\n");
//        }
    let xs : bits('vlen) = arg4;

    v : vector(('b * 'n), dec, bit)  = arg3;
    v
    }

//val process_vle_2 : forall ('vlen 'b 'n : Int ) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> bits('vlen)
////val process_vle_2 : forall (bits(32) 'vlen,  'b 'n : Int ) . ( int('b), bits('n), vector(('b * 'n),dec, bit) )  -> bits('vlen)
//function process_vle_2 (arg1, arg2, arg3) =
//    {
//    let 'vlen = get_vlen();
//    let xs : bits('vlen) = arg3;
//
//    xs
//    }

//val process_vle_2 : forall 'vlen . ( ) -> unit
//val process_vle_2 : forall 'vlen .  -> unit
function process_vle_2 (arg1, arg2) =
    {
    print(arg2);
//    print_int("size of 'vlen", sizeof('vlen) );
//    print_int("size of 'vlen ",        arg1  );
//    print_int("size of 'vlen", sizeof(arg1) );      // SCE:  cannot re-write sizeof(arg1)
//    print_int("size of 'vlen", sizeof('vlen) );      // SCE:  cannot re-write sizeof('vlen)
    }





