#!/usr/bin/env python3

"""clarify sys.argv"""

__appname__ = 'sysargv.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

################################################

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))