# VAMOS AGORA RESPONDER AS PERGUNTAS DE NEGOCIO 
  
 # 1 - Quantas escolas têm internet por estado?
 
 SELECT * FROM escolas_backup;
 
 -- Escolas com acesso a internet por estado
 SELECT NO_UF, COUNT(*) AS escolas_com_internet
FROM escolas_backup
WHERE IN_INTERNET = TRUE
GROUP BY NO_UF
ORDER BY escolas_com_internet DESC;

-- Escolas sem acesso a internet por estado
 SELECT NO_UF, COUNT(*) AS escolas_sem_internet
FROM escolas_backup
WHERE IN_INTERNET = FALSE
GROUP BY NO_UF
ORDER BY escolas_sem_internet DESC;

-- Escolas sem informações sobre acesso a internet por estado
SELECT NO_UF, COUNT(*) AS escolas_sem_informacao_internet
FROM escolas_backup
WHERE IN_INTERNET = -1
GROUP BY NO_UF
ORDER BY escolas_sem_informacao_internet DESC;

# Quais estados têm maior proporção de escolas com internet?
 SELECT 
  NO_REGIAO, NO_UF AS Estado,
  ROUND(SUM(CASE WHEN IN_INTERNET = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS perc_com_internet
FROM 
  escolas_backup
GROUP BY 
 NO_REGIAO, NO_UF
ORDER BY 
  perc_com_internet DESC;