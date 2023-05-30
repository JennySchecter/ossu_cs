# (Advanced) Change the socket program so that it only shows data 
# after the headers and a blank line have been received. 
# Remember that recv receives characters (newlines and all), not lines.
import socket,re

url = input('Enter a url:')

try:
	if re.search('^http[s]?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',url) == None:
		print('Pls enter a valid url')
	else:
		host = url.split('/')[2]
		mysock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		mysock.connect((host,80))
		cmd = "GET "+ url + ' HTTP/1.0\r\n\r\n';
		cmd = cmd.encode();
		mysock.sendall(cmd)
		document = b''
		while True:
			data = mysock.recv(512)
			if len(data) < 1:
				break
			document = document + data
		mysock.close();
		headpos = document.find(b'\r\n\r\n')
		print(document[headpos+4:].decode())
except Exception as e:
	print(e)

