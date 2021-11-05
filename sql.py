# import python packages 
import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# import from own modules
# credetials
from creds import host, port, database, user, password


def get_conn():
    return psycopg2.connect(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password)

def get_engine():
    return create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')