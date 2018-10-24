#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: TreeHeight.R
# Description: calculate the treeheight
# Date: Oct 2018


# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# clean up
rm(list=ls())

# read the data
MyData <- read.csv("../Data/trees.csv", header = TRUE) # import with headers

# Calculate the function
TreeHeight <- function(Angle.degrees, Distance.m){
  radians <- Angle.degrees * pi / 180
  height <- Distance.m * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}
TreeHts = TreeHeight(MyData[,3],MyData[,2])

# create a new colun in my data
MyData$Tree.Height.m <- TreeHts

# write a new csv
write.csv(MyData, "../Result/TreeHts.csv") 