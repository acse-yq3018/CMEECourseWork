MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF)

# scatter plots
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20) # Change marker
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20, xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels

# histogram
hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count") # include labels
hist(log(MyDF$Predator.mass),xlab="Predator Mass (kg)",ylab="Count", 
     col = "lightblue", border = "pink") # Change bar and borders colors
#? try adjusting the histogram bin widths to make them same for the predator and prey 
#? and making the x and y labels larger and in boldface. 

# subplot
par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log(MyDF$Predator.mass),
     xlab = "Predator Mass (kg)", ylab = "Count", 
     col = "lightblue", border = "pink", 
     main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log(MyDF$Prey.mass),
     xlab="Prey Mass (kg)",ylab="Count", 
     col = "lightgreen", border = "pink", 
     main = 'prey')

# overlaying plots
hist(log(MyDF$Predator.mass), # Predator histogram
     xlab="Body Mass (kg)", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap") 
hist(log(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors
#? It would be nicer to have both the plots with the same bin sizes

# boxplot
boxplot(log(MyDF$Predator.mass), xlab = "Location", ylab = "Predator Mass", main = "Predator mass")
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")

# combining plot types
par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels
par(fig=c(0,0.8,0.4,1), new=TRUE)
boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
par(fig=c(0.55,1,0,0.8),new=TRUE)
boxplot(log(MyDF$Prey.mass), axes=FALSE)
mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)

# lattice
library(lattice)
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)

# saving graphics
pdf("../results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
     xlab="Body Mass (kg)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
     col = rgb(0, 0, 1, 0.5), 
     add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off() # you can also use dev.off()


# high quality graphic
require(ggplot2)

# scatterplots
qplot(Prey.mass, Predator.mass, data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), 
      data = MyDF, colour = "red")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = I("red"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, size = 3) #with ggplot size mapping
qplot(log(Prey.mass), log(Predator.mass),  data = MyDF, size = I(3)) #no mapping
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = 3) #will give error
#? traceback
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape= I(3))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction, alpha = I(.5))

# add smoothers and regression lines
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth")) + geom_smooth(method = "lm")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"), 
      colour = Type.of.feeding.interaction) + geom_smooth(method = "lm")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"),
      colour = Type.of.feeding.interaction) + geom_smooth(method = "lm",fullrange = TRUE)

qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "jitter")

# boxplot
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")

# histogram and density plot
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram")
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction, binwidth = 1)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction, 
      alpha = I(0.5))
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      colour = Type.of.feeding.interaction)

# multi-faceted plots
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets =  .~ Type.of.feeding.interaction, data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets = .~ Type.of.feeding.interaction + Location, 
      data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets = .~ Location + Type.of.feeding.interaction, 
      data = MyDF, geom =  "density")

# logarithmic axes
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy")

# plot annotations
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
      main = "Relation between predator and prey mass", 
      xlab = "log(Prey mass) (g)", 
      ylab = "log(Predator mass) (g)")
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
      main = "Relation between predator and prey mass", 
      xlab = "Prey mass (g)", 
      ylab = "Predator mass (g)") + theme_bw()

# saving plots
pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
            main = "Relation between predator and prey mass", 
            xlab = "log(Prey mass) (g)", 
            ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()


# varlous geom
# load the data
MyDF <- as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))
# barplot
qplot(Predator.lifestage, data = MyDF, geom = "bar")
# boxplot
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "boxplot")
# density
qplot(log(Predator.mass), data = MyDF, geom = "density")
# histogram
qplot(log(Predator.mass), data = MyDF, geom = "histogram")
# scatterplot
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "point")
# smooth
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth")
# lm
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth", method = "lm")


# advanced plotting: ggplot
p <- ggplot(MyDF, aes(x = log(Predator.mass),
                      y = log(Prey.mass),
                      colour = Type.of.feeding.interaction))
p

p + geom_point()

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass), colour = Type.of.feeding.interaction ))
q <- p + geom_point(size=I(2), shape=I(10)) + theme_bw()
q

q + theme(legend.position = "none")

# plot a matrix
require(reshape2)

GenerateMatrix <- function(N){
  M <- matrix(runif(N * N), N, N)
  return(M)
}

M <- GenerateMatrix(10)
Melt <- melt(M)

p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + geom_tile()
p

p + geom_tile(colour = "black")
p + theme(legend.position = "none")

p + theme(legend.position = "none", 
          panel.background = element_blank(),
          axis.ticks = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x = element_blank(),
          axis.title.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.y = element_blank())

p + scale_fill_continuous(low = "yellow", high = "darkgreen")

p + scale_fill_gradient2()

p + scale_fill_gradientn(colours = grey.colors(10))

p + scale_fill_gradientn(colours = rainbow(10))

p + scale_fill_gradientn(colours = c("red", "white", "blue"))
