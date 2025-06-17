#PROJETO EM SQL UMA Análise de infraestrutura escolar e modalidades de ensino por estado e região (Brasil, 2024)

#CRIAÇÃO DO DATABASE PARA RECEBER OS DADOS

-- Criação do database para o projeto de análise escolar
CREATE DATABASE Censo_Escolar_2024;

-- Seleção do database criado
USE Censo_Escolar_2024;

-- Verificação de criação bem-sucedida
SELECT DATABASE() AS Banco_Atual;

# CRIAR A TABELA PARA RECEBER OS DADOS
#Será criado uma tabela apenas para dos dados que seram utilizado no projeto e não de toda base de dados
#Referente as Escolas (como infraestrutura, localização)

CREATE TABLE escolas_2024 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NO_REGIAO VARCHAR(20),          -- Nome da Região Geográfica
    NO_UF VARCHAR(50),             -- Nome da unidade da Federação(Estado)               
    NO_MUNICIPIO VARCHAR(100),     -- Nome do Municipio (Cidade)
    NO_ENTIDADE VARCHAR(100),      -- Nome da Escola
    TP_DEPENDENCIA INT,            -- Dependência Administrativa (1- FEDERAL, 2 - ESTADUAL, 3- MUNICIPAL, 4 PRIVADA)
    TP_LOCALIZACAO INT,            -- Localização (1-URBANA, 2 RURAL)
    IN_INTERNET BOOLEAN,           -- Acesso a internet (0- NÃO, 1- SIM)
    IN_ENERGIA_REDE_PUBLICA BOOLEAN, -- Abastecimento de energia elétrica - Rede pública (0- NÃO, 1- SIM)
    IN_AGUA_POTAVEL BOOLEAN,       -- Fornece água potável para o consumo humano (0- NÃO, 1- SIM)
    IN_ESGOTO_REDE_PUBLICA BOOLEAN,-- Esgoto sanitário - Rede pública (0- NÃO, 1- SIM)
    IN_BANHEIRO BOOLEAN,           -- Dependências físicas existentes e utilizadas na escola - Banheiro (0- NÃO, 1- SIM)
    IN_QUADRA_ESPORTES BOOLEAN,    -- Dependências físicas existentes e utilizadas na escola - Quadra de esportes coberta ou descoberta (0- NÃO, 1- SIM)
    IN_REFEITORIO BOOLEAN,         -- Dependências físicas existentes e utilizadas na escola - Refeitório (0- NÃO, 1- SIM)
    IN_BIBLIOTECA BOOLEAN,         -- Dependências físicas existentes e utilizadas na escola - Biblioteca (0- NÃO, 1- SIM)
    QT_MAT_BAS INT,                -- Número de Matrículas da Educação Básica
    QT_DOC_BAS INT,                -- Número de Docentes da Educação Básica (NÚMERO DE PROFESSORES)
    QT_TUR_BAS INT                -- Número de Turmas de Educação Básica
);

#IMPORTANDO OS DADOS
#Importandos os dados do arquivo csv na pasta segura do mysql
#Para importamos apenas a informações que queremos das escolas, precisamos primeiro criar um arquivo csv apenas com essas informações retiradas do aqruivo original
# para isso foi utilizado um cogido em python para fazer isso

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/escolas_2024_filtrado.csv' 
-- Carrega os dados do arquivo CSV localizado no caminho especificado (da pasta segura do mysql)
INTO TABLE escolas_2024
-- Indica que os dados serão importados para a tabela 'escolas_2024'.
CHARACTER SET utf8mb4
-- Define o conjunto de caracteres do arquivo para utf8mb4 (suporte completo a Unicode).
FIELDS TERMINATED BY ';'
-- Especifica que os campos no arquivo CSV são separados por ponto e vírgula. 
ENCLOSED BY '"'
-- Indica que os valores estão entre aspas duplas.
LINES TERMINATED BY '\r\n'
-- Define que cada linha termina com o caractere de retorno de carro + nova linha (formato Windows).
IGNORE 1 LINES
-- Ignora a primeira linha do arquivo, geralmente usada para pular o cabeçalho com nomes das colunas.
(
	@NO_REGIAO , @NO_UF, @NO_MUNICIPIO, @NO_ENTIDADE, @TP_DEPENDENCIA, @TP_LOCALIZACAO, @IN_INTERNET, @IN_ENERGIA_REDE_PUBLICA, 
    @IN_AGUA_POTAVEL, @IN_ESGOTO_REDE_PUBLICA, @IN_BANHEIRO, @IN_QUADRA_ESPORTES, @IN_REFEITORIO,         
	@IN_BIBLIOTECA, @QT_MAT_BAS, @QT_DOC_BAS, @QT_TUR_BAS
)
-- Define variáveis temporárias para receber os dados de cada coluna do arquivo.
SET
NO_REGIAO = NULLIF(@NO_REGIAO, ''),
NO_UF = NULLIF(@NO_UF, ''),
NO_MUNICIPIO = NULLIF(@NO_MUNICIPIO, ''),
NO_ENTIDADE = NULLIF(@NO_ENTIDADE, ''),
TP_DEPENDENCIA = NULLIF(@TP_DEPENDENCIA, ''), 
TP_LOCALIZACAO = NULLIF(@TP_LOCALIZACAO, ''),  
IN_INTERNET = NULLIF(@IN_INTERNET, ''),
IN_ENERGIA_REDE_PUBLICA = NULLIF(@IN_ENERGIA_REDE_PUBLICA, ''),
IN_AGUA_POTAVEL = NULLIF(@IN_AGUA_POTAVEL, ''),
IN_ESGOTO_REDE_PUBLICA = NULLIF(@IN_ESGOTO_REDE_PUBLICA, ''),
IN_BANHEIRO = NULLIF(@IN_BANHEIRO, ''),
IN_QUADRA_ESPORTES = NULLIF(@IN_QUADRA_ESPORTES, ''),
IN_REFEITORIO = NULLIF(@IN_REFEITORIO, ''),
IN_BIBLIOTECA = NULLIF(@IN_BIBLIOTECA, ''),
QT_MAT_BAS = NULLIF(@QT_MAT_BAS, ''),
QT_DOC_BAS = NULLIF(@QT_DOC_BAS, ''),
QT_TUR_BAS = NULLIF(@QT_TUR_BAS, '');
-- Atribui os valores das variáveis às colunas da tabela.
-- Usa NULLIF para transformar strings vazias ('') em NULL no banco de dados.