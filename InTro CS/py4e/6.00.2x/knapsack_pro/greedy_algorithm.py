class Food(object):
    def __init__(self,name,value,weight):
        self.name = name
        self.value = value
        self.calories = weight
    
    def getValue(self):
        return self.value
    
    def getCost(self):
        return self.calories
    
    def density(self):
        return self.getValue()/self.getCost()

    def __str__(self):
        return self.name + ':<' + str(self.value)\
            + ',' + str(self.calories) + '>'

def buildMenu(names,values,calories):
    """names,values,calories lists of same length.
       name a list of strings
       values and calories lists of nunbers
       returns list of Foods
    """
    menu = []
    for i in range(len(values)):
        menu.append(Food(names[i],values[i],calories[i]))
    return menu

def greedy(items, maxCosts, keyFunction):
    """Assumes items a list, maxCost >= 0,
       keyFunction maps elements of items to numbers
    """
    itemsCopy = sorted(items,key = keyFunction,reverse = True)
    result = []
    totalValue,totalCost = 0.00,0.00
    for i in range(len(itemsCopy)):
        if totalCost + itemsCopy[i].getCost() <= maxCosts:
            result.append(itemsCopy[i])
            totalValue += itemsCopy[i].getValue()
            totalCost += itemsCopy[i].getCost()
    return (result,totalValue)

def testGreedy(items,constraint,keyFunction):
    taken,val = greedy(items,constraint,keyFunction)
    print("所拿取物品的总价值 =",val)
    for item in taken:
        print(' ',item)

def testGreedys(foods,maxUnits):
    print('通过价值来贪心分配',maxUnits,'calories')
    testGreedy(foods,maxUnits,Food.getValue)
    print('\n通过卡路里来进行贪心分配',maxUnits,'calories')
    testGreedy(foods,maxUnits,lambda x: 1/Food.getCost(x))
    print('\n通过密度进行贪心分配',maxUnits,'calories')
    testGreedy(foods,maxUnits,Food.density)

# names = ['wine','beer','pizza','burger','fires','cola','apple','dount','cake']
# values = [89,90,95,100,90,79,50,10]
# calories = [123,154,258,354,365,150,95,195]
# foods = buildMenu(names,values,calories)
# testGreedys(foods,750)








