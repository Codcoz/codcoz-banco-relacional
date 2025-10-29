CREATE OR REPLACE FUNCTION func_calcula_ocupacao_estoque(id_empresa INTEGER)
RETURNS NUMERIC 
AS $$
DECLARE
	estoque_ocupado NUMERIC;
BEGIN
	IF id_empresa NOT IN (SELECT id FROM empresa)
		THEN
			RETURN NULL;
			
		ELSE
			SELECT 
        		COALESCE(SUM(p.quantidade)::NUMERIC / e.capacidade_estoque * 100, 0) INTO estoque_ocupado
			FROM produto p
			JOIN empresa e ON p.empresa_id = e.id
			WHERE e.id = id_empresa
			GROUP BY e.capacidade_estoque;
			
			RETURN estoque_ocupado;
			
		END IF;
		
		EXCEPTION
			WHEN others THEN
				RAISE NOTICE 'Erro no cálculo: %', SQLERRM;
				RETURN NULL;
		 
END;
$$
LANGUAGE plpgsql;