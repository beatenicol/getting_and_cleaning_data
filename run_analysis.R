#1. Downloading and unzipping dataset. Reading files into tables

## create directory to store dataset and download zipfile into destination directory
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Reading trainings tables:
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_activities <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## Reading testing tables:
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_activities <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

## Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assinging column names:
colnames(train_data) <- features[,2] 
colnames(train_activities) <-"activityId"
colnames(train_subject) <- "subjectId"

colnames(test_data) <- features[,2] 
colnames(test_activities) <- "activityId"
colnames(test_subject) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# 2. Merging the training and the test sets to create one data set.

## combine columns for training and test data into tables
train_merged <- cbind(train_activities, train_subject, train_data)
test_merged <- cbind(test_activities, test_subject, test_data)
## combine the training and test data tables into one complete dataset
data_merged <- rbind(train_merged, test_merged)

#3. Extracting only the measurements on the mean and standard deviation for each measurement

## identify the relevant columns for new table if means and standard deviations
mean_and_std <- (grepl("activityId" , colnames(data_merged)) | 
                         grepl("subjectId" , colnames(data_merged)) | 
                         grepl("mean.." , colnames(data_merged)) | 
                         grepl("std.." , colnames(data_merged)) 
)

## Create subset of complete dataset from the identified columns
data_mean_std <- data_merged[ , mean_and_std == TRUE]

#4. Using descriptive activity names to name the activities in the data set:
tidy_data <- merge(data_mean_std, activityLabels,
                              by='activityId',
                              all.x=TRUE)
## get column names 
tidy_data_cols <- colnames(tidy_data) 

## remove special characters 
tidy_data_cols <- gsub("[\\(\\)-]", "", tidy_data_cols) 

## expand abbreviations and clean up names 
tidy_data_cols <- gsub("^f", "frequencyDomain", tidy_data_cols) 
tidy_data_cols <- gsub("^t", "timeDomain", tidy_data_cols) 
tidy_data_cols <- gsub("Acc", "Accelerometer", tidy_data_cols) 
tidy_data_cols <- gsub("Gyro", "Gyroscope", tidy_data_cols) 
tidy_data_cols <- gsub("Mag", "Magnitude", tidy_data_cols) 
tidy_data_cols <- gsub("Freq", "Frequency", tidy_data_cols) 
tidy_data_cols <- gsub("mean", "Mean", tidy_data_cols) 
tidy_data_cols <- gsub("std", "StandardDeviation", tidy_data_cols) 

## correct typo 
tidy_data_cols <- gsub("BodyBody", "Body", tidy_data_cols) 

## use new labels as column names
colnames(tidy_data) <- tidy_data_cols

#5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
tidy_set <- aggregate(. ~subjectId + activityId, tidy_data, mean)
tidy_set <- tidy_set[order(tidy_set$subjectId, tidy_set$activityId),]

write.table(tidy_set, "Tidy_set.txt", row.name=FALSE)
