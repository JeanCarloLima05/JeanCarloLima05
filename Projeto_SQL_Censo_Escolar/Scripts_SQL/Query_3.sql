# 3 - Quantas escolas têm saneamento básico completo (água + esgoto + energia) e qual a porcentagem em relação ao total de escolas?
 

WITH 
-- Total de escolas válidas (com informação nos 3 indicadores)
total_escolas AS (
    SELECT COUNT(*) AS total
    FROM escolas_backup
    WHERE IN_ENERGIA_REDE_PUBLICA IN (0, 1)
      AND IN_AGUA_POTAVEL IN (0, 1)
      AND IN_ESGOTO_REDE_PUBLICA IN (0, 1)
),

-- Escolas com saneamento completo (todos 3 serviços)
com_saneamento AS (
    SELECT COUNT(*) AS quantidade
    FROM escolas_backup
    WHERE IN_ENERGIA_REDE_PUBLICA = TRUE
      AND IN_AGUA_POTAVEL = TRUE
      AND IN_ESGOTO_REDE_PUBLICA = TRUE
)
-- Resultado final com números absolutos e porcentagem
SELECT 
    c.quantidade AS escolas_com_saneamento,
    t.total AS total_escolas_validas,
    ROUND((c.quantidade * 100.0 / t.total), 2) AS porcentagem
FROM 
    com_saneamento c,
    total_escolas t;