--NEW QUERIES (1/16/2024)
--Separate Hire Date into Year, Month, Day in the Employees Table
SELECT *,
EXTRACT(YEAR FROM hire_date) AS hire_year,
EXTRACT(MONTH FROM hire_date) AS hire_month,
EXTRACT(DAY FROM hire_date) AS hire_day
FROM employees;


--Check for Errors in Salary Table
SELECT *
FROM salaries
ORDER BY to_date DESC; 


--Check if Dates Match Up from each Table 
CREATE VIEW test_all AS
SELECT d.dept_no, d.dept_name, CAST(de.emp_no AS int), 
e.first_name, e.last_name, 
e.hire_date, 
de.from_date AS de_from_date, s.from_date AS s_from_date,
de.to_date AS de_to_date, s.to_date AS s_to_date, 
s.salary
--JOIN tables: departments, dept_emp, employees, salaries
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY length(de.emp_no), de.emp_no ASC; --order by length of int and int


--JOIN Titles table with test_all VIEW above
SELECT d.dept_no, d.dept_name, CAST(de.emp_no AS int), 
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
ORDER BY length(de.emp_no), de.emp_no ASC;
--TOTAL ROWS: 489,903


--Check how many employees have mismatched hire and start dates
SELECT emp_no, hire_date, de_from_date
FROM test_all
WHERE hire_date != de_from_date;
--TOTAL: 245,736


--Check how many employees have mismatched to_dates
SELECT emp_no, de_to_date, s_to_date
FROM test_all
WHERE de_to_date != s_to_date;
--TOTAL: 323,161


--Check for Duplicate Entries
SELECT emp_no, COUNT (emp_no)
FROM test_all
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;
--TOTAL 31,579 duplicate employee numbers


--Average salary per department
CREATE VIEW avg_dept_salary AS
SELECT e.dept_no, d.dept_name, COUNT (DISTINCT (e.emp_no)) AS employees, AVG (s.salary) AS average_dept_salary
FROM departments d
JOIN dept_emp e
ON d.dept_no = e.dept_no
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY d.dept_name, e.dept_no
ORDER BY average_dept_salary DESC;


--OLD QUERIES (2019)
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
