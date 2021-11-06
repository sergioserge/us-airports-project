# import python packages 
import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# import from own modules
# credetials
from creds import host, port, database, user, password

# functions for connection
def get_conn():
    return psycopg2.connect(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password)

# function
def get_engine():
    return create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')


# function get_data for sql
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
		
        display(pd.read_sql_query(query, conn))
       
	    # close the connection to the PostgreSQL database
        conn.close()

    # the code below makes the function more robust, you can ignore this part
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()