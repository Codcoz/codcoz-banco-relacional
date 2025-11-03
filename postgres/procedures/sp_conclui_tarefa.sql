CREATE OR REPLACE PROCEDURE sp_conclui_tarefa(idn INTEGER, contagemn INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
	produto_id INTEGER;
BEGIN

	IF idn IN (SELECT id FROM tarefa WHERE id = idn)
	THEN
		
		SELECT id INTO produto_id FROM produto p
		JOIN tarefa t ON p.ingrediente_id = t.ingrediente_id
		WHERE t.id = idn;
		
		UPDATE tarefa
		SET 
			situacao = 'CONCLUÍDA',
			data_conclusao = current_timestamp,
			contagem = contagemn
		WHERE id = idn;
		
		UPDATE produto 
		SET 
			quantidade = contagemn
		WHERE id = produto_id;

		RAISE NOTICE 'Tarefa % atualizado com sucesso!', idn;
	
	ELSE
		RAISE EXCEPTION 'Tarefa com id % não encontrado', idn;
	END IF;
	

	EXCEPTION
		WHEN others THEN
			RAISE NOTICE 'Erro ao atualizar tarefa %: %', idn, SQLERRM;
	
END;
$$;
