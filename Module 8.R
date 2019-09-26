#Module 8
##I will do module 8 here
f <- file.choose()
f
d <- read.table(f, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
head(d)  # shows the first 6 lines of data


d <- read.csv(f, header = TRUE, stringsAsFactors = FALSE)
head(d)


f <- "/Users/isaacchandler/Desktop/Repos/Projects/CPDS-1960-2014-reduced.txt" 
# specfies a local path
d <- read.table(f, header = TRUE, sep = "\t", stringsAsFactors = FALSE, fill = TRUE)  # if fill is left as the default (FALSE) then this will throw an error... if TRUE then in case the rows have unequal length, blank fields are implicitly added
head(d)  # shows the first 6 lines of data
tail(d)
d <- read.delim(f, header = TRUE, stringsAsFactors = FALSE)  # for the `read.delim()` function, fill=TRUE by default
head(d)
library(readr)

f <- "/Users/isaacchandler/Desktop/Repos/Projects/CPDS-1960-2014-reduced.txt"
d <- read_tsv(f, col_names = TRUE)

head(d)
class(d)
d <- read_delim(f, delim = "\t", col_names = TRUE)
head(d)

f <- (file.choose(new = FALSE))
f <- "~/Desktop/Repos/Projects/CPDS-1960-2014-reduced.csv"
f
d <- read_csv(f, col_names = TRUE)  # for comma-separated value files
head(d)

d <- read_delim(f, delim = ",", col_names = TRUE)  # for generic delimited files, where the delimiter is a comma
head(d)

#Loading Excel Files

library(readxl)
f <- file.choose(FALSE)
f
d <- read_excel(f, sheet = 1, col_names = TRUE)
head(d)

str(d)  # `read_excel()` yields a 'tibble'

#Using the {XLConnect} package

library(xlsx)
library(readxl)
file.choose(

)
f <- "/Users/isaacchandler/Desktop/Repos/Projects/Country-Data-2016.xlsx"

d <- read_excel(f, sheet = 1, col_names = TRUE)
head(d)

library(curl)
          
f <- curl("https://raw.githubusercontent.com/difiore/ADA-2019/master/CPDS-1960-2014-reduced.csv")
d <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)   




library(readr)
f <- "https://raw.githubusercontent.com/difiore/ADA-2019/master/CPDS-1960-2014-reduced.csv"
d <- read_csv(f, col_names = TRUE)
head(d)


#Google Sheets
library(googlesheets)
gs_auth()  # opens a browser dialog box to ask for authorization...
gs_ls()  # lists the sheets in your Google Sheets account
s <- gs_title("CPDS-1960-2014-reduced")  # registers this as a Google Sheets spreadsheet
gs_ws_ls(s)  # lists the different worksheets within this spreadsheet
d <- gs_read(s)  # reads data from the spreadsheet
head(d)
str(d)


#Concept Review
##There are lots of ways to get data into R from a variety of sources!
  ##The file.choose() command will allow you to browse the directory structure on your local machine
##The {readr} and {readxl} packages contain probably the most useful functions for reading in most types of delimited data (“.csv”, “.txt”, “.tsv”, “.xlsx”)
##We can read in or download data from remote sites on the web with {curl} or specific packages designed to work with particular hosting sites (e.g., GitHub, Dropbox, Box, Google Sheets, Google Drive)










