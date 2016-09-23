# fibonacci series in cython!
def fib(n):
    """
    Print fibonacci series up to n
    """
    a, b = 0, 1
    while b < n:
        print b,
        a, b = b, a + b
