# Change your socket program so that it counts the number of characters 
# it has received and stops displaying any text after it has shown 3000 
# characters. The program should retrieve the entire docu- ment and 
# count the total number of characters and display the count of the number
# of characters at the end of the document.
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
sum_num = 0;
while True:
	data = mysock.recv(300)
	if len(data) < 1:
		break	
	sum_num = sum_num + len(data)
	if sum_num <= 3000:
		print(data.decode('utf8','ignore'))
print('data length:',sum_num)
mysock.close()