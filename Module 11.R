#Module 11 - Probability and Distributions

##{manipulate} allows us to create an interactive 
##plot that lets us dynamically change something about the values being plotted. 

outcomes <- c(1, 2, 3, 4, 5, 6)
manipulate(hist(sample(x = outcomes, size = n, replace = TRUE), breaks = c(0.5, 
                                                                           1.5, 2.5, 3.5, 4.5, 5.5, 6.5), probability = TRUE, main = paste("Histogram of Outcomes of ", 
                                                                                                                                           n, " Die Rolls", sep = ""), xlab = "roll", ylab = "probability"), n = slider(0, 
                                                                                                                                                                                                                        1000000, initial = 100, step = 100))
nrolls <- 1000
roll <- function(x) {
  sample(1:6, x, replace = TRUE)
}
two_dice <- roll(nrolls) + roll(nrolls)
hist(two_dice, breaks = c(1.5:12.5), probability = TRUE, main = "Rolling Two Dice",
     xlab = "sum of rolls", ylab = "probability")
