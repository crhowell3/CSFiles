import random


board = ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
player1 = ''
player2 = ''


def display_board(board):
    print(f'   |   |   \n {board[7]} | {board[8]} | {board[9]} \n   |   |   \n-----------\n   |   |   \n {board[4]} | {board[5]} | {board[6]} \n   |   |   \n-----------\n   |   |   \n {board[1]} | {board[2]} | {board[3]} \n   |   |   \n')


def player_input():
    '''
    OUTPUT = (Player 1 marker, Player 2 marker)
    '''
    p_input = "#"
    while not p_input == 'X' and not p_input == 'O':
        p_input = input("Player 1: Do you want to be X or O?: ").upper()

    if p_input == 'X':
        return ('X', 'O')
    else:
        return ('O', 'X')


def place_marker(board, marker, position):
    board[position] = marker
    display_board(board)


def win_check(board, mark):
    return ((board[1] == mark and board[2] == mark and board[3] == mark) or
            (board[4] == mark and board[5] == mark and board[6] == mark) or
            (board[7] == mark and board[8] == mark and board[9] == mark) or
            (board[1] == mark and board[4] == mark and board[7] == mark) or
            (board[2] == mark and board[5] == mark and board[8] == mark) or
            (board[3] == mark and board[6] == mark and board[9] == mark) or
            (board[1] == mark and board[5] == mark and board[9] == mark) or
            (board[7] == mark and board[5] == mark and board[3] == mark))


def choose_first():
    result = random.randint(1, 2)
    if result == 1:
        return "Player 1"
    else:
        return "Player 2"


def space_check(board, position):
    return board[position] == ' '


def full_board_check(board):
    for i in range(1, 10):
        if space_check(board, i):
            return False

    # BOARD IS FULL IF WE RETURN TRUE
    return True


def player_choice(board):

    position = 0

    while position not in [1, 2, 3, 4, 5, 6, 7, 8, 9] or not space_check(board, position):
        position = int(input('Choose a position: (1-9) '))

    return position


def replay():

    choice = input("Play again? Enter Yes or No: ")

    return choice == 'Yes'


def main():
    # WHILE LOOP TO KEEP RUNNING THE GAME
    print('Welcome to Tic Tac Toe!')

    while True:

        player1, player2 = player_input()
        turn = choose_first()
        print(turn + ' will go first')

        play_game = input('Ready to play? y or n? ')

        if play_game == 'y':
            game_on = True
        else:
            game_on = False

        while game_on:

            if turn == 'Player 1':

                position = player_choice(board)
                place_marker(board, player1, position)

                if win_check(board, player1):
                    display_board(board)
                    print('PLAYER 1 HAS WON!!')
                    game_on = False
                else:
                    if full_board_check(board):
                        display_board(board)
                        print("TIE GAME!")
                        break
                    else:
                        turn = 'Player 2'
            else:

                position = player_choice(board)
                place_marker(board, player2, position)

                if win_check(board, player2):
                    display_board(board)
                    print('PLAYER 1 HAS WON!!')
                    game_on = False
                else:
                    if full_board_check(board):
                        display_board(board)
                        print("TIE GAME!")
                        break
                    else:
                        turn = 'Player 1'

        if not replay():
            break


if __name__ == "__main__":
    main()
