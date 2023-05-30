filename = input('Enter a filename:');
try:
	fhand = open(filename)
except:
	print('File not found',filename)
	exit();
#目标字符串
needle_str = 'X-DSPAM-Confidence:'
#总行数
line_count = 0;
#目标字符串出现次数
search_str_count = 0;
#均值
sum_value = 0;
for line in fhand:
	line_count = line_count + 1;
	strpos = line.find(needle_str)

	if strpos != -1 :
		search_str_count = search_str_count +1
		sum_value = sum_value + float(line.rstrip()[strpos+len(needle_str):])
average = sum_value/search_str_count
print('Count line:',line_count);
print('Sum DSPAM-Confidence:',sum_value);
print('average DSPAM-Confidence:',average);