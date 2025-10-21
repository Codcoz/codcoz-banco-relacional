CREATE OR REPLACE PROCEDURE sp_cria_tarefa( 
	empresa_idn INTEGER, 
	tipo_tarefa_idn INTEGER, 
	ingrediente_idn INTEGER,
	relator_idn INTEGER,
	responsavel_idn INTEGER,
	pedido_idn INTEGER,
	situacaon VARCHAR(100),
	data_criacaon DATE,
	data_limiten DATE
)
LANGUAGE plpgsql
AS $$
BEGIN

	INSERT INTO tarefa(
		empresa_id,
		tipo_tarefa_id,
		ingrediente_id,
		relator_id,
		responsavel_id,
		pedido_id,
		situacao,
		quantidade_esperada,
		data_criacao,
		data_limite
	) VALUES (
		empresa_idn, 
		tipo_tarefa_idn, 
		ingrediente_idn,
		relator_idn,
		responsavel_idn,
		pedido_idn,
		situacaon,
		(SELECT COUNT(*) FROM produto p
		JOIN ingrediente i ON i.id = p.ingrediente_id
		WHERE p.ingrediente_id = ingrediente_idn),		
		data_criacaon,
		data_limiten
	);
	
	RAISE NOTICE 'Nova tarefa cadastrado!';
	
	EXCEPTION
	WHEN foreign_key_violation THEN
		RAISE NOTICE 'Empresa ou funcionario não existem (empresa_id=% / funcionario_id=%, %).', empresa_idn, relator_idn, responsavel_idn;
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao inserir tarefa: %', SQLERRM;
	
END;
$$;