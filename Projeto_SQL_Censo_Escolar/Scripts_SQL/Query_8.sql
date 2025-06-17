# 8 - Qual é o número médio de docentes, matriculas e turmas por escola em municípios com mais de 100 escolas?

SELECT 
  NO_MUNICIPIO,
  COUNT(*) AS total_escolas,
  ROUND(AVG(CASE WHEN QT_DOC_BAS != -1 THEN QT_DOC_BAS END), 2) AS media_docentes, -- Calculando a média de professores, apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_docentes'
  ROUND(AVG(CASE WHEN QT_MAT_BAS != -1 THEN QT_MAT_BAS END), 2) AS media_matriculas, -- Calculando a média de alunos (matriculas), apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_matriculas'
  ROUND(AVG(CASE WHEN QT_TUR_BAS != -1 THEN QT_TUR_BAS END), 2) AS media_turmas -- Calculando a média de turmas, apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_turmas'
FROM escolas_backup
GROUP BY NO_MUNICIPIO
HAVING COUNT(*) > 100 -- Filtrando apenas para os municípios que possuem masi de 100 escolas
ORDER BY media_turmas DESC LIMIT 10; -- Ordenando da maior média de professores para a menor