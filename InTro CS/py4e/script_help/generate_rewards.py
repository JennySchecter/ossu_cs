import random


new_log_file = open('/Users/zhangjing/Desktop/rewards_10.txt', 'w')

ac_serial_no = "20198892"

for i in range(0, 80):
    l = ac_serial_no + str(random.randint(100000000, 999999999)) + \
        "," + str(random.randint(1000, 9999)) + ",10.00,2022-09-01 00:00:00,2022-12-31 23:59:59" + "\n"
    new_log_file.write(l)

new_log_file.close()
