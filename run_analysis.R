## library import
library(dplyr)
library(reshape2)

## file import
sub_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
sub_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
fea <- read.table("features.txt")

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##sum(grepl("mean()", fea[,2], fixed = T))
##sum(grepl("std()", fea[,2], fixed = T))
selected <- grepl("mean()", fea[,2], fixed = T) | grepl("std()", fea[,2], fixed = T)

## 1. Merges the training and the test sets to create one data set.
dat1 <- rbind( cbind(sub_test, y_test, X_test[, selected]),
               cbind(sub_train, y_train, X_train[, selected]) )

## 4. Appropriately labels the data set with descriptive variable names.
fea_name <- make.names(fea[selected,2])
fea_name <- gsub("...", ".", fea_name, fixed = T)
fea_name <- gsub("..", "", fea_name, fixed = T)
names(dat1) = c("Subj_ID", "Activity", fea_name)

## 3. Uses descriptive activity names to name the activities in the data set.
## Remove "ING" for shorter variable name
act <- c("WALK", "WALK_UPSTAIRS", "WALK_DOWNSTAIRS", "SIT", "STAND", "LAY")
dat1 <- mutate(dat1, Activity = act[Activity])

## 5. Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
dat2 <- melt(dat1, id = c("Subj_ID", "Activity"))
dat2 <- dcast(dat2, Subj_ID + Activity ~ variable, mean)
write.table(dat2, "HAR_Data.txt", row.name=FALSE)
