#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: TAutoCorr.R
# Description: calculate the coefficient and p-value
# Date: Oct 2018

# load the data
load("../Data/KeyWestAnnualMeanTemperature.RData")

# plot the data
png('../Result/TAutoCorrP.png')
plot(ats$Year, ats$Temp)
dev.off()

# calculate the coefficient of keywest annual mean temperature
cor1 <- cor(ats[1:99,2], ats[2:100,2], method = "pearson")

# calculate the random coefficient
cor2 <- rep(NA, 10000)
for (i in 1:10000){
  cor2[i] <- cor(sample(ats[1:99, 2], 99), sample(ats[2:100, 2], 99), method = "pearson")
}

# calculate the p value
p = length(cor2[cor2>cor1])/length(cor2)

# print the person's r value and p value
print("Pearson r value is")
print(cor1)
print("P-value is")
print(p)

