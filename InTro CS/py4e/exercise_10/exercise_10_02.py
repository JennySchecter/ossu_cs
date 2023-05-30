# Exercise 2: This program counts the distribution of the hour of the day
# for each of the messages. You can pull the hour from the “From” line
# by finding the time string and then splitting that string into parts using
# the colon character. Once you have accumulated the counts for each
# hour, print out the counts, one per line, sorted by hour as shown below.
# python timeofday.py
# Enter a file name: mbox-short.txt
# 04 3
# 06 1
# 07 1
# 09 2
# 10 3
# 11 6
# 14 1
# 15 2
# 16 4
# 17 2
# 18 1
# 19 1
filename = input('Enter a filename:')
try:
	fhand = open(filename)
except:
	ptint('File can not open:',filename)
	exit()

#first create a dictionary count the number of hour
d = dict()
for line in fhand:
	words = line.split()
	if len(words) < 5 or words[0] != 'From': continue
	colon_pos = words[5].find(':')
	hour = words[5][:colon_pos]
	d[hour] = d.get(hour,0) + 1

# second create a list of tuple, like (count,hour)
l = list()
for key,val in d.items():
	l.append((key,val))

# sort by hour ASC and print 
l.sort()

for key in l:
	h,count = key
	print(h,count)








