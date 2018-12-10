#!/usr/bin/env Rscript

"""vectorize1 written in python"""

__appname__ = 'vectorize1.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#import
import scipy as sc
import numpy as np
import time

#create a random matrix of 1000*1000
M = np.matrix(np.random.rand(1000,1000))

#function
def SumAllElements(M): 
  """sum all elements of an array"""
  Dimensions = sc.shape(M)
  Tot = 0
  for i in range(Dimensions[0]):
    for j in range(Dimensions[1]):
      Tot = Tot + M[i,j]
  return Tot

# profiling
start = time.time() 
SumAllElements(M) # runs the function
print ("SumAllElements(M) (non vectorized version) takes %f s to run." % (time.time() - start))

start = time.time()
sc.sum(M)
print ("np.sum(M) (vectorized version) takes %f s to run." % (time.time() - start))