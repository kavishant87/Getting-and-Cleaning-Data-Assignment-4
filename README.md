# Getting-and-Cleaning-Data-Assignment-4
This Repository contains Getting and Cleaning Data course Project and 
   First, download and unzip the data file into your R working directory.
   Second, download the R source code into your R working directory.
   Finally, execute R source code to generate tidy data file.
   
Code explaination
The code combined training dataset and test dataset, and extracted partial variables to create another dataset with the averages of each variable for each activity.

New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

The code was written based on the instruction of this assignment
Read training and test dataset into R environment. Read variable names into R envrionment. Read subject index into R environment.

The Script
run_analysis.R performs the data preparation and then followed by the 5 steps required as described in the course project’s definition:

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each       subject.
    
lastData.txt is the exported final data after going through all the sequences described above.
