#背包问题，选择物品的所有情况
def powerSet(items):
    N = len(items)
    # enumerate the 2**N possible combinations 枚举2的N次方的可能组合
    for i in range(2**N):
        combo = []
        for j in range(N):
            # test bit jth of integer i
            if (i >> j) % 2 == 1:
                print(i>>j)
                combo.append(items[j])
        yield combo
items = ['A','B','C','D']
g = powerSet(items)
for i in range(16):
    print(next(g))