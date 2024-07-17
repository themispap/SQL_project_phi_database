-- Λογαριασμοί που εκκρεμούν
SELECT category, amount, paydate FROM payments
WHERE NOT paid AND (business OR business = NOT %s) AND paydate <= CURRENT_DATE+interval '25 days'
ORDER BY amount DESC;