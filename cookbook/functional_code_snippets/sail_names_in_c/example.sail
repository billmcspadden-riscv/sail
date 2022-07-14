default Order dec
$include <prelude.sail>

val giraffe1 : unit -> int
function giraffe1 ()  = {
	 return 1
}

val giraffe2 : unit -> int

function giraffe3 () -> int = {
	 return 3
}

val giraffe4 : unit -> int
function giraffe4 () = {
	 return 4
}


val main : unit -> int effect {rreg, wreg}
function main () = {
    let x1 = giraffe1() in
    let x2 = giraffe2() in
    let x3 = giraffe3() in
	return 7

}



