#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: next.R
# Description: clarify the function of next in R
# Date: Oct 2018

for (i in 1:10) {
  if ((i %% 2) == 0) 
    next # pass to next iteration of loop 
  print(i)
}