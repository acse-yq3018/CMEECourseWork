#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: CountLines.sh
# Desc: Count the number of lines in a file
# Arguments: none
# Date: Oct 2018


NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo
