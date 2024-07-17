SELECT
	courses.course_name,
	SUM(records.duration) AS total_duration
FROM records
LEFT JOIN courses ON courses.course_id = records.course_id
LEFT JOIN students ON students.student_id = records.student_id
WHERE records.record_date >= {start}
	AND records.record_date <= {stop}
	AND students.student_id = %s
GROUP BY courses.course_name;