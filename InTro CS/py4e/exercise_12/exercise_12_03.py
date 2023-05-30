# Use urllib to replicate the previous exercise of 
# (1) retrieving the document from a URL, 
# (2) displaying up to 3000 characters, and 
# (3) counting the overall number of characters in the document. 
# Don’t worry about the headers for this exercise, 
# simply show the first 3000 characters of the document contents.
import urllib.request,re,ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter a url: ');
try:
	#check the input is a url
	if re.search('^http[s]?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',url) == None:
		print('Pls enter a valid url')
	else:
		fhand = urllib.request.urlopen(url,context=ctx)
		sum_num = 0
		for line in fhand:
			words = line.decode().strip()
			sum_num = sum_num + len(words)
			if sum_num < 3000:
				print(words)
		print('data length:',sum_num);
except Exception as e:
	print(e)




