import psycopg2, getpass
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="localhost",
        user = "BUILDER",
        password = getpass.getpass(),
        port="5432",
        database="postgres")
    # Create a cursor to perform database operations
    cursor = connection.cursor()
    # First time around, check to see what information you're getting back from the server.
    cid = input('Enter Customer Id: ')
    sno = input('Enter Staff Number: ')
    cursor.callproc('ADDCUSTORDER',(cid, sno))
    connection.commit()
    print("Customer Order id = ", cursor.fetchone()[0])
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
