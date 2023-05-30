#search log file, find unique [notice]
try:
    fhand = open('1620349152-07_notice.log')
except:
    print('Error: 没有找到文件或读取文件失败')

d = dict()
for line in fhand:
    line = line.strip('\n')
    position = line.find('[ notice ]')
    key_str = '[ notice ] '
    if position != -1:
        position_start = position + len(key_str)
        d[line[position_start:]] = d.get(line[position_start:],0) + 1

fhand.close()

new_log_file = open('unique_notice.log','w')
for key in d:
    new_log_file.write(key + ':' + str(d[key]) + '\n')

new_log_file.close()


