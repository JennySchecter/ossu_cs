def stdDevOfLengths(L):
    """
    L: a list if strings
    returns:float,the standard deviation of the lengths of the strings ,
    or 'NaN' if L is empty.
    """
    if len(L) == 0:
        return float('NaN')
    total_length = 0
    for l in L:
        total_length += len(l)
    mean = total_length/len(L)

    total_square = 0
    for l in L:
        total_square += (len(l) - mean)**2
    return (total_square/len(L))**0.5

import pylab
import random
# dist = []
# for i in range(100000):
#     dist.append(random.gauss(5,1))
# pylab.hist(dist,1000)
# pylab.show()


def noReplacementSimulation(numTrials):
    '''
    Runs numTrials trials of a Monte Carlo simulation
    of drawing 3 balls out of a bucket containing
    3 red and 3 green balls. Balls are not replaced once
    drawn. Returns the a decimal - the fraction of times 3 
    balls of the same color were drawn.
    '''
    # Your code 
    same_color_count = 0
    for trial in range(numTrials):
        L = ['r','r','r','g','g','g']
        draw_ball = []
        for i in range(3):
            ball = random.choice(L)
            draw_ball.append(ball)
            L.remove(ball)
        ball_str = ''.join(draw_ball)
        if ball_str == 'rrr' or ball_str == 'ggg':
            same_color_count += 1
    return same_color_count/numTrials



