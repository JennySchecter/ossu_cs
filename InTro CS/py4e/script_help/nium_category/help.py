# 将文本中的行业分类，一行一行读取并写入一个xlsx表格中
import xlwt;

l = list()

# 使用 with open() 语句读取文件
with open("category.txt", 'r', encoding='utf-8') as file:
    # 逐行读取文件内容
    for line in file:
        # 去掉行尾的换行符
        line = line.strip('\n')
        l.append(line)

book = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book.add_sheet('Sheet1', cell_overwrite_ok=True)
for i in range(0, len(l)):
    sheet.write(i,0,l[i])
savepath = 'category.xlsx'
book.save(savepath)