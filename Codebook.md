# Codebook for Coursera "Getting and Cleaning Data" course assginment

The dataset corresponding to this codebook is located in file 'tidy_set.txt' in this repository.
See the 'Readme' file for background information on this data set.

## Data
The 'tidy_set.txt' data file is a text file, containg space-separated values.
The first row contains the name of the variables, which are listed and described below, followed by rows containing the values.

## Variables
Each row contains, for a given subject and activity, average signal measurements.

### Identifiers
- 'subjectID': Subject identifier, integer, ranges from 1 to 30.
- 'activityID': Activity identifier, string with 6 possible values: 'WALKING', 'WALKING UPSTAIRS', 'WALKING DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'

### Average of measurements
All measurements are floating-point values, normalised and bounded within [-1,1].

Prior to normalisation, acceleration measurements (variables containing `Accelerometer`) were made in *g*'s (9.81 m.s⁻²) and gyroscope measurements (variables containing `Gyroscope`) were made in radians per second (rad.s⁻¹).

Magnitudes of three-dimensional signals (variables containing `Magnitude`) were calculated using the Euclidean norm.

The measurements are classified in two domains:

- Time-domain signals (variables prefixed by `timeDomain`), resulting from the capture of accelerometer and gyroscope raw signals.
- Frequency-domain signals (variables prefixed by `frequencyDomain`), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals.

#### Time-domain signals
- `timeDomainBodyAccelerometerMeanX/Y/Z` 
- `timeDomainBodyAccelerometerStandardDeviationX/Y/Z` 
- `timeDomainGravityAccelerometerMeanX/Y/Z`
- `timeDomainGravityAccelerometerStandardDeviationX/Y/Z`
- `timeDomainBodyAccelerometerJerkMeanX/Y/Z` 
- `timeDomainBodyAccelerometerJerkStandardDeviationX/Y/Z` 
- `timeDomainBodyGyroscopeMeanX/Y/Z` 
- `timeDomainBodyGyroscopeStandardDeviationX/Y/Z`
- `timeDomainBodyGyroscopeJerkMeanX/Y/Z` 
- `timeDomainBodyGyroscopeJerkStandardDeviationX/Y/Z` 
- `timeDomainBodyAccelerometerMagnitudeMean` 
- `timeDomainBodyAccelerometerMagnitudeStandardDeviation` 
- `timeDomainGravityAccelerometerMagnitudeMean` 
- `timeDomainGravityAccelerometerMagnitudeStandardDeviation` 
- `timeDomainBodyAccelerometerJerkMagnitudeMean` 
- `timeDomainBodyAccelerometerJerkMagnitudeStandardDeviation` 
- `timeDomainBodyGyroscopeMagnitudeMean`
- `timeDomainBodyGyroscopeMagnitudeStandardDeviation` 
- `timeDomainBodyGyroscopeJerkMagnitudeMean`
- `timeDomainBodyGyroscopeJerkMagnitudeStandardDeviation` 

#### Frequency-domain signals
- `frequencyDomainBodyAccelerometerMeanX/Y/Z` 
- `frequencyDomainBodyAccelerometerStandardDeviationX/Y/Z` 
- `frequencyDomainBodyAccelerometerMeanFrequencyX/Y/Z` 
- `frequencyDomainBodyAccelerometerJerkMeanX/Y/Z` 
- `frequencyDomainBodyAccelerometerJerkStandardDeviationX/Y/Z` 
- `frequencyDomainBodyAccelerometerJerkMeanFrequencyX/Y/Z` 
- `frequencyDomainBodyGyroscopeMeanX/Y/Z` 
- `frequencyDomainBodyGyroscopeStandardDeviationX/Y/Z` 
- `frequencyDomainBodyGyroscopeMeanFrequencyX/Y/Z` 
- `frequencyDomainBodyAccelerometerMagnitudeMean` 
- `frequencyDomainBodyAccelerometerMagnitudeStandardDeviation` 
- `frequencyDomainBodyAccelerometerMagnitudeMeanFrequency` 
- `frequencyDomainBodyAccelerometerJerkMagnitudeMean` 
- `frequencyDomainBodyAccelerometerJerkMagnitudeStandardDeviation`
- `frequencyDomainBodyAccelerometerJerkMagnitudeMeanFrequency` 
- `frequencyDomainBodyGyroscopeMagnitudeMean` 
- `frequencyDomainBodyGyroscopeMagnitudeStandardDeviation` 
- `frequencyDomainBodyGyroscopeMagnitudeMeanFrequency` 
- `frequencyDomainBodyGyroscopeJerkMagnitudeMean` 
- `frequencyDomainBodyGyroscopeJerkMagnitudeStandardDeviation` 
- `frequencyDomainBodyGyroscopeJerkMagnitudeMeanFrequency`

## Transformations

The zip file containing the source data is located at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

The following transformations were applied to the source data:
1. The training and test sets were merged to create one data set.
2. The measurements on the mean and standard deviation (i.e. signals containing the strings `mean` and `std`) were extracted for each measurement, and the others were discarded.
3. The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see identifier section)
4.The variable names were replaced with descriptive variable names (e.g. `tBodyAcc-mean()-X` was expanded to `timeDomainBodyAccelerometerMeanX`), using the following set of rules:
 - Special characters (i.e. `(`, `)`, and `-`) were removed.
 - The initial `f` and `t` were expanded to `frequencyDomain` and `timeDomain` respectively.
 -  - `Acc`, `Gyro`, `Mag`, `Freq`, `mean`, and `std` were replaced with `Accelerometer`, `Gyroscope`, `Magnitude`, `Frequency`, `Mean`, and `StandardDeviation` respectively.
 5. From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.
 
 The collection of the source data and the transformations listed above were implemented by the `run_analysis.R` R script (see `README.md` file for usage instructions).

 
