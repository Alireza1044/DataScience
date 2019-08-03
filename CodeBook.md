# CodeBook
The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

**1. Assign each data to variables**
- features <- `features.txt` ,col.names = c("id","name")
- x_train <- `X_train.txt` ,col.names = features$name
- y_train <- `Y_train.txt` ,col.names = "id"
- y_test <- `y_test.txt` ,col.names = "id"
- x_test <- `X_test.txt` ,col.names = features$name)
- activity <- `activity_labels.txt` ,col.names = c("Id","Label")
- subject_test <- `subject_test.txt` ,col.names = "subjectId"
- subject_train <- `subject_train.txt` ,col.names = "subjectId"

**2. Merges the training and the test sets to create one data set**
- `x_merged` is created by merging `x_train` and `x_test` using rbind() function
- `y_merged` is created by merging `y_train` and `y_test` using rbind() function
- `subject_merged` is created by merging `subject_train` and `subject_test` using rbind() function
- `Merged` is created by merging `subject_merged`, `y_merged` and `x_merged` using cbind() function

**3. Extracts only the measurements on the mean and standard deviation for each measurement**
- `Merged` is created by subsetting `Merged`, selecting only columns: `SubjectID`, `ActivityLabel` and the measurements on the mean and standard deviation for each measurement

**4. Uses descriptive activity names to name the activities in the data set**
- "WALKING"
- "WALKING_UPSTAIRS"
- "WALKING_DOWNSTAIRS"
- "SITTING"
- "STANDING"
- "LAYING"

**5. Appropriately labels the data set with descriptive variable names**
- all "Acc" in column’s name replaced by "Accelerometer"
- all "^t" in column’s name replaced by "Time"
- all "^f" in column’s name replaced by "Frequency"
- all "BodyBody" in column’s name replaced by "Body"
- all "Mag" in column’s name replaced by "Magnitude"
- all "-mean()" in column’s name replaced by "Mean"
- all "-std()" in column’s name replaced by "STD"
- all "-freq()" in column’s name replaced by "Frequency"
- all "Gyro" in column’s name replaced by "Gyroscope"
- all "angle" in column’s name replaced by "Angle"
- all "gravity" in column’s name replaced by "Gravity"
- all "Frequencyuency" in column’s name replaced by "Frequency"
- all "tBody" in column’s name replaced by "TimeBody"
- all "iqr" in column’s name replaced by "InterquartileRange"
- all "energy" in column’s name replaced by "Energy"
- all "entropy" in column’s name replaced by "Entropy"
- all "arCoeff" in column’s name replaced by "AutoRegressiveCoefficients"
- all "max" in column’s name replaced by "Max"
- all "mad" in column’s name replaced by "Mad"
- all "min" in column’s name replaced by "Min"
- all "^id" in column’s name replaced by "ActivityID"
- all "^Label" in column’s name replaced by "ActivityLabel"
- all "^subjectId" in column’s name replaced by "SubjectID"
- Remove `ActivityID` column from the `Merged`

**6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
- `Result` is created by sumarizing `Merged` taking the means of each variable for each `ActivityLabel` and each `SubjectID`, after groupped by `SubjectID` and `ActivityLabel`.
- Export `Result` into `result.txt` file.
