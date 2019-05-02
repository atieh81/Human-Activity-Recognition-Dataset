
library("dplyr", lib.loc="C:/Program Files/R/R-3.5.2/library")
# library("dplyr")

##########################################################
# Loading data set
##########################################################

# Test data
setwd("C:/RWD/Muhamad/Getting and Cleaning data course/Project/UCI HAR Dataset/test/")
## file.choose()
x_test <- read.table(file = "X_test.txt")
y_test <- read.table(file = "y_test.txt")
subject_test <- read.table(file = "subject_test.txt")

# Train data
setwd("C:/RWD/Muhamad/Getting and Cleaning data course/Project/UCI HAR Dataset/train/")

x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table(file = "subject_train.txt")

# Load activity names and features
setwd("C:/RWD/Muhamad/Getting and Cleaning data course/Project/UCI HAR Dataset/")
features <- read.table(file = "features.txt")
activity_labels <- read.table(file = "activity_labels.txt")

##########################################################
# Merge the training and the test data
##########################################################

x_dataset <- rbind(x_test, x_train)
y_dataset <- rbind(y_test, y_train)
subject_dataset <- rbind(subject_test, subject_train)


##########################################################
# Label the data set with descriptive variable names
##########################################################

colnames(x_dataset) <- features[,2]


##########################################################
# Extracts only the measurements on the mean and 
# standard deviation
##########################################################

x_dataset <- x_dataset[, !duplicated(colnames(x_dataset))]
main_dataset <- select(x_dataset, contains("mean()"), contains("std()"))

##########################################################
# Name the activities in the data set using descriptive
# activity names
##########################################################

# Join activity names to y-dataset
y_dataset <- left_join(y_dataset, activity_labels, by = "V1") # Join by activity code

# Add activity names to data set
main_dataset <- cbind(y_dataset[,2], main_dataset)


##########################################################
# Add Subject to data set
##########################################################

main_dataset <- cbind(subject_dataset, main_dataset)
colnames(main_dataset)[1:2] <- c("subject", "activity_label")

##########################################################
# Creates a data set with the average of each variable 
# for each activity and each subject
##########################################################

group_dataset <- main_dataset %>% 
  group_by(subject, activity_label) %>% 
  summarise_all(.funs = mean)

##########################################################
# Export data of group_dataset to CSV file
##########################################################

setwd("C:/RWD/Muhamad/Getting and Cleaning data course/Project/")
write.csv(group_dataset, file = "project_output.csv")

