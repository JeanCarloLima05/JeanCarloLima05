# 🏫 Análise de Infraestrutura Escolar na Educação Básica no Brasil com SQL
Um projeto em SQL utilizando dados do Censo da Educação Básica 2024 para responder perguntas sobre a infraestrutura das escolas públicas e privadas brasileiras.

## 📖 Introdução

Este é um projeto **pessoal de análise de dados**, desenvolvido com o objetivo de **praticar e aplicar conhecimentos em SQL**, abrangendo desde o **processo de ELT (Extração, Carregamento e Transformação)** até a **modelagem da tabela e criação de consultas**.

O projeto foi inteiramente construído dentro do MYSQL, utilizando o **dataset "Microdados do Censo Escolar da Educação Básica 2024"**, amplamente conhecido e disponível publicamente no site do INEP:  
🔗 [Link para o dataset no INEP]([https://www.kaggle.com/datasets/vivek468/superstore-dataset-final](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar))

---

## 🎯 Objetivo

Este projeto tem como objetivo **analisar dados educacionais do Brasil** utilizando **SQL**, com foco em identificar gargalos de infraestrutura em escolas públicas e privadas. Entre os aspectos investigados estão:

- 📡 Acesso à internet  
- 💧 Saneamento básico  
- ⚡ Energia elétrica 
- 🏫 Outras características relevantes  

### 📊 Contexto  
O projeto responde a **10 perguntas de negócio** através de consultas SQL, simulando um ambiente real de análise de dados na área da **educação básica**.

### 🛠️ Finalidade
- **Aplicar conhecimentos em SQL** utilizando comandos essenciais (SELECT, JOIN, GROUP BY, WHERE, PROCEDURE, FUNCTIONS, etc.)
- **Identificar padrões** na infraestrutura escolar brasileira
- **Gerar insights** para possíveis melhorias no sistema educacional

---

## ❓ Perguntas de Negócio que Guiaram a Análise

Durante o desenvolvimento, diversas **questões estratégicas** foram elaboradas para nortear a exploração dos dados:

1. **Quantas escolas têm internet por estado?**  
2. **Qual a média de turmas por escola em cada região?**  
3. **Quantas escolas têm saneamento básico completo (água + esgoto + energia)?**  
4. **Qual a distribuição de escolas públicas x privadas por estado?**  
5. **Qual o ranking dos 10 municípios com mais turmas?**
6. **Quais as escolas tem a melhor infraestrutura (banheiro, quadra esportiva, refeitorio e bibliotecas) por Cidades/Etados/Região?**
7. **Quantas escolas de cada nível de infraestrutura existem em uma determinada região e tipo de rede administrativa?**
8. **Qual é o número médio de docentes, matriculas e turmas por escola em municípios com mais de 100 escolas?**
9. **Qual a distribuição percentual de escolas com água potável por região?**
10. **Qual o Total de alunos por tipo de escola em cada estado?**

---

**🔔 Observação:**  
Todas as perguntas, análises e interpretações realizadas são **fictícias** e têm como principal finalidade a **simulação de um cenário realista** para **fins de aprendizado e desenvolvimento de competências na área de análise de dados**.

---

## 🛠️ Processos de ELT e Modelagem dos Dados

Este projeto foi práticamente desenvolvido no **MYSQL**, desde a importação e transformação dos dados até a criação de consultas. Todas as etapas foram cuidadosamente realizadas para garantir uma análise precisa e eficiente.

## 🗃️ 1️⃣ Criação do DATABASE

### 📌 Etapa Inicial
O projeto começou com a criação do banco de dados no MySQL para armazenar e analisar os dados educacionais:

```sql
-- Criação do database para o projeto de análise escolar
CREATE DATABASE IF NOT EXISTS Censo_Escolar_2024;

-- Seleção do database criado
USE Censo_Escolar_2024;

-- Verificação de criação bem-sucedida
SELECT DATABASE() AS Banco_Atual;
```
---

## 🏗️ 2️⃣ Criação da Tabela `escolas_2024`

## 📊 Estrutura da Tabela `escolas_2024`

### 🗂️ Campos Principais

| Campo            | Tipo          | Descrição                               | Valores/Referência                 | Métrica               |
|------------------|---------------|-----------------------------------------|------------------------------------|------------------------|
| **`id`**         | `INT`         | Chave primária auto-incrementada        | -                                  | Identificador único    |
| **`NO_REGIAO`**  | `VARCHAR(20)` | Região geográfica do Brasil             | Norte, Nordeste, Centro-Oeste, Sudeste, Sul | Localização     |
| **`NO_UF`**      | `VARCHAR(50)` | Unidade Federativa (Estado)             | SP, RJ, MG, etc.                   | Análise regional       |
| **`NO_MUNICIPIO`** | `VARCHAR(100)` | Município onde a escola está localizada | -                                  | Dados locais           |
| **`NO_ENTIDADE`** | `VARCHAR(100)` | Nome oficial da instituição de ensino   | -                                  | Identificação          |

---

### 🔑 Campos de Classificação

| Campo              | Tipo  | Descrição                 | Valores Válidos                                         | Análise                  |
|--------------------|-------|---------------------------|----------------------------------------------------------|--------------------------|
| **`TP_DEPENDENCIA`** | `INT` | Dependência administrativa | `1` = Federal  <br> `2` = Estadual <br> `3` = Municipal <br> `4` = Privada | Comparação público/privado |
| **`TP_LOCALIZACAO`** | `INT` | Localização geográfica     | `1` = Urbana <br> `2` = Rural                            | Acesso à infraestrutura  |

---

### 🏗️ Campos de Infraestrutura (Booleanos)

| Campo                      | Tipo      | Descrição                     | Impacto                |
|----------------------------|-----------|-------------------------------|------------------------|
| **`IN_INTERNET`**          | `BOOLEAN` | Acesso à internet             | `0` = Não <br> `1` = Sim | Conectividade           |
| **`IN_ENERGIA_REDE_PUBLICA`** | `BOOLEAN` | Energia da rede pública        | `0` = Não <br> `1` = Sim | Infraestrutura básica   |
| **`IN_AGUA_POTAVEL`**      | `BOOLEAN` | Água potável disponível       | `0` = Não <br> `1` = Sim | Saneamento              |
| **`IN_ESGOTO_REDE_PUBLICA`** | `BOOLEAN` | Esgoto da rede pública         | `0` = Não <br> `1` = Sim | Condições sanitárias    |
| **`IN_BANHEIRO`**          | `BOOLEAN` | Banheiro disponível           | `0` = Não <br> `1` = Sim | Infraestrutura básica   |

---

### 📚 Campos Educacionais

| Campo           | Tipo | Descrição                         | 
|-----------------|------|-----------------------------------|
| **`QT_MAT_BAS`**| `INT`| Quantidade de Matrículas na Educação Básica   | 
| **`QT_DOC_BAS`**| `INT`| Quantidade de Docentes na Educação Básica     |
| **`QT_TUR_BAS`**| `INT`| Quantidade de Turmas na Educação Básica       | 

**🔔 Observações:**

- Todos os campos apresentados pertencem à **mesma tabela**, chamada `escolas_2024`.
- A tabela original do INEP contém **mais de 400 colunas**; para este projeto, foram selecionadas **apenas as variáveis relevantes** para responder às perguntas de negócio.
- A estrutura da tabela foi criada com base no **dicionário de dados oficial** fornecido junto ao dataset do Censo Escolar 2024, disponível no site do INEP.

---

## 📥 3️⃣ Importação dos Dados

Os dados utilizados neste projeto foram baixados do site do INEP em um arquivo `.zip`, que contém os microdados do **Censo Escolar da Educação Básica 2024** em formato CSV.

Além dos dados principais das escolas, o pacote inclui:
- Um Arquivo CSV 'microdados_ed_basica_2024', que foi o arquivo principal utilizado nesse projeto.
- Um arquivo `Dicionário de Dados` em CSV, que foi utilizado para criar o modelo da tabela a ser usada no projeto e auxiliar na análise das variáveis;
- Um arquivo `Leia-me` em PDF, com instruções e detalhes técnicos sobre o conteúdo;
- Outros arquivos CSV com informações complementares, que **não serão abordados neste projeto**, mas podem ser úteis para análises futuras.

## ⚙️ Preparação dos Dados para Importação

Após o download dos dados do INEP, iniciou-se o processo de importação no MySQL. Foram feitas várias tentativas de importar o arquivo CSV completo, que contém mais de **400 colunas**, porém sem sucesso.

Foi constatado que seria inviável criar uma tabela no MySQL com **todas as colunas** da base original, tanto por limitações técnicas quanto pela **relevância das variáveis** para este projeto.

Diante disso, decidiu-se criar um novo arquivo CSV contendo **apenas as colunas selecionadas** para análise, com base no modelo da tabela `escolas_2024` já criado no MySQL.

Para isso, foi utilizado um código em **Python (pandas)** que lê o arquivo original e exporta um novo CSV contendo apenas os campos necessários, facilitando a importação e garantindo consistência com a estrutura da tabela.
Ainda por problemas de compatibilidade foi preciso trasnformar o arquivo csv e txt, para leitura em python.

```python
import pandas as pd  # Importa a biblioteca pandas para manipulação de dados tabulares

# Caminho do arquivo original (.txt) contendo os microdados do Censo Escolar 2024
arquivo_origem = 'dados/microdados_ed_basica_2024.txt'

# Lista com os nomes das colunas que serão utilizadas na análise
colunas_desejadas = [
    'NO_REGIAO', 'NO_UF', 'NO_MUNICIPIO', 'NO_ENTIDADE', 'TP_DEPENDENCIA', 'TP_LOCALIZACAO',
    'IN_INTERNET', 'IN_ENERGIA_REDE_PUBLICA',
    'IN_AGUA_POTAVEL', 'IN_ESGOTO_REDE_PUBLICA', 'IN_BANHEIRO',
    'IN_QUADRA_ESPORTES', 'IN_REFEITORIO', 'IN_BIBLIOTECA',
    'QT_MAT_BAS', 'QT_DOC_BAS', 'QT_TUR_BAS'
]

# Lê o arquivo original, carregando apenas as colunas selecionadas
df = pd.read_csv(
    arquivo_origem,       # Caminho do arquivo original
    sep=';',              # Separador utilizado no arquivo (ponto e vírgula)
    encoding='latin1',    # Codificação dos caracteres para leitura correta
    usecols=colunas_desejadas  # Filtra apenas as colunas desejadas
)

# Exporta o novo DataFrame para um arquivo CSV com as colunas filtradas
df.to_csv(
    'dados/escolas_2024_filtrado.csv',  # Caminho de saída genérico para o novo arquivo
    sep=';',           # Utiliza ponto e vírgula como separador
    index=False,       # Não inclui o índice do DataFrame como coluna no CSV
    encoding='utf-8'   # Codificação apropriada para importação no MySQL
)
```

## 💾 Importação dos Dados no MySQL

Com o arquivo CSV filtrado contendo apenas as colunas relevantes, foi possível realizar a importação para o MySQL utilizando o comando `LOAD DATA INFILE`.

Abaixo está o script SQL utilizado para carregar os dados do arquivo `escolas_2024_filtrado.csv` na tabela `escolas_2024`

```sql
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/escolas_2024_filtrado.csv'
-- Carrega os dados do arquivo CSV localizado no caminho especificado.

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
	@NO_REGIAO, @NO_UF, @NO_MUNICIPIO, @NO_ENTIDADE, @TP_DEPENDENCIA, @TP_LOCALIZACAO, @IN_INTERNET, @IN_ENERGIA_REDE_PUBLICA, 
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
```

---

Após a importação dos dados bem-sucedida, podemos verificar utilizando um `SELECT * FROM escolas_2024` e notar que a tabela foi importada com sucesso. 

Agora, para começarmos a limpeza dos dados — verificando duplicatas e tratando valores nulos — criaremos uma cópia da tabela, na qual iremos realizar a limpeza. 

Por fim, faremos as queries para responder as perguntas de negócio, utilizando a tabela chamada `escolas_backup`.

```sql
-- Criação de uma table de backup a partir da table original
CREATE TABLE escolas_backup AS
SELECT * FROM escolas_2024;
```

## 🧹 4️⃣ Limpeza e Transformação dos Dados

Nesta etapa, após a importação bem-sucedida da tabela original e a criação de uma tabela de backup (`escolas_backup`) para tratarmos os dados com mais segurança, iniciamos o processo de limpeza e transformação.

O primeiro passo é verificar a presença de **duplicatas** nos dados, garantindo que cada linha represente uma escola única e válida antes de prosseguirmos com os demais tratamentos (como nulos, formatação e consistência de dados).

### 🧩 Parte 1: Verificar Duplicatas

Primeiramente, vamos verificar se há **linhas duplicadas** em toda a base de dados. Para isso, utilizamos o seguinte código SQL:

```sql
-- Verificar duplicatas considerando todas as colunas da tabela
SELECT *
FROM escolas_backup
GROUP BY id, NO_REGIAO, NO_UF, NO_MUNICIPIO, NO_ENTIDADE, TP_DEPENDENCIA, TP_LOCALIZACAO, 
         IN_INTERNET, IN_ENERGIA_REDE_PUBLICA, IN_AGUA_POTAVEL, IN_ESGOTO_REDE_PUBLICA, 
         IN_BANHEIRO, IN_QUADRA_ESPORTES, IN_REFEITORIO, IN_BIBLIOTECA, QT_MAT_BAS, 
         QT_DOC_BAS, QT_TUR_BAS
HAVING COUNT(*) > 1;
```
O código conta o número de linhas repedidas na tabela (ou seja maior que 1)

📋 **Retorno da consulta:**

Nenhum resultado retornado. Retorno de lista vazia

✅ Isso indica que **não há duplicatas** na tabela `escolas_2024`, considerando todas as colunas listadas no `GROUP BY`.

### 🧩 Parte 2: Verificar Duplicatas de Nomes de Escolas

Em seguida, vamos verificar se há **nomes de escolas repetidos** nos dados. Isso pode indicar inconsistências ou duplicações, como a mesma escola sendo registrada mais de uma vez.

Utilizamos o seguinte comando SQL:

```sql
-- Verificar duplicatas nos nomes das escolas
SELECT NO_ENTIDADE, COUNT(*) AS quantidade
FROM escolas_backup
GROUP BY id, NO_ENTIDADE
HAVING COUNT(*) > 1;
```
O código conta quantas vezes o nome de cada escola (NO_ENTIDADE) aparece.
Identifica se o mesmo nome aparece mais de uma vez no conjunto de dados.

📋 **Retorno da consulta:**

Nenhuma linha foi retornada, nenhum nome de escola repedido na base de dados.

✅ **Conclusão da Verificação de Duplicatas**

Após verificarmos todas as linhas da tabela e também analisarmos a variável `NO_ENTIDADE` (nome da escola), que é um dos principais indicadores de possíveis repetições:

- **Não foram encontradas duplicatas completas** entre os registros.
- **Não foram identificados nomes de escolas repetidos** com o mesmo `id`.

📌 Com isso, concluímos que **não há valores ou linhas duplicadas** nos dados da tabela `escolas_2024`. Podemos seguir com segurança para a próxima etapa do tratamento dos dados.

---

5️⃣🔍 Verificação de Valores Nulos

Após garantir que não há duplicatas na base de dados, o próximo passo é verificar a **presença de valores nulos ou vazios** nas colunas da tabela `escolas_2024`. Isso é essencial para definir estratégias de tratamento, como preenchimento, substituição por padrão ou exclusão de registros.

A consulta abaixo identifica a **quantidade de valores nulos ou vazios (`''`)** em cada coluna da tabela:

```sql
SELECT 
    COUNT(*) AS total_registros,
    SUM(CASE WHEN id IS NULL OR id = '' THEN 1 ELSE 0 END) AS id_nulos,
    SUM(CASE WHEN NO_REGIAO IS NULL OR NO_REGIAO = '' THEN 1 ELSE 0 END) AS NO_REGIAO_nulos,
    SUM(CASE WHEN NO_UF IS NULL OR NO_UF = '' THEN 1 ELSE 0 END) AS NO_UF_nulos,
    SUM(CASE WHEN NO_MUNICIPIO IS NULL OR NO_MUNICIPIO = '' THEN 1 ELSE 0 END) AS NO_MUNICIPIO_nulos,
    SUM(CASE WHEN NO_ENTIDADE IS NULL OR NO_ENTIDADE = '' THEN 1 ELSE 0 END) AS NO_ENTIDADE_nulos,
    SUM(CASE WHEN TP_DEPENDENCIA IS NULL OR TP_DEPENDENCIA = '' THEN 1 ELSE 0 END) AS TP_DEPENDENCIA_nulos,
    SUM(CASE WHEN TP_LOCALIZACAO IS NULL OR TP_LOCALIZACAO = '' THEN 1 ELSE 0 END) AS TP_LOCALIZACAO_nulos,
    SUM(CASE WHEN IN_INTERNET IS NULL OR IN_INTERNET = '' THEN 1 ELSE 0 END) AS IN_INTERNET_nulos,
    SUM(CASE WHEN IN_ENERGIA_REDE_PUBLICA IS NULL OR IN_ENERGIA_REDE_PUBLICA = '' THEN 1 ELSE 0 END) AS IN_ENERGIA_REDE_PUBLICA_nulos,
    SUM(CASE WHEN IN_AGUA_POTAVEL IS NULL OR IN_AGUA_POTAVEL = '' THEN 1 ELSE 0 END) AS IN_AGUA_POTAVEL_nulos,
    SUM(CASE WHEN IN_ESGOTO_REDE_PUBLICA IS NULL OR IN_ESGOTO_REDE_PUBLICA = '' THEN 1 ELSE 0 END) AS IN_ESGOTO_REDE_PUBLICA_nulos,
    SUM(CASE WHEN IN_BANHEIRO IS NULL OR IN_BANHEIRO = '' THEN 1 ELSE 0 END) AS IN_BANHEIRO_nulos,
    SUM(CASE WHEN IN_QUADRA_ESPORTES IS NULL OR IN_QUADRA_ESPORTES = '' THEN 1 ELSE 0 END) AS IN_QUADRA_ESPORTES_nulos,
    SUM(CASE WHEN IN_REFEITORIO IS NULL OR IN_REFEITORIO = '' THEN 1 ELSE 0 END) AS IN_REFEITORIO_nulos,
    SUM(CASE WHEN IN_BIBLIOTECA IS NULL OR IN_BIBLIOTECA = '' THEN 1 ELSE 0 END) AS IN_BIBLIOTECA_nulos,
    SUM(CASE WHEN QT_MAT_BAS IS NULL OR QT_MAT_BAS = '' THEN 1 ELSE 0 END) AS QT_MAT_BAS_nulos,
    SUM(CASE WHEN QT_DOC_BAS IS NULL OR QT_DOC_BAS = '' THEN 1 ELSE 0 END) AS QT_DOC_BAS_nulos,
    SUM(CASE WHEN QT_TUR_BAS IS NULL OR QT_TUR_BAS = '' THEN 1 ELSE 0 END) AS QT_TUR_BAS_nulos
FROM 
    escolas_2024;
```

📌 **O que esse código faz:**

- Retorna o **número total de registros** da tabela.
- Conta quantos registros possuem valores **nulos (`IS NULL`)** ou **vazios (`= ''`)** em cada coluna relevante.
- Permite avaliar **quais campos precisam de tratamento de dados ausentes**.

📋 **Retorno da consulta:**

Notamos que varias colunas apresentaram valores nulos, alguns em grandes quantidades como mostra atabela abaixo:

| Coluna                      | Valores Nulos/Vazios |
|----------------------------|-----------------------|
| total_registros            |       215545          |
| id_nulos                   |    0                  |
| NO_REGIAO_nulos            |    0                  |
| NO_UF_nulos                |    0                  |
| NO_MUNICIPIO_nulos         |    0                  |
| NO_ENTIDADE_nulos          |    0                  |
| TP_DEPENDENCIA_nulos       |    0                  |
| TP_LOCALIZACAO_nulos       |    0                  |
| IN_INTERNET_nulos          |    41138              |
| IN_ENERGIA_REDE_PUBLICA_nulos |    40119           |
| IN_AGUA_POTAVEL_nulos      |       110306          |
| IN_ESGOTO_REDE_PUBLICA_nulos |    39405            |
| IN_BANHEIRO_nulos          |       148976          |
| IN_QUADRA_ESPORTES_nulos   |     145638            |
| IN_REFEITORIO_nulos        |      118481           |
| IN_BIBLIOTECA_nulos        |      48774            |
| QT_MAT_BAS_nulos           |     36259             |
| QT_DOC_BAS_nulos           |     36548             |
| QT_TUR_BAS_nulos           |     36259             |

## Tratamento de Valores Nulos

A partir da consulta realizada notamos que há valores nulos nos registros, eles aparecem em grande quantidade, nas variáveis booleanas e nas variáveis quantitativas. 

A melhor maneira para o tratamento desses valores primeiramente é verificar com a área de negócio as principais causas, como falta de informação na coleta, coleta errada entre outros. 

Como em nosso caso, como se trata de um projeto de aprendizagem, vamos tomar as seguintes providências:

## Parte 1 - Valores Booleanos

Para os valores nulos encontrados em variáveis booleanas, decidimos que:

- **Objetivo:** Preservar os dados originais e manter a coerência da análise
- **Solução:** Os valores nulos serão convertidos para `-1`
- **Justificativa:**  
  O valor `-1` irá indicar claramente que não há informação sobre aquela variável, mantendo os valores booleanos originais (`0` e `1`) intactos

**Representação:**
- `1` = Verdadeiro/Sim
- `0` = Falso/Não  
- `-1` = Dado não disponível (anteriormente NULL)

## 📋 Procedure para Verificação de Valores Nulos

Primeiramente criaremos um procedure para verificar os valores nulos nas colunas. Isso vai ajudar a checar se as alterações que serão aplicadas funcionaram:

```sql
DELIMITER $$

CREATE PROCEDURE resumo_dados_nulos()
BEGIN
    SELECT 
        COUNT(*) AS total_registros,
        SUM(CASE WHEN id IS NULL OR id='' THEN 1 ELSE 0 END) AS id_nulos,
        SUM(CASE WHEN NO_REGIAO IS NULL OR NO_REGIAO ='' THEN 1 ELSE 0 END) AS NO_REGIAO_nulos,
        SUM(CASE WHEN NO_UF IS NULL OR NO_UF ='' THEN 1 ELSE 0 END) AS NO_UF_nulos,
        SUM(CASE WHEN NO_MUNICIPIO IS NULL OR NO_MUNICIPIO ='' THEN 1 ELSE 0 END) AS NO_MUNICIPIO_nulos,
        SUM(CASE WHEN NO_ENTIDADE IS NULL OR NO_ENTIDADE ='' THEN 1 ELSE 0 END) AS NO_ENTIDADE_nulos,
        SUM(CASE WHEN TP_DEPENDENCIA IS NULL OR TP_DEPENDENCIA ='' THEN 1 ELSE 0 END) AS TP_DEPENDENCIA_nulos,
        SUM(CASE WHEN TP_LOCALIZACAO IS NULL OR TP_LOCALIZACAO ='' THEN 1 ELSE 0 END) AS TP_LOCALIZACAO_nulos,
        SUM(CASE WHEN IN_INTERNET IS NULL OR TRIM(IN_INTERNET) ='' THEN 1 ELSE 0 END) AS IN_INTERNET_nulos,
        SUM(CASE WHEN IN_ENERGIA_REDE_PUBLICA IS NULL OR TRIM(IN_ENERGIA_REDE_PUBLICA) ='' THEN 1 ELSE 0 END) AS IN_ENERGIA_REDE_PUBLICA_nulos,
        SUM(CASE WHEN IN_AGUA_POTAVEL IS NULL OR TRIM(IN_AGUA_POTAVEL) ='' THEN 1 ELSE 0 END) AS IN_AGUA_POTAVEL_nulos,
        SUM(CASE WHEN IN_ESGOTO_REDE_PUBLICA IS NULL OR TRIM(IN_ESGOTO_REDE_PUBLICA) ='' THEN 1 ELSE 0 END) AS IN_ESGOTO_REDE_PUBLICA_nulos,
        SUM(CASE WHEN IN_BANHEIRO IS NULL OR TRIM(IN_BANHEIRO) ='' THEN 1 ELSE 0 END) AS IN_BANHEIRO_nulos,
        SUM(CASE WHEN IN_QUADRA_ESPORTES IS NULL OR TRIM(IN_QUADRA_ESPORTES) = '' THEN 1 ELSE 0 END) AS IN_QUADRA_ESPORTES_nulos,
        SUM(CASE WHEN IN_REFEITORIO IS NULL OR TRIM(IN_REFEITORIO) ='' THEN 1 ELSE 0 END) AS IN_REFEITORIO_nulos,
        SUM(CASE WHEN IN_BIBLIOTECA IS NULL OR TRIM(IN_BIBLIOTECA) ='' THEN 1 ELSE 0 END) AS IN_BIBLIOTECA_nulos,
        SUM(CASE WHEN QT_MAT_BAS IS NULL OR QT_MAT_BAS ='' THEN 1 ELSE 0 END) AS QT_MAT_BAS_nulos,
        SUM(CASE WHEN QT_DOC_BAS IS NULL OR QT_DOC_BAS ='' THEN 1 ELSE 0 END) AS QT_DOC_BAS_nulos,
        SUM(CASE WHEN QT_TUR_BAS IS NULL OR QT_TUR_BAS ='' THEN 1 ELSE 0 END) AS QT_TUR_BAS_nulos
    FROM 
        escolas_backup;
END $$

DELIMITER ;
```

**Objetivo:**  
Este procedure permite verificar a quantidade de valores nulos ou vazios em cada coluna da tabela `escolas_backup`, servindo como base para validar as transformações aplicadas nos dados.

## 🔄 Substituição de Valores Nulos/Vazios por -1 em Variáveis Booleanas

Agora iremos fazer a alteração dos valores nulos e vazios para `-1` nas variáveis booleanas:

```sql
-- Atualiza a tabela escolas_backup substituindo NULL/vazios por -1
-- em todas as colunas de flags booleanas
UPDATE escolas_backup
SET 
  IN_INTERNET = CASE 
    WHEN IN_INTERNET IS NULL OR TRIM(IN_INTERNET) = '' THEN -1 
    ELSE IN_INTERNET 
  END,
  
  IN_ENERGIA_REDE_PUBLICA = CASE 
    WHEN IN_ENERGIA_REDE_PUBLICA IS NULL OR TRIM(IN_ENERGIA_REDE_PUBLICA) = '' THEN -1 
    ELSE IN_ENERGIA_REDE_PUBLICA 
  END,
  
  IN_AGUA_POTAVEL = CASE 
    WHEN IN_AGUA_POTAVEL IS NULL OR TRIM(IN_AGUA_POTAVEL) = '' THEN -1 
    ELSE IN_AGUA_POTAVEL 
  END,
  
  IN_ESGOTO_REDE_PUBLICA = CASE 
    WHEN IN_ESGOTO_REDE_PUBLICA IS NULL OR TRIM(IN_ESGOTO_REDE_PUBLICA) = '' THEN -1 
    ELSE IN_ESGOTO_REDE_PUBLICA 
  END,
  
  IN_BANHEIRO = CASE 
    WHEN IN_BANHEIRO IS NULL OR TRIM(IN_BANHEIRO) = '' THEN -1 
    ELSE IN_BANHEIRO 
  END,
  
  IN_QUADRA_ESPORTES = CASE 
    WHEN IN_QUADRA_ESPORTES IS NULL OR TRIM(IN_QUADRA_ESPORTES) = '' THEN -1 
    ELSE IN_QUADRA_ESPORTES 
  END,
  
  IN_REFEITORIO = CASE 
    WHEN IN_REFEITORIO IS NULL OR TRIM(IN_REFEITORIO) = '' THEN -1 
    ELSE IN_REFEITORIO 
  END,
  
  IN_BIBLIOTECA = CASE 
    WHEN IN_BIBLIOTECA IS NULL OR TRIM(IN_BIBLIOTECA) = '' THEN -1 
    ELSE IN_BIBLIOTECA 
  END;

```

**Legenda de Valores:**
- `1` = Sim/Disponível
- `0` = Não/Indisponível  
- `-1` = Não informado (originalmente NULL ou vazio)
- 
**Métods utilizados**
- UPDATE - Modifica registros existentes
- CASE WHEN - Condicional para substituição seletiva
- IS NULL - Verifica valores nulos
- TRIM() - Remove espaços em branco
- Operador OR - Combina condições
  
**Impacto:** Esta transformação preserva os dados originais enquanto marca claramente os registros com informações faltantes.

## ✅ Verificação das Alterações

Após a aplicação do código de substituição de valores nulos, podemos verificar o sucesso das alterações utilizando:

```sql
-- Chama o procedure para verificar a quantidade de valores nulos restantes
CALL resumo_dados_nulos();

-- Visualiza uma amostra dos dados com as alterações aplicadas
SELECT * FROM escolas_backup LIMIT 10;
```

📋 **Retorno da consulta:**

1. O procedure `resumo_dados_nulos()` retornou o valor `0` para valores nulos nas colunas booleanas, antes mostrando a quantidades de valores nulos.
2. A consulta SELECT exibiu o valor `-1` nos campos onde anteriormente havia NULL/valores vazios.

Assim os valores nulos e vazios das variaveis booleanas foram devidamente substituidos pelo valor '-1', que significa que não há informações para aquela escola. Com isso podemos seguir para a proxima etapa, que é modificar os valores nulos das variaveis quantitativas.

## Parte 2 - Valores Quantitativos

Para os valores nulos encontrados em variáveis quantitativas, iremos utilizar a mesma abordagem anterior, decidimos que:

- **Objetivo:** Preservar os dados originais e manter a coerência da análise
- **Solução:** Os valores nulos serão convertidos para `-1`
- **Justificativa:**  
  O valor `-1` irá indicar claramente que não há informação sobre aquela variável, mantendo os valores quantitativos originais  intactos

## 🔄 Substituição de Valores Nulos/Vazios por -1 em Variáveis Quantitativas

Agora iremos fazer a alteração dos valores nulos e vazios para `-1` nas variáveis quantitativas, o bjetivo mantendo em preservar a fonte de dados original, e atribuir aos valores nulos "-1", como forma de destacar que não há informações sobre a escola a respeito das variaveis quantitativas:

```sql
UPDATE escolas_backup
SET 
  QT_MAT_BAS = CASE
    WHEN QT_MAT_BAS IS NULL OR QT_MAT_BAS = '' THEN -1
    ELSE QT_MAT_BAS
  END,

  QT_DOC_BAS = CASE
    WHEN QT_DOC_BAS IS NULL OR QT_DOC_BAS = '' THEN -1
    ELSE QT_DOC_BAS
  END,
  
  QT_TUR_BAS = CASE
    WHEN QT_TUR_BAS IS NULL OR QT_TUR_BAS = '' THEN -1
    ELSE QT_TUR_BAS
  END;
```

**Métods utilizados**
- UPDATE - Modifica registros existentes
- CASE WHEN - Condicional para substituição seletiva
- IS NULL - Verifica valores nulos
- Operador OR - Combina condições

## ✅ Verificação das Alterações

Após a aplicação do código de substituição de valores nulos, podemos verificar o sucesso das alterações utilizando:

```sql
-- Chama o procedure para verificar a quantidade de valores nulos restantes
CALL resumo_dados_nulos();

-- Visualiza uma amostra dos dados com as alterações aplicadas
SELECT * FROM escolas_backup LIMIT 10;
```

📋 **Retorno da consulta:**

1. O procedure `resumo_dados_nulos()` retornou o valor `0` para valores nulos nas colunas quantitativas, antes mostrando a quantidades de valores nulos.
2. A consulta SELECT exibiu o valor `-1` nos campos onde anteriormente havia NULL/valores vazios.

Assim os valores nulos e vazios das variaveis quantitativas foram devidamente substituidos pelo valor '-1', que significa que não há informações para aquela escola. Com isso resolvemos os problemas dos valores nulos em nossa base de dados. 

Assim terminamos a etapa de Limpeza e trasnformação dos dados, podendo assim passa para etapa, onde começaremos a responder as perguntas de negocíso utilizando as consultas do SQL.
