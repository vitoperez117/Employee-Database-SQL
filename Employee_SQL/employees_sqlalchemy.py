#import dependencies

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy import Integer
from sqlalchemy import Date

import pandas as pd

#set path

database_path = 'postgres://postgres:password@localhost:5432/SQL_Challenge'

#create engine
engine = create_engine(f'postgresql://{database_path}')
conn = engine.connect()

#read sql into pandas
data = pd.read_sql("select * from salaries", conn)

print (data.head())