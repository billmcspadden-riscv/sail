default Order dec
$include <prelude.sail>

val giraffe1 : unit -> int
function giraffe1 ()  = {
	 return 1
}

function giraffe2 ( n : int ) -> int = {
	 return n
}

overload giraffe = { giraffe1, giraffe2 }

val main : unit -> int effect {rreg, wreg}
function main () = {
    let x1 = giraffe() in
    let x2 = giraffe( 17 ) in
	return x2

}



