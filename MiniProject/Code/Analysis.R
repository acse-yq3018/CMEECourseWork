library(plyr)
library(ggplot2)
library(gridExtra)

# Read data
fixeddata <- read.csv(file="~/Documents/MiniProject/Data/FixedData.csv", header=TRUE, sep=",")
monthvector  <- c("Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan")

#community data
communitydata <-ddply(fixeddata, c("pond", "treat", "month"),  function(x) {
  sum.count <- sum(x$abundance, na.rm = true)
  sum.biomass= sum(x$biomass)
  data.frame(community.abundance = sum.count, community.biomass=sum.biomass)
})

communitydataanalysis <-ddply(communitydata, c("treat", "month"),  function(x) {
  mean.count <- mean(x$community.abundance)
  sd.count <- sd(x$community.abundance, na.rm = FALSE)
  mean.biomass <- mean(x$community.biomass)
  sd.biomass <- sd(x$community.biomass, na.rm = FALSE)
  data.frame(mean.abundance = mean.count, sd.abundance = sd.count, mean.biomass=mean.biomass, sd.biomass = sd.biomass)
})

png("../Graph/CommunityBiomassPlot.png", height = 300, width = 600)
sdbimline <- aes(ymax = communitydataanalysis$mean.biomass + communitydataanalysis$sd.biomass,
                 ymin = communitydataanalysis$mean.biomass - communitydataanalysis$sd.biomass)
ggplot(data=communitydataanalysis, aes(x=month, y=mean.biomass, fill=treat)) +
  geom_bar(stat="identity", position=position_dodge(0.9)) +
  geom_errorbar(sdbimline, position = position_dodge(0.9), width = 0.25, color = "grey")+
  scale_fill_manual("treat", values = c("Cold" = "dodgerblue2", "Warm" = "coral2")) + 
  theme_minimal() +
  scale_x_discrete(limits = monthvector)
dev.off()

##############################################################################

#generate the data to compare the powerlaw model and the downing model
deleteddata <- read.csv(file="~/Documents/MiniProject/Data/DeleteData.csv", header=TRUE, sep=",")

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

datatouse <- read.csv(file="~/Documents/MiniProject/Data/DataToUse.csv", header=TRUE, sep=",")
#############################################################################
# plot the linear regression
plotpower <- function(inputmonth){
  warm <- subset(datatouse, treat == "Warm" & month == inputmonth)
  cold <- subset(datatouse, treat == "Cold" & month == inputmonth)
  ggplot() + 
    geom_point(data = warm, aes(log(mean.bodymass),log(abundance)), colour = "coral2") + 
    geom_point(data = cold, aes(log(mean.bodymass),log(abundance)), colour = "dodgerblue2") +
    stat_smooth(data = warm, aes(log(mean.bodymass),log(abundance)),method = "lm", colour = "coral2") +
    stat_smooth(data = cold, aes(log(mean.bodymass),log(abundance)),method = "lm", colour = "dodgerblue2") +
    labs(x="log(bodymass)",y="log(abundance)") +
    ggtitle(inputmonth)+
    theme(plot.title = element_text(hjust = 0.5))
}
plotpowerall <- lapply(monthvector, plotpower)
png("../Graph/as12l.png", height = 1200, width= 1000)
grid.arrange(grobs = plotpowerall, ncol=3, nrow =4)
dev.off()

#predicted and actual data
powerpredict <- function(inputmonth){
  warm <- subset(datatouse, treat == "Warm" & month == inputmonth)
  cold <- subset(datatouse, treat == "Cold" & month == inputmonth)
  warmfit <- lm(log(abundance) ~log(biomass), data = warm )
  coldfit <- lm(log(abundance) ~log(biomass) + temp, data = cold )
  warm$predict <- fitted(warmfit)
  cold$predict <- fitted(coldfit)
  ggplot() + 
    geom_point(data = warm, aes(predict,log(abundance)), colour = "coral2") + 
    geom_point(data = cold, aes(predict,log(abundance)), colour = "dodgerblue2") +
    labs(x="Predicted log(abundance)",y="Observed log(abundance)") +
    geom_abline(intercept = 0, slope = 1, color="black",linetype="dashed", size=0.5)+
    ggtitle(inputmonth)+
    theme(plot.title = element_text(hjust = 0.5))
}

ppall <- lapply(monthvector, powerpredict)
png("../Graph/as12op.png", height = 1200, width= 1000)
grid.arrange(grobs = ppall, ncol=3, nrow =4)
dev.off()

downingpredict <- function(inputmonth){
  warm <- subset(datatouse, treat == "Warm" & month == inputmonth)
  cold <- subset(datatouse, treat == "Cold" & month == inputmonth)
  warmfit <- lm(log(abundance) ~log(biomass) +log(max.bodymass) + temp, data = warm )
  coldfit <- lm(log(abundance) ~log(biomass) +log(max.bodymass) + temp, data = cold )
  warm$predict <- fitted(warmfit)
  cold$predict <- fitted(coldfit)
  ggplot() + 
    geom_point(data = warm, aes(predict,log(abundance)), colour = "coral2") + 
    geom_point(data = cold, aes(predict,log(abundance)), colour = "dodgerblue2") +
    geom_abline(intercept = 0, slope = 1, color="black",linetype="dashed", size=0.5)+
    labs(x="Predicted log(abundance)",y="Observed log(abundance)") +
    ggtitle(inputmonth)+
    theme(plot.title = element_text(hjust = 0.5))
}

dpall <- lapply(monthvector, downingpredict)
png("../Graph/pd12l.png", height = 1200, width= 1000)
grid.arrange(grobs = dpall, ncol=3, nrow =4)
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
png("../Graph/ascoef.png", height = 300, width= 600)
grid.arrange(p1, p2, ncol=2, nrow =1)
dev.off()

png("../Graph/ascoefplot.png", height = 200, width= 600)
ggplot() + 
  geom_point(data = powercoefwarm, aes(monthvector,powercoefwarm$log.bodymass), colour = "coral2") + 
  geom_point(data = powercoefcold, aes(monthvector,powercoefcold$log.bodymass), colour = "dodgerblue2") +
  labs(x="month",y="slope")
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
png("../Graph/pdcoef.png", height = 600, width= 700)
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
png("../Graph/aic.png", height = 300, width= 600)
grid.arrange(aic1, aic2, ncol=2, nrow =1)
dev.off()

