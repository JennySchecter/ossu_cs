
from dis import code_info


try:
    fhand = open('us_state.log')
except:
    print('Error: 没有找到文件或读取文件失败')

zone_name = list()
zone_code = list()
for line in fhand:
    line = line.strip('\n')
    position1 = line.find('"zone_code": "')
    key_str1 = '"zone_code": "'
    if position1 != -1:
        position_start = position1 + len(key_str1)
        zone_code.append(line[position_start:-2])

    position2 = line.find('"zone_name": "')
    key_str2 = '"zone_name": "'
    if position2 != -1:
        position_start = position2 + len(key_str2)
        zone_name.append(line[position_start:-1])

fhand.close()

d = dict();

for name,code in zip(zone_name,zone_code):
    d[name] = code

try:
    state_fhand = open('sim_card_state.log')
except:
    print('Error: 没有找到文件或读取文件失败')

new_log_file = open('sim_card_state_after_deal.log', 'w')
for line in state_fhand:
    line = line.strip('\n')
    new_log_file.write(d[line]+ '\n')

new_log_file.close()


