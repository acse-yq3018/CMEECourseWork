#!/usr/bin/env python3

"""find oaks and output it"""

__appname__ = 'oaks_debugme.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

####################################################
#Import
import csv
import sys
import pdb
import doctest

#Define is_an_oak function and doctest
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
    >>> is_an_oak('Quercus robur')
    True

    >>> is_an_oak('Pinus Sylvestris')
    False

    >>> is_an_oak('Quercuss')
    False"""
    return name.lower().split()[0] == 'quercus' #make thename lower class first, then split it to strings and pick the first string

# Define the main function
def main(argv):
    """write all the oaks into a csv"""
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Result/JustOaksData.csv','w')
    
    taxa = csv.reader(f)
    next(taxa) # Start reading the csv from the second line
    
    csvwrite = csv.writer(g)
    csvwrite.writerow(['Genus', 'Species']) # Write genus and species in the first line
   
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0])
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])  
        else:
            print('NOT AN OAK!\n')
    return 0

# To run with embedded tests 
doctest.testmod()   

# Check status and exit
if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
