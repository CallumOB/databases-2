import psycopg2, getpass, pandas as pd
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="",  
        user = "",
        password=getpass.getpass(prompt='Password '),
        port="", 
        database="")
    cursor = connection.cursor()
    postgreSQL_select_Query = 'select ...'
    cursor.execute(postgreSQL_select_Query)
    df = pd.DataFrame(
        cursor.fetchall(), 
        columns=['',''])
    print(df)
except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if (connection):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
    else:
        print("Terminating")
