set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),]; 
X$var2[c(1,3)] = NA
X

# Subsetting
X[,1]
X[,"var1"]
X[1:2,"var1"]

X[(X$var1 <= 3 & X$var3 >11),]
X[(X$var1 <= 3 | X$var3 > 15),]

X[which(X$var2 >8),]

# Sorting
sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var2)
sort(X$var2,na.last=TRUE)

# Ordering
X[order(X$var1,X$var2),]

# Ordering with plyr
#install.packages("plyr")
library(plyr)
arrange(X,var1)
arrange(X,desc(var2))

# Adding rows or columns to df
X$var4 <- rnorm(5)

Y <- cbind(X,rnorm(5))
Y

### Summarizing data

rest <- read.csv("Restaurants.csv")
head(rest,3)
tail(rest,3)
summary(rest,3)
str(rest)
quantile(rest$councilDistrict, na.rm=TRUE)
quantile(rest$councilDistrict,probs=c(0.5,0.75,0.9), na.rm=TRUE)
table(rest$zipCode, useNA = "ifany")
table(rest$councilDistrict,rest$zipCode, useNA = "ifany")
sum(is.na(rest$councilDistrict))
any(is.na(rest$councilDistrict))
all(rest$zipCode > 0)

colSums(is.na(rest)) # gives number of NA's column wise
all(colSums(is.na(rest))==0)

table(rest$zipCode %in% c('21212'))
table(rest$zipCode %in% c('21212','21213'))

rest[rest$zipCode %in% c('21212','21213'),]

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions) 
summary(DF)

xt <- xtabs(Freq~Gender+Admit,data=DF)
xt

warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks ~. ,data=warpbreaks) # . denotes all other columns
xt
# Making flat tables out of cross tables(xt)
ftable(xt)

# Size of data
fakeData <- rnorm(1E5)
s <- object.size(fakeData)

print(s,units="MB")

### Creating New Variables

s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length=3); s2
s3 <- c(1,3,8,25,100); seq(along=s3)

rest$nearMe <- rest$neighborhood %in% c("Roland Park","Homeland")
table(rest$nearMe)

rest$zipWrong <- ifelse(rest$zipCode < 0,TRUE,FALSE)
table(rest$zipWrong,rest$zipCode < 0)


rest$zipGroups <- cut(rest$zipCode,breaks=quantile(rest$zipCode))
unique(rest$zipGroups)

table(rest$zipGroups)
table(rest$zipGroups,rest$zipCode)

install.packages("Hmisc")
library(Hmisc)
rest$zipGroups <- cut2(rest$zipCode,g=4)
table(rest$zipGroups)

rest$zcf <- factor(rest$zipCode)
rest$zcf[1:10]
class(rest$zcf)

yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac <- factor(yesno,levels=c("yes","no"))
as.numeric(yesnofac)

library(Hmisc); library(plyr)
rest2 <- mutate(rest,zipGroups = cut2(zipCode,g=4)) #  mutate of plyr would alter the existing data frame
table(rest2$zipGroups)

### Reshaping data

library(reshape2)
data(mtcars)
head(mtcars)

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)

cylData <- dcast(carMelt,cyl~variable)
cylData

cylData <- dcast(carMelt,cyl~variable,mean)
cylData

head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum) # summing up counts for each spray type

spIns  = split(InsectSprays$count,InsectSprays$spray)
spIns

sapply(spIns,sum)

sprCount = lapply(spIns,sum)
sprCount
unlist(sprCount) # converts a list to vector

ddply(InsectSprays,.(spray), summarize,sum=sum(count))
ddply(InsectSprays,"spray", summarize,sum=sum(count))

spraySums <- ddply(InsectSprays,.(spray), summarize, sum=ave(count,FUN=sum)); 
dim(spraySums)
spraySums

### dplyr package
install.packages("dplyr")
library(dplyr)

chicago <- readRDS("chicago.rds")
names(chicago)
head(select(chicago,city:dptp))
head(select(chicago,-(city:dptp)))

i <- match("city",names(chicago))
j <- match("dptp",names(chicago))
head(chicago[, -(i:j)])

chic.f <- filter(chicago, pm25tmean2 > 30) 
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)

chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25,na.rm=TRUE))
head(select(chicago,pm25,pm25detrend))

sort(c(TRUE,FALSE))
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold","hot") ))

hotcold <- group_by(chicago, tempcat)
hotcold

summarize(hotcold, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <-  mutate(chicago,year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago,year)

summarize(years, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

# Chaining functions with %>% ; similar to pipeline action
chicago %>% mutate(month=as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, 
na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))


