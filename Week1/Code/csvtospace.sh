#!/bin/bash
# Author:Yuxin Qin yq3018@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in the files with tabs
# Arguments: 1-> tab delimited file
# Date: Oct 2018

echo "Creating a tabs delimited version of $1 ..."
cat $1 | tr -s "," " " >> $1.txt
echo "Done!"
exit