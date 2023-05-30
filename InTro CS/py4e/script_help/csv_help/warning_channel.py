#search csv file
import xlwt;
try:
    fhand = open('ips_warning_channel.csv')
except:
    print('Error: 没有找到文件或读取文件失败')

l = list()

for line in fhand:
    line = line.strip('\n')
    position = line.find('订单号:')
    key_str = '订单号:'
    if position != -1:
        position_start = position + len(key_str)
        l.append(line[position_start:-1])

fhand.close()


book = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book.add_sheet('平台订单号', cell_overwrite_ok=True)


for i in range(0, len(l)):
    sheet.write(i,0,l[i])
savepath = 'refund_fail_order.xlsx'
book.save(savepath)
# new_log_file.close()


