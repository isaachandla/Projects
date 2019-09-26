#Module 7

##https://difiore.github.io/applied-data-analysis-s2019/module-07/module-07.html

m <- matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)
m
##a matrix is, essentially, a single vector that is split either into multiple columns or multiple rows of the same length.
m <- matrix(data = c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = FALSE)
m
##, set to FALSE by default (note that FALSE is not in quotation marks). This means that the first column of the matrix will be filled first, the second column second, etc.
m <- matrix(data = c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)
m
##change
v1 <- c(1, 2, 3, 4)
v2 <- c(6, 7, 8, 9)
m1 <- rbind(v1, v2)
m1
##binding of same length
m2 <- cbind(v1, v2)
m2
## column bind

class(m1)
class(m2)
dim(m1)
dim(m2)
colnames(m1)
rownames(m1)
colnames(m2)
rownames(m2)
str(m1)
str(m2)
attributes(m1)
attr(m1, which = "dim")
attr(m1, which = "dimnames")[[1]]
attr(m1, which = "dimnames")[[2]]    



#Arrays
a <- array(data = 1:90, dim = c(5, 6, 3))
a
v <- 1:100
v[1:15]
v[c(2, 4, 6, 8, 10)]
v <- 101:200
v[seq(from = 1, to = 100, by = 2)]
m <- matrix(data = 1:80, nrow = 8, ncol = 10, byrow = FALSE)
m
x<- m(4,5)
x <- m[4, 5]
x
#Overwriting elements
##You can replace elements in a vector or matrix, or even entire rows or columns, by identifying the elements to be replaced and then assigning them new values.

m[7, 1] <- 564
m[, 8] <- 2
m[2:5, 4:8] <- 1
m[2:5, 4:8] <- c(20, 19, 18, 17)
m[2:5, 4:8] <- matrix(data = c(20:1), nrow = 4, ncol = 5, byrow = TRUE)
m[, 8] <- c("a", "b")
m

#Lists and dataframes
##A single list, for example, could contain a matrix, vector of character strings, vector of factors, an array, even another list.
s <- c("this", "is", "a", "vector", "of", "strings")  # this is a vector of character string
m <- matrix(data = 1:40, nrow = 5, ncol = 8)  # this is a matrix
b <- FALSE  # this is a boolean variable
l <- list(s, m, b)
l
#Subsetting
##You can reference or extract elements from a list similarly to how you would from other data structure, except that you use double brackets ([[ ]]) to reference a single element in the list.
l[[2]]
l[[2]][2, 6]
l[[2]][2, ]
l[[2]][, 6]
l[2:3]
l[c(1, 3)]
class(l)
str(l)
names(l) <- c("string", "matrix", "logical")
names(l)
l$string
l[["string"]]
l[[2]][3, 5]
l$matrix[3, 5]
l[["matrix"]][3, 5]


#Data frames
df <- data.frame(firstName = c("Rick", "Negan", "Dwight", "Maggie", "Michonne"), 
                 community = c("Alexandria", "Saviors", "Saviors", "Hiltop", "Alexandria"), 
                 sex = c("M", "M", "M", "F", "F"), age = c(42, 40, 33, 28, 31))
df


df <- read.csv(file = "~/Desktop/ML.csv", sep = ",", header = TRUE, 
               stringsAsFactors = FALSE)
# only print select columns of this data frame head() means we will also
# only print the first several rows
head(df[, c(1, 3, 5, 6, 7,10)])
str(df)
# single bracket notation
df[, 4]
str(df[, 4])
# using single bracket notation with a column index and no row index
df[4]
str(df[4])
# using single bracket notation with a column name
df["Country"]
str(df["Country"])


##As with matrixes, you can add rows (additional cases) or columns (additional variables) to a data frame using rbind() and cbind().
##Alternatively, you can extend a data frame by adding a new variable directly using the $ operator, like this:
##Using the [[ ]] operator with a new variable name in quotation marks works, too:
##An expression that evaluates to a logical vector also be used to subset data frames. Here, we filter the data frame for only those rows where the variable school is “UT”.
new_df <- df[df$Category == "General CSR", ]
new_df
new_df <- df[c(1,3,5,6,7)]
new_df
new_df <- df[,c(1,3,5)]
new_df
new_df <- df[, -c(1, 2, 5:18)]
new_df
##We can use a minus sign - in front of a vector of indices to instead indicate columns we do not want to return:


#Data Tables
library(data.table)
dt <- data.table(firstName = c("Rick", "Negan", "Dwight", "Maggie", "Michonne"), 
                 community = c("Alexandria", "Saviors", "Saviors", "Hiltop", "Alexandria"), 
                 sex = c("M", "M", "M", "F", "F"), age = c(42, 40, 33, 28, 31))
dt
str(dt)
# versus...
df <- data.frame(firstName = c("Rick", "Negan", "Dwight", "Maggie", "Michonne"), 
                 community = c("Alexandria", "Saviors", "Saviors", "Hiltop", "Alexandria"), 
                 sex = c("M", "M", "M", "F", "F"), age = c(42, 40, 33, 28, 31))
df
str(df)
##Note that printing a data table results in a slightly different output (e.g., row numbers are printed followed by a “:”) and the structure (str()) looks a bit different. Also, different from data frames, when we read in data, columns of character type are never converted to factors by default (i.e., we do not need to specify anything like stringsAsFactors=FALSE when we read in data… that’s the opposite default as we see for data frames).

The big advantage of using data tables over data frames is that they support a different, easier syntax for filtering rows and selecting columns and for grouping output.
dt[sex == "M"]  # filter for sex = 'M' in a data table
df[df$sex == "M", ]  # filter for sex = 'M' in a data frame
dt[1:2]  # return the first two rows of the data table
df[1:2, ]  # return the first two rows of the data table
dt[, sex]  # returns the variable 'sex'
str(dt[, sex])  # sex is a CHARACTER vector
df[, c("sex")]  # returns the variable 'sex'
str(df[, c("sex")])  # sex is a FACTOR with 2 levels


#Tibbles
library(tibble)
t <- tibble(firstName = c("Rick", "Negan", "Dwight", "Maggie", "Michonne"), 
            community = c("Alexandria", "Saviors", "Saviors", "Hiltop", "Alexandria"), 
            sex = c("M", "M", "M", "F", "F"), age = c(42, 40, 33, 28, 31))
t
str(t)
t[, "age"]
class(t[, "age"])
df[, "age"]
class(df[, "age"])
#There are some other subtle differences regarding the behavior of tibbles versus data frames that are also worthwhile to note. Data frames support “partial matching” in variable names when the $ operator is used, thus df$a will return the variable df$age. Tibbles are stricter and will never do partial matching.
df$a  # returns df$age
t$a  # returns NULL and gives a warning
t <- tibble(a = 1:4, c = 1)  # this works fine... c is recycled
t
# t <- tibble(a=1:4, c=1:2) # but this will throw an error... c is not
# recycled (even though it could fit evenly into the number of row)
df <- data.frame(a = 1:4, c = 1:2)  # by contrast, this latter works for data frames
df
##Creating matrices and arrays: matrix(data=, nrow=, ncol=, byrow=), array(data=, dim=), rbind(), cbind()
##Creating lists: list()
##Creating data frames: data.frame()
##Subsetting: single bracket ([ ]), double bracket ([[ ]]), and $ notation
##Variable coercion: as.numeric(), as.character(), as.data.frame()
##Reading .csv data: read.csv(file=, header=, stringsAsFactors=)
##Filtering rows of a data frame using {base} R: df[df$<variable name> == "<criterion>", ], df[df[["<variable name>"]] == "<criterion>", ]
##Selecting/excluding columns of a data frame: df[ , c("<variable name 1>", "<variable name 2>",...)],df[ , c(<column index 1>, <column index 2>,...)]
