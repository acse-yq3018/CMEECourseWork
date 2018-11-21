#!/usr/bin/env python3

"""run LV1 and LV2 at the same time"""

__appname__ = 'runLV.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

import subprocess
import time

def runLV1():
    """run LV1"""
    subprocess.os.system("python3 LV1.py")

def runLV2():
    """run LV2"""
    subprocess.os.system("python3 LV2.py 1. 0.1 1.5 0.75 3000")

start = time.time()
runLV1()
print("LV1 takes %f s to run" % (time.time() - start))

start = time.time()
runLV2()
print("LV2 takes %f s to run" % (time.time() - start))
