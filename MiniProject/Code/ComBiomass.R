#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: Analysis.R
# Description: analysis of miniproject
# Date: Feb 2019

library(plyr)
library(ggplot2)


# Read data
fixeddata <- read.csv(file="../Data/FixedData.csv", header=TRUE, sep=",")
monthvector  <- c("Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan")


#community data
communitydata <-ddply(fixeddata, c("pond", "treat", "month"),  function(x) {
  sum.count <- sum(x$abundance, na.rm = true)
  sum.biomass= sum(x$biomass)
  data.frame(community.abundance = sum.count, community.biomass=sum.biomass)
})
write.csv(communitydata, file = "../Data/CommunityData.csv")


communitydataanalysis <-ddply(communitydata, c("treat", "month"),  function(x) {
  mean.count <- mean(x$community.abundance)
  sd.count <- sd(x$community.abundance, na.rm = FALSE)
  mean.biomass <- mean(x$community.biomass)
  sd.biomass <- sd(x$community.biomass, na.rm = FALSE)
  data.frame(mean.abundance = mean.count, sd.abundance = sd.count, mean.biomass=mean.biomass, sd.biomass = sd.biomass)
})


sdbimline <- aes(ymax = communitydataanalysis$mean.biomass + communitydataanalysis$sd.biomass,
                 ymin = communitydataanalysis$mean.biomass - communitydataanalysis$sd.biomass)

pdf("../Graph/CommunityBiomassPlot.pdf", 8,2)
ggplot(data=communitydataanalysis, aes(x=month, y=mean.biomass, fill=treat)) +
  geom_bar(stat="identity", position=position_dodge(0.9)) +
  geom_errorbar(sdbimline, position = position_dodge(0.9), width = 0.25, color = "grey")+
  scale_fill_manual("treat", values = c("Cold" = "dodgerblue2", "Warm" = "coral2")) + 
  theme_minimal() +
  scale_x_discrete(limits = monthvector)+
  labs(y= "biomass")
dev.off()