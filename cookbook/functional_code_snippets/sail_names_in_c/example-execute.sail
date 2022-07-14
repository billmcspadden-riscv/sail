default Order dec
$include <prelude.sail>


scattered union ast
val execute : ast -> int

union clause ast = ITYPE : int
function clause execute ITYPE(i) = { return 17 }

union clause ast = BTYPE : bool
function clause execute BTYPE(b) = { return 19 }

union clause ast = RTYPE : real
function clause execute BTYPE(r) = { return 23 }

union clause ast = BVTYPE : bits(32)
function clause execute BTYPE(bv) = { return 29 }

end execute
end ast
