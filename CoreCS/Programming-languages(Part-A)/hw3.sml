(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end
	
(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
			       
(* QS 1 *)
fun only_capitals xs = List.filter (fn i => Char.isUpper (String.sub (i,0))) xs    

(*fun longest_string1 xs = 
    let fun longer_string (new_s,acc) =
	    if String.size acc < String.size new_s then new_s else acc
    in
	List.foldl longer_string "" xs
    end*)
				   
(* QS 2 *)
fun longest_string1 xs =
    List.foldl (fn (x,acc) => if String.size acc < String.size x then x else acc) "" xs

(* QS 3 *)	
fun longest_string2 xs =
    List.foldl (fn (x,acc) => if String.size acc <= String.size x then x else acc) "" xs

(*fun longest_string_helper f xs =
     List.foldl f "" xs*)
(* QS 4 *)
fun longest_string_helper f xs =
    List.foldl (fn (x,acc) => if f(String.size acc, String.size x) then x else acc) "" xs
val longest_string3 = longest_string_helper (fn (x,y) => x<y)
val longest_string4 = longest_string_helper (fn (x,y) => x<=y)
					    
(* QS 5 *)
val longest_capitalized = longest_string1 o only_capitals

(* QS 6 *)
val rev_string = String.implode o List.rev o String.explode

(* QS 7 *)
fun first_answer f xs =
    case xs of
	[] => raise NoAnswer
      | x::xs' => case f x of
			 SOME v => v
		       | NONE => first_answer f xs'

(* QS 8 *)					      
 fun all_answers f xs =
    let fun acc_ans (acc,xs) =
	    case xs of
		[] => SOME acc
	      | x::xs' =>
		case f x of
		    SOME v => acc_ans (v @ acc, xs')
		  | NONE => NONE
    in  acc_ans ([],xs) end


(* QS 9a *)
fun count_wildcards p =
    g (fn _ => 1) (fn x => 0) p
      
(* QS 9b *)
fun count_wild_and_variable_lengths p =
    g (fn _ => 1) (fn x => String.size x) p

(* QS 9c *)
fun count_some_var (s : string, p : pattern) =
    g (fn _ => 0) (fn x => if x = s then 1 else 0) p


(* QS 10: helper function *)
fun get_vars p =
    case p of
         Variable x        => [x]
       | TupleP ps         => List.foldl (fn (p,i) => (get_vars p) @ i) [] ps
       | ConstructorP(_,p) => get_vars p
       | _                 => []

fun is_repeat xs =
    case xs of
	[] => false
      | x::xs' => (List.exists (fn i => i = x ) xs')  orelse (is_repeat xs')

fun check_pat p =
    let val vars = get_vars p
    in
	not (is_repeat vars)
    end

(* QS 11 *)
fun match (v : valu, p : pattern) =
    case (v,p) of
	(_,Wildcard) => SOME []
      | (_,Variable s)=> SOME [(s,v)]
      | (Unit,UnitP) => SOME []
      | (Const x1,ConstP x2) => if x1=x2 then SOME [] else NONE 
      | (Tuple vs,TupleP ps) => if length vs = length ps 
				then all_answers match (ListPair.zip (vs,ps)) else NONE
      | (Constructor(s2,v),ConstructorP(s1,p)) => if s1 = s2 then match (v,p) else NONE
      | _ => NONE 
					    
(* QS 12 *)
fun first_match v lsp =
    let val tp_lst = List.map (fn x => (v,x)) lsp
    in SOME (first_answer match tp_lst) handle NoAnswer => NONE 
    end 

	
