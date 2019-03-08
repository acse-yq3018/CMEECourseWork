library(plyr)

# Read Original data
Originaldata <- read.csv(file="~/Documents/MiniProject/Data/RawData.csv", header=TRUE, sep=",")

# to check the shape name
as.data.frame(table(Originaldata$shape, Originaldata$equation))
# to turn all the shape name into lower class
shape_rename <- tolower(Originaldata$shape)
Originaldata$shape <- shape_rename

# to check whether equation fit the shape
as.data.frame(table(Originaldata$shape, Originaldata$equation))
# some of the equation do not match the shape, need to be remodify
# d= diameter h= height
equation <- shape_rename 
equation <- replace(equation, equation=="cone", "v=pi/12*d^2*h") #checked
equation <- replace(equation, equation=="cylindrical", "v=pi/4*(d^2)*h") #changed to correct
equation <- replace(equation, equation=="double.cone", "v=pi/6*(d^2)*h/2") #checked
equation <- replace(equation, equation=="ellipsoid.of.revolution", "v=pi/6*d*d/2*h") #should be right  
equation <- replace(equation, equation=="general.ellipsoid", "v=pi/6*d*d/2*h") #should be right
equation <- replace(equation, equation=="oblate.spheroid ", "v=pi/6*(d^2)*h") #should be right
equation <- replace(equation, equation=="parallelpiped", "v=3/4*(h^2)*d") # why 3/4
equation <- replace(equation, equation=="prolate.spheroid", "v=pi/6*(d^2)*h") # checked
equation <- replace(equation, equation=="spherical", "v=pi/6*(d^3)") #changed to correct
Originaldata$equation <- equation 

# to set a new column of equation that fit length and width
equation.fit <- shape_rename 
equation.fit <- replace(equation.fit, equation.fit=="cone", "v=pi/12*(length^2)*width")
equation.fit <- replace(equation.fit, equation.fit=="cylindrical", "v=pi/4*(length^2)*width")
equation.fit <- replace(equation.fit, equation.fit=="double.cone", "v=pi/6*(length^2)*width/2")
equation.fit <- replace(equation.fit, equation.fit=="ellipsoid.of.revolution", "v=pi/6*length*length/2*width")
equation.fit <- replace(equation.fit, equation.fit=="general.ellipsoid", "v=pi/6*length*length/2*width")
equation.fit <- replace(equation.fit, equation.fit=="oblate.spheroid ", "v=pi/6*(length^2)*width")
equation.fit <- replace(equation.fit, equation.fit=="parallelpiped", "v=3/4*(width^2)*length")
equation.fit <- replace(equation.fit, equation.fit=="prolate.spheroid", "v=pi/6*(length^2)*width")
equation.fit <- replace(equation.fit, equation.fit=="spherical", "v=4/3*pi*((length+width)/2)^3 ")
Originaldata$equation.fit <- equation.fit 

# calculate the biovolume
biovolumefunction <- function(shape, length, width){
  if(shape == "cone"){
    bv <- pi/12*(length^2)*width
    return(bv)
  }
  if(shape == "cylindrical"){
    bv <- pi/4*(length^2)*width
    return(bv)
  }
  if(shape == "double.cone"){
    bv <- pi/6*(length^2)*width/2
    return(bv)
  }
  if(shape == "ellipsoid.of.revolution"){
    bv <- pi/6*length*length/2*width
    return(bv)
  }
  if(shape == "general.ellipsoid"){
    bv <- pi/6*length*length/2*width
    return(bv)
  }
  if(shape == "oblate.spheroid"){
    bv <- pi/6*(length^2)*width
    return(bv)
  }
  if(shape == "parallelpiped"){
    bv <- 3/4*(width^2)*length
    return(bv)
  }
  if(shape == "prolate.spheroid"){
    bv <- pi/6*(length^2)*width
    return(bv)
  }
  if(shape == "spherical"){
    bv <- 4/3*pi*((length+width)/2)^3
    return(bv)
  }
}
biovolume = biovolumefunction(Originaldata$shape, Originaldata$length, Originaldata$width)
Originaldata$biovolume <- biovolume

# calculate the bodymass mg
bodymassfunction <- function(biovolume){
  bom <- biovolume*0.14*1.1
  return(bom)
}
bodymass = bodymassfunction(Originaldata$biovolume)
Originaldata$bodymass.mg <- bodymass

# calculate the biomass mg
biomassfunction <- function(bodymass){
  bim <- bodymass*0.25
  return(bim)
}
biomass = biomassfunction(Originaldata$bodymass)
Originaldata$biomass.mg <- biomass

# calculate the bodymass g
bodymassgfunction <- function(bodymass){
  bomg <- bodymass/1000000
  return(bomg)
}
bodymassg = bodymassgfunction(Originaldata$bodymass)
Originaldata$bodymass.g <- bodymassg

# calculate the biomass g
biomassgfunction <- function(biomass){
  bimg <- biomass/1000000
  return(bimg)
}
biomassg = biomassgfunction(Originaldata$biomass)
Originaldata$biomass.g <- biomassg

# refill some blanks in temperature
checktempvancancy <- subset(Originaldata, month == "Feb" & treat == "Warm" & pond == 9)
Originaldata$temp[972:1053] <- 9.3
Originaldata$temp[22781:22783] <- 9.3
Originaldata$temp[22806] <- 9.3
Originaldata$temp[18221] <- 9.3
write.csv(Originaldata, file= "../Data/CalData.csv")

######################################################################################
# read calculated data
caldata <- read.csv(file="~/Documents/MiniProject/Data/CalData.csv", header=TRUE, sep=",")

# check spherical data (according to analysis I did, there is something wrong with the spherical ones)
sph <- subset(caldata, shape == "spherical")
checksphfunction <- function(length, width){
  lw<- abs(length-width)
  return(lw)
}
lengthwidth = checksphfunction(sph$length, sph$width)
sph$lengthminuswidth <- lengthwidth
suspect <- subset(sph, lengthminuswidth > 50)
xtodelete <- as.vector(suspect$X)

#delete the abnormal data
deleteddata <- caldata
for(i in xtodelete){
deleteddata <- subset(deleteddata, X != i)
}
write.csv(deleteddata, file= "../Data/DeleteData.csv")

deleteddata <- read.csv(file="~/Documents/MiniProject/Data/DeleteData.csv", header=TRUE, sep=",")

#fixed data
fixeddata <-ddply(deleteddata, c("pond", "treat", "month", "temp","sample", "group", "family", "genus", "species", "feeding", "taxon"),  function(x) {
  sum.count <- sum(x$count, na.rm = true)
  sum.bodymass= mean(x$bodymass.g)
  data.frame(abundance = sum.count, bodymass= sum.bodymass)
})
biomassfunction <- function(bodymass, abundance){
  bim <- bodymass*0.25*abundance
  return(bim)
}
biomass = biomassfunction(fixeddata$bodymass, fixeddata$abundance)
fixeddata$biomass <- biomass
write.csv(fixeddata, file = "../Data/FixedData.csv")

