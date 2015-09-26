# TidyData

The script 'run_analysis.R' imports the Human Activity Recognition Using Smartphones Dataset and output a new  tidy dataset, named "HAR_Data.txt".

The dataset is generated through the manipulation steps as below:

- Identify the feature variables which include "mean()" or "std()". This will disregard variables like fBodyAcc-meanFreq()-X
, but those variables are not considered measurements on the mean and standard deviation for each measurement.

- Using cbind() and rbind(), merge 'subject_train.txt', 'X_train.txt', 'y_train.txt', 'subject_test.txt', 'X_test.txt', 'y_test.txt' into a large dataset of dimension 10299-by-68, only the variables extracted in the previous step are merged.

- Using make.names(), replace the feature variable names with a valid name.

- Using mutate(), replace the activity numeric labels by descriptive words. 

- Using melt() and dcast(), generate the second dataset with averages of each variable for all combinations of subjects and activities. Then use write.table() to write to a new file.

Detailed variable description is in the file 'CodeBook.md'.
