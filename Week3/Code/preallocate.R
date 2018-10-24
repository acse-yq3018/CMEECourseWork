#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: preallocate.R
# Description: clarify the function of system.time
# Date: Oct 2018

a <- NA

pre1 <- function(a){
  for (i in 1:1000000){
    a <- c(a,i) 
}
}


print(system.time(pre1(a)))

b <- NA
pre2 <- function(b){
    b <- rep(NA, 1000000)
  for (i in 1:1000000){
      b[i] <- i
}
}

print(system.time(pre2(b)))