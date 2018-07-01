## Question 1
#install.packages("jsonlite")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)


oauth_endpoints("github")

# Change based on what you have
myapp <- oauth_app(appname = "appNameHere",
                   key = "appKeyHere",
                   secret = "appSecretHere")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] #2013-11-07T13:25:07Z

## Question 2
install.packages("sqldf")
library(sqldf)
library("RMySQL")
# Either load the drive to SQLite or detach other existing drivers
# options(sqldf.driver = "SQLite") # This could be used instead of having to type in 
# drv = "SQLite" each time sqldf is used

detach("package:RMySQL", unload=TRUE) # I had this loaded so i detached it

fp <- file.path(getwd(), "acs.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",fp)
acs <- data.table::data.table(read.csv(fp))

?sqldf

sqldf("select pwgtp1 from acs where AGEP < 50", drv="SQLite") 
# sqldf("select pwgtp1 from acs where AGEP < 50")

## Question 3 
b <- unique(acs$AGEP)
d <- sqldf("select distinct AGEP from acs") # Answer
length(d[[1]])
length(b)

## Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode <- readLines(con)
close(con)
htmlcode
nchar(htmlcode[c(10,20,30,100)]) # 45 31 7 25

## Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
colWidths <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3) # Based on the spaces and lengths of the columns
colNames <- c("S", "WEEK", "S", "SSTNINO12", "S", "SSTANINO12", 
              "S", "SSTNINO3", "S", "SSTANINO3", "S", "SSTNINO34", "S", 
              "SSTANINO34", "S", "SSTNINO4", "S", "SSTANINO4")
# S denotes a space and the remaining their respective names

data <- read.fwf(url, colWidths, header = FALSE, skip = 4, col.names = colNames)
names(data)
sum(data[,"SSTNINO3"]) #32426.7
 