# CodeBook.md

1. Subjects are identified by a number between 1 and 30 

2. Activities are labeled as follows:

```
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING
```

3. Record layout

The following fields are included in each record:

data frame:

```
subject activity [variables listed in Appendix B]

```

summary data frame:

```
subject activity [mean of variables listed in Appendix B]
```

## Units

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


# Appendix B  

```
1	subject
2	activity
3	tBodyAccmeanX
4	tBodyAccmeanY
5	tBodyAccmeanZ
6	tBodyAccstdX
7	tBodyAccstdY
8	tBodyAccstdZ
9	tGravityAccmeanX
10	tGravityAccmeanY
11	tGravityAccmeanZ
12	tGravityAccstdX
13	tGravityAccstdY
14	tGravityAccstdZ
15	tBodyAccJerkmeanX
16	tBodyAccJerkmeanY
17	tBodyAccJerkmeanZ
18	tBodyAccJerkstdX
19	tBodyAccJerkstdY
20	tBodyAccJerkstdZ
21	tBodyGyromeanX
22	tBodyGyromeanY
23	tBodyGyromeanZ
24	tBodyGyrostdX
25	tBodyGyrostdY
26	tBodyGyrostdZ
27	tBodyGyroJerkmeanX
28	tBodyGyroJerkmeanY
29	tBodyGyroJerkmeanZ
30	tBodyGyroJerkstdX
31	tBodyGyroJerkstdY
32	tBodyGyroJerkstdZ
33	tBodyAccMagmean
34	tBodyAccMagstd
35	tGravityAccMagmean
36	tGravityAccMagstd
37	tBodyAccJerkMagmean
38	tBodyAccJerkMagstd
39	tBodyGyroMagmean
40	tBodyGyroMagstd
41	tBodyGyroJerkMagmean
42	tBodyGyroJerkMagstd
43	fBodyAccmeanX
44	fBodyAccmeanY
45	fBodyAccmeanZ
46	fBodyAccstdX
47	fBodyAccstdY
48	fBodyAccstdZ
49	fBodyAccmeanFreqX
50	fBodyAccmeanFreqY
51	fBodyAccmeanFreqZ
52	fBodyAccJerkmeanX
53	fBodyAccJerkmeanY
54	fBodyAccJerkmeanZ
55	fBodyAccJerkstdX
56	fBodyAccJerkstdY
57	fBodyAccJerkstdZ
58	fBodyAccJerkmeanFreqX
59	fBodyAccJerkmeanFreqY
60	fBodyAccJerkmeanFreqZ
61	fBodyGyromeanX
62	fBodyGyromeanY
63	fBodyGyromeanZ
64	fBodyGyrostdX
65	fBodyGyrostdY
66	fBodyGyrostdZ
67	fBodyGyromeanFreqX
68	fBodyGyromeanFreqY
69	fBodyGyromeanFreqZ
70	fBodyAccMagmean
71	fBodyAccMagstd
72	fBodyAccMagmeanFreq
73	fBodyBodyAccJerkMagmean
74	fBodyBodyAccJerkMagstd
75	fBodyBodyAccJerkMagmeanFreq
76	fBodyBodyGyroMagmean
77	fBodyBodyGyroMagstd
78	fBodyBodyGyroMagmeanFreq
79	fBodyBodyGyroJerkMagmean
80	fBodyBodyGyroJerkMagstd
81	fBodyBodyGyroJerkMagmeanFreq

```