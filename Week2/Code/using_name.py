#!/usr/bin/env python3

"""clarify the __name__ == '__main__' """

__appname__ = 'using_name.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'


if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')