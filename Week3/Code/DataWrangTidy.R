#!/usr/bin/env Rscript
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: DataWrangTidy.R
# Description: Wrangle the data using dplyr and tidyr
# Date: Oct 2018

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# clean up ###############
rm(list=ls())

############# Import packages ###############
require(dplyr)
require(tidyr)

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Convert data to tbl class ###############
MyData <- tbl_df(MyData)
MyMetaData <- tbl_df(MyMetaData)

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData)
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
MyWrangledData <- TempData %>% gather(., Species, Count, -Cultivation, -Block, -Plot, -Quadrat) %>%
  mutate( Cultivation = as.factor(Cultivation),
          Block = as.factor(Block),
          Plot = as.factor(Plot),
          Quadrat = as.factor(Quadrat),
          Species = as.factor(Species),
          Count = as.numeric(Count))                                                                                                                                                                                                                                                                                                                                                                                                         
str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Start exploring the data (extend the script below)!  ###############
# arrange the data in the catogory of species first, then cultivation
MyexploredData <- arrange(MyWrangledData, Species, Cultivation)
