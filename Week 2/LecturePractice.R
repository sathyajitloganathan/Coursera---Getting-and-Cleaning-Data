#### MySQL

install.packages("RMySQL")
library(RMySQL)

# Connecting to server and viewing all databases avvailable
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)
result

# Connecting to hg19 database and viewing tables inside it
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)

length(allTables)

#Connecting to a table of hg19 and viewing its fields
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*) as NoOfReccords from affyU133Plus2")

# Reading from a table
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

# Selecting a specific subset 
install.packages("data.table")
library(data.frame)
df <- data.frame(a=1:3,b=rnorm(3))
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall)

query <- dbSendQuery(hg19,"drop table affyU133Plus2") # Haha cant do that and please dont try anything similar

dbDisconnect(hg19) # Dont forget to close connection

### HDF5
source("https://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library("rhdf5")
created = h5createFile("example.h5")
created
#Create groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","bar")
created = h5createGroup("example.h5","foo/foobar")
h5ls("example.h5")

#Write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobar/B")
h5ls("example.h5")

#Write a dataset (instead of writing to group)
df = data.frame(1L:5L, seq(0,1,length.out=5),c("ab","cde","fghi","a","s"), stringAsFactors=FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

#Reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobar/B")
readdf = h5read("example.h5", "df")
readA
readB
readdf
h5closeAll()

#Writing and reading chunks
h5write(c(12,13,14), "example.h5","foo/A", index = list(1:3,1))
h5read("example.h5","foo/A", index=list(1:3,1))


### Reading from the Web
con <- url("https://soundcloud.com/charts/new?genre=all-music&country=all-countries")
htmlcode <- readLines(con)
close(con)
htmlcode

# Parsing with XML
library(XML)
url <- "https://soundcloud.com/charts/new?genre=all-music&country=all-countries"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html,"//title",xmlValue)

i <- xpathSApply(html,"//p",xmlValue)
i

# GET from the httr package
library(httr)
html2 <- GET(url)
content2 <- content(html2,as="text")
parsedHTML = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHTML,"//title",xmlValue)

# Authenticated websites
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2
names(pg2)

# Using handle
google = handle("http://www.google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

### Reading from API's
myapp = oauth_app("twitter", key="yourConsumerKeyHere", secret="yourConsumerSecret")
sig = sign_oauth1.0(myapp, token="yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL= GET(url,sig) 

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


### Reading from other sources
