#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas and then saves the output into a .csv file
# Arguments: bash tabtocsv.sh ../Sandbox/test.txt
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
mv $1.csv ../Result
echo "Done!"
exit
