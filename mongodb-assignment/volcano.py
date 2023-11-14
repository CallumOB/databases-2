import pandas as pd
from pymongo import MongoClient
import json

uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)

df = pd.read_csv('eruptions.csv', sep=',', delimiter=None, encoding='UTF-8')
