# Rename this file to sql.py
# Fill in credentials
host='data-analytics-course.c8g8r1deus2v.eu-central-1.rds.amazonaws.com'
port='5432'
database='postgres'
user='paulrahn'
password='en30U2h9ZOGaQsHx'

# api key
#api_key

## Do NOT change anything below!
# sqlalchemy engine for writing data to a database
from sqlalchemy import create_engine    
get_engine = create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')

# Import the Python packages for get_data() function
import psycopg2
import pandas as pd
# Insert the get_data() function definition below
def get_data(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # create a connection to the PostgreSQL server
        conn = psycopg2.connect(host=host,
                        port=port,
                        database=database,
                        user=user,
                        password=password)
        result = pd.read_sql_query(query, conn)
        display(result)
        # close the connection to the PostgreSQL database
        conn.close()
        return(result)
    # the code below makes the function more robust, you can ignore this part
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()