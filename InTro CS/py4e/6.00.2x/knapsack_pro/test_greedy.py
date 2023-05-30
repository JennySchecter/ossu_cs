import greedy_algorithm as ga;
import brute_force_algorithm as bfa;

names = ['wine','beer','pizza','burger','fires','cola','apple','dount','cake']
values = [89,90,95,100,90,79,50,10]
calories = [123,154,258,354,365,150,95,195]
foods = ga.buildMenu(names,values,calories)
ga.testGreedys(foods,750)
print('')
bfa.testMaxVal(foods,750)