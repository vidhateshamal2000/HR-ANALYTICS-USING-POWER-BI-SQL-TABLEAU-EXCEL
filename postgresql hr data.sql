create table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
)
 select * from hrdata

 select sum(employee_count) from hrdata
-- where education = 'High School'
--where department = 'Sales'

 select sum(employee_count) as employee_count from hrdata 
 where education_field = 'Medical'

 select * from hrdata

select count(attrition) from hrdata
where attrition = 'Yes' and department = 'R&D' and education_field = 'Medical'
and education = 'High School'

select * from hrdata
select round(((select count(attrition) from hrdata where attrition = 'Yes' and department = 'Sales') / 
sum (employee_count)) * 100, 2 ) from hrdata
where department = 'Sales'

select (select sum(employee_count) from hrdata) - count(attrition) as active_employee from hrdata
where attrition='Yes';



select * from hrdata
select round (avg(age),0) as Avg_age from hrdata

-- Attrition by Gender

select gender, count(attrition) from hrdata
where attrition = 'Yes'
group by gender
order by count(attrition) desc  

--department wise Attrition 

select department, count(attrition), round((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as pct from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc;

-- No  of employee by Age Group

select age, sum(employee_count) from hrdata
group by age
order by age

-- Education wise Attrition
select education_field, count(attrition) from hrdata
where attrition = 'Yes'
group by education_field
order by count(attrition) desc


--Attrition Rate by Gender for different Age Group
select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;


-- Job Satisfaction Rating

create extension if not exists tablefunc;

---Then run this to get o/p-
SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;

