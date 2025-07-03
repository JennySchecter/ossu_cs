(* Section 3: Fold and more closures *)

(* Another hall-of-fame higher-order function *)

fun fold (f,acc,xs) =
    case xs of
	[] => acc
      | x::xs' => fold(f,f(acc,x),xs')

(* Sum all xs *)
fun f1 xs = fold ((fn (x,y) => x+y), 0, xs)
(* are all list is non-nagetive *)
fun f2 xs = fold ((fn (x,y) => x andalso y >= 0), true, xs)

(* counting the number of elements between lo and hi, inclusive *)
fun f3(xs,lo,hi) =
    fold ((fn (x,y) =>
	      x + (if y >= lo andalso y<= hi then 1 else 0)),
	  0, xs)


fun longest_string1 xs = 
    let fun longer_string (old_s,new_s) =
	    if String.size old_s < String.size new_s then new_s else old_s
    in
	fold (longer_string, "", xs)
    end
