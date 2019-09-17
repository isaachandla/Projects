#Module 7
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
