DROP TABLE IF EXISTS temp_table;
-- CREATE TEMPORARY TABLE temp_table (week_number INTEGER);

-- INSERT INTO temp_table (week_number)
-- SELECT generate_series(1,52);
SELECT s.a AS week_number, date {start} + interval '7' day * s.a AS date
INTO TEMP temp_table
  FROM generate_series(1,52) AS s(a);

SELECT temp_table.week_number, temp_table.date,
	CASE WHEN tab2.n ISNULL THEN 0 ELSE tab2.n END AS signups,
	CASE WHEN tab3.nn ISNULL THEN 0 ELSE -tab3.nn END AS signouts
FROM temp_table
LEFT JOIN
-- signups
(SELECT tab.week_number, COUNT(tab.student_id) AS n FROM
(SELECT student_id,
	CASE WHEN DATE_PART('week', signup_date) >= DATE_PART('week', date {start})
		THEN DATE_PART('week', signup_date) - DATE_PART('week', date {start})+1
	ELSE DATE_PART('week', signup_date)+29
	END AS week_number
FROM students
WHERE signup_date >= {start} 
	AND acad_year= {acad_year}
	AND signup_date <= {stop} 
	AND cohort !~ '^Φ' AND cohort !~ '^δ')
AS tab
GROUP BY tab.week_number) AS tab2
ON tab2.week_number=temp_table.week_number

LEFT JOIN
--signouts
(SELECT tab.week_number, COUNT(tab.student_id) AS nn FROM
(SELECT student_id,
	CASE WHEN DATE_PART('week', del_date) >= DATE_PART('week', date{start})
		THEN DATE_PART('week', del_date) - DATE_PART('week', date{start})+1
	ELSE DATE_PART('week', del_date)+29
	END AS week_number
FROM students
WHERE del_date >= {start} 
	AND del_date <= {stop} 
	AND cohort !~ '^Φ' 
	AND cohort !~ '^δ')
AS tab
GROUP BY tab.week_number) AS tab3
ON tab3.week_number=temp_table.week_number
