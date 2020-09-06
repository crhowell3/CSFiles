def create_cubes(n):
    for x in range(n):
        yield x**3


def gen_fibon(n):

    a = 1
    b = 1
    for i in range(n):
        yield a
        a, b = b, a+b


# GENERATOR OBJECTS MUST BE ITERATED THROUGH
if __name__ == "__main__":
    for x in create_cubes(100):
        print(x)

    for y in gen_fibon(10):
        print(y)
