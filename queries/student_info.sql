SELECT
	students.student_id,
	students.student_name,
	students.surname AS s_surname,
	students.grade,
	students.level,
	students.school,
	students.cohort,
	CASE WHEN students.mobile IS NULL THEN '' ELSE students.mobile END AS s_mobile,
	CASE WHEN students.email IS NULL THEN '' ELSE students.email END AS s_email,
	students.discount,
	learning_plans.description,
	learning_plans.price,
	learning_plans.charge_type,
	customers.customer_name,
	customers.surname AS cust_surname,
	parent_id,
	customers.mobile AS cust_mobile,
	CASE WHEN customers.email IS NULL THEN '' ELSE customers.email END AS cust_email,
	CASE WHEN customers.phone IS NULL THEN '' ELSE customers.phone END,
	CASE WHEN customers.address IS NULL THEN '' ELSE customers.address END,
	CASE WHEN customers.zip IS NULL THEN '' ELSE customers.zip END,
	CASE WHEN customers.region IS NULL THEN '' ELSE customers.region END,
	customers.city
FROM students
LEFT JOIN customers ON customers.customer_id = students.parent_id
LEFT JOIN learning_plans ON learning_plans.plan_id = students.plan_id
WHERE students.acad_year = {acad_year} AND learning_plans.acad_year = {acad_year}
	AND students.cohort !~ '^δ' 
	AND students.student_id = %s
