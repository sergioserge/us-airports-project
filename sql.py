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

# get data as dataframe from database
def query_database(query_string):
    engine = get_engine()
    with engine.connect() as connection:
        result = connection.execute(query_string)
        result = result.fetchall()
        #df = pd.DataFrame(result)
    
    return result

# save dataframe to database
def save_to_db(df, table_name):
    # function to upload the data to the database
    engine = get_engine()

    if engine != None:
        try:
            df.to_sql(table_name, # Name of SQL table
                            con=engine, # Engine or connection
                            if_exists='replace', # Drop the table before inserting new values 
                            index=False, # Write DataFrame index as a column
                            chunksize=5000, # Specify the number of rows in each batch to be written at a time
                            method='multi') # Pass multiple values in a single INSERT clause
            return print(f"The {table_name} table was imported successfully.")
        # Error handling
        except (Exception, psycopg2.DatabaseError) as error:
            engine = None
            return print(error)


# function get_data for sql
def get_data(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # create a connection to the PostgreSQL server
        conn = get_conn()

        display(pd.read_sql_query(query, conn))
       
	    # close the connection to the PostgreSQL database
        conn.close()

    # the code below makes the function more robust, you can ignore this part
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()