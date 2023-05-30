
fun fold f = fn acc => fn xs =>
		case xs of
		    [] => acc
		  | x::xs' => fold f (f(acc,x)) xs'

fun sum1 xs = fold (fn (x,y) => x+y) 0 xs
val sum2 = fold (fn (x,y) => x+y) 0

fun addone x =
    x + 1
fun range i j = if i > j then [] else i :: range (i+1) j
fun other_curry1 f = fn x => fn y => f y x
fun other_curry2 f x y = f y x
fun curry f x y = f (x,y)
fun uncurry f (x,y) = f x y
