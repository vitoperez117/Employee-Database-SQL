# Employee-Database-SQL

## Table of Contents

1) ERD of schema (.png)
1) Table schemata SQL (.sql)
1) SQL Queries (.sql)
1) Employee salary on SQL Alchemy (.py)
1) Employee salary on SQL Alchemy (.ipynb)
1) Average Salary by Title Data Frame (.png)
1) Average Salary by Title Plot (.png)
2) Average Salary by Department Data Frame (.png)
3) Average Salary by Department Plot (.png)

## Analysis of Employee Salaries using SQL Alchemy

The task requires salaries to be aggregated by title. First, it is necessary to inspect the CSV files for 'salaries' and the 'titles' before the join and group by commands are issued. 

### Limitations
1) The 'titles' table has 443,308 rows whereas the 'salaries' table has 300,024. The 'titles' table includes repeat employee number entries with different titles which denotes a promotion or change of title.

2) The 'salaries' table does not include salary data for employees working past the year 2001; it contains no current salary data.

3) When performing an inner join on the departments, dept_emp, employees, and salaries tables, the dates do NOT match up. Specifically, the 'from_date' in the department employee ('dept_emp') table is not the same as the 'from_date' in the salaries table.

There are 245,736 employee with mismatched 'hire_date' and 'start_date' entries. There are 323,161 employees with mismatched final dates of employment ('to_date') between the 'department employee' and 'salaries' tables.



### Average Salary Grouped by Title

![Average Salary by Title](Average_Salary_by_Title_DF.png)

![Average Salary by Title](Average_Salary_by_Employee_Title.png)

Comparing average salaries per title, the data immediately looks erroneous. An assistant engineer, an engineer, a senior engineer, and a technique leader should not be earning nearly the same salaries because of their places in the professional hierarchy. Similarly, a staff member should not be earning the same as a senior staff member. Based on the hierarchy of titles and the size of the company, the average salaries for superior or senior roles should be substantially greater than junior or subordinate roles.


### Average Salary per Department
![Average Salary by Department](Average_Salary_by_Department_DF.png)

![Average Salary by Department](Average_Salary_by_Department.png)

Although the 'salaries' table is not updated, the budget allocation for department salaries appears sound. 


