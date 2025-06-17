import pandas as pd

# Caminho do arquivo .txt original
arquivo_origem = r'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/microdados_ed_basica_2024.txt'

# Colunas que você quer extrair
colunas_desejadas = [
    'NO_REGIAO', 'NO_UF', 'NO_MUNICIPIO', 'NO_ENTIDADE', 'TP_DEPENDENCIA', 'TP_LOCALIZACAO',
    'IN_INTERNET', 'IN_ENERGIA_REDE_PUBLICA',
    'IN_AGUA_POTAVEL', 'IN_ESGOTO_REDE_PUBLICA', 'IN_BANHEIRO',
    'IN_QUADRA_ESPORTES', 'IN_REFEITORIO', 'IN_BIBLIOTECA',
    'QT_MAT_BAS', 'QT_DOC_BAS', 'QT_TUR_BAS'
]

# Carregar apenas as colunas desejadas
df = pd.read_csv(arquivo_origem, sep=';', encoding='latin1', usecols=colunas_desejadas)

# Salvar novo arquivo CSV filtrado
df.to_csv(
    r'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/escolas_2024_filtrado.csv',
    sep=';',
    index=False,
    encoding='utf-8'
)