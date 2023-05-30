#暴力算法和动态规划的区别
#动态规划存储所有排列组合作为键存储字典中
import random
import sys
sys.path.append('../knapsack_pro/')
import greedy_algorithm as ga
def buildLargeMenu(numItems,maxVal,maxCost):
    items = [];
    for i in range(numItems):
        items.append(ga.Food(str(i),
        random.randint(1,maxVal),
        random.randint(1,maxCost)))
    return items
def fastMaxVal(toConsider,avail,memo = {}):
    if (len(toConsider),avail) in memo:
        return memo[(len(toConsider),avail)]
    elif toConsider == [] or avail == 0:
        result = (0,())
    elif toConsider[0].getCost() > avail:
        result = fastMaxVal(toConsider[1:],avail)
    else:
        nextItem = toConsider[0];
        # if i take this, explore left branch
        withVal,withToTake = fastMaxVal(toConsider[1:],avail - nextItem.getCost())
        withVal += nextItem.getValue()
        # if i not take this,explore right branch
        withoutVal,withoutToTake = fastMaxVal(toConsider[1:],avail)
        if  withVal > withoutVal:
            result = (withVal,withToTake+(nextItem,))
        else:
            result = (withoutVal,withoutToTake)

    memo[(len(toConsider),avail)] = result
    return result

def maxVal(toConsider,avail):
    if toConsider == [] or avail == 0:
        result = (0,())
    elif toConsider[0].getCost() > avail:
        result = maxVal(toConsider[1:],avail)
    else:
        nextItem = toConsider[0];
        # if i take this, explore left branch
        withVal,withToTake = maxVal(toConsider[1:],avail - nextItem.getCost())
        withVal += nextItem.getValue()
        # if i not take this,explore right branch
        withoutVal,withoutToTake = maxVal(toConsider[1:],avail)
        if  withVal > withoutVal:
            result = (withVal,withToTake+(nextItem,))
        else:
            result = (withoutVal,withoutToTake)
    return result

def testMaxVal(foods,maxUnits,algorithm,printItems = True):
    print("Menu contains",len(foods),'items')
    print('Use Search Tree to allocate',maxUnits,'calories')
    val,taken = algorithm(foods,maxUnits)
    if printItems:
        print(str(algorithm),'Total value of item taken=',val)
        for item in taken:
            print(' ',item)

for numItems in (5,10,15,20,25):
    items = buildLargeMenu(numItems,90,250)
    testMaxVal(items,750,maxVal,True)
    testMaxVal(items,750,fastMaxVal,True)

# names = ['a','b','c','d']
# values = [6,7,8,9]
# calories = [3,3,2,5]
# foods = ga.buildMenu(names,values,calories)
# for item in foods:
#     print(item)
# testMaxVal(foods,5,fastMaxVal,True)
