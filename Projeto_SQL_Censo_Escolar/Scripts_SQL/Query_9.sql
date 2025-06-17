# 9 - Qual a distribuição percentual de escolas com água potável por região

-- CTEs 
WITH total_regiao AS ( -- Calculo do total de escolas por região
	SELECT NO_REGIAO, COUNT(*) AS total_escolas
    FROM escolas_backup
     WHERE IN_AGUA_POTAVEL IN (0, 1)
    GROUP BY NO_REGIAO
), com_agua AS (  -- Calculo de escolas por região que possuem água potável (IN_AGUA_POTAVEL = 1 ou true)
    SELECT NO_REGIAO, COUNT(*) AS escolas_com_agua
    FROM escolas_backup
    WHERE IN_AGUA_POTAVEL = 1
    GROUP BY NO_REGIAO
)
SELECT 
	t.NO_REGIAO,
    ROUND((a.escolas_com_agua / t.total_escolas)* 100, 2) AS perc_com_agua -- Calculo a porcentagem de escolas por região que possuem acesso a água potável
FROM total_regiao t -- Definição do Alias "t" para total_regiao
JOIN com_agua a USING (NO_REGIAO) -- Definição do Alias "a" para com_agua
ORDER BY perc_com_agua DESC;
