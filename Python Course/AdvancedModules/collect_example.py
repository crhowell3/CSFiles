from collections import Counter
from collections import namedtuple

mylist = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3]
letters = 'aaaabbbbbcccccdddddddd'

print(Counter(mylist))
c = Counter(letters)

c.most_common()


Dog = namedtuple('Dog', ['age', 'breed', 'name'])
sammy = Dog(age=5, breed='Husky', name='Sam')

print(sammy.age)
print(sammy.breed)
print(sammy[0])
