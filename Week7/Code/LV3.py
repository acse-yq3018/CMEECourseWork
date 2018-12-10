#!/usr/bin/env python3

"""draw Lotka-Volterra model with different formula"""

__appname__ = 'LV3.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#import
import sys
import scipy as sc
import matplotlib.pylab as p

#function
def dCR_dt(pops, t=0):
    """ define the model """
    # Initiate an array to store the results
    N = sc.zeros((t,2), dtype = float)
    N[0,0] = pops[0]
    N[0,1] = pops[1]
    for i in range(t-1):
        N[i+1,0] = N[i,0]*(1+r*(1-(N[i,0]/K))-a*N[i,1])
        N[i+1,1] = N[i,1]*(1-z+e*a*N[i,0])
    return N

#dictate parameters
if len(sys.argv) ==6:
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
    K = float(sys.argv[5])
else:
    r = 1.0
    a = 0.1
    z = 1.5
    e = 0.75
    K = 30

#time
t = 100

#initial population
R0 = 10 #resource per unit area
C0 = 5  #consumer per unit area
RC0 = sc.array([R0, C0]) 

#return results of the function as an array
pops = dCR_dt(RC0, t)

#plot
f1 = p.figure()

p.plot(range(t), pops[:,0], 'g-', label='Resource density')
p.plot(range(t), pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.annotate('r=%r, a=%r, z=%r, e=%r, K=%r' %(r,a,z,e,K), xy=(0.5,0.5))

f1.savefig('../Result/LV3_model1.pdf')
p.close(f1)

f2 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Cosumer density')
p.title('Consumer-Resource population dynamics')
p.annotate('r=%r, a=%r, z=%r, e=%r, K=%r' %(r,a,z,e,K), xy=(10.5,0.1))

f2.savefig('../Result/LV3_model2.pdf')
p.close(f2)
