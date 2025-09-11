# 🎵 Projeto SQL & Power BI - Loja de Música Digital (Chinook Database)

## 🎯 Objetivo do Projeto

Este projeto tem como objetivo **simular uma situação real de análise de dados em um contexto de negócio**, utilizando o **Chinook Database** (base pública e gratuita).  

A proposta é aplicar técnicas de **SQL (SQLite)** e **Power BI** para:  
- Organizar e explorar dados de clientes, vendas e catálogo musical.  
- Responder a **perguntas de negócio** relevantes para a gestão da empresa.  
- Criar indicadores estratégicos que auxiliem na **tomada de decisões**.  

📌 **Benefício**:  
Este case simula como uma empresa de **streaming/loja digital de música** poderia acompanhar sua **receita, clientes e catálogo musical** para identificar oportunidades de crescimento, entender o comportamento dos clientes e apoiar decisões estratégicas.

---

## 📌 Contexto do Projeto
O **Chinook Database** simula uma loja de música digital, contendo informações sobre:
- Clientes
- Funcionários
- Artistas e Álbuns
- Faixas musicais
- Gêneros musicais
- Faturas e Itens de venda

O objetivo deste projeto é **analisar o desempenho de vendas, clientes e catálogo musical**, utilizando **SQL (SQLite)** para tratamento, exploração e modelagem dos dados, e **Power BI** para visualizações e storytelling.

## 📂 Fonte dos Dados

Este projeto utiliza o **Chinook Database**, uma base de dados **pública e gratuita** muito utilizada em treinamentos de SQL.  
O banco simula uma **loja de música digital**, contendo informações sobre clientes, funcionários, artistas, álbuns, faixas, gêneros e faturas de vendas.  

🔗 Disponível em: [Chinook Database no GitHub](https://github.com/lerocha/chinook-database)

> ⚠️ Observação: Este projeto é de caráter **educacional**, desenvolvido para fins de **aprendizado e prática de técnicas de análise de dados** com **SQL (SQLite)** e **Power BI**.  
> Não há uso comercial ou dados sensíveis envolvidos.
---

## ⚙️ Estrutura do Banco de Dados
Principais tabelas do Chinook:
- `Customer` → clientes
- `Employee` → funcionários
- `Artist`, `Album`, `Track`, `Genre` → catálogo musical
- `Invoice`, `InvoiceLine` → vendas (faturas e itens de fatura)
- `Playlist`, `PlaylistTrack` → playlists

---

## ❓ Perguntas de Negócio

Essas perguntas guiarão a parte SQL e depois serão visualizadas no Power BI.


### 🎯 Vendas e Receita
- Qual é a receita total da loja?
- Qual é a evolução das vendas por ano e mês?
- Quais são os gêneros musicais mais vendidos?
- Quem são os clientes que mais gastaram?


### 👥 Clientes e Funcionários
- Qual país concentra mais clientes ativos?
- Quem são os 3 clientes mais rentáveis em cada país?
- Qual funcionário (suporte a clientes) está associado ao maior volume de vendas?


### 🎵 Catálogo de Músicas
- Quais são os artistas mais vendidos?
- Quais são os álbuns mais vendidos?
- Qual o preço médio por faixa em cada gênero?


### 📊 Indicadores Estratégicos
- Qual é o ticket médio por cliente?
- Quais são as tendências de crescimento de vendas?
- Qual é o gênero musical com maior potencial de receita?

---

## 🛠️ Etapa 1 – ETL e Modelagem em SQL
Criação de **views** para organizar os dados e facilitar análises.

### 🔹 1. Dimensão de Tempo
```sql
CREATE VIEW vw_time AS
SELECT 
    InvoiceId,
    DATE(InvoiceDate) AS InvoiceDate,
    STRFTIME('%Y', InvoiceDate) AS Year,
    STRFTIME('%m', InvoiceDate) AS Month,
    STRFTIME('%Y-%m', InvoiceDate) AS YearMonth
FROM Invoice;
```

### 🔹 2. Resumo de Vendas
```sql
CREATE VIEW vw_sales_summary AS
SELECT 
    i.InvoiceId,
    i.InvoiceDate,
    i.Total AS InvoiceTotal,
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.Country,
    c.City,
    e.FirstName || ' ' || e.LastName AS SupportRep
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId;
```

### 🔹 3. Detalhamento de Vendas por Faixa
```sql
CREATE VIEW vw_tracks_sales AS
SELECT 
    il.InvoiceLineId,
    il.InvoiceId,
    il.Quantity,
    il.UnitPrice,
    (il.Quantity * il.UnitPrice) AS LineTotal,
    t.TrackId,
    t.Name AS TrackName,
    g.Name AS Genre,
    a.Title AS Album,
    ar.Name AS Artist
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist ar ON a.ArtistId = ar.ArtistId
JOIN Genre g ON t.GenreId = g.GenreId;
```

### 🔹 4. Fato Consolidado (View Principal)
```sql
CREATE VIEW vw_fact_sales AS
SELECT 
    s.InvoiceId,
    s.InvoiceDate,
    s.InvoiceTotal,
    s.CustomerId,
    s.CustomerName,
    s.Country,
    s.City,
    s.SupportRep,
    ts.TrackId,
    ts.TrackName,
    ts.Genre,
    ts.Album,
    ts.Artist,
    ts.Quantity,
    ts.UnitPrice,
    ts.LineTotal
FROM vw_sales_summary s
JOIN vw_tracks_sales ts ON s.InvoiceId = ts.InvoiceId;
```

### 🔹 5. Receita Mensal
```sql
CREATE VIEW vw_monthly_sales AS
SELECT 
    STRFTIME('%Y-%m', InvoiceDate) AS YearMonth,
    SUM(InvoiceTotal) AS TotalSales,
    COUNT(DISTINCT CustomerId) AS CustomersCount,
    COUNT(InvoiceId) AS TotalInvoices
FROM Invoice
GROUP BY STRFTIME('%Y-%m', InvoiceDate)
ORDER BY YearMonth;
```

## 🛠️ Etapa 2 – Exploração e Consultas de Negócio

Aqui usamos as **views criadas** (`vw_sales_summary`, `vw_tracks_sales`, `vw_fact_sales`, `vw_monthly_sales`, `vw_time`) para responder as **❓ Perguntas de Negócio**, em diferentes níveis de complexidade.

## 🎯 Vendas e Receita

❓ Qual é a receita total da loja?  
```sql
SELECT SUM(InvoiceTotal) AS TotalRevenue
FROM vw_sales_summary;
```
📸 Resultado da consulta:

![Resultado](./Projeto_SQL_PowerBI_Loja_Musica_Digital/ResultadoConsulta/Resultado1.png)

📝 Interpretação:

Foi obtido uma receita de **2328,60** dolares, com as vendas de músicas digitais.

❓ Qual é a evolução das vendas por ano e mês?
```sql
SELECT YearMonth, SUM(InvoiceTotal) AS TotalVendido
FROM vw_time t
JOIN vw_sales_summary s ON t.InvoiceId = s.InvoiceId
GROUP BY YearMonth
ORDER BY YearMonth;
```
📸 Resultado da consulta:

📝 Interpretação:

Utilizando a view de dimensionamento de tempo podemos obter o ano/mês, a juntamente com a view do resumo de vendas podemos fazer o romatoria da receita de vendas e agrupar por ano e mês. 
Assim obtemos uma tabela ordenada por ano/mês, notando que a receita de venda segue um valor médio, com oscilações em alguns meses específicos, mas sempre com aumento da receita em tais meses.

❓ Quais são os gêneros musicais mais vendidos?
```sql
SELECT Genre, SUM(LineTotal) AS ReceitaFaixa
FROM vw_tracks_sales
GROUP BY Genre
ORDER BY ReceitaFaixa DESC;
```

📝 Interpretação:

Temos a soma das receita gerada por essa faixa específica (Quantidades x preço por unidade de faixa), assim agrupando por genero e ordenando dos generos mais vendidos para os menos vendidos. Temos que o gênero de **Rock** foi o mais vendido com **826,65**, seguido do estilo músical **Latino** com **382,14** e em terceito o gênero **Metal** com **261,26** de receita gerada.
O **Rock** é o estilo músical que mais se destaca nas vendas online de música na loja, obtendo uma receita cerca de **53,77%** maior que o segundo estilo mais vendido.


❓ Quem são os clientes que mais gastaram? (Top 10)
```sql
SELECT CustomerName, Country, SUM(InvoiceTotal) AS TotalGasto
FROM vw_sales_summary
GROUP BY CustomerId
ORDER BY TotalGasto DESC
LIMIT 10;
```
📝 Interpretação:

Os Clientes que mais gastaram na loja foram: Em primeiro **Helena Holý** com um total gasto de **49,62**, o segundo cliente que mais gastou foi **Richard Cunningham** com um total gasto de **47,62** e em terceiro **Luis Rojas** com um total gasto de **46,62**.
Podemos observar que os 10 clientes que masi gastaram na loja, gastaram valores dentre **40** e **50** doleres em compras.

## 👥 Clientes e Funcionários

❓ Qual país concentra mais clientes ativos?
```sql
SELECT Country, COUNT(DISTINCT CustomerId) AS TotalCustomers
FROM vw_sales_summary
GROUP BY Country
ORDER BY TotalCustomers DESC;
```

📝 Interpretação:
O país que concentra mais clientes ativo é os **Estados Unidos** com um total de **13** clientes ativos, seguido do **Canadá** com 8 clientes ativos e **França** e **Brasil** com 5 clientes ativos. Notamos que os clientes ativos do Estado Unidos correspondem a cerca de **22%** de todos os clientes ativos da loja (total de 59 clientes ativos). 

❓ Qual funcionário (suporte a clientes) está associado ao maior volume de vendas?
```sql
SELECT SupportRep, SUM(InvoiceTotal) AS TotalSales
FROM vw_sales_summary
GROUP BY SupportRep
ORDER BY TotalSales DESC;
```

📝 Interpretação:
O funcionário que está associado so maior volume de vendas é **Jane Peacock** com um valores associdado de **833,04**, seguido por **Margaret Park** com **775,40** e **Steve Johnson** com **720,16**. Notamos que os vendedores mantém um bom desempenho de vendas com valores bem próximo, isso mostra uma integração de vendas bem destribuida entre os funcionários da loja.

❓ Quem são os 3 clientes mais rentáveis em cada país?
```sql
WITH ranked_customers AS (
    SELECT 
        Country,
        CustomerName,
        SUM(InvoiceTotal) AS TotalSpent,
        RANK() OVER (PARTITION BY Country ORDER BY SUM(InvoiceTotal) DESC) AS RankPos
    FROM vw_sales_summary
    GROUP BY Country, CustomerId
)
SELECT * 
FROM ranked_customers
WHERE RankPos <= 3
ORDER BY Country, RankPos;
```

## 🎵 Catálogo de Músicas

❓ Quantidade de álbuns cadastrados por artista.
```sql
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS TotalAlbums
FROM Artist ar
JOIN Album al ON ar.ArtistId = al.ArtistId
GROUP BY ar.Name
ORDER BY TotalAlbums DESC;
```

❓ Quais são os artistas mais vendidos? (Top 5)
```sql
SELECT Artist, SUM(LineTotal) AS Revenue
FROM vw_tracks_sales
GROUP BY Artist
ORDER BY Revenue DESC
LIMIT 5;
```

❓ Quais são os álbuns mais vendidos?
```sql
SELECT Album, SUM(LineTotal) AS Revenue
FROM vw_tracks_sales
GROUP BY Album
ORDER BY Revenue DESC
LIMIT 5;
```

❓ Qual a faixa mais cara vendida em cada gênero musical?
```sql
WITH ranked_tracks AS (
    SELECT 
        Genre,
        TrackName,
        UnitPrice,
        RANK() OVER (PARTITION BY Genre ORDER BY UnitPrice DESC) AS RankPos
    FROM vw_tracks_sales
)
SELECT Genre, TrackName, UnitPrice
FROM ranked_tracks
WHERE RankPos = 1
ORDER BY Genre;
```

## 📊 Indicadores Estratégicos

❓ Qual é o ticket médio por cliente?
```sql
SELECT AVG(CustomerTotal) AS AvgTicket
FROM (
    SELECT CustomerId, SUM(InvoiceTotal) AS CustomerTotal
    FROM vw_sales_summary
    GROUP BY CustomerId
);
```

❓ Quais são as tendências de crescimento de vendas? (Receita acumulada)
```sql
WITH monthly_sales AS (
    SELECT 
        YearMonth,
        SUM(InvoiceTotal) AS Revenue
    FROM vw_time t
    JOIN vw_sales_summary s ON t.InvoiceId = s.InvoiceId
    GROUP BY YearMonth
)
SELECT 
    YearMonth,
    Revenue,
    SUM(Revenue) OVER (ORDER BY YearMonth) AS CumulativeRevenue
FROM monthly_sales;
```

❓ Qual é o gênero musical com maior potencial de receita?
```sql
SELECT Genre, SUM(LineTotal) AS Revenue
FROM vw_tracks_sales
GROUP BY Genre
ORDER BY Revenue DESC
LIMIT 1;
```
