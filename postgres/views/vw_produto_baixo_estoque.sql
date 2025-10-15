CREATE OR REPLACE VIEW vw_produto_baixo_estoque
AS
	SELECT 
		e.nome 		as empresa,
		u.nome		as unidade_medida,
		p.nome		as produto,
		p.codigo_ean,
		p.quantidade,
		p.descricao,
		p.marca,
		p.validade
	FROM produto p
	LEFT JOIN empresa e ON e.id = p.empresa_id
	LEFT JOIN unidade_medida u ON u.id = p.unidade_medida_id
	LEFT JOIN ingrediente i ON i.id = p.ingrediente_id
	WHERE i.quantidade_minima >= p.quantidade
	ORDER BY p.quantidade ASC;