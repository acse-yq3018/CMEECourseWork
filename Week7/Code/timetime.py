#!/usr/bin/env python3

"""test the function of timeit"""

__appname__ = 'timetime.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'


##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################
iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

%timeit my_squares_loops(iters)
%timeit my_squares_lc(iters)


##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join

%timeit(my_join_join(iters, mystring))
%timeit(my_join(iters, mystring))