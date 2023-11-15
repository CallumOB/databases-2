import pandas as pd 
import json
from pymongo import MongoClient

df = pd.read_csv('Swimming Database 2.csv', encoding='latin-1')
print(f"Columns: \n{df.columns}")
print(f"Dataframe shape: {df.shape}")

# Replacing spaces in column names with underscores
df.columns = list(map(lambda x: x.replace(" ", "_"), df.columns))
print(df.dtypes)

# Renaming duration and dropping swim_time as they have the same data
df = df.rename(columns={"Duration_(hh:mm:ss:ff)": "Duration"})
df = df.drop(columns=['Swim_time'])
print(df.columns)

# Converting date formats 
df['Athlete_birth_date']=pd.to_datetime(df['Athlete_birth_date'],format='%m/%d/%Y').dt.date
df['Athlete_birth_date']=df['Athlete_birth_date'].astype("string")

df['Swim_date']=pd.to_datetime(df['Swim_date'],format='%m/%d/%Y').dt.date
df['Swim_date']=df['Swim_date'].astype("string")

# Unique values in each column 
print('Unique values')
print(df.nunique())
print('Top 5 rows')
print(df.head(2))
print(df.tail(2))


# MY WORK: Checking if team code and team name are 1:1 (they are)
for i in  sorted(df.Team_Code.unique()):
    if len(df[df.Team_Code==i].Team_Name.unique())!=1:
        print(i)

# I will design a 1:few relationship between team and swims to show all swims a team has competed in. It will also show each athlete from that team that competed in that swim. 
# Remcving null data 
print('Event_Name', df.Event_Name.isnull().sum())
print('Event_description', df.Event_description.isnull().sum())
print('Swim_date', df.Swim_date.isnull().sum())
print('Rank_Order', df.Rank_Order.isnull().sum())
print('City', df.City.isnull().sum())
print('Duration', df.Duration.isnull().sum())
print(df[df.City.isnull()])

df["City"].fillna("Not Specified", inplace = True)

print(df[['Event_Name', 
            'Event_description', 
            'Swim_date', 
            'Rank_Order', 
            'City', 
            'Country_Code', 
            'Duration']].isnull().values.any())

# Setting up data frames
team_df = df[['Team_Name', 'Team_Code']].drop_duplicates()

print(f"\n{team_df.Team_Name}\n")
print(f"\n{team_df.describe(include='all')}\n")
print(f"\n{team_df.isnull().values.any()}\n")

# Connecting to mongodb
uri = uri = 'mongodb://admin:Sp00ky!@localhost:27017/?AuthSource=admin'
client = MongoClient(uri)

mydb = client["Swimming"]
mycol = mydb["Team"]
mycol.drop()

for row in team_df.itertuples():
    print(row.Team_Name, type(row))

    teamswims = df[df.Team_Name == row.Team_Name][['Event_Name',
                                                   'Event_description',
                                                   'Swim_date',
                                                   'Athlete_Full_Name',
                                                   'Gender',
                                                   'Athlete_birth_date',
                                                   'Rank_Order',
                                                   'City',
                                                   'Country_Code',
                                                   'Duration']]
    
    entries = json.dumps({"Team Name": row.Team_Name,
                          "Team Code": row.Team_Code,
                          "Events": teamswims.to_dict('records')})

    x = mycol.insert_one(json.loads(entries))

client.close()
