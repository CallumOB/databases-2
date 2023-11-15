import pandas as pd
from pymongo import MongoClient
import json

df = pd.read_csv('eruptions.csv', sep=',', delimiter=None, encoding='UTF-8')

# Replace column name spaces with underscores
df.columns = list(map(lambda x: x.replace(" ", "_"), df.columns))
print(df.dtypes)

# Renaming Elevation_(m)
df = df.rename(columns={"Elevation_(m)": "Elevation"})
print(df.columns)

# checking if volcano number and volcano name are 1:1
for i in sorted(df.Volcano_Name.unique()):
    if len(df[df.Volcano_Name==i].Volcano_Number.unique())!=1:
        print(i)

# Checking for N/A Data
print("Volcano_Number", df.Volcano_Number.isnull().sum())
print("Volcano_Name", df.Volcano_Name.isnull().sum())
print("Country", df.Country.isnull().sum())
print("Primary_Volcano_Type", df.Primary_Volcano_Type.isnull().sum())
print("Activity_Evidence", df.Activity_Evidence.isnull().sum())
print("Last_Known_Eruption", df.Last_Known_Eruption.isnull().sum())
print("Region", df.Region.isnull().sum())
print("Subregion", df.Subregion.isnull().sum())
print("Latitude", df.Latitude.isnull().sum())
print("Longitude", df.Longitude.isnull().sum())
print("Elevation", df.Elevation.isnull().sum())
print("Dominant_Rock_Type", df.Dominant_Rock_Type.isnull().sum())
print("Tectonic_Setting", df.Tectonic_Setting.isnull().sum())

print(df[df.Dominant_Rock_Type.isnull()])
print(df[df.Tectonic_Setting.isnull()])

df['Dominant_Rock_Type'].fillna("Not Specified", inplace=True)
df['Tectonic_Setting'].fillna("Not Specified", inplace=True)

print(df[['Volcano_Number',
          'Volcano_Name',
          'Country',
          'Primary_Volcano_Type',
          'Activity_Evidence',
          'Last_Known_Eruption', 
          'Region', 
          'Subregion',
          'Latitude', 
          'Longitude',
          'Elevation',
          'Dominant_Rock_Type',
          'Tectonic_Setting']].isnull().values.any())

# Setting up data frame for inserting data into the DB
