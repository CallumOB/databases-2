import psycopg2, getpass
from psycopg2 import Error
dockerServer=False
FirstTime=True
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
    if FirstTime:
    # Print PostgreSQL details
        print("PostgreSQL server information")
        print(connection.get_dsn_parameters(), "\n")
        # Executing a SQL query
        cursor.execute("SELECT version();")
        # Fetch result
        record = cursor.fetchone()
        print("You are connected to - ", record, "\n")   
    cname = input('Enter Customer Name: ')
    caddr = input('Enter Customer Address: ')
    cursor.callproc('ADDCUSTOMER',(cname, caddr))
    connection.commit()
    CustId = cursor.fetchone()[0]
    print("Customer id = ", CustId)
    #     row =cursor.fetchone()
except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if (connection):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
    else:
        print("Terminating")