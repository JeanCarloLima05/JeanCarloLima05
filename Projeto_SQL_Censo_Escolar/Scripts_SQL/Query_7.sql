# 7 - Quantas escolas de cada nível de infraestrutura existem em uma determinada região e tipo de rede administrativa?

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
        
CALL contar_nivel_infra_por_rede_regiao('Nordeste', 1);
 -- Chama o procedure e passa os parâmetros (Região , Tipo)
