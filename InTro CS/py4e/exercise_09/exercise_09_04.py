# Exercise 4: Add code to the above program to figure out who has the
# most messages in the file. After all the data has been read and the dictionary has been created, look through the dictionary using a maximum
# loop (see Chapter 5: Maximum and minimum loops) to find who has
# the most messages and print how many messages the person has.
# Enter a file name: mbox-short.txt
# cwen@iupui.edu 5
# Enter a file name: mbox.txt
# zqian@umich.edu 195
filename = input('Enter a filename:');
try:
	fhand = open(filename)
except:
	print('File can not open: ',filename)
	exot();
d = dict()
for line in fhand:
	words = line.split()
	if len(words) < 1 or words[0] != 'From':continue
	d[words[1]] = d.get(words[1],0) + 1

maximum_key = None

for key in d:
	if maximum_key is None or d[key] > d.get(maximum_key,0):
		maximum_key = key	

print(maximum_key,d[maximum_key])
