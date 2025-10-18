CREATE OR REPLACE PROCEDURE sp_inclui_acesso(
	funcionario_idn INTEGER
)
LANGUAGE plpgsql
AS $$

BEGIN
	
	INSERT INTO acesso(
		funcionario_id,
		data
	) VALUES (
		funcionario_idn,
		current_timestamp
	);
	
	RAISE NOTICE 'Novo acesso cadastrado!';
	
	EXCEPTION
	WHEN foreign_key_violation THEN
		RAISE NOTICE 'Funcionário não existe (funcionario_id=%).', funcionario_idn;
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao inserir acesso: %', SQLERRM;

END;
$$;