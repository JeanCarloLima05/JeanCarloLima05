# 6 - Quais as escolas tem a melhor infraestrutura (banheiro, quadra esportiva, refeitorio e bibliotecas) por Cidades/Etados/Região 

# Criar uma função que retorna a classificação de infraestrutura com base em número de itens disponíveis

 DELIMITER $$

CREATE FUNCTION classifica_infraestrutura(
    banheiro BOOLEAN,
    quadra BOOLEAN,
    refeitorio BOOLEAN,
    biblioteca BOOLEAN
)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SET total = banheiro + quadra + refeitorio + biblioteca;

    IF total >= 3 THEN
        RETURN 'Alta';
    ELSEIF total = 2 THEN
        RETURN 'Média';
    ELSE
        RETURN 'Baixa';
    END IF;
END $$

DELIMITER ;
 
#Chamar a função que classifica a infra estrutura das escolas
SELECT 
  NO_ENTIDADE,
  classifica_infraestrutura(IN_BANHEIRO, IN_QUADRA_ESPORTES, IN_REFEITORIO, IN_BIBLIOTECA) AS nivel_infra
FROM escolas_backup;


#Criando um View para facilitar a chamada da função, separando por escolas, estado, municipio e região

CREATE OR REPLACE VIEW vw_infra_escolas AS
SELECT 
  NO_ENTIDADE,
  NO_MUNICIPIO,
  NO_UF,
  NO_REGIAO,
  classifica_infraestrutura(
    IN_BANHEIRO,
    IN_QUADRA_ESPORTES,
    IN_REFEITORIO,
    IN_BIBLIOTECA
  ) AS nivel_infra
FROM escolas_backup;

-- Para vizualizar a view e verificar se funciona
select * from vw_infra_escolas;

#Quantidades de escolas que dos diferentes níveis de infraestrutura por municipio, estado e região

#MUNICIPIOS, ESTADO E REGIÃO 

SELECT 
  NO_MUNICIPIO, NO_UF, NO_REGIAO,
  COUNT(*) AS total_escolas,
  SUM(nivel_infra = 'Alta') AS escolas_alta,
  SUM(nivel_infra = 'Média') AS escolas_media,
  SUM(nivel_infra = 'Baixa') AS escolas_baixa
FROM vw_infra_escolas
GROUP BY NO_MUNICIPIO, NO_UF, NO_REGIAO
ORDER BY escolas_alta DESC LIMIT 20;

#MUNICIPIOS
SELECT 
  NO_MUNICIPIO, 
  COUNT(*) AS total_escolas,
  SUM(nivel_infra = 'Alta') AS escolas_alta,
  SUM(nivel_infra = 'Média') AS escolas_media,
  SUM(nivel_infra = 'Baixa') AS escolas_baixa
FROM vw_infra_escolas
GROUP BY NO_MUNICIPIO, NO_UF
ORDER BY escolas_alta DESC LIMIT 20;

#ESTADOS
SELECT 
  NO_UF,
  COUNT(*) AS total_escolas,
  SUM(nivel_infra = 'Alta') AS escolas_alta,
  SUM(nivel_infra = 'Média') AS escolas_media,
  SUM(nivel_infra = 'Baixa') AS escolas_baixa
FROM vw_infra_escolas
GROUP BY NO_UF
ORDER BY escolas_alta DESC; 

#REGIÃO 
SELECT 
  NO_REGIAO,
  COUNT(*) AS total_escolas,
  SUM(nivel_infra = 'Alta') AS escolas_alta,
  SUM(nivel_infra = 'Média') AS escolas_media,
  SUM(nivel_infra = 'Baixa') AS escolas_baixa
FROM vw_infra_escolas
GROUP BY NO_REGIAO
ORDER BY escolas_alta DESC;