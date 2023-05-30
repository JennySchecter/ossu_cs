# This func will modify the argument t 
def chop(t):
	if not isinstance(t,list):
		return 'The argument need a list'
	if len(t) < 2:
		return []
	# t.pop(0)
	# t.pop()
	del t[0]
	del t[-1]
	return t;



# This func will unmodify the argument t, instead it will return a new list
def middle(t):
	if not isinstance(t,list):
		return 'The argument need a list'
	return t[1:-1]

t = input('Enter a list:');

input_list = list(t);

#chop_list = chop(input_list)
chop_list = middle(input_list)

print(input_list)
print(chop_list)