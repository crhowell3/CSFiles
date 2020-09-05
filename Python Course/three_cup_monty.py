# Simple game to demonstrate interaction with Python functions

from random import shuffle

# INITIAL LIST
cups = ['', 'O', '']


# FUNCTION FOR SHUFFLING CUPS
def shuffle_list(my_list):
    shuffle(my_list)
    return my_list


# FUNCTION FOR GETTING PLAYER'S GUESS
def player_guess():
    guess = ''

    while guess not in ['0', '1', '2']:
        guess = input("Pick a number: 0, 1, or 2: ")

    return int(guess)


# MAIN FUNCTION, VALIDATES GUESS
def main():
    result = shuffle_list(cups)
    index = player_guess()
    if (result[index] == 'O'):
        print("Correct!")
    else:
        print("Wrong")
        print(result)


# DRIVER
if __name__ == "__main__":
    main()
