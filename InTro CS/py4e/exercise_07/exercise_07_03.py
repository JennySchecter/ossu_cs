filename = input('Enter a filename:')
if filename == 'na na boo boo':
	print('NA NA BOO BOO TO YOU - You have been punk\'d!')
	exit()

try:
	fhand = open(filename)
except:
	print('File cannot be opened: ',filename)
	exit()
count = 0
for line in fhand:
	count = count + 1
print("There were",count,"subject lines in",filename)	