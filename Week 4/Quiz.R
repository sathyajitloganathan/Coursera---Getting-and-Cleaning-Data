# Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fp <- file.path(getwd(),"ss06hid.csv")
download.file(url,fp,method="curl")

data <-  read.csv("ss06hid.csv")
data
strsplit(names(data),"wgtp")[[123]] #"" "15"

# Question 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fp <- file.path(getwd(),"FGDP.csv")
download.file(url,fp,method="curl")

data <-  read.csv("FGDP.csv",skip=4, nrows=190, stringsAsFactors=FALSE)
names(data)
data
mean(as.numeric(str_trim(gsub(",","",data$X.4))), na.rm=TRUE)
as.numeric(data$X.4) #377652.4

# Question 3
grep("^United",data$X.3) #3

# Question 4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FGDP <- data.table::fread(url,skip=5,nrows=190)

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
FEDSTATS_Country <- data.table::fread(url2)

names(FGDP)
names(FEDSTATS_Country)

mergeDT <- merge(FGDP,FEDSTATS_Country, by.x = "V1", by.y = "CountryCode")

names(mergeDT)

fye_data <- mergeDT[grep("fiscal year end", tolower(mergeDT$`Special Notes`)),]

fye_and_june_data <- fye_data[grep("june", tolower(fye_data$`Special Notes`)),]

length(fye_and_june_data$`Special Notes`) #13

# Question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

help(package = lubridate)
values2012 <- sampleTimes[year(sampleTimes) == 2012]
sum(year(sampleTimes) == 2012)
sum(wday(values2012) == 2) 
#250, 47
