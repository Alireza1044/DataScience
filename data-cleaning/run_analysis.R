# Load Packages
library(data.table)
library(dplyr)

# Set Working Directory
setwd("Desktop/Developer/DataScience/data")

# Load the data into R
features <- fread("features.txt",col.names = c("id","name"))
x_train <- fread("train/X_train.txt",col.names = features$name)
y_train <- fread("train/Y_train.txt",col.names = "id")
y_test <- fread("test/y_test.txt",col.names = "id")
x_test <- fread("test/X_test.txt",col.names = features$name)
activity <- fread("activity_labels.txt",col.names = c("Id","Label"))
subject_test <- fread("test/subject_test.txt",col.names = "subjectId")
subject_train <- fread("train/subject_train.txt",col.names = "subjectId")

# Merge test & train data to form one sinlge data set
x_merged <- rbind(x_train,x_test)
y_merged <- rbind(y_train,y_test)
subject_merged <- rbind(subject_train,subject_test)
Merged <- cbind(subject_merged,y_merged,x_merged)
Merged <- subset(Merged, select=which(!duplicated(names(Merged))))
Merged <- select(Merged,subjectId,id,contains("mean"),contains("std"))

# Merge Activity names into the dataset By ActivityID
Merged <- merge(Merged,activity,by.x = "id",by.y = "Id")

# Rename variable names with Appropriate ones
colnames(Merged) <- gsub("Acc","Accelerometer",colnames(Merged))
colnames(Merged) <- gsub("^t","Time",colnames(Merged))
colnames(Merged) <- gsub("^f","Frequency",colnames(Merged))
colnames(Merged) <- gsub("BodyBody","Body",colnames(Merged))
colnames(Merged) <- gsub("Mag","Magnitude",colnames(Merged))
colnames(Merged) <- gsub("-mean()","Mean",colnames(Merged),ignore.case = TRUE)
colnames(Merged) <- gsub("-std()","STD",colnames(Merged),ignore.case = TRUE)
colnames(Merged) <- gsub("-freq()","Frequency",colnames(Merged),ignore.case = TRUE)
colnames(Merged) <- gsub("Gyro","Gyroscope",colnames(Merged))
colnames(Merged) <- gsub("angle","Angle",colnames(Merged))
colnames(Merged) <- gsub("gravity","Gravity",colnames(Merged))
colnames(Merged) <- gsub("Frequencyuency","Frequency",colnames(Merged))
colnames(Merged) <- gsub("()","",colnames(Merged))
colnames(Merged) <- gsub("STD()","STD",colnames(Merged))
colnames(Merged) <- gsub("STD()-","STD-",colnames(Merged))
colnames(Merged) <- gsub("tBody","TimeBody",colnames(Merged))
colnames(Merged) <- gsub("iqr","InterquartileRange",colnames(Merged))
colnames(Merged) <- gsub("energy","Energy",colnames(Merged))
colnames(Merged) <- gsub("entropy","Entropy",colnames(Merged))
colnames(Merged) <- gsub("arCoeff","AutoRegressiveCoefficients",colnames(Merged))
colnames(Merged) <- gsub("max","Max",colnames(Merged))
colnames(Merged) <- gsub("mad","Mad",colnames(Merged))
colnames(Merged) <- gsub("min","Min",colnames(Merged))
colnames(Merged) <- gsub("^id","ActivityID",colnames(Merged))
colnames(Merged) <- gsub("^Label","ActivityLabel",colnames(Merged))
colnames(Merged) <- gsub("^subjectId","SubjectID",colnames(Merged))

# Order columns by name & put "SubjectID" & "ActivityLabel" in the  beggining
setcolorder(Merged,sort(names(Merged)))
setcolorder(Merged,c("SubjectID","ActivityLabel"))

# Remove ActivityID column from the dataset
Merged <- select(Merged,-ActivityID)

# Create a second, independent tidy dataset with the average of each variable for each activity and each subject
Result <- Merged %>% group_by(SubjectID, ActivityLabel) %>% summarise_all(list(mean))

# Writing the final dataset to a text file
write.table(Result,"result.txt",row.names = FALSE)