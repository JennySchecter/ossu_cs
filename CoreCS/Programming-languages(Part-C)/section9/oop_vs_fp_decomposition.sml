(* section 9 : OOP vs. Functional Decomposition *)
(* OOP 和 FP 分解问题 *)

datatype exp = Int of i
	     | Negate of exp
	     | Add of exp * exp
	     | Mult of exp *exp
				

exception BadResult of string

fun eval e = (* 不需要环境因为没有变量 *)
    case e of
	Int _ => e
      | Negate e1 => (case eval e1 of
			 Int i => Int (~i)
		       | _ => raise BadResult "non-int in negation")
      | Add(e1,e2) => (let val v1 = eval e1
			   val v2 = eval e2
		       in
			   case (v1,v2) of
			       (Int i, Int j) => Int (i+j)
			     | _ => raise BadResult "non-ints in addition"
                       end
      | Mult(e1,e2) => let val v1 = eval e1
			   val v2 = eval e2
		       in
			   case (v1,v2) of
			       (Int i,Int j) => Int (i*j)
			     | _ => raise BadResult "non-ints in multiply")
                       end



fun toString e = 					  
    case e of
	Int i => Int.toString i
      | Negate e1 => "-(" ^ (toString e1) ^ ")"
      | Add(e1,e2) => "(" ^ (toString e1) ^ " + "
		      ^ (toString e2) ^ ")"
      | Mult(e1,e2) => "(" ^ (toString e1) ^  " *  "
		      ^ (toString e2) ^ ")"

fun hasZero e =
    case e of
	Int i => i=0
      | Negate e1 => hasZero e1
      | Add(e1,e2) => (hasZero e1) orelse (hasZero e2)
      | Mult(e1,e2) => (hasZero e1) orelse (hasZero e2)


fun noNegConstants e = 
    case e of
	Int i => if i < 0 then Negate (Int(~i)) else e
      | Negate e1 => Negate(noNegConstants e1)
      | Add(e1,e2) => Add(noNegConstants e1, noNegConstants e2)
      | Mult(e1,e2) => Mult(noNegConstants e1, noNegConstants e2)
    
