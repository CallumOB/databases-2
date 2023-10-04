import psycopg2, getpass, pandas as pd
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="localhost",  
        user = "builder",
        password=getpass.getpass('Password: '),
        port="54321", 
        database="postgres")
    cursor = connection.cursor()
    postgreSQL_select_Query = 'select * from student'
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
