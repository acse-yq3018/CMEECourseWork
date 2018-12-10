#!/usr/bin/env python3

"""clarify foo function"""

__appname__ = 'cfexercises2.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#################################################

import sys

#Functions
def foo1(x):
    """ calculate square root of x"""
    return x ** 0.5

def foo2(x, y):
    """return the larger number"""
    if x > y:
        return x
    return y

def foo3(x, y, z):
    """ align the 3 number from the samllest one"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x):
    """calculate the factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x): # a recursive function
    """calculate the factorial of x embeded function"""
    if x == 1:
        return 1
    return x * foo5(x - 1)

def main(argv):
    """Test functions"""
    print(foo1(2))
    print(foo2(5,8))
    print(foo3(4,6,8))
    print(foo4(5))
    print(foo5(5))
    return 0

if(__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)