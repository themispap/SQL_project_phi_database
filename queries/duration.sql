DROP TABLE IF EXISTS temp_table;
CREATE TEMPORARY TABLE temp_table (month_number INTEGER);

INSERT INTO temp_table (month_number)
VALUES (6),(7),(8),(9),(10),(11),(12),(1),(2),(3),(4),(5);

SELECT 
	temp_table.month_number,
	CASE WHEN stud_dur.sum IS NULL THEN 0 ELSE stud_dur.sum END AS stud,
	CASE WHEN foit_dur.sum IS NULL THEN 0 ELSE foit_dur.sum END AS foit,
	CASE WHEN dyn_dur.sum IS NULL THEN 0 ELSE dyn_dur.sum END AS dyn
FROM temp_table
LEFT JOIN
-- Ώρες διδασκαλίας ανά μήνα (μαθητές)
(SELECT tab_1.month_number, SUM(tab_1.duration) FROM
(SELECT DISTINCT(r.record_date,s.cohort) AS dist_val, EXTRACT(MONTH FROM r.record_date) AS month_number, r.duration, r.course_id
FROM records AS r
LEFT JOIN students AS s ON s.student_id = r.student_id
WHERE s.cohort !~ '^Φ' AND s.cohort !~ '^δ'
	AND r.record_date >= {start} 
	AND r.record_date <= {stop}
	AND s.acad_year = {acad_year}
	) AS tab_1
GROUP BY tab_1.month_number
ORDER BY tab_1.month_number)
AS stud_dur ON stud_dur.month_number=temp_table.month_number
LEFT JOIN
-- Ώρες διδασκαλίας ανά μήνα (φοιτητές)
(SELECT tab_1.month_number, SUM(tab_1.duration) FROM
(SELECT DISTINCT(r.record_date,s.cohort) AS dist_val, EXTRACT(MONTH FROM r.record_date) AS month_number, r.duration, r.course_id
FROM records AS r
LEFT JOIN students AS s ON s.student_id = r.student_id
WHERE s.cohort ~ '^Φ'
	AND r.record_date >= {start}
	AND r.record_date <= {stop}
	AND s.acad_year = {acad_year}
	) AS tab_1
GROUP BY tab_1.month_number
ORDER BY tab_1.month_number)
AS foit_dur ON foit_dur.month_number=temp_table.month_number
LEFT JOIN
-- Ώρες διδασκαλίας ανά μήνα (δυναμικό)
(SELECT tab_1.month_number, SUM(tab_1.duration) FROM
(SELECT DISTINCT(r.record_date,s.cohort) AS dist_val, EXTRACT(MONTH FROM r.record_date) AS month_number, r.duration, r.course_id
FROM records AS r
LEFT JOIN students AS s ON s.student_id = r.student_id
WHERE s.cohort ~ '^δ'
	AND r.record_date >= {start}
	AND r.record_date <= {stop}
	AND s.acad_year = {acad_year}
	) AS tab_1
GROUP BY tab_1.month_number
ORDER BY tab_1.month_number)
AS dyn_dur ON dyn_dur.month_number=temp_table.month_number;
