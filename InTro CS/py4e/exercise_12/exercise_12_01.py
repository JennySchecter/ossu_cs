# Change the socket program socket1.py(example_12_01.py) to prompt the user
# for the URL so it can read any web page. You can use split('/') to
# break the URL into its component parts so you can extract the host
# name for the socket connect call. Add error checking using try and
# except to handle the condition where the user enters an improperly
# formatted or non-existent URL.

# Tips: AF_INET means IPv4, AF_INET6 means IPv6;
# SOCK_STREAM means tcp/ip protocol, SOCK_DGRAM means UDP protocol
import socket,re

url = input('Enter a url: ');
try:
	#check the input is a url
	if re.search('^http[s]?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+',url) == None:
		print('Pls enter a valid url')
	else:
		host = url.split('/')[2];
		mysock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		mysock.connect((host,80))
		cmd = "GET "+ url + ' HTTP/1.0\r\n\r\n';
		cmd = cmd.encode();
		# print(cmd);quit();
except Exception as e:
	print(e)
mysock.send(cmd);
while True:
	data = mysock.recv(512)
	if len(data) < 1:
		break	
	print(data.decode('utf8','ignore'))

mysock.close()


	
