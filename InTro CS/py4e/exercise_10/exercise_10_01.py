# Exercise 1: Revise a previous program as follows: Read and parse the
# “From” lines and pull out the addresses from the line. Count the number of messages from each person using a dictionary.
# After all the data has been read, print the person with the most commits
# by creating a list of (count, email) tuples from the dictionary. Then
# sort the list in reverse order and print out the person who has the most
# commits.
# Sample Line:
# From stephen.marquard@uct.ac.za Sat Jan 5 09:14:16 2008
# Enter a file name: mbox-short.txt
# cwen@iupui.edu 5
# Enter a file name: mbox.txt
# zqian@umich.edu 195
filename = input('Enter a filename:')
try:
	fhand = open(filename)
except:
	ptint('File can not open:',filename)
	exit()

#first create a dictionary count the number of messages
d = dict()
for line in fhand:
	words = line.split()
	if len(words) < 1 or words[0] != 'From': continue
	d[words[1]] = d.get(words[1],0) + 1

#second create a list of tuple, like (count,email_addr) 
l = list()
for key,val in d.items():
	l.append((val,key))
#we can also do it like this
# for key in d:
# 	l.append((d[key],key))
# then we can sort this list by count
l.sort(reverse=True)
count,email_addr = l[0]
print(email_addr,count)


