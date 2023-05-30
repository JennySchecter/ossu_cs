# Hangman game
#

# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)

import random,string

WORDLIST_FILENAME = "words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = loadWords()


def isWordGuessed(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: boolean, True if all the letters of secretWord are in lettersGuessed;
      False otherwise
    '''
    # FILL IN YOUR CODE HERE...
    flag = True
    for i in secretWord:
        flag = flag and (i in lettersGuessed)
    return flag
    
def getGuessedWord(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters and underscores that represents
      what letters in secretWord have been guessed so far.
    '''
    # FILL IN YOUR CODE HERE...
    result_str = secretWord
    for i in secretWord:
        if i not in lettersGuessed:
            result_str = result_str.replace(i,'_ ')
    return result_str

def getAvailableLetters(lettersGuessed):
    '''
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters that represents what letters have not
      yet been guessed.
    '''
    # FILL IN YOUR CODE HERE...
    lower_letter = string.ascii_lowercase
    available_letter = ''
    for i in lower_letter:
        if i not in lettersGuessed:
            available_letter += i
    return available_letter
    

def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE...
    guess_times = 8
    lettersGuessed = []
    available_letter = string.ascii_lowercase

    word_len = len(secretWord)
    secretWordUnserScore = '_ ' * word_len

    print('Welcome to the game, Hangman!\r\n'
        "I am thinking of a word that is %d letters long.\r\n-------------" % (word_len))
    while guess_times >= 1:
        print("You have",guess_times,"guesses left.")
        print("Available letters:",available_letter)
        guess = input('Please guess a letter: ')
        guessInLowerCase = guess.lower()

        # the input must be letters
        if guessInLowerCase not in string.ascii_lowercase:
            print("Wrong input!!!")
            break;
        # append letter to lettersGuessed
        if guessInLowerCase not in lettersGuessed:
            lettersGuessed.append(guessInLowerCase)
        else:
            print("Oops! You've already guessed that letter:",secretWordUnserScore);
            print("-------------");
            continue;

        if guessInLowerCase in secretWord:
            secretWordUnserScore = getGuessedWord(secretWord,lettersGuessed)
            print("Good guess:",secretWordUnserScore)
        else:
            print("Oops! That letter is not in my word: ",secretWordUnserScore)
            guess_times -= 1
        # update available_letter
        available_letter = getAvailableLetters(lettersGuessed)
        print("-------------");  
        
        if isWordGuessed(secretWord,lettersGuessed):
            print("Congratulations, you won!")
            break

    if guess_times < 1:
        print("Sorry, you ran out of guesses. The word was %s. " % (secretWord))
    return ''

        

# When you've completed your hangman function, uncomment these two lines
# and run this file to test! (hint: you might want to pick your own
# secretWord while you're testing)

secretWord = chooseWord(wordlist).lower()
hangman(secretWord)
