#!/usr/bin/env python3

"""get all the best match sequence"""

__appname__ = 'align_seqs_better.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

################################################

#Import
import sys

#Set the infile and outfile
infile = "../Data/infile"
outfile = "../Result/best_match_ASB"

#Read lines from infile and set seqq&seq2
with open(infile) as f:
    lines = f.readlines()
    seqs = [ line.strip() for line in lines ]
seq1 = seqs[0]
seq2 = seqs[1]

#Exit if the sequence is less than 2
if len(seqs) < 2:
    sys.exit("Insufficient sequences")
    
# assign the longest sequence s1, and the shortest to s2
# l1 is the length of the longest, l2 that of the shortest

l1 = len(seq1) 
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# function that computes a score
# by returning the number of matches 
# starting from arbitrary startpoint
def calculate_score(s1, s2, l1, l2, startpoint):
    # startpoint is the point at which we want to start
    matched = "" # contains string for alignement
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            # if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    #build some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print("")

    return score

#Test function of calculate_score
calculate_score(s1, s2, l1, l2, 0)
calculate_score(s1, s2, l1, l2, 1)
calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score)
my_best_align = None
my_best_score = -1
best_align_number = 0

#First we find the best score
for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_score = z

#Then we add best_align sequence one by one to the my_best_aligns set
my_best_aligns = set()
for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z == my_best_score:
        my_best_align = "." * i + s2
        best_align_number += 1
        my_best_aligns.add(my_best_align)
        
print(my_best_align)
print(s1)
print("Best score:", my_best_score)

#Write the best lines to outfile        
with open(outfile, 'w') as outf:
    for i in my_best_aligns:
        outf.write(i + '\n')
        outf.write(str(my_best_score) + '\n')

