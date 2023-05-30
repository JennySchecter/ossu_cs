# Exercise 5: This program records the domain name (instead of the
# address) where the message was sent from instead of who the mail came
# from (i.e., the whole email address). At the end of the program, print
# out the contents of your dictionary.
# python schoolcount.py
# Enter a file name: mbox-short.txt
# {'media.berkeley.edu': 4, 'uct.ac.za': 6, 'umich.edu': 7,
# 'gmail.com': 1, 'caret.cam.ac.uk': 1, 'iupui.edu': 8}
filename = input('Enter a filename: ')
try:
	fhand = open(filename)
except:
	print('File can not open: ',filename)
	exot();
d = dict()
for line in fhand:
	words = line.split()
	if len(words) < 1 or words[0] != 'From':continue
	domain_pos = words[1].find('@')
	domain = words[1][domain_pos+1:]
	d[domain] = d.get(domain,0) + 1
print(d)