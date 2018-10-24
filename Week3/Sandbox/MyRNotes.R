# matrix
mat <- matrix (1:25,5,5,byrow = TRUE)
mat
dim(mat) #get the size of the matrix



# array
arr <- array(1:50, c(5,5,2))
arr
arr[,,1]
arr[,,2]



# dara frames
Col1 <- 1:10
Col1
Col2 <- LETTERS[1:10]
Col2
Col3 <- runif(10) #10 random numbers from a uniform distribution
Col3
MyDF <- data.frame(Col1, Col2, Col3)
print(MyDF)
names(MyDF) <- c("MyFirstColumn", "My Second Column", "My.Third.Column")
MyDF
MyDF$MyFirstColumn
MyDF$My Second Column
colnames(MyDF)
colnames(MyDF)[2] <- "MySecondColumn"
MyDF
MyDF$My.Third.Column
MyDF[,1]
MyDF[1,1]
MyDF[c("MyFirstColumn","My.Third.Column")] # show two specific columns only
class(MyDF)
str(MyDF) # structure of r project
head(MyDF)
tail(MyDF)
# factor
a <- as.factor(c(1,2,3,4))
a
class(a)
levels(a)
class(MyDF$MySecondColumn)
MyDF$MySecondColumn <- as.character(MyDF$MySecondColumn)
class(MyDF$MySecondColumn)
str(MyDF)


# lists
MyList <- list(species=c("Quercus robur","Fraxinus excelsior"), age=c(123, 84))
MyList
MyList[1]
MyList[[1]]
MyList[["species"]]
MyList$species
MyList$species[1]


# sequence
years <- 1990:2009
years
years <- 2009:1990 # or in reverse order 
years
seq(1, 10, 0.5)
seq(from=1,to=10, by=0.5)
seq(from=1, by=0.5, to=10)


# index
MyVar <- c( 'a' , 'b' , 'c' , 'd' , 'e' )
MyVar[1]
MyVar[4] 
MyVar[c(3,2,1)]
MyVar[c(1,1,5,5)]

v <- c(0, 1, 2, 3, 4)
v[3]
v[1:3] 
v[-3] # remove elements
v[c(1, 4)] 

mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #create a matrix
mat1
mat1[1,2]
mat1[1,2:4]
mat1[1:2,2:4]
mat1[1,] 
mat1[,1]


#recycle
a <- c(1,5) + 2
a
x <- c(1,2); y <- c(5,3,9,2)
x;y
x + y
x + c(y,1)


# vector-matrix operation
v <- c(0, 1, 2, 3, 4)
v2 <- v*2 # multiply whole vector by 2
v2
v * v2
t(v)
v %*% t(v) # matrix/vector product
v3 <- 1:7 # assign using sequence
v3
v4 <- c(v2, v3) # concatenate vectors
v4


# strings and pasting
species.name <- "Quercus robur" #You can alo use single quotes
species.name
paste("Quercus", "robur")
paste("Quercus", "robur",sep = "") #Get rid of space
paste("Quercus", "robur",sep = ", ") #insert comma to separate
paste('Year is:', 1990:2000)


# random number
rnorm(10, m=0, sd=1)
dnorm
qnorm
runif
rpois


