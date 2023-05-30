score = input('Enter Score:\n');
try:
	f_score = float(score);
	if f_score <= 0.0 or f_score >= 1.0:
		print('Bad Score: not between the right range 0.0 and 1.0')
	elif f_score >= 0.9:
		print('A');
	elif f_score >= 0.8:
		print('B');
	elif f_score >= 0.7:
		print('C');
	elif f_score >= 0.6:
		print('D');
	else:
		print('F');
except:
	print('Bad Score: pls input the right number');