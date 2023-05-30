class Location(object):
    def __init__(self,x,y):
        """x and y are floats"""
        self.x = x
        self.y = y

    def move(self,deltaX,deltaY):
        """deltaX and deltaY are floats"""
        return Location(self.x + deltaX,self.y + deltaY)

    def getX(self):
        return self.x
    def getY(self):
        return self.y

    def distFrom(self,other):
        ox = other.x
        oy = other.y
        xDist = self.x - ox
        yDist = self.y - oy
        return (xDist**2 + yDist**2)**0.5
    
    def __str__(self):
        return '<' + str(self.x) + ','\
            + str(self.y) + '>'


class Field(object):
    def __init__(self):
        self.drunks = {}
    
    def addDrunk(self,drunk,loc):
        if  drunk in self.drunks:
            raise ValueError('Duplicate drunk')
        else:
            self.drunks[drunk] = loc
    def getLoc(self,drunk):
        if drunk not in self.drunks:
            raise ValueError('Drunk not in field')
        return self.drunks[drunk]
    def moveDrunk(self,drunk):
        if drunk not in self.drunks:
            raise ValueError("Drunk not in field")
        xDist,yDist = drunk.takeStep()
        currentLocation = self.drunks[drunk]
        self.drunks[drunk] = currentLocation.move(xDist,yDist)
    
#parent class
class Drunk(object):
    def __init__(self,name):
        self.name = name
    def __str__(self):
        return 'This drunk is named ' + self.name

import random
#subclass
class UsualDrunk(Drunk):
    def takeStep(self):
        stepChoices = \
            [(0.0,1.0),(0.0,-1.0),(1.0,0.0),(-1.0,0.0)]
        return random.choice(stepChoices)
    
#subclass
class ColdDrunk(Drunk):
    def takeStep(self):
        stepChoices = \
            [(0.0,0.9),(0.0,-1.1),(1.0,0.0),(-1.0,0.0)]
        return random.choice(stepChoices)

# Simulating a Walk
def walk(f,d,numSteps):
    """Assume: f a Field, d a Drunk in f, and numSteps an int >= 0
       Moves d numSteps times; returns the distance between the final
       location and the location at the start of the walk.
    """
    start = f.getLoc(d)
    for s in range(numSteps):
        f.moveDrunk(d)
    return start.distFrom(f.getLoc(d))

def simWalks(numSteps,numTrials,dClass):
    """Assume numSteps an int >=0, numTrials an int >0, dClass a subclass
       of Drunk.
       Simulates numTrials walks of numSteps steps each.
       Returns a list of the final distances for each trial.
    """
    Homer = dClass('homer')
    origin = Location(0,0)
    distances = []
    for t in range(numTrials):
        f = Field()
        f.addDrunk(Homer,origin)
        distances.append(round(walk(f,Homer,numSteps),1))
    return distances

def drunkTest(walkLengths,numTrials,dClass):
    """Assume walkLengths a sequence of ints >= 0,numTrials a int > 0,
       dClass a subclass of Drunk
       For each number of steps in walkLengths,runs simWalks with numTrials walks
       and prints results 
    """
    for numSteps in walkLengths:
        distances = simWalks(numSteps,numTrials,dClass)
        print(dClass.__name__,"random walk of",numSteps,'steps')
        print('Mean =',round(sum(distances)/len(distances),4))
        print('Max =',max(distances),'Min =',min(distances))

# random.seed(0)
# drunkTest((10,100,1000,10000),100,UsualDrunk)

# 绘图样式
class styleIterator(object):
    def __init__(self,styles):
        self.index = 0
        self.styles = styles
    def nextStyle(self):
        result = self.styles[self.index]
        if self.index == len(self.styles) - 1:
            self.index = 0
        else:
            self.index += 1
        return result

# 根据一组模拟步数，一个试验次数，一个酒鬼类型，得到一组对应模拟步数的平均距起点距离
def simDrunk(numTrials,dClass,walkLengths):
    meanDistance = [];
    for numSteps in walkLengths:
        print('Start simulation of',numSteps,'steps')
        trials_distance = simWalks(numSteps,numTrials,dClass)
        mean = sum(trials_distance)/len(trials_distance)
        meanDistance.append(mean)
    return meanDistance 

import matplotlib.pylab as plt
# import matplotlib.pyplot as plt   这2个都行
def simAll(drunkKinds,walkLengths,numTrials):
    styleChoice = styleIterator(('m-','b--','g-.'))
    for dClass in drunkKinds:
        curStyle = styleChoice.nextStyle()
        print('Starting simulation of',dClass.__name__)
        means = simDrunk(numTrials,dClass,walkLengths)
        plt.plot(walkLengths,means,curStyle,label = dClass.__name__)
    plt.title('Mean Distance from Origin ('+str(numTrials)+' trials)')
    plt.xlabel('Number of Steps')
    plt.ylabel('Distance from Origin')
    plt.legend(loc = 'upper left')
    plt.show()

# numSteps = (10,100,1000,10000)
# simAll((UsualDrunk,ColdDrunk),numSteps,100)

def getFinalLocs(numSteps,numTrials,dClass):
    locs = []
    d = dClass('homer')
    for i in range(numTrials):
        f = Field()
        f.addDrunk(d,Location(0,0))
        for i in range(numSteps):
            f.moveDrunk(d)
        locs.append(f.getLoc(d))
    return locs

def plotLocs(drunkKinds,numSteps,numTrials):
    styleChoice = styleIterator(('k+','r^','mo'))
    for dClass in drunkKinds:
        locs = getFinalLocs(numSteps,numTrials,dClass)
        xVals,yVals = [],[]
        for loc in locs:
            xVals.append(loc.getX())
            yVals.append(loc.getY())
        #将列表转化为数组，因为列表不能求和，求绝对值
        xVals = plt.array(xVals)
        yVals = plt.array(yVals)
        meanX = sum(abs(xVals))/len(xVals)
        meanY = sum(abs(yVals))/len(yVals)
        curStyle = styleChoice.nextStyle()
        plt.plot(xVals,yVals,curStyle,label = 'Mean abs dist = <'+\
            dClass.__name__+str(meanX)+','+str(meanY) +'>')
    plt.title('Location at end of walks ('+str(numSteps)+' steps)')
    plt.xlim(-1000,1000)
    plt.ylim(-1000,1000)
    plt.xlabel('Step East/West of Origin')
    plt.ylabel('Step North/South of Origin')
    plt.legend(loc = 'upper left')
    plt.show()

# random.seed(0)
# plotLocs((UsualDrunk,ColdDrunk),10000,1000)

# 虫洞模型
class OddField(Field):
    def __init__(self,numHoles = 1000,xRange = 100,yRange = 100):
        Field.__init__(self)
        self.wormholes = {}
        for w in range(numHoles):
            x = random.randint(-xRange,xRange)
            y = random.randint(-yRange,yRange)
            newX = random.randint(-xRange,xRange)
            newY = random.randint(-yRange,yRange)
            newLoc = Location(newX,newY)
            self.wormholes[(x,y)] = newLoc

    #与父类的不同在于，如果是虫洞会传递到虫洞对应的位置
    def moveDrunk(self,drunk):
        Field.moveDrunk(self,drunk)
        x = self.drunks[drunk].getX()
        y = self.drunks[drunk].getY()
        #如果移动后的位置在虫洞对应的键上，则移动到虫洞对应的位置
        if  (x,y) in self.wormholes:
            self.drunks[drunk] = self.wormholes[(x,y)]
        
def traceWalk(fieldKinds,numSteps):
    styleChoice = styleIterator(('b+','r^','ko'))
    for fClass in fieldKinds:
        f = fClass()
        d = UsualDrunk('homer')
        f.addDrunk(d,Location(0,0))
        locs = []
        for s in range(numSteps):
            f.moveDrunk(d)
            locs.append(f.getLoc(d))
        xVals,yVals = [],[]
        for loc in locs:
            xVals.append(loc.getX())
            yVals.append(loc.getY())
        curStyle = styleChoice.nextStyle()
        plt.plot(xVals,yVals,curStyle,label = fClass.__name__)
    plt.title('Spots Visited on Walk ('+str(numSteps)+' steps)')
    plt.xlabel('Step East/West of Origin')
    plt.ylabel('Step North/South of Origin')
    plt.legend(loc = 'upper left')
    plt.show()

traceWalk((Field,OddField),500)
