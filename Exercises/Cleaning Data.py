import numpy as np
import pandas as pd

data = pd.read_csv('cereal_calories.csv', header='infer')

print('\nAvailable -1 in different attributes')
print((data==-1).sum())

data2 = data.replace(-1, np.NaN) # Replacing -1 with NaN

print('Number of missing values:')
for col in data2.columns:
    print('\t%s: %d' % (col, data2[col].isna().sum()))

print('Number of rows in original data = %d' % (data2.shape[0]))
data2 = data2.dropna() # Dropping the rows containing NaN
print('Number of rows after discarding missing values = %d' % (data2.shape[0]))


# Generating a csv file with the clearned data
data2.to_csv('cereal_calories_cleaned.csv', sep=',', index=False)
print('Cleaned data saved as a .csv file')