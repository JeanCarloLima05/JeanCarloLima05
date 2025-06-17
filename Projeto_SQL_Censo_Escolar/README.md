# 🏫 Análise de Infraestrutura Escolar na Educação Básica no Brasil com SQL
Um projeto em SQL utilizando dados do Censo da Educação Básica 2024 para responder perguntas sobre a infraestrutura das escolas públicas e privadas brasileiras.

## 📖 Introdução

Este é um projeto **pessoal de análise de dados**, desenvolvido com o objetivo de **praticar e aplicar conhecimentos em SQL**, abrangendo desde o **processo de ELT (Extração, Carregamento e Transformação)** até a **modelagem da tabela e criação de consultas**.

O projeto foi inteiramente construído dentro do MYSQL, utilizando o **dataset "Microdados do Censo Escolar da Educação Básica 2024"**, amplamente conhecido e disponível publicamente no site do INEP:  
🔗 [Link para o dataset no INEP](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar) 

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
## 📜 Scripts SQL

- Script da Criação do Database e Criação da Table:  
  [Visualizar código SQL](./Scripts_SQL/Criar_Importar_Dados.sql)
  
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

📌 Com isso, concluímos que **não há valores ou linhas duplicatas** nos dados da tabela `escolas_2024`. Podemos seguir com segurança para a próxima etapa do tratamento dos dados.

## 📜 Scripts SQL

- Script da Verificação de Duplicatas:  
  [Visualizar código SQL](./Scripts_SQL/Verificar_Duplicatas.sql)

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

**Métodos utilizados**
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

## 📜 Scripts SQL

- Script de Tratamento dos Velores Nulos:  
  [Visualizar código SQL](./Scripts_SQL/Valores_Nulos.sql)

---

## 6️⃣ 📊 Respondendo Perguntas de Negócio

Após realizar a **limpeza** e **transformação** dos dados, estamos prontos para responder às perguntas de negócio propostas. 

### 🔍 Metodologia Adotada:
- 📌 **1 query dedicada** para cada pergunta de negócio
- 📂 **Organização em arquivos separados** na pasta do projeto
- 📝 **Documentação clara** em cada script SQL

## 1 - Quantas escolas têm acesso à internet por estado?

### 📌 Objetivo da Análise
Identificar a distribuição geográfica de escolas com infraestrutura digital básica.

### 🔍 Métrica Principal
- Contagem absoluta de escolas com `IN_INTERNET = 1` agrupadas por UF

Além de obtermos informações sobre as escolas que tem acesso a internet por estado, também segue os código mostrando as escolas que não possuem acesso a internet por estado e as escolas que não há informações sobre o acesso de internet por estado.

```sql
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
```

**Legenda de Valores:**
- `TRUE` = Sim/Disponível
- `FALSE` = Não/Indisponível  
- `-1` = Não informado


Ainda podemos verificar quais estados têm maior proporção de escolas com internet em relação ao número de escolas por estado.

```sql
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
```

📋 **Retorno da consulta:**

## 🔎 Principais Insights
1. **São Paulo** é o estado com o maior número de escolas com acesso a interne, sendo **30614** escolas, seguido por **Minas Gerais** e **Bahia**.
2. **Pará** é o estado com maior número de escolas **SEM** acesso a internet, sendo **1949** escolas, seguido pelo **Maranhão** e **Bahia**
3. **Distrito Federal** lidera a maior proporção de escolas com acesso a internet com **97,43%**, seguida do **Paraná** e **Goiás**
4. Disparidade entre as escolas com acesso a internet na região **Sul/Centro-Oeste/Sudeste** em relação as regiões **Norte e Nordeste** evidente nos dados.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Escolas com acesso a internet por estado
[Download dos resultados](./dados/resultado_analise1.csv)
- Escolas sem acesso a internet por estado
[Download dos resultados](./dados/resultado_analise1.csv)
- Escolas sem informações sobre acesso a internet por estado
[Download dos resultados](./dados/resultado_analise1.csv)
- Quais estados têm maior proporção de escolas com internet?
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 2 - Qual a média de turmas por escola em cada região?

### 📌 Objetivo da Análise
Identificar a média da quantidade de turmas registradas na educação básica por região.

```sql
SELECT 
  NO_REGIAO AS Regiao,
  ROUND(AVG(QT_TUR_BAS), 2) AS media_turmas
FROM 
  escolas_backup
WHERE 
  QT_TUR_BAS != -1
GROUP BY 
  NO_REGIAO;
```
**Métodos utilizados**
- ROUND - Arredonda o valore da variave, para quantidade de casas decimais informada (nesse caso 2 casa decimais)
- AVG - Retorna a Média dos valores 
- WHERE - Filtra termo descrito (Nesse caso filtra os valores da quantidade de turmas para todos os valores validos, diferente de "-1", ou seja, não conta aquelas variaveis que não há informação).
- GROUP BY - Agrupa os valores de media_turmas por Região.

📋 **Retorno da consulta:**

| Região                     | Média de Turmas |
|----------------------------|-----------------------|
|Centro-Oeste	             |       15.96           |
|Nordeste                    |    10.60              |
|Norte                       |    10.11              |
|Sudeste                     |    14.05              |
|Sul                         |    13.24              | 

## 🔎 Principais Insights

1. A Região **Centro-Oeste** apresenta a maior média da quantidades de turmas por escola, seguidas por **Sudeste**, **Sul**, **Nordeste** e **Norete**, respectivamente.
2. Novamente notamos a disparidade da média quantidade de turmas por escola entre as Regiões **Sul/Centro-Oeste/Sudeste** em relação as regiões **Norte e Nordeste** evidente nos dados

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Média de turmas por Região
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 3 - Quantas escolas têm saneamento básico completo (água + esgoto + energia) e qual a porcentagem em relação ao total de escolas??

### 📌 Objetivo da Análise
Identificar quantas escolas tem saneamento básico completo, ou seja, quantas escolas possuem água, rede de esgoto e energia elétrica e qual a porcentagem das escolas que possuem esse saneamento e o total de escolas com infomrações válidas.

```sql
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
```
**Métodos utilizados**
- Uso de **CTEs** (Common Table Expressions) para Clareza na Lógica. Uma CTE calcula o total de escolas válidas, ou seja, quantidades de escolas que apresentão informação nas 3 categorias de saneamento listadas (não apresentando o valore ("-1")). A segunta CTE calcula a quantidade de escolas que possuem o saneamento completo, ou seja, escolas que possuem os três serviço (true).
- Assim podemos então calcular a porcentagem de escolas que possuem saneamento básico completo em relação ao númeor de escolas total.
- Usamos WITH ,para cria as CTEs, usamos também os comandos WHERE, COUNT, ROUND e a condicional AND. Além disso foi utilizado uma abrevição do nome das consultas do CTEs para falicitar na modelagem do código. (Ex: com_saneamento = c e total_escolas = t)

📋 **Retorno da consulta:**

| Escolas com saneamento     | Total de Escola Validas    | Porcentagem	               |
|----------------------------|----------------------------|----------------------------|
|103457                      |181065                      |57.14                       |


## 🔎 Principais Insights

1. O número de escolas com sanemanto básico completo é de **103457**.
2. Temos uma taxa de **57,14%** da escolas com sanemanto básico completo, ou seja, **42,86%** das escolas não possuem sanemanto básico completo.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Escolas com sanemanto básico completo
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 4 - Qual a distribuição de escolas públicas x privadas por estado?

### 📌 Objetivo da Análise
Identificar qual a distribuição de escolas publicas e privadas por estado. As escolas públicas são divididas em três tipos Federal, Estadual e Municipal.

```sql
SELECT 
  NO_UF AS Estado,
  COUNT(CASE WHEN TP_DEPENDENCIA IN (1, 2, 3) THEN 1 END) AS escolas_publicas,
  COUNT(CASE WHEN TP_DEPENDENCIA = 1 THEN 1 END) AS escolas_federais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 2 THEN 1 END) AS escolas_estaduais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 3 THEN 1 END) AS escolas_municipais,
  COUNT(CASE WHEN TP_DEPENDENCIA = 4 THEN 1 END) AS escolas_privadas,
  COUNT(*) AS total_escolas
FROM 
  escolas_backup
WHERE 
  TP_DEPENDENCIA IN (1, 2, 3, 4)
GROUP BY 
  NO_UF
ORDER BY 
  NO_UF;
```

**Métodos utilizados**
- Utilizamos COUTN, CASE, WHEN, WHERE, CROUP BY, ORDER BY. Mas nessa consulta utilizamos o método PIVOT, ONDE COLOCAMOS O CASE em apenas uma linha tornando co código mais fácil de ser contruido, otmizando tempo e espaço de código.

📋 **Retorno da consulta:**

A consulta retornou uma tabela do tipo: 

| Estado | escolas_publicas   | escolas_federais | escolas_estaduais | escolas_municipais | escolas_privadas | total_escolas |
|--------|--------------------|------------------|-------------------|--------------------|------------------|---------------|

A tabela completa com os valores esta no arquivo csv, na pasta do projeto, link a baixo.

## 🔎 Principais Insights

1. **São Paulo** é o estado com maior número de escolas Públicas com **20535** escolas públicas, seguido de **Minas Gerais** e **Bahia**.
2. **Distrito Federal** é o estado com o menor número de escolas Públicas com **722** escolas públicas, seguido do **Amapá** e **Roraima**.
3. **São Paulo** também é o estado com maior número de escolas Privadas com **13328** escolas particulares, seguido de **Minas Gerais** e **Rio de Janeiro**.
4. **Acre** é o estado com o menor número de escolas Privadas com **46** escolas particulares, seguido de **Roraima** e **Amapá**.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Escolas Pública e Privadas por Estado
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 5 - Qual o ranking dos 10 municípios com mais turmas?

### 📌 Objetivo da Análise
Identificar o ranking dos 10 municípios com a maior quantidade de turmas nas escolas. Lembrando que queremos apenas a quantidade de turmas válidas, ou seja, apenas valores que são diferentes de "-1".

```sql
SELECT 
 NO_MUNICIPIO AS Municipios, 
 SUM(QT_TUR_BAS) AS total_turmas_validas
FROM escolas_backup
WHERE QT_TUR_BAS != -1 -- Filtra apenas valores válidos (diferentes de -1)
GROUP BY NO_MUNICIPIO
ORDER BY total_turmas_validas DESC
LIMIT 10;
```
📋 **Retorno da consulta:**

| Município      | Número de Turmas |
|----------------|-----------------:|
| São Paulo      |           122126 |
| Rio de Janeiro |            54435 |
| Brasília       |            28864 |
| Fortaleza      |            23131 |
| Belo Horizonte |            23104 |
| Salvador       |            22434 |
| Manaus         |            21142 |
| Curitiba       |            16759 |
| Recife         |            15288 |
| Porto Alegre   |            13358 |

## 🔎 Principais Insights

1. **São Paulo** é o estado com maior número de turmas nas escolas com **122126** turmas, seguido de **Rio de Janeiro** e **Brasília**.
2. Podemos notar uma diferença consideravel em relação o número de turmas da cidade de São Paulo em relação a outras cidades.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Ranking das 10 cidades com maior números de turmas cadastradas
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 6 - Quais as escolas tem a melhor infraestrutura (banheiro, quadra esportiva, refeitorio e bibliotecas) por Cidades/Etados/Região?

## 📌 Objetivo da Análise

Identificar escolas com **melhor infraestrutura** baseada em variáveis booleanas (`1` = possui, `0` = não possui):
- `IN_BANHEIRO` (Banheiro)
- `IN_QUADRA_ESPORTES` (Quadra esportiva)
- `IN_REFEITORIO` (Refeitório)
- `IN_BIBLIOTECA` (Biblioteca)

### 📋 Método de Classificação
Cada escola será categorizada pela **soma de infraestruturas presentes** (valores `1`):
| Variável Booleana         | Descrição               | Valores Válidos |
|---------------------------|-------------------------|-----------------|
| `IN_BANHEIRO`             | Presença de banheiro    | 1 = Sim, 0 = Não |
| `IN_QUADRA_ESPORTES`      | Presença de quadra      | 1 = Sim, 0 = Não |
| `IN_REFEITORIO`           | Presença de refeitório  | 1 = Sim, 0 = Não |
| `IN_BIBLIOTECA`           | Presença de biblioteca  | 1 = Sim, 0 = Não |

### Tabela de Classificação de Infraestrutura

| Pontuação Total | Itens Presentes          | Classificação |
|-----------------|--------------------------|---------------|
| 4               | Todos os 4 itens         | Alta          | 
| 3               | 3 itens                  | Alta          |
| 2               | 2 itens                  | Média         | 
| 0-1             | 1 item ou nenhum         | Baixa         | 

## Parte 1: Função de Classificação de Infraestrutura

### 📌 Objetivo
Criar uma função SQL para classificar automaticamente as escolas em:
- **Alta** (3-4 itens)
- **Média** (2 itens)
- **Baixa** (0-1 item)

```sql
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
```
Em seguida podemos checar se a função está correta: 

```sql
-- Chamando a função passando as colunas dos itens avaliados
SELECT 
  NO_ENTIDADE,
  classifica_infraestrutura(IN_BANHEIRO, IN_QUADRA_ESPORTES, IN_REFEITORIO, IN_BIBLIOTECA) AS nivel_infra
FROM escolas_backup;
```
## Parte 2: Criando um VIEW

### 📌 Objetivo
Criar um VIEW para facilitar a chamada da função, separando por Escolas, Estados, Municípios e Região: 

```sql
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
SELECT * FROM vw_infra_escolas;
``` 
## Parte 3: Quantidade de escolas por níveis de infraestrutura e localização

### 📌 Objetivo
Criar a consulta para classificar a quantidade de escolas por diferentes tipos de níveis de infraestrutura e por municípios, estado e região.
Iremos filtrar pelos 20 Municipios, Estados e Região com a infraestrutura com o nível mais alto:

```sql
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
```
📋 **Retorno da consulta:**
Tabela das escola para diferentes tipos de níveis de infraestrutura por municípios

| Cidade         | Total Escolas | Infra. Alta | Infra. Média | Infra. Baixa |
|----------------|--------------:|------------:|-------------:|-------------:|
| São Paulo      | 8,023        | 2,766       | 3,742        | 1,515        |
| Rio de Janeiro | 4,203        | 2,450       | 1,349        | 404          |
| Belo Horizonte | 2,146        | 1,054       | 292          | 800          |
| Fortaleza      | 1,348        | 829         | 353          | 166          |
| Salvador       | 1,620        | 680         | 484          | 456          |
| Manaus         | 1,107        | 674         | 308          | 125          |
| Curitiba       | 1,210        | 642         | 418          | 150          |
| Brasília       | 1,360        | 618         | 540          | 202          |
| Porto Alegre   | 1,040        | 522         | 301          | 217          |
| Recife         | 1,235        | 513         | 362          | 360          |
| Goiânia        | 873          | 473         | 303          | 97           |
| Campinas       | 741          | 378         | 243          | 120          |
| Guarulhos      | 745          | 361         | 257          | 127          |
| Belém          | 704          | 357         | 186          | 161          |
| São Luís       | 829          | 357         | 245          | 227          |
| Campo Grande   | 552          | 308         | 165          | 79           |
| São Gonçalo    | 576          | 305         | 168          | 103          |
| Duque de Caxias| 603          | 294         | 215          | 94           |
| Natal          | 633          | 288         | 155          | 190          |
| Uberlândia     | 434          | 275         | 86           | 73           |

**Legenda:**
- **Infra. Alta**: Escolas com 3-4 itens de infraestrutura
- **Infra. Média**: Escolas com 2 itens de infraestrutura
- **Infra. Baixa**: Escolas com 0-1 item de infraestrutura

O código acima também mostra as consultas para Estado e Regiões, além de uma conuslta que filtra estados, municípios e regiões na mesma tabela, segue as consultas em csv na pasta do projeto.

## 🔎 Principais Insights

1. **São Paulo** é a cidade com maior número de escolas com infraestrutura **alta** com **2766** escolas, seguido de **Rio de Janeiro** e **Belo Horizonte**.
2. Consequentemente **São Paulo** também é a cidade com maior número de escolas com infraestrutura **baixa** com **1515** escolas, seguido de **Salvador** e **Belo Horizonte**.
3. A região **Sudeste** é a região com maior número de escolas com infraestrutura **alta** com **30577** escolas.
4. A região **Nordeste** é a região com maior número de escolas com infraestrutura **baixa** com **43516** escolas. 
5. Podemos notar uma diferença consideravel dos níveis da infraestrutura da escolas baseada na sua localização (Região, Estado e Municípios). 

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv

- Escolas por nível de infreestrutura por Municípios, Estados e Região
[Download dos resultados](./dados/resultado_analise1.csv)
- Escolas por nível de infreestrutura por Municípios
[Download dos resultados](./dados/resultado_analise1.csv)
- Escolas por nível de infreestrutura por Estados 
[Download dos resultados](./dados/resultado_analise1.csv)
- Escolas por nível de infreestrutura por Região
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 7 - Quantas escolas de cada nível de infraestrutura existem em uma determinada região e o tipo de rede administrativa?

## 📌 Objetivo da Análise
O objetivo é saber o número de escolas da educação básica para cada nível de infraestrutura, passando por uma região específica e por um tipo de rede admistrativa específica (Federal, Estadual, Municípal e Privada).

Para isso iremos criar um Procedure, que por sua vez chama o View criada na pergunta número 6, que por sua vez chama a função que classifica o nível infraestrutura das escolas. Assim podemos passar a região escolhida e o tipo de rede administrativa.

```sql
DELIMITER $$

CREATE PROCEDURE contar_nivel_infra_por_rede_regiao(
	IN regiao_alvo VARCHAR(50), -- Parâmetro de entrada (região)
    IN tipo_rede INT -- Parâmetro de entrada (1=Federal, 2 = Estadual, 3 = Municipal, 4 = Privada) 
)
BEGIN
	SELECT
		v.nivel_infra, -- Nível infra da tabela do VIEW
        COUNT(*) AS total_escolas
	FROM vw_infra_escolas v -- View criada na pergunta 6 chamando a função (view abreviada para "v")
    INNER JOIN escolas_backup e ON v.NO_ENTIDADE = e.NO_ENTIDADE  -- Relaciona a VIEW com a tabela original para acessar a região e tipo de rede (tabela principal abreviada para "e").
    WHERE e.NO_REGIAO = regiao_alvo -- Busca a região na tabela original
		AND e.TP_DEPENDENCIA = tipo_rede -- Busca o tipo de rede administrativa na tabela original
	GROUP BY v.nivel_infra 
    ORDER BY FIELD(v.nivel_infra, 'Alta', 'Média', 'Baixa'); -- ORDER BY FIELD() Garante a ordem da lógica (Alta>Média>baixa) e não alfabética
END $$

DELIMITER ;
        
CALL contar_nivel_infra_por_rede_regiao('Nordeste', 1); -- Chama o procedure e passa os parâmetros (Região , Tipo)
```

**Métodos utilizados**
### 🔧 Estrutura Básica
- `DELIMITER $$` - Altera o delimitador para criação de procedures
- `CREATE PROCEDURE` - Define um bloco de código reutilizável com parâmetros (`IN`)

### 🔎 Consulta e Filtragem
- `SELECT ... FROM` - Seleciona dados da view/tabela
- `INNER JOIN` - Combina dados de tabelas original e do view
- `WHERE` - Filtra por região e tipo de rede

### 📊 Processamento de Dados
- `COUNT(*)` - Conta ocorrências por grupo
- `GROUP BY` - Agrupa resultados por nível de infraestrutura
- `ORDER BY FIELD()` - Ordena categorias de forma customizada (Alta > Média > Baixa)

### 🚀 Execução
- `CALL` - Invoca o procedure com parâmetros específicos
- `vw_infra_escolas` - View pré-existente com classificação de infraestrutura

**🔔 Observação:** 
A saída da consulta depende dos parâmetros de região e de tipo de rede informados, assim para exemplicifar escolhemos os parâmetros ('Nordeste = região, e 1 ('Federal') = rede) para termos uma saída.

📋 **Retorno da consulta:**

| Nível Infra | Total escolas | 
|-------------|---------------|
|Alta         | 200           |
|Média        | 29            |
|Baixa        | 7             |

## 🔎 Principais Insights

1. Assim podemos ter uma visão mais detalhada do nível de infraestrutura das escolas. no exmplo podemos notar que a região **Nordeste** apresenta **200** escolas **Federais** com nível **alto** de infraestrutura, **29** escolas **Federais** de nível **médio** e **7** escolas **Federais** de nível **baixo** de infraestrutura.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv, além do script em sql para teste

- Escolas por nível de infreestrutura por Região e Tipo de Rede Administrativa determinados.
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 8 - Qual é o número médio de docentes, matriculas e turmas por escola em municípios com mais de 100 escolas?

## 📌 Objetivo da Análise
Identificar o número médio de professores cadastrados, matriculas (alunos) e turmas por escolas nos municípios com mais de 100 escolas.

```sql
SELECT 
  NO_MUNICIPIO,
  COUNT(*) AS total_escolas,
  ROUND(AVG(CASE WHEN QT_DOC_BAS != -1 THEN QT_DOC_BAS END), 2) AS media_docentes, -- Calculando a média de professores, apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_docentes'
  ROUND(AVG(CASE WHEN QT_MAT_BAS != -1 THEN QT_MAT_BAS END), 2) AS media_matriculas, -- Calculando a média de alunos (matriculas), apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_matriculas'
  ROUND(AVG(CASE WHEN QT_TUR_BAS != -1 THEN QT_TUR_BAS END), 2) AS media_turmas -- Calculando a média de turmas, apenas para os casos válidos (diferentes de "-1"), aredondando para 2 casa decimais e salvando na variavel 'media_turmas'
FROM escolas_backup
GROUP BY NO_MUNICIPIO
HAVING COUNT(*) > 100 -- Filtrando apenas para os municípios que possuem masi de 100 escolas
ORDER BY media_docentes DESC; --LIMIT 10 (OPCIONAL); -- Ordenando da maior média de professores para a menor,opção
```
📋 **Retorno da consulta:**

Para facilitar a vizualização aqui limitamos para as 10 primeiras cidades, mas o código está para todas as cidades.

Tabela ordenada para a maior média de **Docentes**
| Cidade               | Escolas | Média Prodessores | Média Alunos | Média Turmas |
|----------------------|--------:|-------------:|-------------:|------------------:|
| Praia Grande         | 181     | 39.70        | 560.25       | 23.94             |
| Vitória              | 236     | 32.47        | 430.84       | 19.06             |
| Serra                | 279     | 32.03        | 527.03       | 21.80             |
| Vila Velha           | 289     | 31.39        | 484.19       | 20.80             |
| Barueri              | 167     | 31.28        | 582.77       | 21.71             |
| Campo Grande         | 593     | 30.00        | 411.16       | 17.56             |
| Dourados             | 152     | 29.74        | 424.46       | 18.73             |
| Uberaba              | 280     | 29.52        | 395.78       | 18.38             |
| Cariacica            | 226     | 29.27        | 435.93       | 17.99             |
| Ribeirão das Neves   | 178     | 29.22        | 491.34       | 20.06             |

Tabela ordenada para a maior média de **Matriculas**
| Cidade                  | Escolas | Média Prodessores | Média Alunos | Média Turmas |
|-------------------------|--------:|-------------:|-------------:|------------------:|
| Itapevi                 | 103     | 26.33        | 611.77       | 20.85             |
| Águas Lindas de Goiás   | 106     | 19.24        | 590.88       | 21.28             |
| Barueri                 | 167     | 31.28        | 582.77       | 21.71             |
| Praia Grande            | 181     | 39.70        | 560.25       | 23.94             |
| Francisco Morato        | 108     | 22.27        | 546.00       | 21.10             |
| Parauapebas             | 146     | 18.49        | 532.45       | 23.75             |
| Serra                   | 279     | 32.03        | 527.03       | 21.80             |
| Manaus                  | 1107    | 21.98        | 509.16       | 19.96             |
| Aparecida de Goiânia    | 247     | 19.11        | 493.00       | 17.02             |
| Ribeirão das Neves      | 178     | 29.22        | 491.34       | 20.06             |

Tabela ordenada para a maior média de **Turmas**
| Cidade               | Escolas | Média Prodessores | Média Alunos | Média Turmas |
|----------------------|--------:|-------------:|-------------:|------------------:|
| Praia Grande         | 181     | 39.70        | 560.25       | 23.94             |
| Parauapebas          | 146     | 18.49        | 532.45       | 23.75             |
| Brasília             | 1360    | 26.25        | 490.34       | 22.48             |
| Serra                | 279     | 32.03        | 527.03       | 21.80             |
| Barueri              | 167     | 31.28        | 582.77       | 21.71             |
| Águas Lindas de Goiás| 106     | 19.24        | 590.88       | 21.28             |
| Francisco Morato     | 108     | 22.27        | 546.00       | 21.10             |
| Itapevi              | 103     | 26.33        | 611.77       | 20.85             |
| Vila Velha           | 289     | 31.39        | 484.19       | 20.80             |
| Florianópolis        | 365     | 25.32        | 405.74       | 20.27             |

## 🔎 Principais Insights

1. Notamos que a Cidade de **Praia Grande** tem a maior média de professores por escola com quase **40** por escola, seguido pelas cidades de **Vitória** e **Serra**.
2. Fazendo um novo Filtro agora pela maior média de **Alunos**(matrículas): A cidade de **Itapevi** tem a maior média de alunos por escola com quase **612** alunos, seguido pelas cidades de **Águas Lindas de Goiás** e **Barueri**.
3. Fazendo um novo Filtro agora pela maior média de **Turmas**(matrículas): A cidade de **Praia Grande** tem a maior média de turmas por escola com quase **24** turmas, seguido pelas cidades de **Parauapebas** e **Brasília**.
4. Notamos como os dados podem variar de forma diferentees quando variamos os parâmetros (Docentes, Matriculas e turmas), permitindo uma análise mais profunda dos dados.

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv.

- Cidades com mais de 100 escolas classificadas, por quantidade de Docentes, Matriculas e Turmas ( Filtrada por Docentes)
[Download dos resultados](./dados/resultado_analise1.csv)
- Cidades com mais de 100 escolas classificadas, por quantidade de Docentes, Matriculas e Turmas ( Filtrada por Matrículas)
[Download dos resultados](./dados/resultado_analise1.csv)
- Cidades com mais de 100 escolas classificadas, por quantidade de Docentes, Matriculas e Turmas ( Filtrada por Turmas)
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 9 - Qual a distribuição percentual de escolas com água potável por região?

## 📌 Objetivo da Análise
Identificar a distribuição percentual de escolas que possuem acesso a água potável por região.

```sql
WITH total_regiao AS ( -- Calculo do total de escolas válidas por região
	SELECT NO_REGIAO, COUNT(*) AS total_escolas
    FROM escolas_backup
    WHERE IN_AGUA_POTAVEL IN (0, 1) - Escolas valídas
    GROUP BY NO_REGIAO
), com_agua AS (  -- Calculo de escolas por região que possuem água potável (IN_AGUA_POTAVEL = 1 ou true)
    SELECT NO_REGIAO, COUNT(*) AS escolas_com_agua
    FROM escolas_backup
    WHERE IN_AGUA_POTAVEL = 1
    GROUP BY NO_REGIAO
)
SELECT 
	t.NO_REGIAO,
    ROUND((A.escolas_com_agua / t.total_escolas)* 100, 2) AS perc_com_agua  -- Calculo a porcentagem de escolas por região que possuem acesso a água potável
FROM total_regiao t -- Definição do Alias "t" para total_regiao
JOIN com_agua a USING (NO_REGIAO) -- Definição do Alias "a" para com_agua
ORDER BY perc_com_agua DESC;
```

**Métodos utilizados**
- Uso de **CTEs** (Common Table Expressions) para Clareza na Lógica. Uma CTE calcula o total de escolas válidas, ou seja, quantidades de escolas que apresentão informação sobre acesso a água potável (sim =1 ou não =0) (não apresentando o valor ("-1")). A segunta CTE calcula a quantidade de escolas que possuem acesso a água potável, ou seja, escolas que possuem água potável = 1 ou (true).
- Assim podemos então calcular a porcentagem de escolas que possuem acesso a água potável completo em relação ao númeor de escolas total válidas , por região.
- Usamos WITH ,para cria as CTEs, usamos também os comandos WHERE, COUNT, ROUND, JOIN e a condicional AND. Além disso foi utilizado uma abrevição do nome das consultas do CTEs para falicitar na modelagem do código. (Ex: com_saneamento = c e total_escolas = t) definição dos "Alias".

📋 **Retorno da consulta:**

| Região     | % com acesso a água potável |
|------------|-----------------------------|
|Sudeste     | 89.35                       |
|Sul         | 65.14                       |
|Centro-Oeste| 57.25                       |
|Nordeste    | 39.92                       |
|Norte       | 13.55                       |

## 🔎 Principais Insights

1. Notamos um indicador preocupante, enquanto a Região **Sudeste** apresenta cerca de **89,35%** das escolas com água potável, a Região **Norte** apresenta apenas **13,55%** das escolas com acesso a água potável. Uma visaõ muito drastica e contrastante do cenario de infraestrutura e saneamento da educação básica no Brasil.
2. Vemos que os indicadores podem variar de forma drastica apenas mudando a região do pais, mostrando um desigualdade no sistema de Educação Básica.


## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv.

- Porcentagem de escolas com acesso a água potável por região.
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 10 - Qual o Total de alunos por tipo de escola em cada estado? 

## 📌 Objetivo da Análise
Identificar qual o total de alunos (matrículas) por tipo de escola (Federal, Estadual, Municípal, Privada) em cada Estado.

```sql
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
        
SELECT * FROM total_matriculas_por_estado_tipo; -- Chamar a VIEW 
```
📋 **Retorno da consulta:**

Modelo da tabela gerada pela consulta (O dados completos estão na pasta do arquivo)

| Estado  | Tipo Escola  | Total Matriculas |
|---------|--------------|------------------|
|Estado 1 | Federal      | # núm matricula  |
|Estado 1 | Estadual     | # núm matricula  |
|Estado 1 | Municipal    | # núm matricula  |
|Estado 1 | Privada      | # núm matricula  |
|Estado 2 | Federal      | # núm matricula  |
|......   | .....        |  .....           |

## 🔎 Principais Insights

1. Notamos uma variação grande de estado para estado, alguns estados há maiores quantidades de alunas nas redes Estaduais (Exemplo: **Acre**, já em outros há maiores quantidades de alunos nas redes Municípais (Exemplo: "Esírito Santo**).
2. Nas Redes Municípais o Estado com maior número de matrículas é **São Paulo**, seguido de **Minas Gerais** e **Bahia**.
3. Nas Redes Estaduais o Estado com maior número de matrículas é **São Paulo**, seguido de **Minas Gerais** e **Paraná**.
4. Nas Redes Federais o Estado com maior número de matrículas é **Minas Gerais**, seguido de **Rio de Janeiro** e **Rio Grande do Sul**.
5. Nas Redes Privada o Estado com maior número de matrículas é **São Paulo**, seguido de **Rio de Janeiro** e **Minas Gerais**.  

## 📁 Dados Completos
Seguem os dados gerados pelas consultas, em formato csv.

- Quantidade de matrículas por região e por tipo de rede administrativa.
[Download dos resultados](./dados/resultado_analise1.csv)

---

## 7️⃣ 🎯 Conclusão e Considerações Finais

### 📌 Resultados Alcançados
Através deste projeto, foi possível:

✅ **Responder todas as perguntas de negócio** definidas inicialmente, transformando dados brutos em insights acionáveis através de c
consultas em  linguagem SQL.  
✅ **Aplicar na prática** conhecimentos essenciais de análise de dados:
   - Importação de Dados csv e txt, para o MYSQL Workbench.
   - Modelagem dos dados: Criação de Table, declaração de variaveis.
   - Limpeza e Trasnformação de dados: Verificação e Remoção de Duplicatas, Verificação e Trasnformação de Valores Nulos.
   - Criação de Functions e Procedures.
   - Criação de VIEWs e CTEs.
   - Utilização de `SELECT` , `JOIN` , `WHERE`, `CASE`, `WHEN` para Consulta filtrada.
   - Utilização de `COUNT` , `GROUP BY`, `SUM`, `AVG` para  Agregação.
   - Utilização de ORDER BY` para Ordenação
   - Utilização de CALL` para Execução com parâmetros (Functions, procedures e view)
   - Utilização `IF ELSE` para Estrutura de controle (Condicionais)
   - Utilização de ALIAS para Renomear colunas ou expressões. 

### 🛠️ Ferramentas Utilizadas
O projeto foi desenvolvido integralmente no **MYSQL WORKBENCH**, demonstrando:
- Capacidade de realizar **ETL completo** na ferramenta
- Criação de **QUERYS DETALHADAS**
- Desenvolvimento dos **principais comandos**
  
**🔔 Observação:**
	Em apenas uma parte desse projeto foi preciso utilizar um pequeno código em **python**, para ser possível e facilitar a criação da tabela de dados no MYSQL.
  
### 🌟 Considerações Finais
Este projeto, desenvolvido com **dados públicos para fins educacionais**, serviu como:
- Laboratório para **consolidar conhecimentos** em Linguagem SQL
- Demonstração de **capacidade analítica** desde a limpeza até  oresultado das consultas e análise das mesmas.
- Base para futuras **implementações em cenários reais**
- Abertura para evolução nas consultas e no projeto em geral, podendo agregar novas ferramentas ou criar vizualizações com outras ferramentas.

> "Os dados contam histórias quando questionados corretamente. Este projeto foi o segundo capítulo nessa narrativa." *(Jean Carlo)*
