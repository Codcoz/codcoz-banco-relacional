CREATE OR REPLACE FUNCTION func_conta_produto_validade(id_empresa INTEGER)
RETURNS INTEGER 
AS $$
DECLARE
	proximos_data_validade INTEGER;
BEGIN
		
		IF id_empresa NOT IN (SELECT id FROM EMPRESA)
		THEN
			RETURN NULL;
			
		ELSE
			SELECT 
				COUNT(*)::INTEGER INTO proximos_data_validade
			FROM produto p
			WHERE p.validade BETWEEN current_date AND current_date + INTERVAL '14 days'
			AND p.empresa_id = id_empresa;

			RETURN proximos_data_validade;
			
		END IF;
		
		EXCEPTION
			WHEN others THEN
				RAISE NOTICE 'Erro na contagem de produtos: %', SQLERRM;
				RETURN NULL;
		 
END;
$$
LANGUAGE plpgsql;