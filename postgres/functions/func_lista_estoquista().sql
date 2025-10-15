CREATE OR REPLACE FUNCTION func_lista_estoquista()
RETURNS TABLE (
	nome VARCHAR(100),
	sobrenome VARCHAR(100),
	empresa VARCHAR(100),
	funcao VARCHAR(100),
	status VARCHAR(100),
	email VARCHAR(100)
)
AS $$
BEGIN
	
	RETURN QUERY
		SELECT 
			fu.nome,
			fu.sobrenome,
			e.nome	as empresa,
			f.nome	as funcao,
			fu.status,
			fu.email
		FROM funcionario fu
		JOIN funcao f on f.id = fu.funcao_id
		JOIN empresa e on e.id = fu.empresa_id;
		
	EXCEPTION
	WHEN others THEN
		RAISE NOTICE 'Erro na listagem de funcionários: %', SQLERRM;
		RETURN;
	
END;
$$
LANGUAGE plpgsql;