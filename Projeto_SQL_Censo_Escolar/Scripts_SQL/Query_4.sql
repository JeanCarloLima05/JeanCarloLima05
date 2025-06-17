 # 4 - Distribuição de escolas públicas x privadas por estado

SELECT 
  NO_UF AS Estado,
  COUNT(CASE WHEN TP_DEPENDENCIA IN (1, 2, 3) THEN 1 END) AS escolas_publicas,
  COUNT(CASE WHEN TP_DEPENDENCIA = 1 THEN 1 END) AS escolas_federais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 2 THEN 1 END) AS escolas_estaduais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 3 THEN 1 END) AS escolas_municipais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 4 THEN 1 END) AS escolas_privadas,
  COUNT(*) AS total_escolas
FROM 
  escolas_backup
WHERE 
  TP_DEPENDENCIA IN (1, 2, 3, 4)
GROUP BY 
  NO_UF
ORDER BY 
NO_UF;

