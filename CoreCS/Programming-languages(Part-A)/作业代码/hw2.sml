(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (s,lst) =
    case lst of
	[] => NONE
      | x::xs' => if same_string(s,x)
		  then SOME (xs')
		  else let val except_lst = all_except_option(s,xs')
		       in
			   case except_lst of
			       NONE => NONE
			     | SOME a => SOME (x::a)
		       end

fun all_except_option2 (s,lst) =
    let fun except_tuple (s,lst,exp_lst,is_in) =
	    case lst of
		[] => ([],false)
	      | x::xs' => if same_string(x,s)
			  then (exp_lst@xs',true)
			  else except_tuple(s,xs',x::exp_lst,is_in)
    in
	case except_tuple (s,lst,[],false) of
	    (_,false) => NONE
	  | (a,true) => SOME a 
    end
			      
fun get_substitutions1 (sll,s) =
    case sll of
	[] => []
      | x::xs' => let val lst =  all_except_option(s,x)
		  in case lst of
			 NONE => get_substitutions1(xs',s)
		       | SOME sl => sl @ get_substitutions1(xs',s)
		  end

fun get_substitutions2 (sll,s) =
    let fun accu (strll,except_lst) =
	    case strll of
		[] => except_lst
	      | x::xs' => let val lst =  all_except_option(s,x)
			  in case lst of
				 NONE => accu(xs',except_lst)
			       | SOME sl => accu(xs',except_lst @ sl)
			  end
    in accu(sll,[])
    end
		     

fun similar_names (sll,{first=x,middle=y,last=z}) =
    let val all_names = get_substitutions2 (sll,x)
    in
	let fun accu (all_names,full_name_lst) =
		case all_names of
		    [] => full_name_lst
		  | f1::f1' => accu (f1',full_name_lst @ [{first=f1,middle=y,last=z}])
	in {first=x,middle=y,last=z} :: accu (all_names,[]) end
    end


    
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color card = (* suit * rank -> color *)
    case card of
	(Clubs,_)  => Black
     |  (Spades,_) => Black
     |  (_,_) => Red 

fun card_value card =
    case card of
	(_,Ace) => 11
      | (_,Num i) => i
      | (_,_) => 10 

fun remove_card (cs,c,exn) =
    let fun accu (cs,except_cs) =	    
	    case cs of
		[] => raise exn
	      | hd::tl => if hd = c then except_cs@tl else accu (tl,hd :: except_cs)
    in accu (cs,[])
    end


fun all_same_color cs =
    case cs of
	[] => true
      | _::[] => true
      | head :: (neck :: rest) => card_color head = card_color neck andalso all_same_color (neck::rest)

fun sum_cards cs =
    let fun accu (cls,sum) =
	    case cls of
		[] => sum
	      | hd::tl => accu (tl,sum + card_value hd)
    in accu (cs,0) end
	
	   
fun score (cs,goal) =
    let val sum = sum_cards cs
    in
	let val pre_score = if sum > goal then (sum - goal) * 3 else goal - sum
        in
 	    if all_same_color cs then pre_score div 2 else pre_score
	end
    end
							  
fun officiate (cs,ms,goal) =
    let fun accu (cs,ms,held_cs) =
	    case (cs,ms) of
		(_,[]) => score (held_cs,goal)
	      | ([],Draw::mtl) => score (held_cs,goal)
	      | (_,Discard c::mtl) => accu (cs,mtl,remove_card (held_cs,c,IllegalMove))
	      | (c1::ctl,Draw::mtl) => if sum_cards (c1::held_cs) > goal
				       then  score(c1::held_cs,goal)
				       else accu (ctl,mtl,c1::held_cs)
    in accu(cs,ms,[]) end	
