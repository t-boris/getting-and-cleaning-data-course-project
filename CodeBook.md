# Code Books 

This document describes the variables, the data, and all transformations that was performed to clean up the data and get __tidy.txt__ file 

## Input

The input data is obtained from "Human Activity Recognition Using Smartphones Data Set". The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Input dataset 

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

### Transformations 

1. 'subject_train.txt' is read into 'subjectTrain'
2. 'subject_test.txt' is read into 'subjectTest'
3. 'y_train.txt' is read into 'yTrain'
4. 'y_test.txt' is read into 'yTest'
5. 'X_train.txt' is read into 'xTrain'
6. 'X_test.txt' is read into 'xTest'
7. 'features.txt' is read into 'features'
8. 'activity_labels.txt' is read into 'activityLabels'
9. Training and Test subjects are merged into 'subject'
10. Training and Test activities are merged into 'y'
11. Training and Test features are merged into 'x'
12. The name of the features are set in 'x' from 'featureNames'.
13. The name of the activities are set in 'y' from 'featureNames'.
14. 'x','y', and 'subject' are mereged into 'data'
15. Filter out all columns of 'data' except "Activity", "Subject" and all columns that contain "mean" or "std"
16. Merge 'activityLabels' and 'data' to get ActivityName column
16. Acronyms in variable names in 'data', like 'std', 'mean', 'BodyBody', 'Gyro', 'gravity', 'Acc', 'Mag', 'angle', 't', and 'f' are replaced with descriptive labels.
17. Created 'tidyData' with average for each activity and subject of 'data'.
18. 'tidyData' is ordered based on activity and subject.
19. 'tidyData' is written into tidy.txt.

## Output 

The output is tidy.txt which is a space-delimited file. 
The header line contains the names of the variables. It contains the mean values of the data contained in the input files. 






