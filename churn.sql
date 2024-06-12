with tb_flg_churn AS (
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
)
SELECT  t1.dtRef, 
t1.idCustomer
t2.recenciaDias, 
t2.frequenciaDias, 
t2.valorPoints, 
t2.idadeBaseDias, 
t2.flEmail, 
t3.QtdPontosManha,
t3.QtdPontosTarde,
t3.QtdPontosNoite,
t3.pctPontosManha,
t3.pctPontosTarde,
t3.pctPontosNoite,
t3.transacoesPontosManha,
t3.transacoesPontosTarde,
t3.transacoesPontosNoite,
t3.pctTransacoesPontosManha,
t3.pctTransacoesPontosTarde,
t3.pctTransacoesPontosNoite,
t4.saldoPointsD21,
t4.saldoPointsD14,
t4.saldoPointsD7,
t4.saldoPointsAcumuladoD21,
t4.saldoPointsAcumuladoD14,
t4.saldoPointsAcumuladoD7,
t4.pointsResgatadosD21,
t4.pointsResgatadosD14,
t4.pointsResgatadosD7,
t4.saldoPoints,
t4.pointsAcumuladosVida,
t4.pointsResgatadosVida,
t4.pointsDia,
t5.QtdeChatMessage,
t5.QtdeResgatarPonei,
t5.QtdeListaPresenca,
t5.QtdeTrocaStreamElements,
t5.QtdePresencaStreak,
t5.QtdeAirflowLover,
t5.QtdeRLover,
t5.pointsChatMessage,
t5.pointsResgatarPonei,
t5.pointsListaPresenca,
t5.pointsTrocaStreamElements,
t5.pointsPresencaStreak,
t5.pointsAirflowLover,
t5.pointsRLover,
t5.pctdeChatMessage,
t5.pctdeResgatarPonei,
t5.pctdeListaPresenca,
t5.pctdeTrocaStreamElements,
t5.pctdePresencaStreak,
t5.pctdeAirflowLover,
t5.pctdeRLover,
t5.avgChatLive,
t5.prodMax_qtd,
t6.qtdDiasTransacaoD21,
t6.qtdDiasTransacaoD14,
t6.qtdDiasTransacaoD7,
t6.avgLiveMinutes,
t6.sumLiveMinutes,
t6.minLiveMinutes,
t6.maxLiveMinutes,
t6.qtdTransacoesVida,
t6.avgTransacoesDia
FROM tb_flg_churn t1
LEFT JOIN fs_general t2
ON t1.idCustomer = t2.idCustomer
AND t1.dtRef = t2.dtRef
LEFT JOIN fs_horarios t3
ON t1.idCustomer = t3.idCustomer 
AND t1.dtRef = t3.dtRef
LEFT JOIN fs_points t4
ON t1.idCustomer = t4.idCustomer 
AND t1.dtRef = t4.dtRef
LEFT JOIN fs_produtos t5
ON t1.idCustomer = t5.idCustomer
AND t1.dtRef = t5.dtRef
LEFT JOIN fs_transacoes t6
ON t1.idCustomer = t6.idCustomer
AND t1.dtRef = t6.dtRef


























