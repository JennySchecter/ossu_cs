(* section2 Nested Patterns *)
exception ListLengthMismatch

(* don't do this *)
fun old_zip3 (l1,l2,l3) =
    if null l1  andalso null l2 andalso null l3
    then []
    else if null l1 orelse null l2 orelse null l3
    then raise ListLengthMismatch
    else (hd l1,hd l2,hd l3) :: old_zip3(tl l1,tl l2,tl l3)


(* don't do this *)					
fun shallow_zip3 (l1,l2,l3) =
    case l1 of
	[] =>
	(case l2 of
	     [] => (case l3 of
			[] => []
		      | _ => raise ListLengthMismatch )
	   | hd2::tl2 => raise ListLengthMismatch)
      | hd1::tl1 =>
	(case l2 of
	     [] => raise ListLengthMismatch
	   | hd2::tl2 => (case l3 of
	                      [] => raise ListLengthMismatch
	                    | hd3::tl3 => (hd1,hd2,hd3) :: shallow_zip3(tl1,tl2,tl3))) 

(* do this *)
fun zip3 list_triple =
    case list_triple of
	([],[],[]) => []
      | (hd1::tl1,hd2::tl2,hd3::tl3) => (hd1,hd2,hd3) :: zip3(tl1,tl2,tl3)
      | _ => raise ListLengthMismatch


fun unzip3 triple_list =
    case triple_list of
	[] => ([],[],[])
      | (x,y,z) :: tl  => let val (x',y',z') = unzip3 tl
			  in (x::x',y::y',z::z') end
    
fun nondecreasing xs  =
    case xs of
	[] => true
      | _::[] => true
      | head::(neck::rest) => head <= neck
			      andalso nondecreasing (neck::rest) 

datatype sgn = P | N | Z

(* 不通过计算乘法计算而找得到乘积结果的符号 *)			   
fun multsign (x1,x2) =
    let fun sign x = if x=0 then Z else if x>0 then P else N
    in
	case (sign x1,sign x2) of
	    (Z,_) => Z
	  | (_,Z) => Z
	  | (P,P) => P
	  | (N,N) => P
	  | _ => N 
    end

fun rev1 lst =
    case lst of
	[] => []
      | x::xs => (rev1 xs) @ [x]

val point = (3,2,1,4)
val (x1,x2)=(#1 point,#3 point)
val (y1,y2)=(#2 point,#4 point)

fun sort_2_num (a,b) =
    if a > b
    then (b,a)
    else (a,b)



let val x=sort_2_num (#1 point,#3 point)
    val y=sort_2_num (#2 point,#4 point)
in
    (#1 x,#1 y,#2 x,#2 y)
end	

			      
