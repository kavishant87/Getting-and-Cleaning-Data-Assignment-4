#Download the package
library(dplyr)

# Checking if file already exists.
if (!file.exists("C:/Users/kavis/Documents/UCI HAR Dataset.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,destfile = "C:/Users/kavis/Documents/UCI HAR Dataset.zip")
}  

# Checking if folder exists
# unzipped the data set and training file
if (!file.exists("UCI HAR Dataset")) { 
  unzip("C:/Users/kavis/Documents/UCI HAR Dataset.zip")
}



# Read the training data
subjecttrain <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
xtrain <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/train/X_train.txt", header = FALSE)
ytrain <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Read the test data
subjecttest <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
xtest <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/test/X_test.txt", header = FALSE)
ytest <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Read Metadata
featureNames <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("C:/Users/kavis/Documents/UCI HAR Dataset/activity_labels.txt", header = FALSE) 

#Part1 : Merge the training and test sets to create one data set
subjectt <- rbind(subjecttrain,subjecttest)
xt <- rbind(xtrain,xtest)
yt <- rbind(ytrain,ytest)

#Naming the appropriate column names based on features.txt file
colnames(xt) <- t(featureNames[2])
colnames(yt) <- "Activity"
colnames(subjectt) <- "Subject"

# Merging the data sets
mergeData <- cbind(yt, xt, subjectt)

# Extracts only the measurements on the mean and standard deviation for each measurement
extractData <-  mergeData %>% select (Subject, Activity, contains("mean"), contains("std"))

#Use descriptive activity names to name the activities in the data set
extractData$Activity <- activityLabels[extractData$Activity, 2]

#Appropriately labels the data set with descriptive variable names.
names(extractData)
names(extractData)[2] = "activity"
names(extractData) <- gsub("Acc", "Accelerometer", names(extractData))
names(extractData) <- gsub("Gyro", "Gyroscope", names(extractData))
names(extractData) <- gsub("BodyBody", "Body", names(extractData))
names(extractData) <- gsub("Mag", "Magnitude", names(extractData))
names(extractData) <- gsub("^t", "Time", names(extractData))
names(extractData) <- gsub("^f", "Frequency", names(extractData))
names(extractData) <- gsub("angle", "Angle", names(extractData))
names(extractData) <- gsub("gravity", "Gravity", names(extractData))
names(extractData) <- gsub("tBody", "TimeBody", names(extractData))

names(extractData) <- gsub("-mean()", "Mean", names(extractData), ignore.case = FALSE)
names(extractData) <- gsub("-std()", "StandardDeviation", names(extractData), ignore.case = FALSE)
names(extractData) <- gsub("-freq()", "Frequency", names(extractData), ignore.case = FALSE)
names(extractData)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
lastData <- aggregate(. ~Subject + activity, extractData, mean)
lastData <- lastData[order(lastData$Subject,lastData$activity),]
write.table(lastData, "lastData.txt", row.name = FALSE)
str(lastData)
lastData
