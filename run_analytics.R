library(dplyr)
library(data.table)
library(tidyr)

wd <- getwd()

# Download and unzip
dataFile = "./data.zip"
if (!file.exists("./data")) {
    dir.create("./data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile=dataFile,method="curl")
    unzip(zipfile=dataFile,exdir="./data")    
} 
dataFilePath <- file.path(wd,"data","UCI HAR Dataset")

# Read data to tables
subjectTrain <- tbl_df(read.table(file.path(dataFilePath, "train", "subject_train.txt")))
subjectTest <- tbl_df(read.table(file.path(dataFilePath, "test", "subject_test.txt")))
yTrain <- tbl_df(read.table(file.path(dataFilePath, "train", "y_train.txt")))
yTest  <- tbl_df(read.table(file.path(dataFilePath, "test" , "y_test.txt" )))
xTrain <- tbl_df(read.table(file.path(dataFilePath, "train", "X_train.txt" )))
xTest  <- tbl_df(read.table(file.path(dataFilePath, "test" , "X_test.txt" )))
features <- tbl_df(read.table(file.path(dataFilePath, "features.txt")))
activityLabels<- tbl_df(read.table(file.path(dataFilePath, "activity_labels.txt")))

# 1. Merges the training and the test sets to create one data set. 
subject <- rbind(subjectTrain, subjectTest)
colnames(subject) <- "Subject"
y <- rbind(yTrain, yTest)
colnames(y) <- "Activity"
x <- rbind(xTrain, xTest)
setnames(features, names(features), c("featureNum", "featureName"))
colnames(x) <- features$featureName
setnames(activityLabels, names(activityLabels), c("Activity","ActivityName"))
data <- cbind(subject, y, x)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
index<-grep(".*mean.*|.*std.*", colnames(data), ignore.case=TRUE)
columns <- c(index, grep("Activity", colnames(data)), grep("Subject", colnames(data)))
data <- data[,columns]

# 3. Uses descriptive activity names to name the activities in the data set
data <- merge(activityLabels, data , by="Activity", all.x=TRUE)
data$ActivityName <- as.character(data$ActivityName)
data <- data[,names(data) != "Activity" ]

# 4 Appropriately labels the data set with descriptive variable names.
# time 
names(data)<-gsub("^t", "Time", names(data))
# Frequency 
names(data)<-gsub("^f", "Frequency", names(data))
# Body 
names(data)<-gsub("BodyBody", "Body", names(data))
# STD
names(data)<-gsub("std\\(\\)", "STD", names(data), ignore.case = TRUE)
# mean
names(data)<-gsub("mean\\(\\)", "Mean", names(data), ignore.case = TRUE)
# gyro 
names(data)<-gsub("Gyro", "Gyroscope", names(data))
# gravity 
names(data)<-gsub("gravity", "Gravity", names(data))
# Accelerometer
names(data)<-gsub("Acc", "Accelerometer", names(data))
# Magnitude
names(data)<-gsub("Mag", "Magnitude", names(data))
# Angle 
names(data)<-gsub("angle", "Angle", names(data))

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
data$Subject <- as.factor(data$Subject)
tidyData <- aggregate(. ~Subject + ActivityName, data, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$ActivityName),]
write.table(tidyData, file = "tidy.txt", row.name=FALSE)


