# This program will not go wrong unless you txt file start with 'From' line the third words exist,
# or the third word is not the week number 
fhand = open('../exercise_07/mbox-short.txt')
count = 0
for line in fhand:
	words = line.split();
	if len(words) == 0 or words[0] != 'From' : continue
	print(words[2])
fhand.close()


#improve program
fhand = open('../exercise_07/mbox-short.txt')
count = 0
for line in fhand:
	words = line.split();
	if len(words) < 2 or words[0] != 'From' : continue
	print(words[2])


