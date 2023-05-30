def genPrimes():
    n = 2
    primes = []
    while n<10:
        flag = True
        for i in primes:
            if (n % i) == 0:
                flag = False
                break;
        if  flag:
            primes.append(n)
            yield n
        n += 1

p = genPrimes()

print(p.__next__())
print(p.__next__())
print(p.__next__())

