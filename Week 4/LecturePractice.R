cameraData <- read.csv("./BFSC.csv")
names(cameraData)
tolower(names(cameraData))

splitNames <- strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]][1]

mylist <-  list(letters = c("A","b","c"), numbers = 1:3, matrix(1:25,ncol=5))
mylist[[1]]
mylist$letters


firstElement <- function(x) {x[1]}
sapply(splitNames, firstElement)

# sub and gsub
testName <- "this_is_a_test"
sub("_","",testName) # only first instance is replaced
gsub("_","",testName) # all instances of the mentioned pattern is replaced

# grep and grepl

grep("Alameda",cameraData$intersection) #grep grabs indices of cells which contain the pattern
table(grepl("Alameda",cameraData$intersection)) # grepl return true if the pattern exists else false

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

grep("Alameda",cameraData$intersection, value=TRUE) #Returns the value of the instead of index if value = TRUE

grep("Alameda",cameraData$intersection)

length(grep("RobinStreet",cameraData$intersection))

# Other String functions
library(stringr)
nchar("Sathyajit Loganathan")
substr("Sathyajit Loganathan",1,9)
paste("Sathyajit","Loganathan")
paste("Sathyajit","Loganathan",sep="+")
paste0("Sathyajit","Loganathan")
str_trim("  Sath..     ")

text <- "sadfe d aa dad a daaa adavhj"

grep("^s(.*?)s",text, value=FALSE) 


### Date Class

d1 <- date()
d1
class(d1)

d2 <- Sys.Date()
d2
class(d2)

format(d2,"%a, %b, %d")
# %a - Weekday, %b - abbreviated month, %d - day as a number

x <- c("1jan1960","2jan1960","31mar1960","30jul1960")
z <- as.Date(x,"%d%b%Y")
z
z[1]-z[2]
as.numeric(z[1]-z[2])

weekdays(d2)
months(d2)
julian(d2) # days since origin

install.packages("lubridate")
library(lubridate)
ymd('19500101')
mdy('01201960')
dmy("24-021982")

ymd_hms("2011-08-19 13:34:23",tz="Pacific/Auckland")

x = dmy(c("1jan1960","2jan1960","31mar1960","30jul1960"))

wday(x[1])
wday(x[1],label=TRUE)
