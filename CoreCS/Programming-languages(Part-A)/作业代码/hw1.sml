fun is_older (d1 : int*int*int, d2 : int*int*int) = (* true if d1 early than d2 *)
    if #1 d1 < #1 d2
    then true
    else if  #1 d1 > #1 d2
    then false
    else
	if #2 d1 < #2 d2
	then true
	else if  #2 d1 > #2 d2
	then false
	else
	    if #3 d1 < #3 d2
	    then true
	    else false

fun number_in_month (ds : (int * int * int) list, m : int) =
    if null ds
    then 0
    else if #2 (hd ds) = m
    then 1 + number_in_month(tl ds,m)
    else number_in_month(tl ds,m)
    
fun number_in_months (ds : (int * int * int) list, ms : int list) =
    if null ms
    then 0
    else number_in_month(ds, hd ms) + number_in_months(ds, tl ms)

fun dates_in_month (ds : (int * int * int) list, m : int) =
    if null ds
    then []
    else if (#2 (hd ds)) = m
    then (hd ds) :: dates_in_month (tl ds,m)
    else dates_in_month (tl ds,m)

fun dates_in_months (ds : (int * int * int) list, ms : int list) =
    if null ms
    then []
    else dates_in_month (ds, hd ms) @ dates_in_months (ds, tl ms)
						      
fun get_nth (ss : string list, n : int) = (* Assuming n > 1 *)
    if n = 1
    then hd ss
    else get_nth (tl ss,n-1)

val month = ["January","February","March","April","May","June","July","August","September","October","November","December"];
fun date_to_string (d : int*int*int) =
    get_nth (month,#2 d) ^ " " ^ Int.toString (#3 d) ^ ", " ^  Int.toString (#1 d)
    
fun number_before_reaching_sum (sum : int, il : int list) =
    if sum > (hd il)
    then 1 + number_before_reaching_sum(sum - (hd il), tl il)
    else 0

fun what_month (d : int) =
    let val month_day = [31,28,31,30,31,30,31,31,30,31,30,31]
    in 1 + number_before_reaching_sum (d,month_day) end

fun month_range (d1 : int, d2 : int) =
    if d1 > d2
    then []
    else what_month d1 :: month_range (d1+1,d2)

fun oldest_v1 (ds : (int*int*int) list) =
    if null ds
    then NONE
    else if null (tl ds)
    then SOME (hd ds)
    else if is_older (hd ds,(hd (tl ds)))
    then oldest_v1 (hd ds :: (tl (tl ds)))
    else oldest_v1 (tl ds)

fun oldest_v2 (ds : (int*int*int) list) =
    if null ds
    then NONE
    else if null (tl ds)
    then SOME (hd ds)
    else
	let val tl_oldest = oldest_v2 (tl ds)
	in
	    if isSome tl_oldest andalso is_older (hd ds,valOf tl_oldest)
	    then SOME (hd ds)
	    else tl_oldest
	end

fun oldest (ds : (int*int*int) list) =
    if null ds
    then NONE
    else if null (tl ds)
    then SOME (hd ds)
    else
	let fun oldest_noempty (ds : (int*int*int) list) =
		if null (tl ds)
		then hd ds
		else
		    let val tl_oldest = oldest_noempty (tl ds)
		    in
			if is_older (hd ds, tl_oldest)
			then hd ds
			else tl_oldest
		    end
	in
	   SOME (oldest_noempty ds)
	end


(* a helper function for QS12, remove_duplicated *)
fun remove_duplicate (xs : int list) =
    if null xs
    then []
    else
	let
	    fun in_list (x : int, xs : int list) =
		if null xs
		then false
		else if x = (hd xs)
		then true
		else in_list (x,(tl xs))
	in
	    if in_list (hd xs, tl xs)
	    then remove_duplicate (tl xs)
	    else (hd xs) :: remove_duplicate (tl xs)
	end

fun number_in_months_challenge (ds : (int*int*int) list, ms : int list) =
    let val distinct_month = remove_duplicate (ms)
    in number_in_months (ds,distinct_month)
    end

fun dates_in_months_challenge (ds : (int*int*int) list, ms : int list) =
    let val distinct_month = remove_duplicate (ms)
    in dates_in_months (ds,distinct_month)
    end


(* a helper func for Q13 *)
fun get_nth_integer (xs : int list, n : int) = (* Assuming n > 1 *)
    if n = 1
    then hd xs
    else get_nth_integer (tl xs,n-1)
	
fun reasonable_date (d : int * int * int) =
    if #1 d <=0
    then false
    else if (#2 d) <= 0 orelse (#2 d) >12
    then false
    else
	let
	    val is_leap_year = (#1 d) mod 400 = 0 orelse ((#1 d) mod 4 = 0 andalso (#1 d) mod 100 <> 0)
	    val month_day = [31,28,31,30,31,30,31,31,30,31,30,31]
	in
	    if is_leap_year andalso #2 d = 2
	    then (#3 d) > 0 andalso (#3 d) <= 29  
	    else (#3 d) > 0 andalso (#3 d) <= get_nth_integer (month_day, #2 d)
	end
