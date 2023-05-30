number_list = []

while True:
	number = input('Enter a number：')
	if number != 'done':
		#convert to int
		try:
			number = int(number)
		except :
			print('Invalid input')
			continue;
		#append to the list
		number_list.append(number)
	else:
		#use build-in function calculate the maximum and minimum of the list
		#print(max(number_list),min(number_list))

		# or you can code by youself
		maxnum = None;
		minnum = None;
		for item in number_list:
			if maxnum is None or item > maxnum:
				maxnum = item
			if minnum is None or item < minnum:
				minnum = item
		print(maxnum,minnum)
		break;		
