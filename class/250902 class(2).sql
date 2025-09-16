use employees;
select gender, count(*) from employees.employees
group by gender;

/* Sanjai Luders의 급여보다 높은 급여를 받는 직원의 정보(사원정보, 이름, 담당업무, 급여)를 조회하세요. */
-- 1단계 : Sanjai Luders의 급여 구하기 
select first_name, last_name, salary  -- 155513
from employees e
join salaries s on e.emp_no = s.emp_no 
where e.first_name = 'sanjai' and e.last_name = 'luders' and s.to_date = '9999-01-01';  
-- 2단계 : 155513보다 높은 급여를 받는 직원들 
select *  
from employees e
join salaries s on e.emp_no = s.emp_no 
where to_date = '9999-01-01' and salary > 155513; 
-- 합치기 
select *  
from employees e
join salaries s on e.emp_no = s.emp_no 
where to_date = '9999-01-01' and salary > 
	(select salary  
	from employees e
	join salaries s on e.emp_no = s.emp_no 
	where e.first_name = 'sanjai' and e.last_name = 'luders' and s.to_date = '9999-01-01'); 


-- 급여 제일 많이 받는 직원 5명 
select e.first_name, e.last_name 
from employees e join salaries s on e.emp_no = s.emp_no
where s.to_date = '9999-01-01'
order by s.salary desc
limit 5;



-- 현재 월급 제일 많이 받는 직원 
select e.first_name, e.last_name 
from employees e join salaries s on e.emp_no = s.emp_no
where s.to_date = '9999-01-01'
and salary = (
    SELECT MAX(salary) FROM salaries
);
