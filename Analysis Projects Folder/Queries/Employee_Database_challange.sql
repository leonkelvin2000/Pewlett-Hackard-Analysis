-- Provide employee info and title for employees born between 1952 and 1955
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date,
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Retrieve number of employees by their most recent job title who are about to retire
SELECT count(emp_no),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(emp_no) DESC;

-- Create a mentorship-eligible table for employees born in 1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Total summary of people retiring
SELECT *
FROM retiring_titles;

SELECT * FROM mentorship_eligibility;

-- Total summary of people eligible for a mentorship program
SELECT COUNT(emp_no)
FROM mentorship_eligibility;

-- Total summary of people eligible for a mentorship program - group by title
SELECT COUNT(emp_no) AS "Total Count", title
FROM mentorship_eligibility
GROUP BY title
ORDER BY "Total Count" DESC;

SELECT *
FROM retiring_titles;
