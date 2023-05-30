filename = input('Enter a filename:');
try:
	fhand = open(filename);
except:
	print('File not found:',filename)
	exit()
for line in fhand:
	print(line.rstrip().upper())