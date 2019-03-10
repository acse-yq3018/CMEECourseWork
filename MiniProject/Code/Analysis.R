#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: Analysis.R
# Description: analysis of miniproject
# Date: Feb 2019

library(plyr)
library(ggplot2)
library(gridExtra)
library(grid)

monthvector  <- c("Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan")

#generate the data to compare the powerlaw model and the downing model
deleteddata <- read.csv(file="../Data/DeleteData.csv", header=TRUE, sep=",")

datatouse <-ddply(deleteddata, c("pond", "treat", "month", "temp", "taxon"),  function(x) {
  sum.count <- sum(x$count, na.rm = true)
  m.bodymass= mean(x$bodymass.g)
  mx.bodymass= max(x$bodymass.g)
  data.frame(abundance = sum.count, mean.bodymass = m.bodymass, max.bodymass= mx.bodymass)
})
biomassfunction <- function(bodymass, abundance){
  bim <- bodymass*0.25*abundance
  return(bim)
}
biomass = biomassfunction(datatouse$mean.bodymass, datatouse$abundance)
datatouse$biomass <- biomass
write.csv(datatouse, file = "../Data/DataToUse.csv")

datatouse <- read.csv(file="../Data/DataToUse.csv", header=TRUE, sep=",")
#############################################################################
# plot the linear regression


pdf("../Graph/as12l.pdf")
ggplot(datatouse, aes(log(mean.bodymass), log(abundance), color = treat)) +
  geom_point(size= 0.2)+ 
  stat_smooth(method = "lm") + 
  labs(x= "log(bodymass)")+
  facet_wrap(~factor(month, levels = monthvector), ncol = 3)
dev.off()

# plot observe and predict data of PL model
fitpl <- lm(log(abundance) ~log(biomass), data = datatouse )
datatouse$predict <- fitted(fitpl)

pdf("../Graph/as12op.pdf",6,6)
ggplot(datatouse, aes(predict, log(abundance), color = treat)) +
  geom_point(size = 0.2)+ 
  labs(x="Predicted log(abundance)",y="Observed log(abundance)") +
  facet_wrap(~factor(month, levels = monthvector), ncol = 3) 
#  geom_abline(intercept = rep(0,12), slope = rep(1,12),color="black",linetype="dashed", size=0.3)
dev.off()

# plot observe and predict data of PD model
fitpd <- lm(log(abundance) ~log(biomass) + log(max.bodymass) + temp, data = datatouse )
datatouse$predict <- fitted(fitpd)
pdf("../Graph/pd12l.pdf", 6, 6)
ggplot(datatouse, aes(predict, log(abundance), color = treat)) +
  geom_point(size= 0.2)+ 
#  geom_abline(intercept = rep(0,12), slope = rep(1,12),color="black",linetype="dashed", size=0.5)+
  labs(x="Predicted log(abundance)",y="Observed log(abundance)") +
  facet_wrap(~factor(month, levels = monthvector), ncol = 3)
dev.off()
######################################################
# function to write the model coefficient
powercoef <- function(inputtreat, inputmonth){
  lmppara <-lm(log(abundance) ~ log(mean.bodymass), data = subset(datatouse, treat == inputtreat & month == inputmonth))
  return(lmppara[[1]]) 
}

downingcoef <- function(inputtreat, inputmonth){
  lmdpara <- lm(log(abundance) ~log(biomass) +log(max.bodymass) + temp, data = subset(datatouse, treat == inputtreat & month == inputmonth))
  return(lmdpara[[1]]) 
}

powercoefwarm <-data.frame()
for(i in monthvector){powercoefwarm <- rbind(powercoefwarm, c(powercoef("Warm", i)))} 
colnames(powercoefwarm) <- c("Intercept", "log.bodymass")
rownames(powercoefwarm) <- monthvector

powercoefcold <-data.frame()
for(i in monthvector){powercoefcold <- rbind(powercoefcold, c(powercoef("Cold", i)))} 
colnames(powercoefcold) <- c("Intercept", "log.bodymass")
rownames(powercoefcold) <- monthvector


p1 <-tableGrob(powercoefwarm)
p2 <-tableGrob(powercoefcold)
pdf("../Graph/ascoef.pdf", 8, 4)
grid.arrange(p1, p2, ncol=2, nrow =1)
dev.off()


pdf("../Graph/ascoefplot.pdf", 7,3)
ggplot() + 
  geom_point(data = powercoefwarm, aes(monthvector,powercoefwarm$log.bodymass), colour = "coral2") + 
  geom_point(data = powercoefcold, aes(monthvector,powercoefcold$log.bodymass), colour = "dodgerblue2") +
  labs(x="month",y="slope")+
  scale_x_discrete(limits = monthvector)
dev.off()

downingcoefwarm <-data.frame()
for(i in monthvector){downingcoefwarm <- rbind(downingcoefwarm, c(downingcoef("Warm", i)))} 
colnames(downingcoefwarm) <- c("Intercept", "log(bodymass)", "log(max.bodymass)", "temperature")
rownames(downingcoefwarm) <- monthvector

downingcoefcold <-data.frame()
for(i in monthvector){downingcoefcold <- rbind(downingcoefcold, c(downingcoef("Cold", i)))} 
colnames(downingcoefcold) <- c("Intercept", "log(bodymass)", "log(max.bodymass)", "temperature")
rownames(downingcoefcold) <- monthvector

d1 <-tableGrob(downingcoefwarm)
d2 <-tableGrob(downingcoefcold)
pdf("../Graph/pdcoef.pdf", 8,8)
grid.arrange(d1, d2, ncol=1, nrow =2)
dev.off()


###########################################################################

#function to calculate aic
poweraic <- function(inputtreat, inputmonth){
  lmppara <-lm(log(abundance) ~ log(mean.bodymass), data = subset(datatouse, treat == inputtreat & month == inputmonth))
  N= nrow(subset(datatouse, treat == inputtreat & month == inputmonth))
  SSR = sum(resid(lmppara)^2)
  aic = N*log((SSR)/N) + 2*2
  return(aic)
}

downingaic <- function(inputtreat, inputmonth){
  lmdpara <- lm(log(abundance) ~log(biomass) +log(max.bodymass) + temp, data = subset(datatouse, treat == inputtreat & month == inputmonth))
  N= nrow(subset(datatouse, treat == inputtreat & month == inputmonth))
  SSR = sum(resid(lmdpara)^2)
  aic = N*log((SSR)/N) + 2*4
  return(aic)
}


powerwarmallaic <-c()
for(i in monthvector){powerwarmallaic <- c(powerwarmallaic, poweraic("Warm", i))} 

powercoldallaic <-c()
for(i in monthvector){powercoldallaic <- c(powercoldallaic, poweraic("Cold", i))} 

downingwarmallaic <-c()
for(i in monthvector){downingwarmallaic <- c(downingwarmallaic, downingaic("Warm", i))} 

downingcoldallaic <-c()
for(i in monthvector){downingcoldallaic <- c(downingcoldallaic, downingaic("Cold", i))} 


paictable <- data.frame(powerwarmallaic, powercoldallaic)
colnames(paictable) <- c("warm AIC", "cold AIC")
rownames(paictable) <- monthvector


daictable <- data.frame(downingwarmallaic, downingcoldallaic)
colnames(daictable) <- c("warm AIC", "cold AIC")
rownames(daictable) <- monthvector

aic1 <-tableGrob(paictable)
aic2 <-tableGrob(daictable)
pdf("../Graph/aic.pdf", 8,4)
grid.arrange(aic1, aic2, ncol=2, nrow =1)
dev.off()

