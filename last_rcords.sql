SELECT * FROM records
WHERE student_id = %s
AND record_date >= CURRENT_DATE - INTERVAL '1 week';