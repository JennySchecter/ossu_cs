def loadFile():
    inFile = open('julytemps.txt')
    high = []
    low = []
    for line in inFile:
        fields = line.split()
        if not fields[0].isdigit() or len(fields) < 3:
            continue
        else:
            high.append(int(fields[1]))
            low.append(int(fields[2]))
    return (low, high)


a = [1,2,3]
b = a.copy()
b.remove(1)
print(a)
print(b)
