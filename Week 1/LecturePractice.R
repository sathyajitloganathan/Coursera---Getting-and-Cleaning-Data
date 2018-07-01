library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

jsonFile <- toJSON(jsonData, pretty=TRUE)
cat(jsonFile)

# Data.tables lecture
DF = data.frame(x = rnorm(9), y=rep(c("a","b","c"),each=3),z=rnorm(9))
DF[DF$y=="a",]
DF[,c(2,3)]

install.packages("data.table")
library(data.table)
DT = data.table(x = rnorm(9), y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,6)

tables()

class(DT)
DT[,2]
DT[DT$y=="a",]
DT[c(2,6)]
DT[c(2,3)]
DT[,c(2,3)]

{
        x=1
        y=2
}

k = {print(10); 5}
print(k)

DT[,list(mean = mean(x),sum = sum(z))]
DT[,w:=z^2]
DT[,m:={tmp = x+z ; log2(tmp+5) }]
DT[,a:=x>0]
DT[,b:= mean(x+w), by=a]

# Note in data tables a copy isnt made so if one is altered all other objects assigned through <- will 
# be also changed. To prevent this use the copy function 
DTcopy <- DT # DTcopy will change if DT is altered
DTcopy2 <- copy(DT) # DTcopy2 wont have changes if DT is altered
DT[,c:=z>0]


# Special Variable
set.seed(123)
DTa <- data.table(x=sample(letters[1:3],1E5,TRUE))

DTa[, .N, by=x] # faster

table(DTa$x) # slower

# Keys
DTk <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DTk,x)
DTk['a']

#Joins
DT1 <- data.table(x=c("a","a","b","dt1"),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x); setkey(DT2,x)
merge(DT1,DT2)

big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df,file=file,row.names=FALSE,col.names=TRUE,sep="\t",quote=FALSE)

fread(file)

system.time(fread(file)) ## When reading into data table much faster

system.time(read.table(file,header=TRUE,sep="\t")) ## When reading into data frame more than 10 times slower

