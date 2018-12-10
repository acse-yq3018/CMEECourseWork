#!/usr/bin/env python3

"""example of debug using %pdb"""

__appname__ = 'debugme.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#################################################

def createabug(x):
    """just a function will get errors"""
    y = x**4
    z = 0.
    y = y/z
    return y

createabug(25)