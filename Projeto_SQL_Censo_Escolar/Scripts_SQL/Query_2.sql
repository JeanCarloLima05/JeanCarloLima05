# 2 - Qual a média de turmas por escola em cada região?
 
 SELECT 
  NO_REGIAO AS Regiao,
  ROUND(AVG(QT_TUR_BAS), 2) AS media_turmas
FROM 
  escolas_backup
WHERE 
  QT_TUR_BAS != -1
GROUP BY 
  NO_REGIAO;