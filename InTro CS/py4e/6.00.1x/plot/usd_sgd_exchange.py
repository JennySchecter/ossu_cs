import matplotlib.pyplot as plt

month_exchange = [
    1.3280,
    1.3320,
    1.3441,
    1.3304,
    1.3211,
    1.3448,
    1.3536,
    1.3444,
    1.3576,
    1.3488,
    1.3648,
    1.3482,
    1.3511,
    1.3548,
    1.3539,
    1.3835,
    1.3702,
    1.3728
]
month = ["21/01","21/02","21/03","21/04","21/05","21/06",
         "21/07","21/08","21/09","21/10","21/11","21/12","22/01",
         "22/02", "22/03", "22/04", "22/05", "22/06"]

month_num = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]

def display_exchange(rate, month_num):
    plt.figure('USD-SGD-RATE')
    plt.clf()
    plt.plot(month_num, rate,"ro-")
    for a, b in zip(month_num, rate):
        plt.text(a, b, '%.4f' % b, ha='center', va='bottom', fontsize=9)
    plt.show()

display_exchange(month_exchange,month)
