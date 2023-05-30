
import matplotlib.pyplot as plt
#根据月储蓄金额和增长率得出退休储蓄金额
def retire(monthly,rate,terms):
    base = [0]
    savings = [0]
    mrate = rate/12
    for i in range(terms):
        base += [i]
        savings += [savings[-1]*(1+mrate) + monthly]
    return base,savings

#以月储蓄金额作为变量绘制曲线
def dispalyRetireWMonths(monthlies,rate,terms):
    plt.figure('retireMonth')
    plt.clf()
    for month in monthlies:
        xval,yval = retire(month,rate,terms)
        plt.plot(xval,yval,label = 'retire:'+str(month))
        plt.legend(loc = 'upper left')
    plt.show()

#以收益率作为变量绘制曲线
def dispalyRetireWRates(monthly,rates,terms):
    plt.figure('retireRates')
    plt.clf()
    for rate in rates:
        xval,yval = retire(monthly,rate,terms)
        plt.plot(xval,yval,label = 'retire:'+str(rate))
        plt.legend(loc = 'upper left')
    plt.show()
#同时以不同的月储蓄额和不同收益率绘制曲线
def dispalyRetireWMonthsAndRates(monthlies,rates,terms):
    plt.figure('retireBoth')
    plt.clf()
    plt.xlim(30*12,40*12)
    monthLabels = ['r','b','g','k']
    rateLabels = ['-','o','--']
    for i in range(len(monthlies)):
        month = monthlies[i]
        monthLabel = monthLabels[i%len(monthLabels)]
        for j in range(len(rates)):
                rate = rates[j]
                rateLabel = rateLabels[j%len(rateLabels)]
                xval,yval = retire(month,rate,terms)
                plt.plot(xval,yval,monthLabel+rateLabel,label = 
                'retire:'+str(month)+'-'+str(rate))
                plt.legend(loc = 'upper left')
    plt.show()

# dispalyRetireWMonths([500,600,700,800,900,1000,1100],.05,40*12)
# dispalyRetireWRates(800,[.04,.06,.08,.10],40*12)
dispalyRetireWMonthsAndRates([800,900,1000,1100],[.04,.06,.08],40*12)





