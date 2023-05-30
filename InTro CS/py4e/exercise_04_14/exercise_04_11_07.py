def coumputegrade(score):
	try:
		score = float(score);
		if score <= 0.0 or score >= 1.0:
			return 'Bad Score: not between 0.0 and 1.0'
		elif score < 0.6:
			return 'F'
		elif score < 0.7:
			return 'D'
		elif score < 0.8:
			return 'C'
		elif score < 0.9:
			return 'D'
		else:
			return 'A'
	except:
		return 'Bad Score'
	

score = input('Enter Score');
print(coumputegrade(score))			