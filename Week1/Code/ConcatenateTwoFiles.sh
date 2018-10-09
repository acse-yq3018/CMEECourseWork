#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Put two files into a file
# Arguments: none
# Date: Oct 2018

#Overwrite file$3 with file$1. 
cat $1 > $3

#Append the contain in of file$2 to file$3
cat $2 >> $3

#Create a new file$3
echo "Merged File is"
cat $3
