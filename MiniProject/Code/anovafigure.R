#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: anovafigure.R
# Description: turn anova table to figure
# Date: Feb 2019

library(gridExtra)

# Read data
af <- read.csv(file="../Data/cbanova.csv", header=TRUE, sep=",")
pdf("../Graph/anova.pdf", 6,2)
grid.table(af, rows = NULL)
dev.off()