DROP TABLE IF EXISTS debit_projects;
DROP TABLE IF EXISTS debit_hourly;
DROP TABLE IF EXISTS debit_monthly;
DROP TABLE IF EXISTS debit_summer;
DROP TABLE IF EXISTS credit;

-- Χρεώσεις από εργασίες
SELECT customer_id, price AS debit 
	INTO TEMP debit_projects
FROM projects 
	WHERE submission_date IS NOT NULL 
		AND submission_date >= {start}
		AND submission_date <= {stop};

-- Χρεώσεις μαθήματα ανά ώρα
SELECT cust.customer_id, SUM(ROUND(r.duration*(1-s.discount)*lp.price,2)) AS debit
	INTO TEMP debit_hourly
FROM records AS r
LEFT JOIN students AS s ON s.student_id = r.student_id
LEFT JOIN learning_plans AS lp ON lp.plan_id = s.plan_id
LEFT JOIN customers AS cust ON cust.customer_id = s.parent_id
WHERE lp.charge_type='ανά ώρα'
	AND r.record_date >= {start}
	AND r.record_date <= {stop}
	AND lp.acad_year = {acad_year}
	AND s.acad_year = {acad_year}
GROUP BY cust.customer_id;

-- Χρεώσεις μαθήματα ανά μήνα
SELECT n_tab.customer_id, SUM(n_tab.months*n_tab.debit) AS debit
	INTO TEMP debit_monthly
FROM
(SELECT cst.customer_id,
CASE
	WHEN s.del_date ISNULL AND s.signup_date <= timestamp {start} + interval '11 weeks' AND CURRENT_DATE <= timestamp {stop}
		THEN EXTRACT(MONTH FROM age(timestamp {start} + interval '9 weeks'))
	WHEN s.del_date ISNULL AND s.signup_date <= timestamp {start} + interval '11 weeks'AND CURRENT_DATE > timestamp {stop}
		THEN EXTRACT(MONTH FROM age(timestamp {stop},timestamp {start} + interval '9 weeks'))
	WHEN s.del_date ISNULL AND s.signup_date > timestamp {start} + interval '11 weeks' AND CURRENT_DATE <= timestamp {stop}
		THEN EXTRACT(MONTH FROM age(date_trunc('month',CURRENT_DATE)+interval '2 weeks',s.signup_date))
	WHEN s.del_date ISNULL AND s.signup_date > timestamp {start} + interval '11 weeks' AND CURRENT_DATE > timestamp {stop}
		THEN EXTRACT(MONTH FROM age(timestamp {stop} - interval '2 weeks',s.signup_date))
	WHEN s.del_date IS NOT NULL 
		THEN EXTRACT(MONTH FROM age(s.del_date, timestamp {start} + interval '9 weeks'))
END AS months,
ROUND(lp.price*(1-s.discount),2) AS debit
FROM students AS s
LEFT JOIN learning_plans AS lp ON lp.plan_id = s.plan_id
LEFT JOIN customers AS cst ON cst.customer_id = s.parent_id
WHERE lp.charge_type = 'ανά μήνα'
	AND lp.acad_year = {acad_year}
	AND s.acad_year = {acad_year})
AS n_tab
GROUP BY n_tab.customer_id;

--Χρεώσεις από θερινά μαθήματα
SELECT cst.customer_id, ROUND(lp.price*(1-s.discount)*1.5,2) AS debit
	INTO TEMP debit_summer
FROM records AS r
LEFT JOIN students AS s ON s.student_id = r.student_id
LEFT JOIN learning_plans AS lp ON lp.plan_id = s.plan_id
LEFT JOIN customers AS cst ON cst.customer_id = s.parent_id
WHERE lp.charge_type = 'ανά μήνα' 
	AND r.record_date >= {start} 
	AND r.record_date <= timestamp {start} + interval '9 weeks'
	AND lp.acad_year = {acad_year}
	AND s.acad_year = {acad_year}
GROUP BY cst.customer_id, debit;

-- Πιστώσεις
SELECT customer_id, SUM(amount) AS credit
	INTO TEMP credit
FROM income
WHERE paydate >={start} 
	AND paydate <= date_trunc('month',CURRENT_DATE)+interval '1 month'
GROUP BY customer_id;

SELECT customers.customer_name,customers.surname,
 round(raw_balance.debit,1) AS debit, 
 round(raw_balance.credit,1) AS credit, 
 round(raw_balance.debit-raw_balance.credit,1) AS res  
 FROM
(SELECT debit.customer_id,
	CASE WHEN debit.debit ISNULL THEN 0.0 ELSE debit.debit END, 
	CASE WHEN credit.credit ISNULL THEN 0.0 ELSE credit.credit END
FROM
(SELECT customer_id, SUM(debit) AS debit FROM(
	SELECT * FROM debit_projects
	UNION SELECT * FROM debit_hourly
	UNION SELECT * FROM debit_monthly
	UNION SELECT * FROM debit_summer) AS union_debit
GROUP BY customer_id) AS debit
LEFT JOIN credit ON credit.customer_id = debit.customer_id)
AS raw_balance
LEFT JOIN customers ON customers.customer_id=raw_balance.customer_id
WHERE raw_balance.debit-raw_balance.credit >= 0
ORDER BY res DESC;
