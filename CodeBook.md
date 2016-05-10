#Input Dataset

The original dataset (Human Activity Recognition Using Smartphones Data Set) used for this analysis can be
obtained in the following internet address: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

---

##Input Dataset Codebook files

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

---


#Input files from original dataset


* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

* 'train/subject_train.txt' and 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


---

#Analysis


The analysis have been performed using R version 3.2.4 on OS X 10.11.4 (El Capitan). The R script used to do the data analysis is run_analysis.R, more information about the methodology used to run the analysis can me found in the markdown file README.md. 


For information about units, and any other relevant information on the original data please refer to files README.txt and features_info.txt. 


For the purpose of this analysis we have combined the 561-feature vectors with time and frequency domain variables for the training and test datasets and have added the corresponding activity labels and subject identifiers to each observation. 


From this combined dataset we have extracted all the measurements on the mean and standard deviation for each measurement and then created another independent tidy data set with the average of each variable for each activity and each subject. The resulting dataset contains 180 rows and 68 columns (66 features mentioned bellow plus subject and activity).

We have renamed activity labels as well as the "feature names" from the measurements of the mean and standard deviation to make column names more descriptive and easier to manipulate.

Notes: 

* Features are normalized and bounded within [-1,1].

* Each feature vector is a row on the text file.


#Transformed variable names

The mapping from the original variable names to the corresponding "descriptive" variable name is as follows:

##Activities:

* WALKING 				: walking
* WALKING_UPSTAIRS 		: walkingupstairs 
* WALKING_DOWNSTAIRS 	: walkingdownstairs
* SITTING 				: sitting
* STANDING 				: standing
* LAYING				: laying

##Features:

* tBodyAcc-mean()-X				: tbodyacc-mean-x
* tBodyAcc-mean()-Y				: tbodyacc-mean-y
* tBodyAcc-mean()-Z				: tbodyacc-mean-z
* tBodyAcc-std()-X				: tbodyacc-std-x
* tBodyAcc-std()-Y				: tbodyacc-std-y
* tBodyAcc-std()-Z				: tbodyacc-std-z
* tGravityAcc-mean()-X			: tgravityacc-mean-x
* tGravityAcc-mean()-Y			: tgravityacc-mean-y
* tGravityAcc-mean()-Z			: tgravityacc-mean-z
* tGravityAcc-std()-X			: tgravityacc-std-x
* tGravityAcc-std()-Y			: tgravityacc-std-y
* tGravityAcc-std()-Z			: tgravityacc-std-z
* tBodyAccJerk-mean()-X			: tbodyaccjerk-mean-x
* tBodyAccJerk-mean()-Y			: tbodyaccjerk-mean-y
* tBodyAccJerk-mean()-Z			: tbodyaccjerk-mean-z
* tBodyAccJerk-std()-X			: tbodyaccjerk-std-x
* tBodyAccJerk-std()-Y			: tbodyaccjerk-std-y
* tBodyAccJerk-std()-Z			: tbodyaccjerk-std-z
* tBodyGyro-mean()-X			: tbodygyro-mean-x
* tBodyGyro-mean()-Y			: tbodygyro-mean-y
* tBodyGyro-mean()-Z			: tbodygyro-mean-z
* tBodyGyro-std()-X				: tbodygyro-std-x
* tBodyGyro-std()-Y				: tbodygyro-std-y
* tBodyGyro-std()-Z				: tbodygyro-std-z
* tBodyGyroJerk-mean()-X		: tbodygyrojerk-mean-x
* tBodyGyroJerk-mean()-Y		: tbodygyrojerk-mean-y
* tBodyGyroJerk-mean()-Z		: tbodygyrojerk-mean-z
* tBodyGyroJerk-std()-X			: tbodygyrojerk-std-x
* tBodyGyroJerk-std()-Y			: tbodygyrojerk-std-y
* tBodyGyroJerk-std()-Z			: tbodygyrojerk-std-z
* tBodyAccMag-mean()			: tbodyaccmag-mean
* tBodyAccMag-std()				: tbodyaccmag-std
* tGravityAccMag-mean()			: tgravityaccmag-mean
* tGravityAccMag-std()			: tgravityaccmag-std
* tBodyAccJerkMag-mean()		: tbodyaccjerkmag-mean
* tBodyAccJerkMag-std()			: tbodyaccjerkmag-std
* tBodyGyroMag-mean()			: tbodygyromag-mean
* tBodyGyroMag-std()			: tbodygyromag-std
* tBodyGyroJerkMag-mean()		: tbodygyrojerkmag-mean
* tBodyGyroJerkMag-std()		: tbodygyrojerkmag-std
* fBodyAcc-mean()-X 			: fbodyacc-mean-x
* fBodyAcc-mean()-Y 			: fbodyacc-mean-y
* fBodyAcc-mean()-Z				: fbodyacc-mean-z
* fBodyAcc-std()-X				: fbodyacc-std-x
* fBodyAcc-std()-Y				: fbodyacc-std-y
* fBodyAcc-std()-Z				: fbodyacc-std-z
* fBodyAccJerk-mean()-X 		: fbodyaccjerk-mean-x
* fBodyAccJerk-mean()-Y 		: fbodyaccjerk-mean-y
* fBodyAccJerk-mean()-Z 		: fbodyaccjerk-mean-z
* fBodyAccJerk-std()-X 			: fbodyaccjerk-std-x
* fBodyAccJerk-std()-Y 			: fbodyaccjerk-std-y
* fBodyAccJerk-std()-Z			: fbodyaccjerk-std-z
* fBodyGyro-mean()-X			: fbodygyro-mean-x
* fBodyGyro-mean()-Y			: fbodygyro-mean-y
* fBodyGyro-mean()-Z			: fbodygyro-mean-z
* fBodyGyro-std()-X				: fbodygyro-std-x
* fBodyGyro-std()-Y				: fbodygyro-std-y
* fBodyGyro-std()-Z				: fbodygyro-std-z
* fBodyAccMag-mean()			: fbodyaccmag-mean
* fBodyAccMag-std()				: fbodyaccmag-std
* fBodyBodyAccJerkMag-mean()	: fbodybodyaccjerkmag-mean
* fBodyBodyAccJerkMag-std()		: fbodybodyaccjerkmag-std
* fBodyBodyGyroMag-mean()		: fbodybodygyromag-mean
* fBodyBodyGyroMag-std()		: fbodybodygyromag-std
* fBodyBodyGyroJerkMag-mean()	: fbodybodygyrojerkmag-mean
* fBodyBodyGyroJerkMag-std()	: fbodybodygyrojerkmag-std

---

#Output


The output of the analysis is the the file 


* X_MEAN_mean_Mean_std.txt


Each row of this dataset contains:

* Activity label (column 1).

* Subject identifier (column 2).

* Mean value for each summarized variable for the given activity and subject (columns 3 to 68).


The summarized variables are the measurements on the mean and standard deviation for each measurement on the original raw data, i.e., they are the mean of the averages and mean standard deviations broken by activiry and subject.


The output file's first row contains the "descriptive" variable names which can be mapped to the original variable names as described above in the "Features" section.


Note: the units haven't been changed from the original data.
