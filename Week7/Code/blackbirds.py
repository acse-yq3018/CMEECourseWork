#!/usr/bin/env python3

"""capture specific things in re.findall and present neatly"""

__appname__ = 'blackbirds.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

#import
import re

# Read the file
f = open('../Data/blackbirds.txt', 'r')
text = f.read()
f.close()

# remove \t\n and put a space in:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

# note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform
# to ASCII:
# text = text.decode('ascii', 'ignore') #will not work in python 3

# Now extend this script so that it captures the Kingdom, 
# Phylum and Species name for each species and prints it out to screen neatly.

# Hint: you may want to use re.findall(my_reg, text)...
# Keep in mind that there are multiple ways to skin this cat! 
# Your solution may involve multiple regular expression calls (easier!), or a single one (harder!)

kingdom = re.findall(r'Kingdom\s\w*', text)
phylum = re.findall(r'Phylum\s\w*', text)
species = re.findall(r'Species\s\w*', text)

l = len(kingdom) 

for i in range(j):
	print(kingdom[i], phylum[i], species[i])
