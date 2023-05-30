#Assume s is a string of lower case characters.

#Write a program that prints the longest substring of s in which the letters occur in alphabetical order. For example, if s = 'azcbobobegghakl', then your program should print

#Longest substring in alphabetical order is: beggh
# In the case of ties, print the first substring. For example, if s = 'abcbcd', then your program should print

# Longest substring in alphabetical order is: abc
# s = 'abcgafgghikabc';
s = 'xycdrmqpjjtmx';
s = 'gspqkcbq';
s = 'zdpamiaqjfzr';
s = 'zyxwvutsrqponmlkjihgfedcba'
s = 'raxovaunkl'
s = 'dqphxvkri'
lis = list();
# dic = dict()
for i in range(0,len(s)):
	j = i;
	for j in range(j,len(s)):
		if j<len(s)-1:
			if s[j+1]>=s[j]:
				continue
			else:
				lis.append((s[i:j+1],j+1-i));
				# dic[s[i:j+1]] = j+1-i
				break;
		else:
			lis.append((s[i:],len(s)-i))
			# dic[s[i:]] = len(s)-i

# print(lis)
target_str = None
count_num = None
for item in lis:
	if  target_str is None or item[1] > target_str[1]:
		target_str = item
		# count_num = item[1]
print(target_str[0])

#注意，这个问题python3可以使用字典解决，但python2 不行，因为python2的dictionary是无序的，
#每次的dic顺序不同，就会出错。
# answer is :
# ['abcg', 'bcg', 'cg', 'g', 'afgghik', 'fgghik', 'gghik', 'ghik', 'hik', 'ik', 'k', 'abc', 'bc', 'c']



