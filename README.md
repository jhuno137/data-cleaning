# Analysis

The objectives of the analysis are:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The analysis is performed by run_analysis.R

___

## R version, platform and OS
R version 3.2.4 (2016-03-10)  
Platform: x86_64-apple-darwin13.4.0 (64-bit)  
Running under: OS X 10.11.4 (El Capitan)

___

## Data files and codebooks

The dataset can be obtained here:

[Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

More information about the dataset can be obtained in the [Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) website.

The data files used for this analysis are: 

1. activity_labels.txt
2. features.txt
3. train/X_train.txt
4. train/y_train.txt
5. train/subject_train.txt
6. test/X_test.txt
7. test/y_test.txt
8. test/subject_test.txt

### Codebooks:

The original codebooks are:

1. README.txt
2. features_info.txt

Where the path to each file is relative to the unziped data directory. For the purposes of the analysis we will suposse that the current directory is the unziped data directory.

During the analysis preformed by the script *run_analysis.R* both feature names (variable names) and activity text labels are transformed to make variable names and activity values more descriptive and easier to read through transformations such as removing underscores, commas and "()" as well as making text lowercased. In order to update the original codebooks (README.txt and features_info.txt) new updated codebooks have been created. These codebooks are *README2.txt* and *features_info2.txt*

---

## Methodology  

1. Load libraries:  

	```
	library(data.table)     # for fast read (fread)  
    library(plyr)           # for select, mutate, etc  
    library(reshape2)       # for melt and dcast  
    ```

2. Load activity labels from file *activity_labels.txt*, transforming text in order to make labels more descriptive (Objective 3) by:   
    * removing "_"
    * lowercasing text labels  

    ```
    activityLabels <- fread("activity_labels.txt")  
    activityLabels$V2 <- tolower( gsub("_","",activityLabels$V2) )  
    ```
      
3. Load variable names from file *features.txt*  

    ```
    names <- fread("features.txt",select = "V2")  
    names <- names$V2  
    ```
4. For both **training** and **test** data sets (files *train/X_train.txt* and *test/X_test.txt* respectively):
    * Load dataset
    * Add column names (from *features.txt*)
    * Load given activities for the given dataset from files *train/y_train.txt* and *test/y_test.txt* and add new column "activity"" with the given activity data as a factor using levels 1:6 and descriptive activity labels as *factor levels*
    * Load subjects data from files *train/subject_train.txt* and *test/subject_test.txt* and add a new collumn "subject" as a factor  
    
    ```
    train <- fread("train/X_train.txt")  
    names(train) <- names  
    trainActivities <- fread("train/y_train.txt")  
    train <-  
        train %>%  
        mutate(activity =  
                   factor(trainActivities$V1,  
                          levels = activityLabels$V1,   
                          labels = activityLabels$V2)  
               )  
    trainSubject <- fread("train/subject_train.txt")  
    train <- train %>% mutate(subject = factor(trainSubject$V1,levels = 1:30))  
    etc..  
    ```
    
5. Combine both *dataframes* (Objective 1)  
```
phoneData <- rbind(train,test)  
```
6. Extract only the measurements on the mean and standard deviation for each measurement, using the fact that each measurement of mean and standard deviation are in columns containing the strings "mean()" and  "std()" respectively (Objective 2)  
```
phoneMeanStdData <- phoneData %>%  
    select(which(grepl("mean\\(\\)|std\\(\\)|activity|subject",names)))  
```
7. Appropriately label the data set with descriptive variable names (Objective 4) by:
    * lowercasing  
    * removing "()" and ","
    
    ```
    names <- tolower(names)  
    names <- gsub("\\(\\)","",names)  
    names <- gsub(",","-",names)  
    ```
8. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject (Objective 5) using **melt** and **dcast**
```
phoneMelt <- phoneMeanStdData %>% melt(id=c("subject","activity"))  
phoneStatsBySubjectAndActiviry <- phoneMelt %>% dcast(activity+subject~variable,mean)  
```