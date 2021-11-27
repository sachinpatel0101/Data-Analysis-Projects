/* PROBLEM 3 - Compare the average salary of female vs male employees in entire company until year 2002 and add a filter 
allowing you to see that per each department*/

-- Solution

SELECT
	e.gender,
    d.dept_name,
    ROUND(avg(s.salary),2),
    year(s.from_date) as calender_year
FROM
	t_employees e
    JOIN
    t_salaries s ON e.emp_no = s.emp_no
    JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
    JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY
    dept_name,
    gender,
    calender_year
HAVING
	calender_year <=2002
ORDER BY
	de.dept_no;





QUERIED DATASET LINK ----> https://docs.google.com/spreadsheets/d/1JTg81j-WUgO_F0Yi6FW4dpJHYMSBmHhLQHH7WM0_BPE/edit#gid=708929425


TABLEAU VISUALIZATION LINK----> https://public.tableau.com/app/profile/sachin.patel8488/viz/SalariesComparisionGenderwiseandDepartmentwise1990-2002/Salaries_Comparision_Gender_wise_and_Department_wise_1990-2002