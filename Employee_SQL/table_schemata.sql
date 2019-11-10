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
