# Exercise 2: Write a program to look for lines of the form:
# New Revision: 39772
# Extract the number from each of the lines using a regular expression
# and the findall() method. Compute the average of the numbers and
# print out the average as an integer.
# Enter file:mbox.txt
# 38549
# Enter file:mbox-short.txt
# 39756
import re
filename = input('Enter file:')
try:
	fhand = open(filename)
except:
	print('File can not open:',filename)
	exit()

l = list();
for line in fhand:
	x = re.findall('^New\sRevision:\s(\d+)',line)
	if len(x) > 0:
		#we can use extend or + to extend the list
		# l.extend(x)
		l = l+x

# Or We can use a for loop
float_l = list(map(int,l))
print(sum(float_l)//len(float_l))