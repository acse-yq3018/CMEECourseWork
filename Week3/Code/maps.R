#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: maps.R
# Description: maps the species on the map
# Date: Oct 2018

# load the maps package
library(maps)

# load the gpdd data
load("../Data/GPDDFiltered.RData")

# create a world map
map(database = 'world', resolution = 0)

# superimpose on the map all the locations
points(x= gpdd$long, y= gpdd$lat, pch = 19,  col = 'red')

# Looking at the map, what biases might you expect in any analysis based on the data represented?
# From the plot, we can find out that the species point mainly focused on Europe and Africa and lack of the data in other continents. 
# However, I lack of the knowledge about the data background and I have no idea of the aim of this plot. So I can't really analyse the data.
# I looked into the data and found there are many species while the species is somehow in a mess, including different salmon, fox, grouse and so on.
# From my perspective, what I can do now is to plot different species with different colors separately for there are too many different species. 
# It is also feasible to catagorize the species according to where they live, the sea or the land. Then we can plot again to have a look.