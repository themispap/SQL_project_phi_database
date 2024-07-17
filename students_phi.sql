SELECT student_id FROM students 
	WHERE acad_year={acad_year} 
	AND cohort !~ '^Φ' 
	AND cohort !~ '^δ'