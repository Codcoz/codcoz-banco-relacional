CREATE OR REPLACE PROCEDURE sp_atualiza_estoquista(
	idn INTEGER, 
	new_id_empresa INTEGER, 
	new_id_funcao INTEGER,
	new_nome VARCHAR(100),
	new_sobrenome VARCHAR(100),
	new_status VARCHAR(100),
	new_email VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
	
	IF idn IN (SELECT id FROM funcionario WHERE id = idn)
	THEN
		UPDATE funcionario
		SET 
			empresa_id = new_id_empresa,
			funcao_id  = new_id_funcao,
			nome       = new_nome,
			sobrenome  = new_sobrenome,
			status     = new_status,
			email      = new_email
		WHERE id = idn;
		
		RAISE NOTICE 'Funcionário % atualizado com sucesso!', idn;
	
	ELSE
		RAISE EXCEPTION 'Funcionário com id % não encontrado', idn;
	END IF;
	

	EXCEPTION
		WHEN foreign_key_violation THEN
			RAISE NOTICE 'Empresa % ou função % não existem.', new_id_empresa, new_id_funcao;
		WHEN others THEN
			RAISE NOTICE 'Erro ao atualizar funcionário %: %', idn, SQLERRM;

END;
$$;