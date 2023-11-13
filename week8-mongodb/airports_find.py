import re
from pymongo import MongoClient

uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)
database = client['Aviation']
collection = database['City']

result = collection.find_one({"City":"London"})
if result:
    print(result)
else:
    print("Document not found.")

result = collection.find_one({"Country":"United Kingdom"})
if result:
    print(result)
else:
    print("Document not found.")

pattern = re.compile(r"Ferry|Station", re.IGNORECASE)
result = collection.find({
    "airports.Name": {"$regex":pattern}
})

for document in result:
    print(document)