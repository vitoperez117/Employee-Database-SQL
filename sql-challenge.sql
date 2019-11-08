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

--Query 1--Employee Details
create view test1 as
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no;
	
select * from test1;


--Query 2--Employees hired in 1986
drop view if exists test2

create view test2 as 
select e.last_name, e.first_name, e.hire_date
from employees as e
where (extract (year from (e.hire_date))) = 1986;

select * from test2;


--Query 3--Manager info
drop view if exists test3

create view test3 as
select d.dept_no, d.dept_name, e.first_name, e.last_name, m.emp_no, m.from_date, m.to_date 
from dept_manager as m 
join departments as d on d.dept_no = m.dept_no
join employees as e on e.emp_no = m.emp_no
order by dept_name;


select * from test3;


--Query 4--Employee and Department Info
drop view if exists test4;

create view test4 as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as s on s.emp_no = e.emp_no
join departments as d on s.dept_no = d.dept_no
order by e.emp_no;

select * from test4;

--Query 5--Employees with First Name of Hercules and Last Name starts with B
drop view if exists test5;

create view test5 as
select  e.emp_no, e.last_name, e.first_name
from employees as e
where e.first_name = 'Hercules'
and e.last_name like 'B%'
order by e.emp_no;

select * from test5;