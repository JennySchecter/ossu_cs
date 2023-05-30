#字典在函数中是被引用的
def fastFib(n,memo = {}):
    """
    Assume n is an int >= 0
    memo only used in recurisive calls
    returns Fibonacci of n
    """
    if n == 0 or n == 1:
        return 1
    try:
        return memo[n]
    except KeyError:
        result = fastFib(n-1,memo) + fastFib(n-2,memo)
        memo[n] = result
        return result

# for i in range(121):
#     print('fib('+ str(i) + ') =',fastFib(i))

def testA(l):
    print(l)
    testB(l)
    print(l)

# 这里l += ['bbb'] 会对l做引用修改，而l =  l + ['bbb'] 则是重新在testB函数内部定义了一个新的l,因此23行打印的l不变。
def testB(l):
    # l += ['bbb']
    l = l + ['bbb']
    l.append('bbb')
    print(l)

testA(['aaa'])