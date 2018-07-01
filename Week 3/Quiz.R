#Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fp <- file.path(getwd(),"ss06hid.csv")
download.file(url,fp,method="curl")

data <- read.csv("ss06hid.csv",header=TRUE)
names(data)
str(data)

agricultureLogical <- data$ACR == 3 & data$AGS == 6

which(agricultureLogical) # 125, 238,262

#Question 2
install.packages("jpeg")
library(jpeg)
library(readJPEG)
?jpeg
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
fp <- file.path(getwd(),"jeff.jpg")
download.file(url,fp,method="curl")
imageData <- readJPEG("jeff.jpg", native=TRUE)
quantile(imageData, seq(0,1,by=0.1)) #-15259150 -10575416

#Question 3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FGDP <- data.table::fread(url,skip=5,nrows=190)

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
FEDSTATS_Country <- data.table::fread(url2)

names(FGDP)
names(FEDSTATS_Country)

mergeDT <- merge(FGDP,FEDSTATS_Country, by.x = "V1", by.y = "CountryCode")

dim(mergeDT)
names(mergeDT)

arrange(mergeDT,desc(V2))$"Short Name"[13] #189 matches, 13th country is St. Kitts and Nevis

#Question 4
mergeDT %>% 
        group_by(`Income Group`) %>%
        summarize(mean(V2))
                print
# 32.96667, 91.91304

#Question 5
mergeDT$Groups <- cut(mergeDT$V2,breaks=5)
tab <- table(mergeDT$Groups,mergeDT$`Income Group`) #5

