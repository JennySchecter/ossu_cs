# Change the urllinks.py program to extract and count paragraph (p) tags 
# from the retrieved HTML document and display the count of the paragraphs 
# as the output of your program. Do not display the paragraph text, 
# only count them. Test your program on several small web pages as well as 
# some larger web pages.
import urllib.request,urllib.parse,urllib.error
import re
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter a url:')
try:
	if re.search('^http[s]?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',url) == None:
		print('Pls enter a valid url')
	else:
		html = urllib.request.urlopen(url,context=ctx).read()
		paragraphs = re.findall(b'<p>(.*)</p>',html)
		# for paragraph in paragraphs:
		# 	print(paragraph.decode())
		print('P tags has :',len(paragraphs))
except Exception as e:
	print(e)

