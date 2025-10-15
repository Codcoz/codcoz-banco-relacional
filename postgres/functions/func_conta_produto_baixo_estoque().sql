CREATE OR REPLACE FUNCTION func_conta_produto_baixo_estoque(id_empresa INTEGER)
RETURNS INTEGER
AS $$
DECLARE
	produto_baixo_estoque INTEGER;
BEGIN
		IF id_empresa NOT IN (SELECT id FROM EMPRESA)
		THEN
			RETURN NULL;
		
		ELSE
			SELECT 
				COUNT(*)::INTEGER INTO produto_baixo_estoque
			FROM produto p
			LEFT JOIN ingrediente i ON i.id = p.ingrediente_id
			WHERE i.quantidade_minima >= p.quantidade
			AND p.empresa_id = id_empresa;

			RETURN produto_baixo_estoque;
		END IF;
		
		EXCEPTION
			WHEN others THEN
				RAISE NOTICE 'Erro na contagem de produtos: %', SQLERRM;
				RETURN NULL;
		 
END;
$$
LANGUAGE plpgsql;