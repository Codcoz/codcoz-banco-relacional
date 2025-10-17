CREATE OR REPLACE FUNCTION func_conta_produto(id_empresa INTEGER)
RETURNS INTEGER
AS $$
DECLARE 
	produtos INTEGER;
BEGIN
		
		IF id_empresa NOT IN (SELECT id FROM EMPRESA)
		THEN
			RETURN NULL;
		
		ELSE
			SELECT 
				SUM(quantidade) INTO produtos
			FROM produto p
			WHERE p.empresa_id = id_empresa;

			RETURN produtos;
		
		END IF;
	
 		EXCEPTION
 			WHEN others THEN
 				RAISE NOTICE 'Erro na contagem de produtos: %', SQLERRM;
 				RETURN NULL;
		 
END;
$$
LANGUAGE plpgsql;