# Now write a program that calculates the minimum fixed monthly payment needed in order pay off a credit card balance within 12 months. By a fixed monthly payment, we mean a single number which does not change each month, but instead is a constant amount that will be paid each month.

# In this problem, we will not be dealing with a minimum monthly payment rate.

# The following variables contain values as described below:

# balance - the outstanding balance on the credit card

# annualInterestRate - annual interest rate as a decimal

# The program should print out one line: the lowest monthly payment that will pay off all debt in under 1 year, for example:

# Lowest Payment: 180 
# Assume that the interest is compounded monthly according to the balance at the end of the month (after the payment for that month is made). The monthly payment must be a multiple of $10 and is the same for all months. 

def min_payment(balance,annualInterestRate):
    """
    balance - the outstanding balance on the credit card
    annualInterestRate - annual interest rate as a decimal
    mini_payment - the minimum fixed monthly payment needed in order pay off a credit card balance within 12 months
    """
    mini_payment = 10
    # increment = 10
    increment = 0.01
    month = 1
    monthInterestRate = annualInterestRate/12
    original_balance = balance
    while month <=12:
        unpaid_balance = balance - mini_payment
        balance = unpaid_balance + unpaid_balance * monthInterestRate
        if balance <= 0:
            break;
        # 如果第十二个月仍然未还清余额，则调整最小还款额及余额，从第一个月重新循环。
        if month == 12:
            month = 1
            balance = original_balance
            mini_payment += increment
        else:
            month += 1
    return round(mini_payment,2)

print("Lowest Payment:",min_payment(320000,0.2))