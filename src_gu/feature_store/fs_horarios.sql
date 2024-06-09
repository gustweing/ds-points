WITH tb_transaction_hour AS (
    SELECT idCustomer,
    pointsTransaction,
    CAST(strftime('%H', datetime(dtTransaction, '-3 hour')) AS INTEGER) as hour
    FROM transactions t1
    WHERE t1.dtTransaction < '{date}'
    AND t1.dtTransaction >= date('{date}', '-21 day')
), 
tb_share AS (
    SELECT idCustomer, 
    SUM(CASE WHEN hour >= 8 AND hour < 12 THEN abs(pointsTransaction) else 0 END) as QtdPontosManha, 
    SUM(CASE WHEN hour >= 12 AND hour < 18 THEN abs(pointsTransaction) else 0 END) as QtdPontosTarde, 
    SUM(CASE WHEN hour >= 18 AND hour <= 23 THEN abs(pointsTransaction) else 0 END) as QtdPontosNoite, 
    1.0 * SUM(CASE WHEN hour >= 8 AND hour < 12 THEN abs(pointsTransaction) else 0 END) / SUM(abs(pointsTransaction)) as pctPontosManha, 
    1.0 * SUM(CASE WHEN hour >= 12 AND hour < 18 THEN abs(pointsTransaction) else 0 END) / SUM(abs(pointsTransaction)) as pctPontosTarde, 
    1.0 * SUM(CASE WHEN hour >= 18 AND hour <= 23 THEN abs(pointsTransaction) else 0 END) / SUM(abs(pointsTransaction)) as pctPontosNoite,
    SUM(CASE WHEN hour >= 8 AND hour < 12 THEN 1 else 0 END) as transacoesPontosManha, 
    SUM(CASE WHEN hour >= 12 AND hour < 18 THEN 1 else 0 END) as transacoesPontosTarde, 
    SUM(CASE WHEN hour >= 18 AND hour <= 23 THEN 1 else 0 END) as transacoesPontosNoite, 
    1.0 * SUM(CASE WHEN hour >= 8 AND hour < 12 THEN 1 else 0 END) / SUM(1) as pctTransacoesPontosManha, 
    1.0 * SUM(CASE WHEN hour >= 12 AND hour < 18 THEN 1 else 0 END) / SUM(1) as pctTransacoesPontosTarde, 
    1.0 * SUM(CASE WHEN hour >= 18 AND hour <= 23 THEN 1 else 0 END) / SUM(1) as pctTransacoesPontosNoite  
    FROM tb_transaction_hour
    GROUP BY idCustomer
)
SELECT '{date}' as dtRef, * 
FROM tb_share