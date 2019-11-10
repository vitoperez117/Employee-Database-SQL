#import dependencies

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy import Integer
from sqlalchemy import Date

import pandas as pd
import matplotlib.pyplot as plt

#set path

database_path = 'postgres://postgres:password@localhost:5432/SQL_Challenge'

#create engine
engine = create_engine(f'postgresql://{database_path}')
conn = engine.connect()

#read sql into pandas (practice)
data = pd.read_sql("select * from salaries", conn)

#print (data.head())

#read sql into pandas (average salary based on title)
data1 = pd.read_sql("select t.title, round(avg(s.salary)::numeric,2) as average_salary from salaries as s left outer join titles as t on s.emp_no = t.emp_no group by t.title;", conn)

#print (data1)

#convert sql query into dataframe
salary_title_pd = pd.DataFrame(data = data1)

#bar chart of data frame
x_axis = salary_title_pd['title']
y_axis = salary_title_pd['average_salary']

plt.xticks(rotation = 45)
plt.title ("Average Salary by Employee Title")
plt.bar(x_axis, y_axis)

plt.savefig("Average Salary by Employee Title.png")