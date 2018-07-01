# Question 1
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file_url,"./quiz.csv")

dt <- fread("quiz.csv")

dt[,"VAL"]
table(dt$VAL) # 53
dt[,.N,by=dt$VAL] # 53

#Question 2
dt$FES  #Tidy data has one variable per column.

# Question 3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, "./ng.xlsx", method="curl")
install.packages("xlsx")
library(xlsx)
dat <- read.xlsx("ng.xlsx",sheetIndex=1, colIndex=7:15,rowIndex=18:23)

sum(dat$Zip*dat$Ext,na.rm=T) #36534720

# Question 4
# use http instead of https
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
install.packages("XML")
library(XML)
doc <- xmlTreeParse(url,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xpathSApply(rootNode,"//name",xmlValue)
rests <- xpathSApply(rootNode,"//row[zipcode = 21231]",xmlValue)
length(rests) #127

#Question 5
install.packages("data.table")
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,"dt.csv")
dt <- fread("dt.csv")
# fastest
system.time(dt[,mean(pwgtp15),by=SEX])
