SELECT students.student_name AS s_name,
	students.surname AS S_surname,
	courses.course_name AS c_name,
	students.grade AS grade,
	students.level AS s_level,
	SUM(records.duration) AS duration
FROM customers
RIGHT JOIN students ON students.parent_id = customers.customer_id
LEFT JOIN records ON records.student_id = students.student_id
LEFT JOIN courses ON courses.course_id = records.course_id
WHERE records.record_date >= {start} AND records.record_date <= {stop}
	AND EXTRACT(MONTH FROM records.record_date) = EXTRACT(MONTH FROM CURRENT_DATE)
	AND students.acad_year = {acad_year}
	AND customers.customer_id = '%s'
GROUP BY students.student_name, students.surname, students.grade, students.level, courses.course_name
