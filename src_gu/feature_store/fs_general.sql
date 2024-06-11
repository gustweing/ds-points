/* CTE - Comum Table Expression  */
WITH tb_rfv AS(
    SELECT 
    idCustomer, 
    CAST (
        min(julianday('{date}') - julianday(dtTransaction)) as INTEGER
        ) + 1 as recenciaDias, 
    COUNT(DISTINCT DATE(dtTransaction)) as frequenciaDias, 
    SUM(CASE WHEN pointsTransaction > 0 THEN pointsTransaction END) as valorPoints
    FROM transactions
    WHERE dtTransaction < '{date}'
    AND dtTransaction >= date('{date}', '-21 day')
    GROUP BY idCustomer
), 
tb_idade AS (
    SELECT t1.idCustomer,
        CAST (
            max(julianday('{date}') - julianday(t2.dtTransaction)) as INTEGER
            ) + 1 as idadeBaseDias
    FROM tb_rfv as t1
    LEFT JOIN transactions as t2
    ON t1.idCustomer = t2.idCustomer
    GROUP BY t2.idCustomer
)
SELECT t1.*, t2.idadeBaseDias, t3.flEmail, date('{date}') as dtRef
FROM tb_rfv as t1
LEFT JOIN tb_idade as t2
ON t1.idCustomer = t2.idCustomer
LEFT JOIN customers as t3
ON t1.idCustomer = t3.idCustomer