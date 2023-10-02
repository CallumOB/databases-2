import psycopg2, getpass, pandas as pd
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="localhost",
        user = "BUILDER",
        password = getpass.getpass(prompt='Password:'),
        port="5432",
        database="postgres")
    custname = input('Enter customer name: ')
    # Create a cursor to perform database operations
    cursor = connection.cursor()
    postgreSQL_select_Query = "select customer_address from b2_customer where customer_name like '%s'"
    cursor.execute(postgreSQL_select_Query % custname)
    print("Customer Addresses")
    df = pd.DataFrame(
    cursor.fetchall(), 
    columns=['Address'])
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

