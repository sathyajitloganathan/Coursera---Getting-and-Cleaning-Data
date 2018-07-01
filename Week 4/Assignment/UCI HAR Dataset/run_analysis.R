# Reading all the data from the files
xTrainData <- read.table("./train/X_train.txt")
yTrainData <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")
xTestData <- read.table("./test/X_test.txt")
yTestData <- read.table("./test/y_test.txt")
testSubject <- read.table("./test/subject_test.txt")

# Merging train data components
TrainDataTemp <- cbind(trainSubject,yTrainData)
TrainDataFinal <- cbind(TrainDataTemp,xTrainData)
dim(TrainDataFinal)

# Merging test data components
TestDataTemp <- cbind(testSubject, yTestData)
TestDataFinal <- cbind(TestDataTemp, xTestData)
dim(TestDataFinal)

# Merging train data and test data
allData <- rbind(TrainDataFinal, TestDataFinal)
dim(allData)

# Obtaining names of all the features 
featureNames <- read.table("./features.txt")

# Extracting the features with mean and standard deviation only
ext_features <- featureNames[grepl("mean|std",featureNames$V2),]

library(dplyr)

# Renaming column names
colnames(allData) <- c("subject","activity",as.vector(featureNames$V2))
names(allData)

# Filtering columns bbased on the extracted features
allData <- allData[,c("subject","activity",as.vector(ext_features$V2))]
dim(allData)

# Converting data frame into datatable
allData_dt <- data.table(allData)

# Reading activity labels from activity_labels.txt
activityLabels <- data.table::fread("activity_labels.txt")

colnames(activityLabels) <- c("activity","activitylabel")

dim(allData_dt)
# Merging the activity labels table with the extracted data table
allData_dt <- merge(allData_dt,activityLabels)

# Removing redundant activity column
allData_dt <- select(allData_dt, -activity)
View(allData_dt)

td <- tbl_df(allData_dt)
tidyData <- td %>% group_by(activitylabel,subject) %>% summarize_all(funs(mean))
tidyData
dim(tidyData)
names(tidyData)
tidyData
write.table(tidyData,"./tidyData.txt",row.names=FALSE)

# Creating the CodeBook
library(knitr)
library(rmarkdown)

knit(input = "CodeBook.Rmd")
render(input = "CodeBook.Rmd", output_format = "html_document")

