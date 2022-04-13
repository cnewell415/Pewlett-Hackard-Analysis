Employee_Database_challenge.sql

-- Create new tables with employee name information and employee title information
SELECT em.emp_no, 
    em.first_name, 
    em.last_name,
    ti.title, 
    ti.from_date, 
    ti.to_date 
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31' 
ORDER BY em.emp_no


-- Remove duplicates from retirement_titles, keeping the most recent title of an employee

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


-- # of employees about to retire within a job title

SELECT title, COUNT(title) AS "job_count" FROM unique_titles
GROUP BY title
ORDER BY "job_count" DESC


-- Mentorship Eligibility Table
-- Holds Emlpoyees eligiable for mentorships
-- i.e. born between 1965-01-01 and 1965-12-31

SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, dp.from_date, dp.to_date, ti.title
INTO mentorship_eligibility
FROM employees as em
INNER JOIN dept_emp as dp
ON em.emp_no = dp.emp_no
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE dp.to_date = '9999-01-01' AND em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY em.emp_no


--- Check Tables
SELECT * FROM retirement_titles;
