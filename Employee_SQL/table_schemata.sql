--Create tables with columns for csv imports
create table departments (
	dept_no varchar,
	dept_name varchar);

create table dept_manager (
	dept_no varchar,
	emp_no varchar,
	from_date date,
	to_date date);

create table dept_emp (
	emp_no varchar,
	dept_no varchar,
	from_date date,
	to_date date);

create table employees (
	emp_no varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	gender char,
	hire_date date);
	
create table salaries (
	emp_no varchar,
	salary int,
	from_date date,
	to_date date);
	
create table titles (
	emp_no varchar,
	title varchar,
	from_date date,
	to_date date);

----Import CSV files into postgres database (vito/postgres@employeeDatabase)

COPY departments (dept_no, dept_name)
FROM '/Users/vito/Desktop/HW BootCamp/9-sql-challenge/CSV files/departments.csv'
DELIMITER ','
CSV HEADER;

COPY dept_emp (emp_no, dept_no, from_date, to_date)
FROM '/Users/vito/Desktop/HW BootCamp/9-sql-challenge/CSV files/dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY dept_manager (dept_no, emp_no, from_date, to_date)
FROM '/Users/vito/Desktop/HW BootCamp/9-sql-challenge/CSV files/dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
FROM '/Users/vito/Desktop/HW BootCamp/9-sql-challenge/CSV files/employees.csv'
DELIMITER ','
CSV HEADER;

COPY salaries (emp_no, salary, from_date, to_date)
FROM '/Users/vito/Desktop/HW BootCamp/9-sql-challenge/CSV files/salaries.csv'
DELIMITER ','
CSV HEADER;
