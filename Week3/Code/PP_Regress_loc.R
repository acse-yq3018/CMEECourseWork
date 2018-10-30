#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: PP_Regress_loc.R
# Description: calculate regression results sorting by location
# Date: Oct 2018

# clean the previous workplace
rm(list=ls())
graphics.off()

# loading packages
library(ggplot2)
library(plyr)

# read data
MyDF <- as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))

# create figure
MyDFGraph <- ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass, col = Predator.lifestage)) + geom_point(shape = 3) + geom_smooth(method = 'lm', fullrange = TRUE) + 
  facet_grid(Location ~.) +
  scale_y_continuous(trans = "log10") + 
  scale_x_continuous(trans = "log10") + 
  xlab("Prey Mass in grams") + 
  ylab("Predator Mass in grams") + 
  theme_bw() + 
  theme(legend.position="bottom") +
  guides(color = guide_legend(nrow=1))
print(MyDFGraph)


# calculate regression result
cal <- function(x,y) {
  model <- lm(log(x)~log(y))
  sum <- summary(model)
  intercept <- coef(model)[1]
  slope <- coef(model)[2]
  fvalue <- sum$fstatistic[1]
  rsquared <- sum$adj.r.squared
  pvalue <- anova(model)$'Pr(>F)'
  return(c(intercept, slope, fvalue, rsquared,pvalue))
}

modelfit <- ddply(MyDF, c("Predator.lifestage", "Location"), summarise,
                  Intercept = cal(Predator.mass, Prey.mass)[1],
                  Slope = cal(Predator.mass, Prey.mass)[2],
                  fvalue = cal(Predator.mass, Prey.mass)[3],
                  rsquared = cal(Predator.mass, Prey.mass)[4],
                  pvalue = cal(Predator.mass, Prey.mass)[5])

write.csv(modelfit, "../Result/PP_Regress_loc.csv", row.names = F)
