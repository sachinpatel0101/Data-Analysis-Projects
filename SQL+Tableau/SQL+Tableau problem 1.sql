/* Problem 1- Create a visualization that provides breakdown between the male and female employees working in company 
each year, starting from 1990*/

-- Solution

SELECT year(d.from_date) as Calender_Year,
	e.gender,
    COUNT(e.emp_no)
FROM
	t_dept_emp d JOIN t_employees e
    ON d.emp_no = e.emp_no
GROUP BY Calender_Year, e.gender
HAVING Calender_Year >= 1990
ORDER BY gender asc,
	Calender_Year asc;
    



LINK TO QUERY RESULTS----> https://docs.google.com/spreadsheets/d/1k1jMjgG7SxK1v7qNmqHVey-IXFCgRXZ2xzpY2Tptk7g/edit#gid=848474173


LINK TO TABLEAU VISUALIZATION----> https://public.tableau.com/app/profile/sachin.patel8488/viz/num_of_employees_Trend_1990-2002/Num_Of_Employees1990-2002