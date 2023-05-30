# Reading binary files using urllib
import urllib.request,urllib.parse,urllib.error
# img = urllib.request.urlopen('http://data.pr4e.org/cover3.jpg').read()
# fhand = open("cover3.jpg",'wb')
# fhand.write(img)
# fhand.close()

# or you can write the img to the file chunk by chunk
img = urllib.request.urlopen('http://data.pr4e.org/cover3.jpg')
fhand = open("cover_chunk.jpg","wb")
size = 0

while True:
	data = img.read(100000)
	if len(data) < 1:break;
	size = size + len(data)
	fhand.write(data)
print(size,'characters copied.')
fhand.close()