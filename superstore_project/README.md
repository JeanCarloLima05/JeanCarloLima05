# 🛒 Análise de Vendas de um Superstore - Projeto em Power BI 

## 📖 Introdução

Este é um projeto **pessoal de análise de dados**, desenvolvido com o objetivo de **praticar e aplicar conhecimentos em Power BI**, abrangendo desde o **processo de ETL (Extração, Transformação e Carga)** até a **modelagem e criação de visualizações interativas**.

O projeto foi inteiramente construído dentro do Power BI, utilizando o **dataset "Sample Superstore Sales Data"**, amplamente conhecido e disponível publicamente no Kaggle:  
🔗 [Link para o dataset no Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

A ideia central é simular uma situação de análise real de dados de vendas de um **supermercado/e-commerce**, respondendo a **perguntas de negócio fictícias**, mas plausíveis, com foco no aprendizado de técnicas de análise, modelagem de dados e visualização.

## 🎯 Objetivo do Projeto

O principal objetivo deste projeto é realizar uma análise exploratória e descritiva dos dados de vendas, com foco em:

✅ Explorar métricas de desempenho de vendas.  
✅ Analisar a segmentação de clientes e seus impactos.  
✅ Avaliar a eficiência operacional, como o tempo médio entre pedido e envio.  
✅ Desenvolver visualizações intuitivas e interativas que facilitem a tomada de decisão.

O projeto foi **totalmente implementado no Power BI**, utilizando:  
- Power Query para a **transformação e limpeza dos dados**.  
- Modelo Estrela para **organização e relacionamento entre tabelas**.  
- Dashboards e relatórios interativos para **apresentação dos insights**.

Todas as análises, modelagens e visualizações foram feitas **sem o uso de outras ferramentas externas**, reforçando o domínio completo da ferramenta.

---

## ❓ Perguntas de Negócio que Guiaram a Análise

Durante o desenvolvimento, diversas **questões estratégicas** foram elaboradas para nortear a exploração dos dados:

1. **Qual é a receita total e o lucro por ano/mês?**  
2. **Quais categorias de produtos possuem a maior margem de lucro?**  
3. **Quais estados e regiões apresentam o melhor desempenho em vendas?**  
4. **Qual é o tempo médio entre o pedido e o envio?**  
5. **Existem clientes recorrentes? Qual é o impacto deles nas vendas?**

---

**🔔 Observação:**  
Todas as perguntas, análises e interpretações realizadas são **fictícias** e têm como principal finalidade a **simulação de um cenário realista** para **fins de aprendizado e desenvolvimento de competências na área de análise de dados**.

## 🛠️ Processos de ETL e Modelagem dos Dados

Este projeto foi inteiramente desenvolvido no **Power BI Desktop**, desde a importação e transformação dos dados até a criação do modelo e dashboards. Todas as etapas foram cuidadosamente realizadas para garantir uma análise precisa e eficiente.

---

## 1️⃣ Importação dos Dados

O processo iniciou com a importação do dataset:

1. Abra o Power BI Desktop.
2. Selecione a opção **"Obter Dados"** > **"Texto/CSV"**.
3. Navegue até o arquivo: `Sample_Superstore_Sales.csv`.
4. Revise a pré-visualização e clique em **"Carregar"**.

---

## 2️⃣ Cópia da Tabela Original

Antes de realizar qualquer transformação ou limpeza, foi criada uma **cópia da tabela original**.  

✅ A tabela original foi mantida **sem alterações**, garantindo a integridade para futuras consultas ou validações.  

✅ Todas as transformações, limpezas e análises foram realizadas a partir da **cópia da tabela**.  

**Exemplo de nomeação:**
- `Sample_Superstore_Original` → **Não alterada**  
- `Sample_Superstore_Tratada` → **Usada para as transformações**  

---

## 3️⃣ Transformação, Limpeza e Análise Exploratória

As transformações foram realizadas utilizando o **Power Query**, com a **Linguagem M**, incluindo as seguintes etapas principais:

---

### ✅ Tradução dos Cabeçalhos

Para facilitar a interpretação e o desenvolvimento da análise, todos os nomes das colunas foram traduzidos do inglês para o português, utilizando o seguinte código M:  

    ```m
    // Tradução dos cabeçalhos, para melhor entendimento
    #"Cabeçalhos Traduzidos" = Table.RenameColumns(#"Cabeçalhos Promovidos", {
        {"Row ID", "ID da Linha"},
        {"Order ID", "ID do Pedido"},
        {"Order Date", "Data do Pedido"},
        {"Ship Date", "Data de Envio"},
        {"Ship Mode", "Modo de Envio"},
        {"Customer ID", "ID do Cliente"},
        {"Customer Name", "Nome do Cliente"},
        {"Segment", "Segmento"},
        {"Country", "País"},
        {"City", "Cidade"},
        {"State", "Estado"},
        {"Postal Code", "CEP"},
        {"Region", "Região"},
        {"Product ID", "ID do Produto"},
        {"Category", "Categoria"},
        {"Sub-Category", "Subcategoria"},
        {"Product Name", "Nome do Produto"},
        {"Sales", "Vendas"},
        {"Quantity", "Quantidade"},
        {"Discount", "Desconto"},
        {"Profit", "Lucro"}
    })
    ´´´m
---

### ✅ Ajuste de Tipos de Dados  

Após a tradução dos cabeçalhos, foi realizado o ajuste dos tipos de dados para garantir a correta análise e visualização:

- `Data do Pedido` → Tipo **Data** (formato: **Português - BR**).  
- `Data de Envio` → Tipo **Data** (formato: **Português - BR**).  
- `Vendas` → Tipo **Número Decimal**.  
- `Lucro` → Tipo **Número Decimal**.  
- `Quantidade` → Tipo **Número Inteiro**.  
- `Desconto` → Tipo **Número Decimal** (ajuste de localidade).  
- `ID da Linha` → Tipo **Número Inteiro**.

---

### ✅ Verificação de Valores Nulos

O próximo passo na transformação e limpeza dos dados foi verificar a existência de valores nulos ou faltantes nas colunas do dataset.

Essa verificação foi realizada utilizando as próprias funcionalidades do Power BI Desktop, no editor do Power Query, que permite identificar rapidamente linhas ou colunas com dados ausentes.

- Colunas analisadas para valores nulos incluíram:  
  `ID do Pedido`, `Data do Pedido`, `Data de Envio`, `Vendas`, `Lucro`, entre outras importantes para a análise.

- Caso fossem encontrados valores nulos, o plano seria tratá-los conforme a necessidade (remoção, substituição, imputação), porém, neste dataset, não foram identificados valores nulos significativos, o que facilitou o prosseguimento da análise.

---
### ✅ Verificação de Duplicatas e Inconsistências nos Dados

Após verificar que **não havia valores nulos** no dataset, o próximo passo foi realizar uma análise para identificar possíveis **duplicatas ou inconsistências** nos dados, com foco na integridade da base para garantir análises confiáveis.

Durante essa análise, foram identificados dois problemas importantes:

---

#### 🚨 Problema 1: Nomes de Produtos Iguais para IDs de Produtos Diferentes

- Foi identificado que alguns **nomes de produtos** se repetiam, mas estavam associados a **IDs de produtos diferentes**.
- Esse tipo de inconsistência pode indicar erro de cadastro, divergência no sistema de origem ou problemas na integração dos dados.
- **Impacto**: pode gerar distorções nas análises relacionadas a vendas por produto e categoria.

**Exemplo hipotético:**  
| ID do Produto | Nome do Produto        |
|---------------|-----------------------|
| PROD123       | Cadeira Executiva X   |
| PROD789       | Cadeira Executiva X   |

---

#### 🚨 Problema 2: IDs de Produtos Iguais para Nomes de Produtos Diferentes

- Também foi detectado o inverso: **mesmos IDs de produto** associados a **nomes diferentes de produtos**.
- Isso é ainda mais grave, pois indica uma falha no controle de identificação única de produtos.
- **Impacto**: pode comprometer severamente as análises de performance de produtos, inventário e vendas.

**Exemplo hipotético:**  
| ID do Produto | Nome do Produto        |
|---------------|-----------------------|
| PROD456       | Impressora Laser A     |
| PROD456       | Impressora Multifuncional B |

---

### ✅ Ações Planejadas

- **Analisar a origem dessas inconsistências**, verificando se são erros sistemáticos ou casos isolados.
- **Definir critérios de tratamento**, como:
  - Unificação de registros duplicados.
  - Correção manual ou automática com base em regras de negócio.
  - Comunicação com a área responsável pelo cadastro de produtos.
 
---

### ✅ Tratamento das Inconsistências - Decisões e Ações

Como este é um **projeto pessoal com foco em aprendizado**, foi decidido adotar as seguintes medidas para **corrigir as inconsistências identificadas**:

---

#### 🛠️ Caso 1: Mesmos Nomes para Diferentes IDs de Produto

**Problema identificado:**  
- O mesmo **nome de produto** aparecia vinculado a **diferentes IDs de produto**.

**Decisão:**  
- **Padronizar os IDs de produto**, unificando todos os registros com o **mesmo nome** sob um **único ID**.

**Critério adotado:**  
- Para cada nome duplicado, foi selecionado o **primeiro ID de ocorrência** como o **ID principal**.
- Todos os registros com o mesmo nome foram atualizados para utilizar esse **ID principal**.

**Exemplo de ação:**

| Antes                               |
|--------------------------------------|
| PROD123 → Cadeira Executiva X       |
| PROD789 → Cadeira Executiva X       |

| Depois                              |
|--------------------------------------|
| PROD123 → Cadeira Executiva X       |
| PROD123 → Cadeira Executiva X       |

**Ferramenta utilizada:**  
- Esta padronização foi realizada diretamente no **Power Query**, utilizando o recurso de **mesclagem de consultas** e **coluna condicional** para substituir os IDs conforme a regra estabelecida.

---

