CREATE OR REPLACE FUNCTION func_lista_tarefa_periodo(inicio DATE, fim DATE, emailn VARCHAR(250))
RETURNS TABLE (
	empresa VARCHAR(100),
	tipo_tarefa VARCHAR(100),
	ingrediente VARCHAR(100),
	relator TEXT,
	responsavel TEXT,
	pedido VARCHAR(100),
	situacao VARCHAR(100),
	quantidade_esperada INTEGER,
	contagem INTEGER,
	data_criacao DATE,
	data_limite DATE,
	data_conclusao DATE
)
AS $$
BEGIN
	
	RETURN QUERY
		SELECT 
			e.nome 								as empresa,
			tt.nome								as tipo_tarefa,
			i.nome								as ingrediente,
			rel.nome || ' ' || rel.sobrenome	as relator,
			res.nome || ' '	|| res.sobrenome    as responsavel,
			p.descricao							as pedido,
			t.situacao,
			t.quantidade_esperada,
			t.contagem,
			t.data_criacao,
			t.data_limite,
			t.data_conclusao
		FROM tarefa t
		LEFT JOIN empresa e ON e.id = t.empresa_id
		LEFT JOIN tipo_tarefa tt ON tt.id = t.tipo_tarefa_id
		LEFT JOIN ingrediente i ON i.id = t.ingrediente_id
		LEFT JOIN funcionario rel ON rel.id = t.relator_id
		LEFT JOIN funcionario res ON res.id = t.responsavel_id
		LEFT JOIN pedido p ON p.id = t.pedido_id
		WHERE t.data_limite BETWEEN inicio AND fim
		AND res.email = emailn
		ORDER BY t.data_limite ASC;
		
		EXCEPTION
			WHEN others THEN
				RAISE NOTICE 'Erro na listagem de tarefas: %', SQLERRM;
				RETURN;
		 
END;
$$
LANGUAGE plpgsql;