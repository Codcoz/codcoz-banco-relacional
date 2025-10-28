CREATE OR REPLACE PROCEDURE sp_cria_produtos( 
	empresa_idn INTEGER, 
	nome_ingrediente VARCHAR(100),
	unidade_medida_idn INTEGER, 
	nomen VARCHAR(100),
	codigo_eann VARCHAR(100),
	quantidaden INTEGER,
	descricaon VARCHAR(100),
	marcan VARCHAR(100),
	validaden DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
	ingrediente_idn INTEGER;
BEGIN

	SELECT id FROM ingrediente INTO ingrediente_idn
	WHERE nome = nome_ingrediente[i];

	INSERT INTO produto (
		empresa_id, 
		unidade_medida_id,
		ingrediente_id,
		nome,
		codigo_ean,
		quantidade,
		descricao,
		marca,
		validade
		) VALUES (
			empresa_idn, 
			unidade_medida_idn, 
			ingrediente_idn,
			nomen,
			codigo_eann,
			quantidaden,
			descricaon,
			marcan,
			validaden
		);
	
		
	RAISE NOTICE 'Novo produto cadastrado!';
	
	EXCEPTION
	WHEN foreign_key_violation THEN
		RAISE NOTICE 'Empresa não existe (empresa_id=%).', empresa_idn;
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao inserir produto: %', SQLERRM;
	
	
END;
$$;