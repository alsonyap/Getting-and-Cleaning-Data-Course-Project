# Project Code Book
The purpose of this code book aims to provide information through several sections: 

* **Study design** : Where the data is retrieved and its background information. 

* **Code book** : Explanation of the variables and its units.  

* **Operations performed** : Tasks performed according to the project instructions to make it tidy and the summaries calculated.  

* **License**

## Study Design

The data that is used has been provided by Coursera at this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The file is unzipped and stored in the default working directory for further operations. 

***

> Background

_The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data._  

_The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain._ 

***

From the data provided, we would only be using the vector of 561 features that was calculated from the variables in the time and frequency domain.

Further information on these features selection are found in the *'features_info.txt'* file.  

> Features Selection

***

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.* 

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).*

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).* 

*These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.*

***

Hence, the files which contain the datasets that we need are:

* *features_info.txt: Shows information about the variables used on the feature vector.*

* *features.txt: List of all features.*

* *activity_labels.txt: Links the class labels with their activity name.*

* *train/X_train.txt: Training set.*

* *train/y_train.txt: Training labels.*

* *test/X_test.txt: Test set.*

* *test/y_test.txt: Test labels.*

* *train/subject_train.txt & train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.*

## Code Book

The variables in the features vector have been **normalized and bounded within [-1,1].**

All features belong under these categories:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

They have subcategories such as mean (mean value), std (standard deviations), mad (median absolute deviation), max (largest value in array), etc. which have been calculated.

However, for this project's task, we are only interested in the mean and std subcategories.

## Operations Performed

To summarize the operations performed to achieve the goals of the project in layman terms:

1. Read in the data into variables which are named similarly as the corresponding files' name.
2. Merge the test and train datasets into one single data set.
3. The headers of the combined dataset are added descriptively via the list found in the _features.txt_ file.
4. Extracts only the feature columns that represent measurements of mean and std only.
5. Added an extra column for subjects to represent which observation rows belong to which subjects.
6. A second column of integers ranging from 1:6 is added as labels for the activities performed for each observation, which made use of the files *y_test.txt* and *y_train.txt*
7. Using this second column, we are able to descriptively change these numeric labels into descriptive words via the usage of the file *activity_labels.txt* through the *merge* command.

The next few steps after will describe the operations performed for the task described in Step 5.

8. Splits the final tidied data above into 30 data frames by subjects.
9. Using a *for* loop to run through all 30 data frames, the features measurements of mean and std are separated by the 6 activities, and thereafter averaged.
10. Results are then collected into one single variable, with each column now representing the values of averaged measurements for a particular activity and a particular subject.
11. Two columns (Activity and Subjects) are then created for labelling of the observation rows in the compiled result.
12. The final result is then represented as a data frame and written out into a .txt file named *output.txt*


## License

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.