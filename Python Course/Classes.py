class Animal():
    def __init__(self):
        print("ANIMAL CREATED")

    def who_am_i(self):
        print("I am an animal")

    def eat(self):
        print("I am eating")


class Dog(Animal):

    def __init__(self):
        Animal.__init__(self)
        print("Dog created")

    def who_am_i(self):
        print("I am a dog!")


def main():

    myanimal = Animal()
    myanimal.eat()

    mydog = Dog()
    mydog.eat()
    mydog.who_am_i()


if __name__ == "__main__":
    main()
