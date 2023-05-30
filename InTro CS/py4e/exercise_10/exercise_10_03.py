# Exercise 3: Write a program that reads a file and prints the letters
# in decreasing order of frequency. Your program should convert all the
# input to lower case and only count the letters a-z. Your program should
# not count spaces, digits, punctuation, or anything other than the letters
# a-z. Find text samples from several different languages and see how
# letter frequency varies between languages. Compare your results with
# the tables at https://wikipedia.org/wiki/Letter_frequencies.
import string
filename = input('Enter a filename:')
try:
	fhand = open(filename)
except:
	ptint('File can not open:',filename)
	exit()

#first create a dictionary count the letter a-z
d = dict()
for line in fhand:
	#  filter numbers and punctuation and new line
	line = line.translate(str.maketrans('0123456789',' '*10,string.punctuation+'\n\r\t'))
	#  filter space and turn to lower
	words = list(line.replace(' ','').lower())
	for word in words:
		d[word] = d.get(word,0) + 1

l = list()
for key,val in d.items():
	l.append((val,key))

l.sort(reverse=True)
for key in l:
	count,letter = key
	print(letter,count)

