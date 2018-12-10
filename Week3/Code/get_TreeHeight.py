#!/usr/bin/env python3

"""calculate treeheight via python"""

__appname__ = 'get_TreeHeight.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#import
import sys
import csv
import math

# read and write csv
f = open(sys.argv[1],'r')
g = open("../Result/" + sys.argv[1].split('.csv')[0].split('/')[-1] +"_treeheights_py.csv",'w')
reader=csv.reader(f)
writer=csv.writer(g)


#function
def main(argv):
    """calculate tree_height"""
    for row in reader:
        if row[0] == 'Species':
            writer.writerow([row[0],row[1],row[2],"Tree.Height.m"])
        else:
            writer.writerow([row[0],row[1],row[2],float(row[1])*math.tan(math.pi/180*float(row[2]))])
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)

f.close()
g.close()
