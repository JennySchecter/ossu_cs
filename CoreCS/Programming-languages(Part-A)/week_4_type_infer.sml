
fun sum xs=
    case xs of
	[] => 0
      | x::xs' => x + sum xs'

fun f (x,y,z) =
    if true
    then (x,y,z)
    else (y,x,z)
	     
