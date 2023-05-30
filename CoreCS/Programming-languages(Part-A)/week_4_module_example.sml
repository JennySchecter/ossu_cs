(* section 4: A Module- Signature example *)

(* structure not use signature is :
   structure x =
   struc
     a lot of bindings
   end

   structure use signature is :
   signature X =
   sig
    a lot of bindings
   end

   structure x :> X =
   struc
     a lot of bindings
   end
*)

signature RATIONAL_A =
sig
    datatype rational = Whole of int | Frac of int * int
    exception BadFrac
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end

signature RATIONAL_B =
sig
    type rational
    exception BadFrac
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end

    signature RATIONAL_C =
sig
    type rational
    exception BadFrac
    val whole : int -> rational
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end
    
    
(* will assign different signature for this module *)
structure Rational1 :> RATIONAL_A =
struct
(* Invariant 1: all denominators > 0
   Invariant 2: rationals keep in reduce form, including that a Frac
   never has a denominator of 1 *)
datatype rational = Whole of int | Frac of int*int
exception BadFrac

(* gcd and reduce help keep fractions reduced,
   but client need not know about them *)
(* they _assume_ their inputs are not negative *)
(* gcd: compute a greatest common divisor bwtween two number 辗转相除法 *)
fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd (x,y-x)
    else gcd (y,x)

fun reduce r =
    case r of
	Whole _ => r
      | Frac (x,y) => let val d = gcd (x,y)
		      in
			  if d = y
			  then Whole (x div y)
			  else Frac (x div d, y div d)
		      end

(* when making a frac, we ban zero denomiators *)
fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce (Frac(~x,~y))
    else reduce (Frac(x,y))
	       
fun add (r1,r2) =
    case (r1,r2) of
	(Whole i,Whole j) => Whole (i+j)
      | (Whole i,Frac(j,k)) => Frac (i*k+j,k)
      | (Frac (i,j),Whole k) => Frac (k*j+i,j)
      | (Frac(i,j),Frac(m,n)) => reduce (Frac(i*n + j*m,j*n))
					
fun toString r =
    case r of
	Whole i => Int.toString i
      | Frac(x,y) => (Int.toString x) ^ "/" ^ (Int.toString y)
		     
end
    
(* this structure can have all three signatures we gave Rational1 in previous segments
   this sturcture does not reduce fractions until print toString 
*)
structure Rational2 :> RATIONAL_A(* or B or C *) =
struct
datatype rational = Whole of int | Frac of int*int
exception BadFrac
	      
fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then Frac(~x,~y)
    else Frac(x,y)
	       
fun add (r1,r2) =
    case (r1,r2) of
	(Whole i,Whole j) => Whole (i+j)
      | (Whole i,Frac(j,k)) => Frac (i*k+j,k)
      | (Frac (i,j),Whole k) => Frac (k*j+i,j)
      | (Frac(i,j),Frac(m,n)) => Frac(i*n + j*m,j*n)
					
fun toString r =
    let fun gcd (x,y) =
	    if x=y
	    then x
	    else if x < y
	    then gcd (x,y-x)
	    else gcd (y,x)
	fun reduce r =
	    case r of
		Whole _ => r
	      | Frac (x,y) => let val d = gcd (x,y)
			      in
				  if d = y
				  then Whole (x div y)
				  else Frac (x div d, y div d)
			      end
    in	
	case reduce r of
	    Whole i => Int.toString i
	  | Frac(x,y) => (Int.toString x) ^ "/" ^ (Int.toString y)
    end
		     
end

(* this structure can have all three signatures we gave Rational1 in previous segments
   this sturcture does not reduce fractions until print toString 
*)
structure Rational3 :> RATIONAL_B(* or C , not A *) =
struct
type rational = int * int
exception BadFrac
	      
fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then (~x,~y)
    else (x,y)
	       
fun add ((a,b),(c,d)) = (a*d + b*c,b*d)
	
fun toString (x,y) =
    if x = 0
    then "0"
    else	
	let fun gcd (x,y) =
		if x=y
		then x
		else if x < y
		then gcd (x,y-x)
		else gcd (y,x)
	    val d = gcd (x,y)
	    val num = x div d
	    val denom = y div d
	in
	    (Int.toString num) ^ (if denom = 1
				then ""
				else "/" ^ (Int.toString denom))
	end
	    
fun Whole i = (i,1)
end


signature DIGIT = 
sig
type digit
val make_digit : int -> digit
val increment : digit -> digit
val decrement : digit -> digit
val test : digit -> unit
end

structure Digit :> DIGIT =
struct
type digit = int
exception BadDigit
exception FailTest
fun make_digit i = if i < 0 orelse i > 9 then raise BadDigit else i
fun increment d = if d=9 then 0 else d+1
fun decrement d = if d=0 then 9 else d-1
val down_and_up = increment o decrement (* recall o is composition *)
fun test d = if down_and_up d = d then () else raise FailTest
end


signature COUNTER =
sig
    type t
    val newCounter : int -> int
    val increment : t -> t
    val first_larger : t * t -> bool
end

structure NoNegativeCounter :> COUNTER = 
struct

exception InvariantViolated

type t = int

fun newCounter i = if i <= 0 then 1 else i

fun increment i = i + 1

fun first_larger (i1,i2) =
    if i1 <= 0 orelse i2 <= 0
    then raise InvariantViolated
    else (i1 - i2) > 0

end

fun mystery f = fn xs =>
    let
        fun g xs =
           case xs of
               [] => NONE
             | x::xs' => if f x then SOME x else g xs'
    in
        case xs of
            [] => NONE
          | x::xs' => if f x then g xs' else mystery f xs'
    end
