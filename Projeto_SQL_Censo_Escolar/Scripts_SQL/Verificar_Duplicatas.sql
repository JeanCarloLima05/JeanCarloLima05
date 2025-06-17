-- Criação de uma table de backup a partir da table original
CREATE TABLE escolas_backup AS
SELECT * FROM escolas_2024;

#VERIFICAR DUPLICATAS 

#Verificar dublicadas de toda as linhas da tabela

SELECT *
FROM escolas_backup
GROUP BY id, NO_REGIAO, NO_UF, NO_MUNICIPIO, NO_ENTIDADE, TP_DEPENDENCIA, TP_LOCALIZACAO, 
         IN_INTERNET, IN_ENERGIA_REDE_PUBLICA, IN_AGUA_POTAVEL, IN_ESGOTO_REDE_PUBLICA, 
         IN_BANHEIRO, IN_QUADRA_ESPORTES, IN_REFEITORIO, IN_BIBLIOTECA, QT_MAT_BAS, 
         QT_DOC_BAS, QT_TUR_BAS
HAVING COUNT(*) > 1;

#Verificar duplicatas dos nomes das Escolas

SELECT NO_ENTIDADE,COUNT(*) as quantidade
FROM escolas_backup
GROUP BY id, NO_ENTIDADE
HAVING COUNT(*) > 1;