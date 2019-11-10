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

--Query 6--All employees from Sales Department
drop view if exists test6;

create view test6 as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as s on s.emp_no = e.emp_no
join departments as d on s.dept_no = d.dept_no
where d.dept_name like 'Sales'
order by e.emp_no;

select * from test6;

--Query 7--All employees in Sales and Development
drop view if exists test7;

create view test7 as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as s on s.emp_no = e.emp_no
join departments as d on s.dept_no = d.dept_no
where d.dept_name like 'Sales'
or d.dept_name like 'Development'
order by e.emp_no;

select * from test7;

--Query 8--Frequency of Employee Last Names
drop view if exists test8;

create view test8 as
select e.last_name, count(e.last_name)
from employees as e
join dept_emp as s on s.emp_no = e.emp_no
join departments as d on s.dept_no = d.dept_no
group by e.last_name
order by count (e.last_name) desc;

select * from test8;