import psycopg2, getpass
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="localhost",
        user = "builder",
        password = getpass.getpass(),
        port="54321",
        database="postgres")
    # Create a cursor to perform database operations
    cursor = connection.cursor()
    # First time around, check to see what information you're getting back from the server.
    sname = str(input('Enter Student Name: '))
    cursor.callproc('ADDSTUDENT', (sname,))
    connection.commit()
    print("Student ID = ", cursor.fetchone()[0])
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
