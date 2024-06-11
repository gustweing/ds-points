WITH tb_trasactions AS (
    SELECT * 
    FROM transactions
    WHERE dtTransaction < '{date}'
    AND dtTransaction >= date('{date}', '-21 day')
),
tb_freq AS (
    SELECT idCustomer,
    COUNT(DISTINCT DATE(dtTransaction)) as qtdDiasTransacaoD21, 
    COUNT(DISTINCT CASE WHEN dtTransaction > DATE('{date}', '-14 day') THEN date(dtTransaction) END) as qtdDiasTransacaoD14, 
    COUNT(DISTINCT CASE WHEN dtTransaction > DATE('{date}', '-7 day') THEN date(dtTransaction) END) as qtdDiasTransacaoD7
    FROM tb_trasactions
    WHERE dtTransaction < '{date}'
    AND dtTransaction >= date('{date}', '-21 day')
    GROUP BY idCustomer
), 
tb_live_minutes AS (
    SELECT idCustomer, 
    date(datetime(dtTransaction, '-3 hour')) as dtTransactionDate, 
    MIN(datetime(dtTransaction, '-3 hour')) as dtInicio,
    MAX(datetime(dtTransaction, '-3 hour')) as dtFim,
    (julianday(MAX(datetime(dtTransaction, '-3 hour'))) - 
    julianday(MIN(datetime(dtTransaction, '-3 hour')))) * 24 * 60 as liveMinutes
    FROM tb_trasactions
    GROUP BY 1, 2
),
tb_hours AS (
    SELECT idCustomer, 
    AVG(liveMinutes) as avgLiveMinutes, 
    SUM(liveMinutes) as sumLiveMinutes,
    MIN(liveMinutes) as minLiveMinutes, 
    MAX(liveMinutes) as maxLiveMinutes
    FROM tb_live_minutes
    GROUP BY idCustomer
), 
tb_vida AS (
    SELECT idCustomer, 
    COUNT(DISTINCT idTransaction) AS qtdTransacoesVida,
    COUNT(DISTINCT idTransaction)/(MAX(julianday('{date}') - julianday(dtTransaction))) AS avgTransacoesDia
    FROM tb_trasactions
    WHERE dtTransaction < '{date}'
    GROUP BY idCustomer
), 
tb_join AS (
SELECT t1.*, 
t2.avgLiveMinutes,
t2.sumLiveMinutes,
t2.minLiveMinutes,
t2.maxLiveMinutes,
t3.qtdTransacoesVida,
t3.avgTransacoesDia
FROM tb_freq t1
LEFT JOIN tb_hours t2
ON t1.idCustomer = t2.idCustomer
LEFT JOIN tb_vida t3
ON t1.idCustomer = t3.idCustomer
)
SELECT '{date}' as dtRef, * 
FROM tb_join