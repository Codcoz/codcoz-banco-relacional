CREATE OR REPLACE PROCEDURE sp_cria_estoquistas( 
	empresa_idn INTEGER, 
	funcao_idn INTEGER, 
	nomen VARCHAR(100),
	sobrenomen VARCHAR(100),
	statusn VARCHAR(200),
	emailn VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
	
	INSERT INTO funcionario (
		empresa_id, 
		funcao_id, 
		nome,
		sobrenome,
		status,
		email,
		data_contratacao
		) VALUES (
			empresa_idn, 
			funcao_idn, 
			nomen,
			sobrenomen,
			UPPER(statusn),
			emailn,
			current_date
		);
		
	RAISE NOTICE 'Novo funcionário cadastrado!';
	
	EXCEPTION
	WHEN unique_violation THEN
		RAISE NOTICE 'Já existe esse funcionário cadastrado.';
	WHEN foreign_key_violation THEN
		RAISE NOTICE 'Empresa ou função não existem (empresa_id=% / funcao_id=%).', empresa_idn, funcao_idn;
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao inserir funcionário: %', SQLERRM;
	
	
END;
$$;