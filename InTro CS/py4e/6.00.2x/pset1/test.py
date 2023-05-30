def greedy_cow_transport(cows,limit=10):
    """
    Uses a greedy heuristic to determine an allocation of cows that attempts to
    minimize the number of spaceship trips needed to transport all the cows. The
    returned allocation of cows may or may not be optimal.
    The greedy heuristic should follow the following method:

    1. As long as the current trip can fit another cow, add the largest cow that will fit
        to the trip
    2. Once the trip is full, begin a new trip to transport the remaining cows

    Does not mutate the given dictionary of cows.

    Parameters:
    cows - a dictionary of name (string), weight (int) pairs
    limit - weight limit of the spaceship (an int)
    
    Returns:
    A list of lists, with each inner list containing the names of cows
    transported on a particular trip and the overall list containing all the
    trips
    """
    # TODO: Your code here
    # pass
    sorted_cow = sorted(cows.items(),key = lambda x:x[1], reverse = True)
    cow_name = list(cows.keys())
    transport_list = []
    total_weight,single_trans = 0,[]
    print(sorted_cow)
    while len(cow_name) > 0:
        for i in sorted_cow:
            if (i[0] in cow_name) and total_weight + i[1] <= limit:
                single_trans.append(i[0])
                cow_name.remove(i[0])
                print(single_trans)
        transport_list.append(single_trans)
        total_weight,single_trans = 0,[]
    return transport_list

cows = {'Miss Bella': 15, 'Milkshake': 75, 'Louis': 45, 'Polaris': 20, 'MooMoo': 85, 'Horns': 50, 'Clover': 5, 'Patches': 60, 'Lotus': 10, 'Muscles': 65}
limit = 100
# print(greedy_cow_transport(cows, limit))
print(cows.keys())