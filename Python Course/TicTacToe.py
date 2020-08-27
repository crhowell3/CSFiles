from IPython.display import clear_output
import random


board = ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
player1 = ''
player2 = ''


def display_board(board):
    print(f'   |   |   \n {board[7]} | {board[8]} | {board[9]} \n   |   |   \n-----------\n   |   |   \n {board[4]} | {board[5]} | {board[6]} \n   |   |   \n-----------\n   |   |   \n {board[1]} | {board[2]} | {board[3]} \n   |   |   \n')


def player_input():
    p_input = "#"
    while not p_input == 'X' and not p_input == 'O':
        p_input = input("Do you want to be X or O?: ")


def place_marker(board, marker, position):
    board[position] = marker
    clear_output()
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

    pass


def space_check(board, position):

    pass


def full_board_check(board):

    pass


def player_choice(board):

    pass


def replay():

    pass


def main():
    display_board(board)
    player_input()


if __name__ == "__main__":
    main()
