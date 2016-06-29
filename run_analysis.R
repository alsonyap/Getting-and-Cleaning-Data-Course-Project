run_analysis <- function() {
    
    # Reading all the relevant text files into variables 
    # Assumes dataset is in working directory as stated in submission page
    activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt")
    features <- read.table("~/UCI HAR Dataset/features.txt")
    
    x_test <- read.table("~/UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
    
    x_train <- read.table("~/UCI HAR Dataset/test/X_train.txt")
    y_test <- read.table("~/UCI HAR Dataset/test/y_train.txt")
    subject_test <- read.table("~/UCI HAR Dataset/test/subject_train.txt")
    
    
    # Step 1: Merges the training and test sets to create one data set.
    datafm <- rbind(x_test, x_train)
    
    
    # Step 2: Extracts only the measurements on the mean and standard deviation for each 
    # measurement.
    # Step 4: Appropriately labels the data set with descriptive variable names.
    names(datafm) <- features$V2
    cols <- grep("mean[()]|std", x = names(datafm), value = TRUE)
    datafm <- datafm[,cols]
    
    
    # Step 3: Uses descriptive activity names to name the activities in the data set.
    
        # 3.1) To add a column for subjects first
        Subjects <- rbind(subject_test, subject_train)
        datafm <- mutate(datafm, Subjects = Subjects$V1)
        
        # 3.2) Adding a column to represent the activities performed 
        Tags <- rbind(y_test, y_train)
        datafm <- mutate(datafm, Tags = Tags$V1)
        
        # 3.3) To perform matching of activities according to the labels
        names(activity_labels) <- c("Tags", "Activity")
        datafm <- merge(datafm, activity_labels, 
                            by.x = "Tags", by.y = "Tags")
        
        # 3.4) Removal of tags column and re-ordering
        datafm$Tags <- NULL
        datafm <- datafm[,c("Subjects", "Activity", cols)]
        
    # Step 5: Create a second, independent tidy data set with the average of each 
    # variable for each activity and each subject.
        
        # 5.1) Split the data by subjects into 30 data frames.
        datasplit <- split(datafm, datafm$Subjects)
        
        # 5.2) Calculates the average for each of the 561 variables (measurements)
        # for each activity (e.g. running) for each subject.
        final_results <- data.frame()
        
        # datasplit is a list of lists. Wants to extract the relevant measurement columns
        # and send them to the tapply function, which gets further split by the 
        # activities before the mean is calculated correspondingly.
        for (i in 1:30) { 
            mean_results <- sapply(datasplit[[i]][,cols],  
                   function(x) {tapply(x, datasplit[[i]]$Activity, mean)})
            mean_results <- data.frame(mean_results) # output is matrix, turns into dtf.
            
            final_results <- rbind(final_results, mean_results) # Compiles the result
                                                                # into a single variable.
        }
        
        # Generates 2 columns - Activity and Subjects, for final output file.
        Activity <- rep(rownames(mean_results), times = 30) 
        Subjects <- rep(1:30, each = 6)
        
        # Combines the columns accordingly
        output <- cbind(Subjects, Activity, final_results)
        
        # Turn the rownames into numbers of ascending order starting from 1
        rownames(output) <- 1:nrow(output)
        
        # Writes the table out into a text file
        write.table(x = output, 
                    file = "~/output.txt", 
                    row.names = FALSE, col.names = TRUE)
        
}