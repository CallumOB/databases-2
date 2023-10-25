import psycopg2, getpass
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="147.252.250.51",
        user = "C21306503",
        password = "$Postgres$",
        port="5432",
        database="postgres")
    
    # Create a cursor to perform database operations
    cursor = connection.cursor()
    # First time around, check to see what information you're getting back from the server.
    scode = input('Enter Stock Code: ')
    sno = input('Enter Staff Number: ')
    quantity = input('Enter Quantity: ')
    cursor.execute(f"CALL addSale('{scode}', {sno}, {quantity});")
    connection.commit()

    print(connection.notices[0])
        
except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL")
    print("Error details: ",error)
finally:
    if (connection):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
    else:
        print("Terminating")
