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
