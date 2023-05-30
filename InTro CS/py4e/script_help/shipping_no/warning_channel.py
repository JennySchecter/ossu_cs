#search log file, find unique [notice]
try:
    fhand = open('express_no_list.log')
except:
    print('Error: 没有找到文件或读取文件失败')

l = list()
for line in fhand:
    line = line.strip('\n')
    l.append("\"" + line + "\"")

fhand.close()

new_log_file = open('deal_express_no.log', 'w')
for i in range(0, len(l)):
    new_log_file.write(l[i]+",")

new_log_file.close()
