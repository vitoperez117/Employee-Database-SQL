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


#establish database path
database_path = 'postgres://postgres:password@localhost:5432/vito'

#create engine
engine = create_engine(f'postgresql://{database_path}')
conn = engine.connect()

#read sql into pandas 
data = pd.read_sql("select * from salaries", conn)

#Average salary based on title (Query 1)
query1 = """select t.title, round(avg(s.salary), 2) as average_salary 
FROM salaries as s 
LEFT OUTER JOIN titles as t 
ON s.emp_no = t.emp_no group by t.title;"""

data1 = pd.read_sql(query1, conn)

salary_title_pd = pd.DataFrame(data = data1)

#bar chart of data frame
x_axis = salary_title_pd['title']
y_axis = salary_title_pd['average_salary']

fig = plt.figure(figsize = (12,7))
plt.xticks(rotation = 45)
plt.title ("Average Salary by Employee Title")
plt.bar(x_axis, y_axis)

plt.savefig("Average_Salary_by_Employee_Title.png", bbox_inches = 'tight')

#Average salary per department (Query 2)
query2 = """SELECT e.dept_no, d.dept_name, 
COUNT (DISTINCT (e.emp_no)) AS employees, round(AVG (s.salary), 2) AS average_dept_salary
FROM departments d
JOIN dept_emp e
ON d.dept_no = e.dept_no
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY d.dept_name, e.dept_no
ORDER BY average_dept_salary DESC;"""

data2 = pd.read_sql(query2, conn)

x_data2 = data2['dept_name']
y_data2 = data2['average_dept_salary']

fig = plt.figure(figsize = (9, 5))

plt.xticks(rotation = 45)
plt.title ("Average Salary by Department")
plt.bar(x_data2, y_data2)

plt.savefig("Average_Salary_by_Department.png", bbox_inches = 'tight')

#Comprehensive Table of Employee Data (Query 3)
query3 = """SELECT d.dept_name, CAST(de.emp_no AS int), 
e.first_name, e.last_name, t.title,
e.hire_date, 
de.from_date AS de_from_date, s.from_date AS s_from_date, t.from_date AS t_from_date,
de.to_date AS de_to_date, s.to_date AS s_to_date, t.to_date AS t_to_date,
s.salary
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN salaries s
ON e.emp_no = s.emp_no
JOIN titles t
ON s.emp_no = t.emp_no
ORDER BY length(de.emp_no), de.emp_no ASC;"""

data3 = pd.read_sql(query3, conn)

