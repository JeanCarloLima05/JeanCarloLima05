 # 5 - Ranking dos 10 municípios com mais turmas
 use censo_escolar_2024;
 
 SELECT 
 NO_MUNICIPIO AS Municipios, 
 SUM(QT_TUR_BAS) AS total_turmas_validas
FROM escolas_backup
WHERE QT_TUR_BAS != -1 -- Filtra apenas valores válidos (diferentes de -1)
GROUP BY NO_MUNICIPIO
ORDER BY total_turmas_validas DESC
LIMIT 10;