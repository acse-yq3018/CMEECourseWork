#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: break.R
# Description: clarify the break function in R
# Date: Oct 2018

i <- 0 #Initialize i
while(i < Inf) {
  if (i == 20) {
    break 
  } # Break out of the while loop! 
  else { 
    cat("i equals " , i , " \n")
    i <- i + 1 # Update i
  }
}
