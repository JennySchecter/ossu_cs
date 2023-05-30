(* section 3: Abstruct Data Types with closures *)

(* a set of ints with three operations
 interface is immutable -- insert returns a new set -- could
 also have implemented a mutable version using ML's reference *)

datatype set = S of { insert : int -> set,
		      member : int -> bool,
		      size   : unit -> int }

(* client use *)
fun use_set () =
    
			
(* val empty_set : set *)
val empty_set =
    let fun make_set xs = (* xs is a "private field" in result *)
	    let (* contains is a "private method" in result*)
		fun contains i = List.exist (fn j => i=j) xs 
	    in
		S { insert : (fn i => if contains i
			              then make_set xs
			              else make_set (i::xs)),
		    member : contains,
		    size   : fn () => length xs
		  }
    in
	make_set []
    end
