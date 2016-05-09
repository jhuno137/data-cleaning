# Author : Antonio Camacho
# GitHub : jhuno137
# Created : May 7, 2016
#
# Objectives : 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Download dataset to the current directory (uncoment if requited)
# fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# tmpFile <- tempfile()
# download.file(url=fileUrl,destfile = tmpFile,method = "curl")
# unzip(zipfile = tmpFile,exdir = ".") # unzip
# unlink(tmpFile)  # remove zip file

library(data.table)     # for fast read (fread)
library(plyr)           # for select, mutate, etc
library(reshape2)       # for melt and dcast

# load activity labels
activityLabels <- fread("activity_labels.txt")

# using descriptive activity names to name the activities in 
# the data set by removing underscores and lowercasing (Objective 3)
activityLabels$V2 <- tolower( gsub("_","",activityLabels$V2) )

# load variable names
names <- fread("features.txt",select = "V2")
names <- names$V2

# Load training data
train <- fread("train/X_train.txt")

# set variable names for training data
names(train) <- names

# load activities for training data
trainActivities <- fread("train/y_train.txt")
# set activity variable as a factor
train <- 
    train %>% 
    mutate(activity = 
               factor(trainActivities$V1,
                      levels = activityLabels$V1, # 1:6
                      labels = activityLabels$V2) # standing, walking, etc
           )

# load and set subjects used for training data as a factor variable
trainSubject <- fread("train/subject_train.txt")
train <- train %>% mutate(subject = factor(trainSubject$V1,levels = 1:30))

# Repeat same steps as for training data
test <- fread("test/X_test.txt")
names(test) <- names
testActivities <- fread("test/y_test.txt")
test <- 
    test %>%
    mutate(
        activity=factor(
            testActivities$V1,
            levels = activityLabels$V1,
            labels = tolower(activityLabels$V2))
        )

testSubject <- fread("test/subject_test.txt")
test <- test %>% mutate(subject=factor(testSubject$V1,levels = 1:30))

# combine datasets (Objective 1)
phoneData <- rbind(train,test)
# note: we have added to more columns (activity and subject)
names <- names(phoneData) # updating names

# extract only the measurements on the mean and standard 
# deviation for each measurement (Objective 2) while keeping
# columns activity and subject which we will using later on
phoneMeanStdData <- phoneData %>% 
    select(which(grepl("mean\\(\\)|std\\(\\)|activity|subject",names)))

names <- names(phoneMeanStdData) # again need to update names

sum(duplicated(names)) # 0

# cleanup names and make them descriptive (Objective 4)
names <- tolower(names)             # lowercase
names <- gsub("\\(\\)","",names)      # remove "()"
names <- gsub(",","-",names)        # replace "," by "-"

#reassign column names to phoneMeanStdData
names(phoneMeanStdData) <- names

# tidy data set with the average of each variable 
# for each activity and each subject (Objective 5)
phoneMelt <- phoneMeanStdData %>% melt(id=c("subject","activity"))
phoneStatsBySubjectAndActivity <- phoneMelt %>% dcast(activity+subject~variable,mean)

# save dataset for later use
write.table(phoneStatsBySubjectAndActivity,"X_MEAN_mean_Mean_std.txt",row.name=FALSE)

