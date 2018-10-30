#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: PP_Lattice.R
# Description: create 3 plots and generate a csv
# Date: Oct 2018

# clean the previous workplace
rm(list=ls())
graphics.off()

# loading lattice
library(lattice)

# read data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

# create the 3 plots
pdf("../Result/Pred_Lattice.pdf")
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF, main = "Predator mass by feeding interaction type")
graphics.off()

pdf("../Result/Prey_Lattice.pdf")
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF, main = "Prey mass by feeding interaction type")
graphics.off()

pdf("../Result/SizeRatio_Lattice.pdf")
densityplot(~log(Predator.mass/Prey.mass) | Type.of.feeding.interaction, data=MyDF, main = "Predator-Prey size ratio by feeding interaction type")
graphics.off()

# create the csv
MeanPredatorMass <- tapply(log(MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, mean)
MedianPredatorMass <- tapply(log(MyDF$Predator.mass), MyDF$Type.of.feeding.interaction, median)

MeanPreyMass <- tapply(log(MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, mean)
MedianPreyMass <- tapply(log(MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, median)

MeanSizeRatio <- tapply(log(MyDF$Predator.mass/MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, mean)
MedianSizeRatio <- tapply(log(MyDF$Predator.mass/MyDF$Prey.mass), MyDF$Type.of.feeding.interaction, median)

result <- data.frame(MeanPredatorMass, MedianPredatorMass, MeanPreyMass, MedianPreyMass, MeanSizeRatio, MedianSizeRatio)

write.csv(result, file = "../Result/PP_Results.csv")