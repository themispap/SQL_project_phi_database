-- replace the {start} with the start date of the selected academic year ('YYYY-MM-DD')
-- replace the {stop} with the end date of the selected academic year ('YYYY-MM-DD')
-- replace the {acad_year} with the selected academic year ('YYYY-YYYY')

DROP TABLE IF EXISTS data_tab;
DROP TABLE IF EXISTS month_tab;

SELECT TO_CHAR(issue_date, 'Mon YY') AS pay_date, SUM(amount) 
INTO TEMPORARY data_tab
FROM payments
WHERE paid AND issue_date >= {start} AND issue_date <= {stop}
GROUP BY TO_CHAR(issue_date, 'Mon YY');

SELECT date {start} + interval '1' month * s.a AS order_date,
		TO_CHAR(date {start} + interval '1' month * s.a, 'Mon YY') AS pay_date
INTO TEMPORARY month_tab
  FROM generate_series(0,12,1) AS s(a);

SELECT pay_date,
CASE
  WHEN sum ISNULL THEN 0
ELSE
  sum
END AS sum
FROM 
(SELECT order_date, month_tab.pay_date, data_tab.sum 
  FROM month_tab
LEFT JOIN data_tab ON data_tab.pay_date=month_tab.pay_date
ORDER BY order_date) AS old_tab;
