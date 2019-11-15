# README.md

For the project, the following implementation decisions were made:

1. Only the following two files with measurements were merged:

  test/X_test.txt: Test set
  train/X_train.txt: Training set 
  
  The files under train/Inertial_Signals and test/Inertial_Signals were not used.
  The assumption is that these were used to calculate the variable values for mean and std already included in these files.

2. labels for activities and measurements were retrieved from the activity_labels.txt and features.txt files.

3. Only columns with either 'mean' and 'std' were considered for the resulting data set.
   The grepl function was used to filter the columns to be considered for the data set.

   Refer to Appendix A section for a list of the included columns from the X_*.txt files.
   
   The merge_datasets() function produces the merged data set.
   All special characters were removed from the column names in the merged data set.
  
   Excerpt:

```   
> head(df[,1:10])
  subject activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ tGravityAccmeanX tGravityAccmeanY
1       2 STANDING     0.2571778   -0.02328523   -0.01465376   -0.9384040   -0.9200908   -0.6676833        0.9364893       -0.2827192
2       2 STANDING     0.2860267   -0.01316336   -0.11908252   -0.9754147   -0.9674579   -0.9449582        0.9274036       -0.2892151
3       2 STANDING     0.2754848   -0.02605042   -0.11815167   -0.9938190   -0.9699255   -0.9627480        0.9299150       -0.2875128
4       2 STANDING     0.2702982   -0.03261387   -0.11752018   -0.9947428   -0.9732676   -0.9670907        0.9288814       -0.2933958
5       2 STANDING     0.2748330   -0.02784779   -0.12952716   -0.9938525   -0.9674455   -0.9782950        0.9265997       -0.3029609
6       2 STANDING     0.2792199   -0.01862040   -0.11390197   -0.9944552   -0.9704169   -0.9653163        0.9256632       -0.3089397   
```
   
4. To produce the summary data set, the data sets were grouped by activity and subject. The mean was calculated for all columns.

   The make_summary() function implements this logic.
   
   The 'meanof' string was prepended to the column names to denote each entry is the mean for each group of records.
   
   For example,

```   
   > head(s[,1:6],20)
             activity subject meanoftBodyAccmeanX meanoftBodyAccmeanY meanoftBodyAccmeanZ meanoftBodyAccstdX
1              LAYING       1           0.2215982        -0.040513953         -0.11320355        -0.92805647
2             SITTING       1           0.2612376        -0.001308288         -0.10454418        -0.97722901
3            STANDING       1           0.2789176        -0.016137590         -0.11060182        -0.99575990
4             WALKING       1           0.2773308        -0.017383819         -0.11114810        -0.28374026
5  WALKING_DOWNSTAIRS       1           0.2891883        -0.009918505         -0.10756619         0.03003534
6    WALKING_UPSTAIRS       1           0.2554617        -0.023953149         -0.09730200        -0.35470803
7              LAYING       2           0.2813734        -0.018158740         -0.10724561        -0.97405946
8             SITTING       2           0.2770874        -0.015687994         -0.10921827        -0.98682228
9            STANDING       2           0.2779115        -0.018420827         -0.10590854        -0.98727189
10            WALKING       2           0.2764266        -0.018594920         -0.10550036        -0.42364284
11 WALKING_DOWNSTAIRS       2           0.2776153        -0.022661416         -0.11681294         0.04636668
12   WALKING_UPSTAIRS       2           0.2471648        -0.021412113         -0.15251390        -0.30437641
13             LAYING       3           0.2755169        -0.018955679         -0.10130048        -0.98277664
14            SITTING       3           0.2571976        -0.003502998         -0.09835792        -0.97101012
15           STANDING       3           0.2800465        -0.014337656         -0.10162172        -0.96674254
16            WALKING       3           0.2755675        -0.017176784         -0.11267486        -0.36035673
17 WALKING_DOWNSTAIRS       3           0.2924235        -0.019355408         -0.11613984        -0.05741005
18   WALKING_UPSTAIRS       3           0.2608199        -0.032410941         -0.11006486        -0.31312344
19             LAYING       4           0.2635592        -0.015003184         -0.11068815        -0.95419374
20            SITTING       4           0.2715383        -0.007163065         -0.10587460        -0.98030993
> 
```

5. During development, the provided .zip file was extracted to "C:\work\R\Module3\project\UCI HAR Dataset"
   This is the default folder for the merge_datasets() and make_summary() functions. 

   However, if another folder is being used you may:
   a) edit the R file 
   OR
   b) provide the folder location in the function call.
   
   Example,

```      
   > source("run_analysis.R")
   > df <- merge_datasets()
   > s <- make_summary(df)
```	  
   OR	  
```	  
   > source("run_analysis.R")
   > df <- merge_datasets("c:/work/R/Module3/project/UCI HAR Dataset")
   > s <- make_summary(df,"c:/work/R/Module3/project/UCI HAR Dataset")
```   
  
  
# Appendix A 

Each record includes the subject identifier and activity, following by the measurement variables.

For each activity, only the following variables were extracted from each data set.

```
f<- read.table("features.txt")
f[grepl("-mean()", f$V2) | grepl("-std()", f$V2), ]
     V1                              V2
1     1               tBodyAcc-mean()-X
2     2               tBodyAcc-mean()-Y
3     3               tBodyAcc-mean()-Z
4     4                tBodyAcc-std()-X
5     5                tBodyAcc-std()-Y
6     6                tBodyAcc-std()-Z
41   41            tGravityAcc-mean()-X
42   42            tGravityAcc-mean()-Y
43   43            tGravityAcc-mean()-Z
44   44             tGravityAcc-std()-X
45   45             tGravityAcc-std()-Y
46   46             tGravityAcc-std()-Z
81   81           tBodyAccJerk-mean()-X
82   82           tBodyAccJerk-mean()-Y
83   83           tBodyAccJerk-mean()-Z
84   84            tBodyAccJerk-std()-X
85   85            tBodyAccJerk-std()-Y
86   86            tBodyAccJerk-std()-Z
121 121              tBodyGyro-mean()-X
122 122              tBodyGyro-mean()-Y
123 123              tBodyGyro-mean()-Z
124 124               tBodyGyro-std()-X
125 125               tBodyGyro-std()-Y
126 126               tBodyGyro-std()-Z
161 161          tBodyGyroJerk-mean()-X
162 162          tBodyGyroJerk-mean()-Y
163 163          tBodyGyroJerk-mean()-Z
164 164           tBodyGyroJerk-std()-X
165 165           tBodyGyroJerk-std()-Y
166 166           tBodyGyroJerk-std()-Z
201 201              tBodyAccMag-mean()
202 202               tBodyAccMag-std()
214 214           tGravityAccMag-mean()
215 215            tGravityAccMag-std()
227 227          tBodyAccJerkMag-mean()
228 228           tBodyAccJerkMag-std()
240 240             tBodyGyroMag-mean()
241 241              tBodyGyroMag-std()
253 253         tBodyGyroJerkMag-mean()
254 254          tBodyGyroJerkMag-std()
266 266               fBodyAcc-mean()-X
267 267               fBodyAcc-mean()-Y
268 268               fBodyAcc-mean()-Z
269 269                fBodyAcc-std()-X
270 270                fBodyAcc-std()-Y
271 271                fBodyAcc-std()-Z
294 294           fBodyAcc-meanFreq()-X
295 295           fBodyAcc-meanFreq()-Y
296 296           fBodyAcc-meanFreq()-Z
345 345           fBodyAccJerk-mean()-X
346 346           fBodyAccJerk-mean()-Y
347 347           fBodyAccJerk-mean()-Z
348 348            fBodyAccJerk-std()-X
349 349            fBodyAccJerk-std()-Y
350 350            fBodyAccJerk-std()-Z
373 373       fBodyAccJerk-meanFreq()-X
374 374       fBodyAccJerk-meanFreq()-Y
375 375       fBodyAccJerk-meanFreq()-Z
424 424              fBodyGyro-mean()-X
425 425              fBodyGyro-mean()-Y
426 426              fBodyGyro-mean()-Z
427 427               fBodyGyro-std()-X
428 428               fBodyGyro-std()-Y
429 429               fBodyGyro-std()-Z
452 452          fBodyGyro-meanFreq()-X
453 453          fBodyGyro-meanFreq()-Y
454 454          fBodyGyro-meanFreq()-Z
503 503              fBodyAccMag-mean()
504 504               fBodyAccMag-std()
513 513          fBodyAccMag-meanFreq()
516 516      fBodyBodyAccJerkMag-mean()
517 517       fBodyBodyAccJerkMag-std()
526 526  fBodyBodyAccJerkMag-meanFreq()
529 529         fBodyBodyGyroMag-mean()
530 530          fBodyBodyGyroMag-std()
539 539     fBodyBodyGyroMag-meanFreq()
542 542     fBodyBodyGyroJerkMag-mean()
543 543      fBodyBodyGyroJerkMag-std()
552 552 fBodyBodyGyroJerkMag-meanFreq()
```