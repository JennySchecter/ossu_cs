import matplotlib.pyplot as plt
mySample = []
myLinear = []
myQuadratic = []
myCubic = []
myExponential = []

for i in range(0,30):
    mySample.append(i)
    myLinear.append(i)
    myQuadratic.append(i**2)
    myCubic.append(i**3)
    myExponential.append(1.5**i)


# 基本绘图
# plt.figure('lin')   #新建一个图形实例
# plt.clf() 
# plt.title('Linear')    #标题
# plt.xlabel('Sample points') #注释x、y轴
# plt.ylabel('Linear function')   
# plt.plot(mySample,myLinear) #绘制
   
# plt.figure('quad')
# plt.clf() 
# plt.title('Quadratic')
# plt.plot(mySample,myQuadratic)
# plt.figure('cube')
# plt.title('Cubic')
# plt.plot(mySample,myCubic)
# plt.figure('expo')
# plt.title('Exponential')
# plt.plot(mySample,myExponential)
# plt.ylabel('Exponential function')

# plt.plot(xvals,yvals,color and style,label...)  指定绘制的线条形状、颜色，标签
# plt.legend(loc = 'upper left') 指定标签的位置

#比较
plt.figure('lin quad')
plt.clf()
plt.plot(mySample,myLinear)
plt.plot(mySample,myQuadratic)

plt.figure('cube exp')
plt.clf()
plt.plot(mySample,myCubic)
plt.plot(mySample,myExponential)


plt.show()

