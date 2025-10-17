CREATE OR REPLACE PROCEDURE sp_conclui_tarefa(idn INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN

	IF idn IN (SELECT id FROM tarefa WHERE id = idn)
	THEN
		UPDATE tarefa
		SET 
			situacao = 'CONCLUÍDA',
			data_conclusao = current_timestamp
		WHERE id = idn;

		RAISE NOTICE 'Tarefa % atualizado com sucesso!', idn;
	
	ELSE
		RAISE EXCEPTION 'Tarefa com id % não encontrado', idn;
	END IF;
	

	EXCEPTION
		WHEN others THEN
			RAISE NOTICE 'Erro ao atualizar tarefa %: %', idn, SQLERRM;
	
END;
$$;
