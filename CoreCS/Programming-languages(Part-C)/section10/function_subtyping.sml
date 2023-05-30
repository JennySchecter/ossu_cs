(* Section 10: Function Subtyping *)

fun distMoved (f : {x:real,y:real}->{x:real,y:real},p : {x:real,y:real}) =
    let val p2 : {x:real,y:real} = f p
	val dx : real = (#x p2) - (#x p)
	val dy : real = (#y p2) - (#y p)
    in Math.sqrt(dx*dx + dy*dy)
    end

fun flipGreen (p:{x:real,y:real}) =
    {x= ~(#x p), y= ~(#y p)}
		      
val d = distMoved(flipGreen, {x=3.0, y=4.0})

fun distToOrigin2 (getx,gety,v) =
    let
	val x = getx v
	val y = gety v
    in
	Math.sqrt (x*x + y*y)
    end
	
fun distToOriginPt (p : {x:real,y:real}) =
    distToOrigin2(fn v => #x v,
		  fn v => #y v,
		  p)
		 
fun distToOriginColorPt (p : {x:real,y:real,color:string}) =
    distToOrigin2(fn v => #x v,
		  fn v => #y v,
		  p)		 
			 
