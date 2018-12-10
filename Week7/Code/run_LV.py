#!/usr/bin/env python3

"""run LVs at the same time and profile them"""

__appname__ = 'runLV.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#import
import subprocess
import time

#function
def runLV1():
    """run LV1"""
    subprocess.os.system("python3 LV1.py")

def runLV2():
    """run LV2"""
    subprocess.os.system("python3 LV2.py 1.0 0.1 1.5 0.75 3000")

def runLV3():
    """run LV3"""
    subprocess.os.system("python3 LV3.py 1.0 0.1 1.5 0.75 30")

def runLV4():
    """run LV4"""
    subprocess.os.system("python3 LV4.py 1.0 0.1 1.5 0.75 30")

#profile
start = time.time()
runLV1()
print("LV1 takes %f s to run" % (time.time() - start))

start = time.time()
runLV2()
print("LV2 takes %f s to run" % (time.time() - start))

start = time.time()
runLV3()
print("LV3 takes %f s to run" % (time.time() - start))

start = time.time()
runLV4()
print("LV4 takes %f s to run" % (time.time() - start))
