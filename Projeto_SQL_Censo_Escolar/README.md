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

A
