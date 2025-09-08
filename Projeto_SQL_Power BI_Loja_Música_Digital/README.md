# 🎵 Projeto SQL & Power BI - Loja de Música Digital (Chinook Database)

## 📌 Contexto do Projeto
O **Chinook Database** simula uma loja de música digital, contendo informações sobre:
- Clientes
- Funcionários
- Artistas e Álbuns
- Faixas musicais
- Gêneros musicais
- Faturas e Itens de venda

O objetivo deste projeto é **analisar o desempenho de vendas, clientes e catálogo musical**, utilizando **SQL (SQLite)** para tratamento, exploração e modelagem dos dados, e **Power BI** para visualizações e storytelling.

---

## ⚙️ Estrutura do Banco de Dados
Principais tabelas do Chinook:
- `Customer` → clientes
- `Employee` → funcionários
- `Artist`, `Album`, `Track`, `Genre` → catálogo musical
- `Invoice`, `InvoiceLine` → vendas (faturas e itens de fatura)
- `Playlist`, `PlaylistTrack` → playlists

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
