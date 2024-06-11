SELECT 
t1.dtRef, 
t1.idCustomer, 
CASE WHEN t2.idCustomer is null THEN 1 else 0 END AS flChurn
FROM fs_general t1
LEFT JOIN fs_general t2
ON t1.idCustomer = t2.idCustomer
AND t1.dtRef = date(t2.dtRef, '-21 day')
WHERE t1.dtRef < DATE('2024-06-06','-21 day')
AND strftime('%d', date(t1.dtRef)) = '01'
ORDER BY t1.dtRef ASC