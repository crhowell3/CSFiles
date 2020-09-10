def main():
    s = 'hello world'
    print(s.center(20, 'z'))
    print('hello\thi'.expandtabs())
    print(s.isalnum())
    print(s.isalpha())
    print(s.islower())
    print(s.isspace())
    print(s.istitle())
    print(s.isupper())
    print('HELLO'.isupper())
    print(s.endswith('o'))
    print(s[-1] == 'o')


if __name__ == "__main__":
    main()
