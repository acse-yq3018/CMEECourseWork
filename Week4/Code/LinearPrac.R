rm(list = ls())
graphics.off()
library("ggplot2")
library(repr)
options(repr.plot.width=6, repr.plot.height=5) # Change default plot size; not necessary if you are using Rstudio

require("minpack.lm") # for Levenberg-Marquardt nls fitting

powMod <- function(x, a, b) {
  return(a * x^b)
}

MyData <- read.csv("../Data/GenomeSize.csv")
head(MyData)

# wrangle data
Data2Fit <- subset(MyData,Suborder == "Anisoptera")
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),] # remove NA's

# scattor plot
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

# better scatter plot
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point()

PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))

summary(PowFit)

Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200)

coef(PowFit)["a"]
coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)

confint(PowFit)

