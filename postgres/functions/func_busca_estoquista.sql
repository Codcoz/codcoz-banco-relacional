CREATE OR REPLACE FUNCTION func_busca_estoquista(idn INTEGER)
RETURNS TABLE (
	nome TEXT,
	empresa VARCHAR(100),
	funcao VARCHAR(100),
	status VARCHAR(100),
	email VARCHAR(100)
)
AS $$
BEGIN

	RETURN QUERY
		
		SELECT 
			fu.nome || ' ' || fu.sobrenome 	as nome,
			e.nome							as empresa,
			f.nome							as funcao,
			fu.status,
			fu.email
		FROM funcionario fu
		JOIN funcao f on f.id = fu.funcao_id
		JOIN empresa e on e.id = fu.empresa_id
		WHERE fu.id = idn;
		
	IF NOT FOUND THEN
		RAISE NOTICE 'Nenhum funcionário encontrado com id %', idn;
	END IF;

	EXCEPTION
		WHEN others THEN
			RAISE NOTICE 'Erro na busca do funcionário %: %', idn, SQLERRM;
			RETURN;
END;
$$
LANGUAGE plpgsql;