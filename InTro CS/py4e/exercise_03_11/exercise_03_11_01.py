hour = input('Enter Hour:\n')
rate = input('Enter Rate:\n')
try:
	fhour = float(hour)
	hrate = float(rate)
	if fhour > 40:
		pay = 40 * hrate + (fhour-40) * hrate * 1.5
	else:
		pay = fhour * hrate 
	print('Pay:',pay);
except Exception as e:
	print('Error:',e);
