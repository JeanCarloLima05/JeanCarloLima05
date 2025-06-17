# 10 - Qual o Total de alunos por tipo de escola em cada estado? 

CREATE VIEW total_matriculas_por_estado_tipo AS 
SELECT 
	NO_UF,
    CASE TP_DEPENDENCIA -- Classificar as escolas pelo tipo
		WHEN 1 THEN 'Federal'
        WHEN 2 THEN 'Estadual'
        WHEN 3 THEN 'Municipal'
        WHEN 4 THEN 'Privada'
	END AS tipo_escola,
    SUM(QT_MAT_BAS) AS total_matriculas -- Soma da quantidade de matrículas (alunos)
FROM escolas_backup
WHERE QT_MAT_BAS != -1 -- Filtras apenas pelas escolas válidas
GROUP BY NO_UF, TP_DEPENDENCIA;
        
SELECT * FROM total_matriculas_por_estado_tipo; -- Chamar o VIEW 