---
title: "CodeBook"
output: html_document
---



### Tidy Data Set Description

#### Dimensions of the tidy data set

This dataset contains 180 rows and 81 columns.

#### Contents of the data set.

Only the measurements on the mean and standard deviation of the measurement were kept in the tidy data set.
Each row contains the averaged variables of the measurements for each activity and each subject.

#### List of columns of the tidy data set


```r
names(tidyData)
```

```
##  [1] "activitylabel"                   "subject"                        
##  [3] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"              
##  [5] "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
##  [7] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
##  [9] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
## [11] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"            
## [13] "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
## [15] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"          
## [17] "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
## [19] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
## [21] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
## [23] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"              
## [25] "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
## [27] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"         
## [29] "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
## [31] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
## [33] "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
## [35] "tGravityAccMag-mean()"           "tGravityAccMag-std()"           
## [37] "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
## [39] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"             
## [41] "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
## [43] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
## [45] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
## [47] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"               
## [49] "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
## [51] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"          
## [53] "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
## [55] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
## [57] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
## [59] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
## [61] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
## [63] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"              
## [65] "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
## [67] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
## [69] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
## [71] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"         
## [73] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
## [75] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"        
## [77] "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
## [79] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
## [81] "fBodyBodyGyroJerkMag-meanFreq()"
```

#### Sample Content of tidy data set


```r
tidyData
```

```
## # A tibble: 180 x 81
## # Groups:   activitylabel [6]
##    activitylabel subject `tBodyAcc-mean()-X` `tBodyAcc-mean()-Y`
##    <chr>           <int>               <dbl>               <dbl>
##  1 LAYING              1               0.222             -0.0405
##  2 LAYING              2               0.281             -0.0182
##  3 LAYING              3               0.276             -0.0190
##  4 LAYING              4               0.264             -0.0150
##  5 LAYING              5               0.278             -0.0183
##  6 LAYING              6               0.249             -0.0103
##  7 LAYING              7               0.250             -0.0204
##  8 LAYING              8               0.261             -0.0212
##  9 LAYING              9               0.259             -0.0205
## 10 LAYING             10               0.280             -0.0243
## # ... with 170 more rows, and 77 more variables:
## #   `tBodyAcc-mean()-Z` <dbl>, `tBodyAcc-std()-X` <dbl>,
## #   `tBodyAcc-std()-Y` <dbl>, `tBodyAcc-std()-Z` <dbl>,
## #   `tGravityAcc-mean()-X` <dbl>, `tGravityAcc-mean()-Y` <dbl>,
## #   `tGravityAcc-mean()-Z` <dbl>, `tGravityAcc-std()-X` <dbl>,
## #   `tGravityAcc-std()-Y` <dbl>, `tGravityAcc-std()-Z` <dbl>,
## #   `tBodyAccJerk-mean()-X` <dbl>, `tBodyAccJerk-mean()-Y` <dbl>,
## #   `tBodyAccJerk-mean()-Z` <dbl>, `tBodyAccJerk-std()-X` <dbl>,
## #   `tBodyAccJerk-std()-Y` <dbl>, `tBodyAccJerk-std()-Z` <dbl>,
## #   `tBodyGyro-mean()-X` <dbl>, `tBodyGyro-mean()-Y` <dbl>,
## #   `tBodyGyro-mean()-Z` <dbl>, `tBodyGyro-std()-X` <dbl>,
## #   `tBodyGyro-std()-Y` <dbl>, `tBodyGyro-std()-Z` <dbl>,
## #   `tBodyGyroJerk-mean()-X` <dbl>, `tBodyGyroJerk-mean()-Y` <dbl>,
## #   `tBodyGyroJerk-mean()-Z` <dbl>, `tBodyGyroJerk-std()-X` <dbl>,
## #   `tBodyGyroJerk-std()-Y` <dbl>, `tBodyGyroJerk-std()-Z` <dbl>,
## #   `tBodyAccMag-mean()` <dbl>, `tBodyAccMag-std()` <dbl>,
## #   `tGravityAccMag-mean()` <dbl>, `tGravityAccMag-std()` <dbl>,
## #   `tBodyAccJerkMag-mean()` <dbl>, `tBodyAccJerkMag-std()` <dbl>,
## #   `tBodyGyroMag-mean()` <dbl>, `tBodyGyroMag-std()` <dbl>,
## #   `tBodyGyroJerkMag-mean()` <dbl>, `tBodyGyroJerkMag-std()` <dbl>,
## #   `fBodyAcc-mean()-X` <dbl>, `fBodyAcc-mean()-Y` <dbl>,
## #   `fBodyAcc-mean()-Z` <dbl>, `fBodyAcc-std()-X` <dbl>,
## #   `fBodyAcc-std()-Y` <dbl>, `fBodyAcc-std()-Z` <dbl>,
## #   `fBodyAcc-meanFreq()-X` <dbl>, `fBodyAcc-meanFreq()-Y` <dbl>,
## #   `fBodyAcc-meanFreq()-Z` <dbl>, `fBodyAccJerk-mean()-X` <dbl>,
## #   `fBodyAccJerk-mean()-Y` <dbl>, `fBodyAccJerk-mean()-Z` <dbl>,
## #   `fBodyAccJerk-std()-X` <dbl>, `fBodyAccJerk-std()-Y` <dbl>,
## #   `fBodyAccJerk-std()-Z` <dbl>, `fBodyAccJerk-meanFreq()-X` <dbl>,
## #   `fBodyAccJerk-meanFreq()-Y` <dbl>, `fBodyAccJerk-meanFreq()-Z` <dbl>,
## #   `fBodyGyro-mean()-X` <dbl>, `fBodyGyro-mean()-Y` <dbl>,
## #   `fBodyGyro-mean()-Z` <dbl>, `fBodyGyro-std()-X` <dbl>,
## #   `fBodyGyro-std()-Y` <dbl>, `fBodyGyro-std()-Z` <dbl>,
## #   `fBodyGyro-meanFreq()-X` <dbl>, `fBodyGyro-meanFreq()-Y` <dbl>,
## #   `fBodyGyro-meanFreq()-Z` <dbl>, `fBodyAccMag-mean()` <dbl>,
## #   `fBodyAccMag-std()` <dbl>, `fBodyAccMag-meanFreq()` <dbl>,
## #   `fBodyBodyAccJerkMag-mean()` <dbl>, `fBodyBodyAccJerkMag-std()` <dbl>,
## #   `fBodyBodyAccJerkMag-meanFreq()` <dbl>,
## #   `fBodyBodyGyroMag-mean()` <dbl>, `fBodyBodyGyroMag-std()` <dbl>,
## #   `fBodyBodyGyroMag-meanFreq()` <dbl>,
## #   `fBodyBodyGyroJerkMag-mean()` <dbl>,
## #   `fBodyBodyGyroJerkMag-std()` <dbl>,
## #   `fBodyBodyGyroJerkMag-meanFreq()` <dbl>
```

