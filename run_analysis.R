run_analysis <- function() { ##First section
# Extracts activity names from file
activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt')
activity_names$V2 <- tolower(activity_names$V2)
activity_names$V2 <- gsub('_',' ',activity_names$V2)

# Extracts feature names from file
feature_list <- read.table('./UCI HAR Dataset/features.txt')

#Imports subject labels
subjecttrain <- read.table('./UCI HAR Dataset/train/subject_train.txt')
subjecttest <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# Imports result files
ytrain <- read.table('./UCI HAR Dataset/train/y_train.txt')
xtrain <- read.table('./UCI HAR Dataset/train/X_train.txt')
ytest <- read.table('./UCI HAR Dataset/test/y_test.txt')
xtest <- read.table('./UCI HAR Dataset/test/X_test.txt')



##Second section

# names the columns in the train and test files
colnames(ytrain) <- c('Activity')
colnames(ytest) <- c('Activity')
colnames(subjecttest) <- c('Subject')
colnames(subjecttrain) <- c('Subject')
colnames(xtest) <- unlist(feature_list[2])
colnames(xtrain) <- unlist(feature_list[2])

#pull columns that show mean or standard deviation
id <- feature_list[grepl('mean\\(\\)$|std\\(\\)$',unlist(feature_list[2])),]
xtest <- xtest[,unlist(id[1])]
xtrain <- xtrain[,unlist(id[1])]


#join both datasets
resultstrain <- cbind(ytrain,subjecttrain,xtrain)
resultstest <- cbind(ytest,subjecttest,xtest)
results <- rbind(resultstrain,resultstest)

#Substitute activity numbers for names
results <- merge(results,activity_names,by.x='Activity',by.y='V1')
results$Activity <- results$V2
results$V2 <- NULL

#Returns the data frame
return(results)
}

dataset1 <- run_analysis()

## Third section

#Function to group means by activity
second_set <- function() {
  library(dplyr)
  data <- dataset1 %>%
    group_by(Activity,Subject) %>%
    summarize(across(is.numeric,mean))

  
  colnames <- colnames(data)
  colnames(data)[3:length(data)] <- paste('Average', colnames(data)[3:length(data)], sep=' ')
  return(data)
}

dataset2 <- second_set()