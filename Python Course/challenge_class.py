class Account:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance

    def deposit(self, amount):
        self.balance = self.balance + amount
        print(f"Added {amount} to the balance")

    def withdrawal(self, amount):
        if (self.balance >= amount):
            self.balance = self.balance - amount
            print(f"Withdrawal accepted")
        else:
            print(f"Not enough funds!")

    def __str__(self):
        return f"Owner: {self.owner}\nBalance: {self.balance}"


def main():
    a = Account("Cam")
    a.deposit(500)
    print(a)
    a.withdrawal(100)
    print(a)
    a.withdrawal(1000)


if __name__ == "__main__":
    main()
