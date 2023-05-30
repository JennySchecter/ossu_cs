#暴力算法
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

def testMaxVal(foods,maxUnits):
    print('Use Search Tree to allocate',maxUnits,'calories')
    val,taken = maxVal(foods,maxUnits)
    print('Total value of item taken=',val)
    for item in taken:
        print(' ',item)

