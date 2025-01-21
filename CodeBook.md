# Codebook

This **Codebook** describes the variables and processes used in the `run_analysis.R` script to create the `tidyData.txt` dataset. It also details how the raw data was transformed to create this clean and tidy dataset.

## Dataset Description

The `tidyData.txt` dataset was created from two main sources: training and test data. The data comes from a study where 30 volunteers performed various activities while wearing a smartphone with embedded accelerometers and gyroscopes.

### Original Files
- `subject_train.txt` and `subject_test.txt`: Identifiers of the subjects who performed the activities.
- `X_train.txt` and `X_test.txt`: Measurement data collected during the activities.
- `y_train.txt` and `y_test.txt`: Activity labels.

### Data Transformations and Cleaning

1. **Merging Data**: The training and test datasets were combined to create a single dataset.
2. **Extracting Variables**: Only the mean and standard deviation measurements for each measurement were kept.
3. **Descriptive Labeling**: Descriptive names were assigned to activities and variables.
4. **Creating an Ordered Dataset**: A second dataset was created containing the mean of each variable for each activity and subject.

## Variables in `tidyData.txt`

### Identifiers
- `subject`: Unique identifier for each subject who performed the activities (range from 1 to 30).
- `activity`: Descriptive name of the activity performed (e.g., "WALKING", "STANDING").

### Measurement Variables
The following variables were calculated as the mean of the accelerometer and gyroscope signal measurements for each combination of subject and activity:

- `timeDomainBodyAccelerometerMeanX`: Mean of the body accelerometer on the X-axis (time domain).
- `timeDomainBodyAccelerometerMeanY`: Mean of the body accelerometer on the Y-axis.
- `timeDomainBodyAccelerometerMeanZ`: Mean of the body accelerometer on the Z-axis.
- `frequencyDomainBodyGyroscopeStandardDeviationX`: Standard deviation of the body gyroscope on the X-axis (frequency domain).
- (And so on for all variables derived from the accelerometer and gyroscope).

### Variable Naming Conventions

The following modifications were applied to improve the clarity of the variable names:
- `t` was replaced with `timeDomain`.
- `f` was replaced with `frequencyDomain`.
- `Acc` was expanded to `Accelerometer`.
- `Gyro` was expanded to `Gyroscope`.
- `Mag` was expanded to `Magnitude`.
- `Freq` was expanded to `Frequency`.
- `BodyBody` was shortened to `Body`.
- `mean` was changed to `Mean`.
- `std` was changed to `StandardDeviation`.

## Complete List of Variables

1. `subject`
2. `activity`
3. `timeDomainBodyAccelerometerMeanX`
4. `timeDomainBodyAccelerometerMeanY`
5. `timeDomainBodyAccelerometerMeanZ`
6. `frequencyDomainBodyGyroscopeStandardDeviationX`
7. `frequencyDomainBodyGyroscopeStandardDeviationY`
8. `frequencyDomainBodyGyroscopeStandardDeviationZ`
9. (And so on for all remaining variables).

