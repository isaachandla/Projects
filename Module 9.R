#Module 9

##https://difiore.github.io/applied-data-analysis-s2019/module-09/module-09.html

#Concept Review
##Summary statistics: summary(), skim()
##Basic plotting: boxplot(), barplot(), histogram()
##Plotting with {ggplot2}: ggplot(data = , mapping = aes()) + geoms + themes + ...
##Using {dplyr}: select(), filter(), arrange(), rename(), mutate(), summarise(), group_by(), %>%

##R has some very easy to use functions for taking a quick tour of your data. 
##We have seen some of these already (e.g., head(), tail(), and str()), and you
##should always use these right after loading in a dataset to work with. Also useful 
##are dim() to return the number of rows and columns in a data frame, names(), colnames(),
##and sometimes rownames().

##attach() & detach()????????


f <- curl("https://raw.githubusercontent.com/difiore/ADA-2019/master/Country-Data-2016.csv")
d <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
d <- as_tibble(d)  # I like tibbles!
head(d)

names(d)

summary(d)

median(d$area, na.rm = TRUE)
median(d$population, na.rm = TRUE)

d$density <- d$population/d$area
d <- d[order(d$density, decreasing = TRUE), ]  # or
d <- d[order(-d$density), ]
d[1:10, ]


d <- d[order(d$density), ]
d[1:10, ]

s <- d[order(-d$population), ]
s <- s[1:20, ]
med_area <- median(s$area, na.rm = TRUE)
med_pop <- median(s$population, na.rm = TRUE)
med_area
med_pop
s <- d[grep(pattern = "^[A-F]", d$country), ]
summary(s)

mean(s$population, na.rm = TRUE)
mean(s$area, na.rm = TRUE)

##PROBLEM
library(skimr)
library(kableExtra)
s <- skim(d)  # the main `skimr()` function
s <- skim_to_wide(d)  # formats results to a wide table
s %>% select(-type, -n, -n_unique, -empty) %>% kable() %>% kable_styling(font_size = 10)

detach(package:skimr)
detach(package:kableExtra)



##With descr(), dfSummary(), and view() from the {summarytools} package, 
##you can also return nicely formatted tables of summary statistics.

library(summarytools)
s <- descr(d, style = "rmarkdown", transpose = TRUE)
# %>% to view() print nicely formatted table to viewer
s %>% summarytools::view()
# s %>% kable() %>% kable_styling(font_size = 10) # an alternative way to
# view
s <- dfSummary(d, style = "grid", plain.ascii = FALSE)
s %>% summarytools::view()
detach(package:summarytools)


##With makeDataReport() from the {dataMaid} package, you can generate a nicely 
##formated report that gets written to a location of your choice.



library(dataMaid)
# this code below produces a formated report, with the type of report
# specified by `output=`
makeDataReport(d, output = "html", file = "~/Desktop/dataMaid-output.Rmd", replace = TRUE)
detach(package:dataMaid)


##Additionally, the packages {psych}, {pastecs}, and {Hmisc} 
##also all contain functions for producing variable summaries:

psych::describe(d)

pastecs::stat.desc(d)

Hmisc::describe(d)


#Boxplots, Barplots, and Dotcharts

##The boxplot() function from {base} R provides a box-and-whiskers visual 
##representation of the five-number summary plus outliers that go beyond the 
##bulk of the data. The function balks if you pass it nonnumeric data, so you
##may need to reference columns specifically using either double bracket 
##notation or the $ operator.

##The barplot() function is useful for crude data, with bar height 
##proportional to the value of the variable. The function dotchart() 
##provides a similar graphical summary.


par(mfrow = c(1, 2))
d$log_population <- log(d$population)
d$log_area <- log(d$area)
boxplot(d$population, ylab = "Population")
boxplot(d$log_population, ylab = "log(Population)")

boxplot(d$area, ylab = "Area")
boxplot(d$log_area, ylab = "log(Area)")

##Plotting with {ggplot2}
# first, we use `tidyr::gather()` to convert our data from wide to long
# format d_long <- gather(d, key=variable, value=value,
# c('log_population','log_area')) # uncomment this to look at a different
# set of variables d_long <- gather(d, key=variable, value=value,
# c('mammals','birds','reptiles','fishes')) # uncomment this to look at a
# different set of variables
d_long <- gather(d, key = variable, value = value, c("birthrate", "deathrate", 
                                                     "life_expect"))
p <- ggplot(data = d_long, aes(x = factor(0), y = value)) + geom_boxplot(na.rm = TRUE, 
                                                                         outlier.shape = NA) + theme(axis.title.x = element_blank(), axis.text.x = element_blank(), 
                                                                                                     axis.ticks.x = element_blank()) + geom_dotplot(binaxis = "y", stackdir = "center", 
                                                                                                                                                    stackratio = 0.2, alpha = 0.3, color = NA, fill = "red", na.rm = TRUE) + 
  facet_grid(. ~ variable) + geom_rug(sides = "l")
p

p <- ggplot(data = d_long, aes(x = factor(0), y = value)) + geom_violin(na.rm = TRUE, 
                                                                        draw_quantiles = c(0.25, 0.5, 0.75)) + theme(axis.title.x = element_blank(), 
                                                                                                                     axis.text.x = element_blank(), axis.ticks.x = element_blank()) + geom_dotplot(binaxis = "y", 
                                                                                                                                                                                                   stackdir = "center", stackratio = 0.2, alpha = 0.3, color = NA, fill = "red", 
                                                                                                                                                                                                   na.rm = TRUE) + facet_grid(. ~ variable) + geom_rug(sides = "l")
p

#HISTOGRAMS

par(mfrow = c(1, 2))  # # sets up two panels side by side
attach(d)  # lets us use variable names without specifing the data frame!
hist(log(population), freq = FALSE, col = "red", main = "Plot 1", xlab = "log(population size)", 
     ylab = "density", ylim = c(0, 0.2))
hist(log(area), freq = FALSE, col = "red", main = "Plot 2", xlab = "log(area)", 
     ylab = "density", ylim = c(0, 0.2))

hist(log(area), freq = FALSE, col = "red", main = "Plot 2", xlab = "log(area)", 
     ylab = "density", ylim = c(0, 0.2))
abline(v = mean(log(area), na.rm = TRUE))


#Density Plots:The density() function computes a non-parametric estimate of the 
##distribution of a variable, which can be combined with other plots to also yield
##a graphical view of the distribution of the data. If your data have missing values,
##then you need to add the argument na.rm=TRUE to the density() function. 
##To superimpose a density() curve on a histogram, you can use the 
##lines(density()) function.



par(mfrow = c(1, 1))  # set up one panel and redraw the log(population) histogram
hist(log(population), freq = FALSE, col = "white", main = "Density Plot with Mean", 
     xlab = "log(population size)", ylab = "density", ylim = c(0, 0.2))
abline(v = mean(log(population), na.rm = TRUE), col = "blue")
lines(density(log(population), na.rm = TRUE), col = "green")
detach(d)


#Tables
t <- sort(table(d$govt_form), decreasing = TRUE)
t

t <- group_by(d, govt_form) %>% summarize(count = n()) %>% arrange(desc(count))
t


#Multivariate Data

f <- curl("https://raw.githubusercontent.com/difiore/ADA-2019/master/KamilarAndCooperData.csv")
d <- read.csv(f, header = TRUE, stringsAsFactors = FALSE)
d <- as_tibble(d)
attach(d)
head(d)

library(skimr)
library(kableExtra)
s <- skim_to_wide(d)  # formats results to a wide table
# here we make use of the `%>%` operator and {dplyr} verbs... se below
s %>% filter(variable == "Scientific_Name" | type == "numeric") %>% select(-type, 
                                                                           -n, -n_unique, -empty) %>% kable() %>% kable_styling(font_size = 10)
detach(package:skimr)
detach(package:kableExtra)

##Plotting using {base} graphics…

boxplot(log(Body_mass_female_mean) ~ Family, d)
detach(d)

p <- ggplot(data = d, aes(x = Family, y = log(Body_mass_female_mean)))
p <- p + geom_boxplot(na.rm = TRUE)
p <- p + theme(axis.text.x = element_text(angle = 90))
p <- p + ylab("log(Female Body Mass)")
p

#Scatterplots

##Scatterplots are a natural tool for visualizing two continuous variables and can be made easily 
##with the plot(x=<variable 1>, y=<variable 2>) function in {base} graphics (where <variable 1> and
##<variable 2> denote the names of the two variables you wish to plot). Transformations of the variables,
##e.g., log or square root (sqrt()), may be necessary for effective visualization.

attach(d)
par(mfrow = c(1, 2))
plot(x = Body_mass_female_mean, y = Brain_Size_Female_Mean)
plot(x = log(Body_mass_female_mean), y = log(Brain_Size_Female_Mean))

detach(d)


p <- ggplot(data = d, aes(x = log(Body_mass_female_mean), y = log(Brain_Size_Female_Mean), 
                          color = factor(Family)))  # first, we build a plot object and color points by Family
p <- p + xlab("log(Female Body Mass)") + ylab("log(Female Brain Size)")  # then we modify the axis labels
p <- p + geom_point(na.rm = TRUE)  # then we make a scatterplot
p <- p + theme(legend.position = "bottom", legend.title = element_blank())  # then we modify the legend
p  # and, finally, we plot the object

##faceting groups
p <- p + facet_wrap(~Family, ncol = 4)  # wrap data 'by' family into 4 columns
p <- p + theme(legend.position = "none")
p

##regression lines
p <- p + geom_smooth(method = "lm", fullrange = FALSE, na.rm = TRUE)
p

library(car)
scatterplot(data = d, log(Brain_Size_Female_Mean) ~ log(Body_mass_female_mean), 
            xlab = "log(Female Body Mass", ylab = "log(Female Brain Size", boxplots = "xy", 
            regLine = list(method = lm, lty = 1, lwd = 2, col = "red"))


p <- ggplot(data = d, aes(x = log(Body_mass_female_mean), y = log(MaxLongevity_m)))
p <- p + geom_point(na.rm = TRUE)
p <- p + geom_smooth(method = "lm", na.rm = TRUE)
p


##We can use either pairs() function from {base} R, the scatterplotMatrix() function from the {car} 
##package, or the pairs.panel() function from the {psych} package to do multiple scatterplots 
##simulaneously. The ggpairs() function from the {GGally} package can also be used, but it is slower.

s <- select(d, c("Brain_Size_Female_Mean", "Body_mass_female_mean", "MeanGroupSize", 
                 "WeaningAge_d", "MaxLongevity_m", "HomeRange_km2", "DayLength_km"))
pairs(s[, 1:ncol(s)])  # or
pairs(data = s, ~.)


library(car)
scatterplotMatrix(s, smooth = TRUE, regLine = list(method = lm, lty = 1, lwd = 2), 
                  ellipse = TRUE, upper.panel = NULL)
detach(package:car)

library(psych)
pairs.panels(s[], smooth = FALSE, lm = TRUE, method = "pearson", hist.col = "#00AFBB", 
             density = TRUE, ellipses = TRUE)
# method = correlation method denisty = show density curve on histogram
# ellipses = show correlation ellipses NAs are ignored by default
detach(package:psych)# method = correlation method denisty = show density curve on histogram
# ellipses = show correlation ellipses NAs are ignored by default
detach(package:psych)



library(GGally)
ggpairs(s, columns = 1:ncol(s))
# NAs produce a warning
detach(package:GGally)  


library(corrplot)
dev.off()  


cor = cor(s, use = "pairwise.complete.obs")
corrplot.mixed(cor, lower.col = "black", number.cex = 0.7)


#Aggregate Statistics and the {dplyr} Package



##To calculate summary statistics for groups of observations in a data frame, there are
##many different approaches. One is to use the aggregate() function from the {stats} 
##package (a standard package), which provides a quick way to look at summary statistics
##for sets of observations, though it requires a bit of clunky code. Here, we apply a 
##particular function (FUN = "mean") to mean female body mass, grouped by Family.

aggregate(d$Body_mass_female_mean ~ d$Family, FUN = "mean", na.rm = TRUE)

##or...

aggregate(x = d["Body_mass_female_mean"], by = d["Family"], FUN = "mean", na.rm = TRUE)


##Another, MUCH EASIER, way to summarize data is to use the package {dplyr}, which
##provides “a flexible grammar of data manipulation” that includes a set of verbs 
##(select(), filter(), arrange(), rename(), mutate(), group_by(), and summarise())
##that can be used to perform useful operations on data frames and related data
##structures (e.g., data tables and tibble). Before using {dplyr} for summarizing data,
##let’s look in general at what it can do…

s <- filter(d, Family == "Hominidae" & Mass_Dimorphism > 2)
head(s)  # filtering a data frame for certain rows...

s <- select(d, Family, Genus, Body_mass_male_mean)  # selecting specific columns...
head(s)



s <- arrange(d, Family, Genus, Body_mass_male_mean)  
# reordering a data frame by a set of variables... `desc()` can be used to reverse the order
head(s)


s <- arrange(d, Family, Genus, desc(Body_mass_male_mean))
head(s)


s <- rename(d, Female_Mass = Body_mass_female_mean)
head(s$Female_Mass)  # renaming columns...


s <- mutate(d, Binomial = paste(Genus, Species, sep = " "))
head(s$Binomial)  # and adding new columns...

##The {dplyr} package makes it easy to summarize data using more convenient functions than aggregate(). For example:

s <- summarise(d, avgF = mean(Body_mass_female_mean, na.rm = TRUE), avgM = mean(Body_mass_male_mean, 
                                                                                na.rm = TRUE))
s


##The group_by() function from {dplyr} allows us to do apply summary functions to 
##sets of observations defined by a categorical variable, as we did above with 
##aggregate().

byFamily <- group_by(d, Family)
byFamily


s <- summarise(byFamily, avgF = mean(Body_mass_female_mean, na.rm = TRUE), avgM = mean(Body_mass_male_mean, 
                                                                                       na.rm = TRUE))
s


#Chaining
##One other cool thing about the {dplyr} package is that it provides a convenient way 
##to chain together operations on a data frame using the “forward pipe” operator (%>%).
##(Actually, the forward pipe operator comes from the {magrittr} package, which 
##{dplyr} incorporates.)


s <- mutate(d, Binomial = paste(Genus, Species, sep = " ")) %>% select(Binomial, 
                                                                       Family, Body_mass_female_mean, Body_mass_male_mean, Mass_Dimorphism) %>% 
  group_by(Family) %>% summarise(avgF = mean(Body_mass_female_mean, na.rm = TRUE), 
                                 avgM = mean(Body_mass_male_mean, na.rm = TRUE), avgBMD = mean(Mass_Dimorphism, 
                                                                                               na.rm = TRUE)) %>% arrange(desc(avgBMD))
s











