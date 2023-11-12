from pymongo import MongoClient

uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)
database = client['Dealers']
collection = database['Car']

document_count = collection.count_documents({})
print(f"Number of documents in the collection: {document_count}")

result = collection.find_one({"Name": "Maruti 800 AC"})
if result:
    print('Document Found:')
    print(result)
else: 
    print("Document not found.")

client.close()