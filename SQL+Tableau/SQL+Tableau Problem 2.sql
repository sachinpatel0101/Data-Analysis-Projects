/* Problem 2 ----> Compare number of male managers to number of female managers from different departments for each year,
starting from 1990*/

-- Solution

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN 
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;


QUERIED DATASET LINK ----> https://docs.google.com/spreadsheets/d/17TkUfhyLhDdSTHAxXUfda2vIAGy9t1RSWBPPx274xKA/edit#gid=1870463339
    
TABLEAU VISUALIZATION LINK----> https://public.tableau.com/app/profile/sachin.patel8488/viz/Number_Of_Active_Managers_Department_Wise_1990-2002/Number_Of_Active_Managers_Department_Wise_1990-2002
    