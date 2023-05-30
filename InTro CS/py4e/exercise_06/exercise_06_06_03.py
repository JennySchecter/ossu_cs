def count(string,letter):
	count = 0;
	for char in string:
		if char == letter:
			count = count + 1;
	return count;

string = input('Pls enter a  sting:\n');
letter = input('Pls enter a letter what you want count in the string:\n');

counts = count(string,letter);
print('Count of',"'"+letter+"'",'in',"'"+string+"'",'is',counts);
