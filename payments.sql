-- Κατηγορίες εξόδων (Εξοφλημένοι λογαριασμοί)
SELECT category, SUM(amount) AS total FROM payments
WHERE paid AND (business OR business) AND paydate >= '2023-06-19' AND paydate <= CURRENT_DATE
GROUP BY category
ORDER BY total DESC;