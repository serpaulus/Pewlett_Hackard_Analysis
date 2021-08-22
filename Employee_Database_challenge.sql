-- The Number of Retiring Employees by Title
SELECT  e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
INTO emps_by_title
FROM employees AS e
    INNER JOIN titles AS ti
        ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
       	rt.first_name,
		rt.last_name,
		rt.title
INTO unique_titles
FROM  retirement_titles AS rt
ORDER BY rt.emp_no , to_date DESC;

--retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;

-- Create a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.

SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date  = '9999-01-01')
	   AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Count the number of elogible mentors per role in mentorship_eligibility table 

SELECT COUNT(me.title), me.title
INTO mentor_role_count
FROM mentorship_eligibility AS me
GROUP BY me.title
ORDER BY me.count DESC;







