import pandas as pd 
import json
import pymongo
from pymongo import MongoClient

uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)

df = pd.read_csv('dealers.csv', sep=',', delimiter=None, encoding = 'latin-1')

print('Dataframe Columns')
print(df.columns)

print('Dataframe shape')
print(df.shape)

print(f'Number of Different Models: {len(df.name.unique())}')
print(f'Number of Different Model Years: {len(df.year.unique())}')
print(f'Top 20 Rows: \n{df.head(20)}')

# extract header information of name and selling price
car = df[['name', 'year']].drop_duplicates().sort_values(['name', 'year'], 
ascending=[True, True])
print(f'Shape of header information: {car.shape}')

mydb = client['Dealers']
mycol = mydb['Car']
mycol.drop()

for row in car.itertuples(): 
    thiscar = (df[(df['name'] == row.name) & (df['year'] == row.year)])
    tc = thiscar[['selling_price', 'km_driven', 'fuel',
                  'seller_type', 'transmission', 'owner']]
    entries = json.dumps({
        "Name": row.name,
        "Year": row.year,
        "details": tc.to_dict('records')
    })

    x = mycol.insert_one(json.loads(entries))

client.close()