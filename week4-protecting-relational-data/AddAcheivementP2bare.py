import psycopg2, getpass
from psycopg2 import Error
try:
    connection = psycopg2.connect(
        host="localhost",
        user = "Sample",
        password = getpass.getpass(),
        port="5432",
        database="postgres")
    # Create a cursor to perform database operations
    cursor = connection.cursor()
    
    bname = input('Subject Name: ')
    bsyll = input('Subject Syllabus: ')
   # print(pname, type(pname), psyll, type(psyll))
    cursor.callproc('"Sample".ADDsubject',[bname, bsyll])
    print('New subject id is ',cursor.fetchone()[0])
  
    pname = input('Student Name: ')
    cursor.callproc('"Sample".ADDstudent',[pname])
    
    print('New student id is ',cursor.fetchone()[0])
    #Add the student to the subject
      cursor.callproc('"Sample".addachievement',(pname, bname))
    connection.commit()
 
except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if (connection):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
    else:
        print("Terminating")