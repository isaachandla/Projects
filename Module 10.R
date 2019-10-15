#Module 10: Central Tendency and Variance

##https://difiore.github.io/applied-data-analysis-s2019/module-10/module-10.html



##The objective of this module is to review the fundamental concepts of central 
##tendency and variance, which are crucial for describing data and for statistical
##hypothesis testing.

##Measures of Central Tendency
##Mode – the most common measurement of values observed
##Median – the middle value in a rank ordered series of values
##Mean – the sum of measured values divided by n, a.k.a., the average or the arithimetic mean
##Harmonic mean – the reciprocal of the average of the reciprocals of a set of values

##Geometric mean: a measure of central tendency for processes that are multiplicative 
##rather than additive = the nth root of the product of the values, taken across a set 
##of n values; for the mathematically inclined, it also equals the antilog of the
##averaged log values


x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 100, 200, 1000)
gm1 <- function(x) {
  prod(x)^(1/length(x))
}
gm1(x)


gm2 <- function(x) {
  exp(mean(log(x)))
}
gm2(x)



#What happens if you have NAs or zeros or negative numbers in the vector?
  
  #HINT: The argument na.rm = TRUE and the function na.omit() may help you write more generic functions.



#Measures of Spread
##A measure of spread or variability in a dataset is the one of the most 
##important summary statistics to calculate. The total range (min to max) is
##one measure of spread, as is the interquartile range (25th to 75th quartile). 
##As we’ve seen, these are both part of the five-number summary and are returned 
##by summary() and related functions.


##Sum of Squares = the sum of the squared deviations of a set of values from the mean of that set

ss1 <- function(x) {
  sum((x - mean(x))^2)
}
ss1(x)
# This is equivalent to...
ss2 <- function(x) {
  sum(x^2) - length(x) * mean(x)^2
}
ss2(x)


##A shortcut to calculate the sum of squares that does not require 
##calculating mean(x) is the (sum of the squared values in the dataset)
##minus the (square of the summed values / n). Thus, another formula for 
##the sum of squares is the following:

ss3 <- function(x) {
  sum(x^2) - (sum(x))^2/length(x)
}
ss3(x)

##The sum of squares increases with sample size… you can see this by adding more data 
##points to your vector. To be able to compare across data sets, we are then more 
##interested in the average deviation of values from the mean rather than the straight
##sum of squares, i.e., a mean squared deviation.


##This is the definition of the variability or variance in a dataset. 
##If we are simply interested in describing the mean squared deviation in a population, 
##where we have a value or measurement for every case (e.g., the femur length of all
##of the gorillas in a musuem population), we could then just divide the sum of squares
##by the number of cases.

##Population Variance = sum of squares / N

pop_v <- function(x) {
  sum((x - mean(x))^2)/(length(x))
}
pop_v(x)

x <- 1:100

pop_v(x)


##sample: Sample Variance 
##(an estimator of the population variance) = sum of squares / (n - 1)

##In this formula, n - 1 is the number of degrees of freedom implied by the sample. 

sample_v <- function(x) {
  sum((x - mean(x))^2)/(length(x) - 1)
}
sample_v(x)

var(x)

#Interesting Questions to Ask:
  ##For a random variable, how is variance related to sample size? To explore this and at the same time learn a bit about loops and flow control in R programming…
#[1] Set up a new plot:
plot(c(0, 100), c(0, 15), type = "n", xlab = "Sample size", ylab = "Variance")

#[2] Create a random variable drawn from a normal distribution using the rnorm() 
##function. We will use for loops to do this for samples of size 5, 10, 15… up to 
##100, with 50 replicates at each size. The structure for for loops is:

for (n in seq(5, 100, 5)) # samples of 5, 10, 15...
{
  for (i in 1:50) # 50 replicates
  {
    x <- rnorm(n, mean = 10, sd = 2)
    points(n, var(x))
  }
}



#How does Sample Variance compare to Population Variance? 
#What happens to the sample variance as sample size increases?


##Another measure of spread around a mean that we often see reported is the standard 
##deviation. The standard deviation is simply the square root of the variance. 
##The advantage of using the standard deviation as a statistic or parameter is that 
##the units of standard deviation are the same as the units of our original measurement
##(rather than being units squared, which are our units for variance).




x <- rnorm(1000, mean = 10, sd = 2)
pop_sd <- function(x) {
  sqrt(pop_v(x))
}
pop_sd(x)

sample_sd <- function(x) {
  sqrt(sample_v(x))
}
sample_sd(x)

#The built-in R function sd() can be used to calculate the standard deviation of a sample.

sd(x)

#Using Measures of Spread
##The standard error of the mean, based on a sample, can thus be defined as follows (all of the following are equivalent):
  
 ## SE mean = square root of the average sample variance
#or

##SE mean = square root of (sample variance / number of observations)
#or

##SE mean = (sample standard deviation) / square root of (number of observations)

se1 <- function(x) {
  sqrt(sample_v(x)/length(x))
}
se1(x)

se2 <- function(x) {
  sqrt(var(x)/length(x))
}
se2(x)

se3 <- function(x) {
  sd(x)/sqrt(length(x))
}
se3(x)


##he package {sciplot} includes the function, se(), for calculating standard errors (as do others).

library(sciplot)
se(x)


#Calculating Confidence Intervals using Standard Errors

set.seed(1)
x <- rnorm(10000, mean = 0, sd = 1)
hist(x, main = "Histogram of Random Draws from a Normal Distribution\nwith Mean = 0 and SD = 1")


set.seed(1)
x <- rnorm(10000, mean = 10, sd = 3)
hist(x, main = "Histogram of Random Draws from a Normal Distribution\nwith Mean = 10 and SD = 3")

mean <- 0
sd <- 1
curve(dnorm(x, mean = mean, sd = sd), from = mean - 4 * sd, to = mean + 4 * 
        sd, n = 1000, type = "l", xlab = "# SD away from mean", ylab = "Density")


curve(pnorm(x, mean = mean, sd = sd), from = mean - 4 * sd, to = mean + 4 * 
        sd, n = 1000, type = "l", xlab = "# SD away from mean", ylab = "Cumulative Probability")

curve(qnorm(x, mean = mean, sd = sd), from = 0, to = 1, n = 1000, type = "l", 
      xlab = "Quantile", ylab = "# SD away from mean")


x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
m <- mean(x)
n <- length(x)
v <- var(x)
s <- sd(x)  # or...
s <- sqrt(v)
e <- sqrt(v/n)  # st error of the mean based on our sample
supper <- mean(x) + qnorm(0.975, mean = 0, sd = 1) * se(x)
lower <- mean(x) + qnorm(0.025, mean = 0, sd = 1) * se(x)  # or lower <- mean(x) - qnorm(0.975)*se(x)
ci <- c(lower, upper)
ci


#or

upper <- mean(x) + qnorm(0.975, mean = 0, sd = 1) * e
lower <- mean(x) + qnorm(0.025, mean = 0, sd = 1) * e  # or lower <- m - qnorm(0.975)*e
ci <- c(lower, upper)
ci


normalCI = function(x, CIlevel = 0.95) {
  upper = mean(x) + qnorm(1 - (1 - CIlevel)/2) * sqrt(var(x)/length(x))  # mean + critical value * the st error of the mean
  lower = mean(x) + qnorm((1 - CIlevel)/2) * sqrt(var(x)/length(x))  # mean - critical value * the st error of the mean
  ci <- c(lower, upper)
  return(ci)
}
# or...
normalCI = function(x, CIlevel = 0.95) {
  ci = mean(x) + c(-1, 1) * qnorm(1 - (1 - CIlevel)/2) * sqrt(var(x)/length(x))
  return(ci)
}

normalCI
#Interpretation of CIs:
  
  ##Based on the given data (with a particular mean, variance, and sample size),
##we are (for the 95% CI) 95% confident that the true mean of the population lies 
##between the lower and upper bounds.
 ##The mean of a repeated sample of the same size drawn from this same underlying
##distribution is expected to fall into this interval 95% of the time.


#Calculating Confidence Intervals by Bootstrapping
##An alternative (and arguably better) way to calculate a confidence interval 
##for a given statistic is by simulation, which does not make any assumptions 
##baout the underlying distribution from which the random variable is drawn. Here, 
##we use the sample() function to sample, with replacement, 15 numbers from our vector 
##x a total of 10000 times.

sim <- NULL  # sets up a dummy variable to hold our 10000 simulations
n <- 15
for (i in 1:10000) {
  sim[i] <- mean(sample(x, n, replace = TRUE))
}
hist(sim, xlab = "Mean of x", main = "Distribution of Means of Simulated Samples")
abline(v = mean(sim), col = "blue", lwd = 3)  # mean of our simulated samples
abline(v = mean(x), col = "red", lwd = 3)  # mean of our actual vector x
ci <- normalCI(x, 0.95)  # call our CI function
abline(v = ci[1], col = "red")  # calculated lower ci bound based on the se of our vector and assuming that our observations are drawn from a normal distribution
abline(v = ci[2], col = "red")  # calculated upper ci bound based on the se of our vector and assuming that our observations are drawn from a normal distribution
text(x = ci[1] - 0.25, y = 1000, "lower CI based on normal distribution", col = "red", 
     srt = 90, pos = 3)
text(x = ci[2] + 0.25, y = 1000, "upper CI based on normal distribution", col = "red", 
     srt = 90, pos = 3)
quantile(sim, c(0.025, 0.975))  # the quantile() function returns the value of x for a specified quantile


abline(v = quantile(sim, 0.025), col = "blue")  # lower ci bound inferred by simulation
abline(v = quantile(sim, 0.975), col = "blue")  # upper ci bound inferred by simulation
text(x = quantile(sim, 0.025) + 0.25, y = 1000, "lower CI based on simulation", 
     col = "blue", srt = 90, pos = 3)
text(x = quantile(sim, 0.975) - 0.25, y = 1000, "upper CI based on simulation", 
     col = "blue", srt = 90, pos = 3)


##The quantile() function returns, for a particular set of simulated data, the observations satisfying the nth quantile, which can be used to define the lower and upper bounds for the confidence interval around the mean of our variable, x.
























