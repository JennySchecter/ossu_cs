def computepay(hour,rate):
	if hour > 40:
		pay = 40 * rate + (hour-40) * rate * 1.5
	else:
		pay = hour * rate
	return pay


pay = computepay(45,10);
print(pay);	