## tbolanos
## [20180127]

## Download files . This step is not needed in working with local files


downloadFiles <-function(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", path = "./dw_data") {
  
  #create path is does not exists
  if(!file.exists(path)){dir.create(path)}
  fileUrl <-  url;
  download.file(fileUrl,destfile= paste(path,"/Dataset.zip", sep = ""))
  
  # Unzip DS 
  unzip(zipfile=paste(path, "/Dataset.zip", sep = ""),exdir=path ) 
}



#merge data sets
process_ds <- function (path = "./dw_data") {
  
  # Reading features:
  lb_features <- read.table(paste(path ,'/UCI HAR Dataset/features.txt', sep = ""))
  
  # Reading  activities:
  lb_activities = read.table(paste(path, '/UCI HAR Dataset/activity_labels.txt', sep = ""))
  
  # Reading trainings sets:
  ds_x_train <- read.table(paste(path,"/UCI HAR Dataset/train/X_train.txt", sep = ""))
  ds_y_train <- read.table(paste(path, "/UCI HAR Dataset/train/y_train.txt", sep = ""))
  ds_subj_train <- read.table(paste(path, "/UCI HAR Dataset/train/subject_train.txt", sep = ""))
  
  # Reading testing sets:
  ds_x_test <- read.table(paste(path,"/UCI HAR Dataset/test/X_test.txt", sep = ""))
  ds_y_test <- read.table(paste(path,"/UCI HAR Dataset/test/y_test.txt", sep = ""))
  ds_subj_test <- read.table(paste(path, "/UCI HAR Dataset/test/subject_test.txt", sep = ""))
  
  #assign  names to columns
  
  
  colnames(ds_x_train) <- lb_features[,2] 
  colnames(ds_y_train) <-"activityId"
  colnames(ds_subj_train) <- "subjectId"
  
  colnames(ds_x_test) <- lb_features[,2] 
  colnames(ds_y_test) <- "activityId"
  colnames(ds_subj_test) <- "subjectId"
  
  colnames(lb_activities) <- c('activityId','activityType')
  
  
  #merge data
  
  
  ds_merged_train <- cbind(ds_y_train, ds_subj_train, ds_x_train)
  ds_merged_test <- cbind(ds_y_test, ds_subj_test, ds_x_test)
  combinedSet <- rbind(ds_merged_train, ds_merged_test)
  
  
  #extract mesures
  
  colNames <- colnames(combinedSet)
  
  
  mn_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
  )
  
  ds_mn_and_std <- combinedSet[ , mn_std == TRUE]
  ds_newNames <- merge(ds_mn_and_std, lb_activities,
                                by='activityId',
                                all.x=TRUE)
  
  ds_Tidy2 <- aggregate(. ~subjectId + activityId, ds_newNames, mean)
  ds_Tidy2 <- ds_Tidy2[order(ds_Tidy2$subjectId, ds_Tidy2$activityId),]
  
  
  write.table(ds_Tidy2, "ds_TidySet.txt", row.name=FALSE)
  
}


downloadFiles()
process_ds()