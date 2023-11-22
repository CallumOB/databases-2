import pandas as pd
import json
from pymongo import MongoClient

uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)

airport_df = pd.read_csv('airports.csv', sep=',', delimiter=None, encoding='latin-1')
airline_df = pd.read_csv('airlines.csv', sep=',', delimiter=None, encoding='latin-1')
routes_df = pd.read_csv('routes.csv', sep=',', delimiter=None, encoding='latin-1')