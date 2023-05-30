#节点
class Node(object):
    def __init__(self,name):
        """Assumes name is a string"""
        self.name = name
    def getName(self):
        return self.name
    def __str__(self):
        return self.name
        
#边
class Edge(object):
    def __init__(self,src,dest):
        self.src = src
        self.dest = dest
    def getSource(self):
        return self.src
    def getDestination(self):
        return self.dest
    def __str__(self):
        return self.src.getName() + '->'\
            + self.dest.getName()

#有向图
class Digraph(object):
    def __init__(self):
        self.edges = {}
    def addNode(self,node):
        if node in self.edges:
            raise ValueError('Duplicate node')
        else:
            self.edges[node] = []
    def addEdge(self,edge):
        src = edge.getSource()
        dest = edge.getDestination()
        if not (src in self.edges and dest in self.edges):
            raise ValueError('Node not in graph')
        else:
            self.edges[src].append(dest)
    def childrenOf(self,node):
        return self.edges[node]
    def hasNode(self,node):
        return node in self.edges
    def getNode(self,name):
        for n in self.edges:
            if n.getName() == name:
                return n
        raise NameError(name)
    def __str__(self):
        result = ''
        for src in self.edges:
            for dest in self.edges[src]:
                result = result + src.getName() +'->'\
                    + dest.getName() + '\n'
        return result[:-1] #omit the final new line

#无向图,只需重写有向图的添加边的方法
class Graph(Digraph):
    def addEdge(self,edge):
        """无向图添加边，两个方向都要添加
        """
        Digraph.addEdge(self,edge)
        rev = Edge(edge.getDestination(),edge.getSource())
        Digraph.addEdge(self,rev)


# 创建简单的航班路线图
def buildCityGraph(GraphType):
    g = GraphType()
    for city in ('Boston','Providence','NewYork','Chicago','Denver','Phoenix','Los Angeles'):
        g.addNode(city)
    g.addEdge(Edge(g.getNode('Boston'),g.getNode('Providence')))
    g.addEdge(Edge(g.getNode('Boston'),g.getNode('NewYork')))
    g.addEdge(Edge(g.getNode('Providence'),g.getNode('Boston')))
    g.addEdge(Edge(g.getNode('Providence'),g.getNode('NewYork')))
    g.addEdge(Edge(g.getNode('NewYork'),g.getNode('Chicago')))
    g.addEdge(Edge(g.getNode('Chicago'),g.getNode('Denver')))
    g.addEdge(Edge(g.getNode('Chicago'),g.getNode('Phoenix')))
    g.addEdge(Edge(g.getNode('Denver'),g.getNode('Phoenix')))
    g.addEdge(Edge(g.getNode('Denver'),g.getNode('NewYork')))
    g.addEdge(Edge(g.getNode('Los Angeles'),g.getNode('Boston')))
    return g

print(buildCityGraph(Digraph))

#下面是计算深度优先搜索路径

#打印路径
def printPath(path):
    """Assumes path is a list of nodes
    """
    result = ''
    for i in range(len(path)):
        result = result + str(path[i])
        if i != len(path) - 1:
            result = result + '->'
    return result

