/* PROBLEM 4 - Create an SQL stored procedure that will allow you to obtain the average male and female salary per department 
within a certain salary range. Let this range defined by two values the user can insert when calling the procedure. 
Finally, visualize the obtained result-set in tableau as aduoble bar chart.*/

-- SOLUTION 

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_sal float, IN p_max_sal float)
BEGIN
SELECT
	d.dept_name,
    e.gender,
    avg(s.salary) as average_salary
FROM 
	t_salaries s
    JOIN
    t_employees e ON s.emp_no = e.emp_no
    JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
    JOIN
    t_departments d ON d.dept_no = de.dept_no
WHERE
	s.salary BETWEEN p_min_sal AND p_max_sal 
GROUP BY
	d.dept_name,
    e.gender;
END$$
DELIMITER ;

CALL filter_salary(50000,90000);






QUERIED DATA SET LINK ----> https://docs.google.com/spreadsheets/d/1tWCpV6-xTLQpk9BpKs7EJ_1ZuGEwsqWNHSz5u4oTrQU/edit#gid=1203421755

TABLEAU VISUALIZATION LINK ----> https://public.tableau.com/app/profile/sachin.patel8488/viz/EmployeeSalaryComparision/Sheet1
    
    
	