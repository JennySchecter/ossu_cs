(* section2 DataType Bindings and Case Expression *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp

fun max_constant e =
    case e of
     Constant i => i
     | Negate e1 => max_constant e1
     | Add (e1,e2) => Int.max(max_constant e1,max_constant e2)
     | Multiply (e1,e2) => Int.max(max_constant e1,max_constant e2)


fun full_name {first=x,middle=y,last=z} =
    x ^ " " ^ y ^ " " ^ z
			    
val r = {first="A",middle="",last="C"}
	    
fun full_name2 (rc : {first:string, last:string, middle:string}) =
    #first rc ^ " " ^ #middle rc ^ " " ^ #last rc
			 

(* section2 List and Options are DataTypes *)

datatype my_int_list = Empty
                     | Cons int * my_int_list

(*  type is int list -> int *)
fun sum_list xs =
    case xs of
	[] => 0
      | x::xs' => x + sum_list xs'

(* type is 'a list -> 'a list *)
fun append (xs,ys) =
    case xs of
	[] => ys
      | x::xs' => x :: append (xs',ys)

(* a binary tree data type  *)		      
datatype ('a,'b) tree = Node of 'a * ('a,'b) tree * ('a,'b) tree
		      | Leaf of 'b

				    
