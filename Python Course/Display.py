def user_choice():

    choice = 'WRONG'

    while choice.isdigit() == False:

        choice = input("Please enter a number (0-10): ")

    return int(choice)


def main():
    user_choice()


if __name__ == "__main__":
    main()
