# Helper function that merges the following files in the given directory <dir> into a data frame:
#
#   subject_<dir>_.txt
#   X_<dir>.txt
#   y_<dir>.txt
#
#
# Notes:
#
#  "<dir>" takes the values of 'test' or 'train'
# 
#  Also, the function retrieves column names from the activity_labels.txt and features.txt files
#

merge_files <- function(d = "test") {

  #subject
  s <- read.table(paste0(d, "/subject_",d,".txt"))
  names(s)[1] <- "subject"
  
  #activity by name
  l <- read.table("activity_labels.txt", stringsAsFactor=FALSE)
  a <- read.table(paste0(d, "/y_",d,".txt"))
  a$V1 <- l[a$V1,2]
  names(a)[1] <- "activity"
  
  #read data set
  t <- read.table(paste0(d, "/X_",d,".txt"))
  # subset for columns labeled 'mean' or 'std' 
  f<- read.table("features.txt")
  names(t) <- f[,2]
  t <- t[, as.vector(f[grepl("-mean()", f$V2) | grepl("-std()", f$V2), 1])]

  #merge files into a single data frame
  df <- data.frame(s,a,t)
  names(df) <- gsub(".", "", names(df), fixed = TRUE)
  
  #return dataframe
  df
}

#The merge_datasets function performs the following steps:
#
# 1. Merges the training and the test sets to create one data set
#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropiately labels the data set with descriptive variable names
#
# "wd" denotes the folder where you have extracted the contents of the provided .zip file 
#
merge_datasets <- function(wd ="c:/work/R/Module3/project/UCI HAR Dataset") {

    #subfolders
    test_folder = "test"
    train_folder = "train"
    
    #initialize result
    merged_df = data.frame()

    #set working directory
    if (dir.exists(paste0(wd,"/",test_folder)) & dir.exists(paste0(wd,"/",train_folder))) {
        setwd(wd)
  
        #read test set
        test_df  <- merge_files(test_folder)
        #read test set
        train_df <- merge_files(train_folder)
        #merge test sets
        merged_df <- rbind(test_df, train_df)
    }
  else {
    print("ERROR: Invalid directory provided.")
  }
  merged_df
}

# make_tidy implements the remaining step for the project:
#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#
make_summary <- function(merged_df, wd="c:/work/R/Module3/project/UCI HAR Dataset") {

  #initialize result
  s = data.frame()
  
  if (!is.null(merged_df)) {
    
    if (nrow(merged_df)==0) {
      print("initializing df")
      merged_df <- merge_datasets(wd)
    }

    if (nrow(merged_df) > 0) {
      s <- aggregate(merged_df[,3:81], by=list(merged_df$activity, merged_df$subject), FUN=mean, na.rm=TRUE)
      names(s) <- paste0("meanof", names(s))
      names(s)[1] = "activity"
      names(s)[2] = "subject"
    }
  }
  
  s
}

######################################
# Usage:
# ------
#
#> source("run_analysis.R")
#> df <- merge_datasets("c:/work/R/Module3/project/UCI HAR Dataset")
#> s <- make_summary(df)

#Output Example:
#--------------
#
# > source("run_analysis.R")
# > df <- merge_datasets("c:/work/R/Module3/project/UCI HAR Dataset")
# > nrow(df)
# [1] 10299
# > ncol(df)
# [1] 81
# > head(df[,1:10],20)
# subject activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ tGravityAccmeanX tGravityAccmeanY
# 1        2 STANDING     0.2571778  -0.023285230   -0.01465376   -0.9384040   -0.9200908   -0.6676833        0.9364893       -0.2827192
# 2        2 STANDING     0.2860267  -0.013163359   -0.11908252   -0.9754147   -0.9674579   -0.9449582        0.9274036       -0.2892151
# 3        2 STANDING     0.2754848  -0.026050420   -0.11815167   -0.9938190   -0.9699255   -0.9627480        0.9299150       -0.2875128
# 4        2 STANDING     0.2702982  -0.032613869   -0.11752018   -0.9947428   -0.9732676   -0.9670907        0.9288814       -0.2933958
# 5        2 STANDING     0.2748330  -0.027847788   -0.12952716   -0.9938525   -0.9674455   -0.9782950        0.9265997       -0.3029609
# 6        2 STANDING     0.2792199  -0.018620399   -0.11390197   -0.9944552   -0.9704169   -0.9653163        0.9256632       -0.3089397
# 7        2 STANDING     0.2797459  -0.018271026   -0.10399988   -0.9958192   -0.9763536   -0.9777247        0.9261366       -0.3095639
# 8        2 STANDING     0.2746005  -0.025035130   -0.11683085   -0.9955944   -0.9820689   -0.9852624        0.9265862       -0.3107735
# 9        2 STANDING     0.2725287  -0.020954013   -0.11447249   -0.9967841   -0.9759063   -0.9865970        0.9255553       -0.3157374
# 10       2 STANDING     0.2757457  -0.010371994   -0.09977589   -0.9983731   -0.9869329   -0.9910219        0.9241734       -0.3175966
# 11       2 STANDING     0.2785959  -0.015231928   -0.09890841   -0.9987851   -0.9819431   -0.9913788        0.9237189       -0.3139857
# 12       2 STANDING     0.2791518  -0.021879444   -0.10973077   -0.9977810   -0.9929512   -0.9856803        0.9240375       -0.3129556
# 13       2 STANDING     0.2745438  -0.023145294   -0.11253960   -0.9962046   -0.9915728   -0.9875183        0.9244592       -0.3156827
# 14       2 STANDING     0.2690663  -0.027685967   -0.11017794   -0.9968836   -0.9864395   -0.9884791        0.9231742       -0.3198183
# 15       2 STANDING     0.2755792  -0.018936424   -0.09740978   -0.9960647   -0.9682255   -0.9806960        0.9203610       -0.3255286
# 16       2 STANDING     0.2819308  -0.004880615   -0.08610614   -0.9890756   -0.9590063   -0.9730239        0.9197994       -0.3257631
# 17       2 STANDING     0.3110779  -0.019430625   -0.10186634   -0.9366878   -0.8401859   -0.8168264        0.8758133       -0.4266813
# 18       2 STANDING     0.2623282  -0.023257054   -0.12552494   -0.9845611   -0.9133798   -0.9126728        0.8899769       -0.4226561
# 19       2 STANDING     0.2884158  -0.003485395   -0.08382786   -0.9945707   -0.9783598   -0.9799426        0.8852919       -0.4260987
# 20       2 STANDING     0.2711659  -0.025972908   -0.09492348   -0.9701240   -0.9018782   -0.9652996        0.8886849       -0.4188977
# 
# > s <- make_summary(df)
# > nrow(s)
# [1] 180
# > ncol(s)
# [1] 81
# > head(s[,1:10],20)
# activity subject meanoftBodyAccmeanX meanoftBodyAccmeanY meanoftBodyAccmeanZ meanoftBodyAccstdX meanoftBodyAccstdY meanoftBodyAccstdZ meanoftGravityAccmeanX manoftGravityAccmeanY
# 1              LAYING       1     0.2215982  -0.040513953   -0.11320355  -0.92805647 -0.836827406  -0.82606140       -0.2488818        0.7055498
# 2             SITTING       1     0.2612376  -0.001308288   -0.10454418  -0.97722901 -0.922618642  -0.93958629        0.8315099        0.2044116
# 3            STANDING       1     0.2789176  -0.016137590   -0.11060182  -0.99575990 -0.973190056  -0.97977588        0.9429520       -0.2729838
# 4             WALKING       1     0.2773308  -0.017383819   -0.11114810  -0.28374026  0.114461337  -0.26002790        0.9352232       -0.2821650
# 5  WALKING_DOWNSTAIRS       1     0.2891883  -0.009918505   -0.10756619   0.03003534 -0.031935943  -0.23043421        0.9318744       -0.2666103
# 6    WALKING_UPSTAIRS       1     0.2554617  -0.023953149   -0.09730200  -0.35470803 -0.002320265  -0.01947924        0.8933511       -0.3621534
# 7              LAYING       2     0.2813734  -0.018158740   -0.10724561  -0.97405946 -0.980277399  -0.98423330       -0.5097542        0.7525366
# 8             SITTING       2     0.2770874  -0.015687994   -0.10921827  -0.98682228 -0.950704499  -0.95982817        0.9404773       -0.1056300
# 9            STANDING       2     0.2779115  -0.018420827   -0.10590854  -0.98727189 -0.957304989  -0.94974185        0.8969286       -0.3700627
# 10            WALKING       2     0.2764266  -0.018594920   -0.10550036  -0.42364284 -0.078091253  -0.42525752        0.9130173       -0.3466071
# 11 WALKING_DOWNSTAIRS       2     0.2776153  -0.022661416   -0.11681294   0.04636668  0.262881789  -0.10283791        0.8618313       -0.3257801
# 12   WALKING_UPSTAIRS       2     0.2471648  -0.021412113   -0.15251390  -0.30437641  0.108027280  -0.11212102        0.7907174       -0.4162149
# 13             LAYING       3     0.2755169  -0.018955679   -0.10130048  -0.98277664 -0.962057545  -0.96369103       -0.2417585        0.8370321
# 14            SITTING       3     0.2571976  -0.003502998   -0.09835792  -0.97101012 -0.856617812  -0.87511018        0.9010990        0.1273034
# 15           STANDING       3     0.2800465  -0.014337656   -0.10162172  -0.96674254 -0.893449307  -0.91141902        0.9350308       -0.3017351
# 16            WALKING       3     0.2755675  -0.017176784   -0.11267486  -0.36035673 -0.069914065  -0.38741199        0.9365067       -0.2619864
# 17 WALKING_DOWNSTAIRS       3     0.2924235  -0.019355408   -0.11613984  -0.05741005 -0.033150372  -0.36224025        0.9390578       -0.2288292
# 18   WALKING_UPSTAIRS       3     0.2608199  -0.032410941   -0.11006486  -0.31312344  0.011628081  -0.36975460        0.8835334       -0.3828512
# 19             LAYING       4     0.2635592  -0.015003184   -0.11068815  -0.95419374 -0.941714042  -0.96266731       -0.4206647        0.9151651
# 20            SITTING       4     0.2715383  -0.007163065   -0.10587460  -0.98030993 -0.890223981  -0.93220301        0.8693030        0.2116225
# 

