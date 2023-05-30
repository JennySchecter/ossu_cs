summation = 0;
count = 0;
average = 0;
while True:
	number = input('Enter a number：');
	if number != 'done':
		try:
			number = int(number)
		except:
			print('Invalid input')
			continue;
		summation += number
		count += 1
		average = summation/count
	else:
		print(summation,count,average);
		break;
