################################################################################
#
# FILE: run_analysis.R
#
# OVERVIEW
#
# This script processes data collected from accelerometers in the Samsung Galaxy S 
# smartphone as part of the Human Activity Recognition (HAR) database. The dataset 
# consists of recordings from 30 subjects performing various Activities of Daily Living 
# (ADL), with the subjects carrying a waist-mounted smartphone that contains embedded 
# inertial sensors. The goal of this script is to clean and transform the raw data into a 
# tidy dataset, which will then be saved to a file named "tidy_data.txt".
#
# For more detailed information, please refer to the README.md file.
#
################################################################################

# Load required libraries
library(dplyr)

################################################################################
# STEP 0 - Set up the working environment and download data if necessary
################################################################################

# Define the URL and file paths
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"
dataPath <- "UCI HAR Dataset"

# Download the zip file if it doesn't exist
if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# Unzip the file if the data directory doesn't exist
if (!file.exists(dataPath)) {
  unzip(zipFile)
}

################################################################################
# STEP 1 - Merge the training and the test sets to create one data set
################################################################################

# Read training data
trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

# Read test data
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))

# Read features and activity labels
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

# Combine training and test data
dataSubjects <- rbind(trainingSubjects, testSubjects)
dataValues <- rbind(trainingValues, testValues)
dataActivity <- rbind(trainingActivity, testActivity)

# Assign column names
colnames(dataSubjects) <- "subject"
colnames(dataValues) <- features[, 2]
colnames(dataActivity) <- "activity"

# Merge data into a single data frame
humanActivity <- cbind(dataSubjects, dataValues, dataActivity)

################################################################################
# STEP 2 - Extract only the measurements on the mean and standard deviation
#          for each measurement
################################################################################

# Select columns that contain "mean" or "std" in their names
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))
humanActivity <- humanActivity[, columnsToKeep]

################################################################################
# STEP 3 - Use descriptive activity names to name the activities in the data set
################################################################################

# Replace activity codes with descriptive names
humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = activities$activityId, 
                                 labels = activities$activityLabel)

################################################################################
# STEP 4 - Appropriately label the data set with descriptive variable names
################################################################################

# Clean column names
humanActivityCols <- colnames(humanActivity)
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)
humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)
colnames(humanActivity) <- humanActivityCols

################################################################################
# STEP 5 - Create a second, independent tidy set with the average of each
#          variable for each activity and each subject
################################################################################

# Calculate the mean of each variable for each combination of subject and activity
humanActivityMeans <- aggregate(. ~ subject + activity, data = humanActivity, FUN = mean)

# output to file "tidyData.txt"
write.table(humanActivityMeans, "tidyData.txt", row.names = FALSE, 
            quote = FALSE)
#First 12 rows and 4 columns in Tidy dataset:
head(humanActivityMeans[order(humanActivityMeans$subject), 1:4],12)
