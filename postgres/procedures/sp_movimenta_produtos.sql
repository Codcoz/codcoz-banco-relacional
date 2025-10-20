CREATE OR REPLACE PROCEDURE sp_movimenta_produtos( 
	codigo_eann VARCHAR(200),
	quantidaden INTEGER
)
LANGUAGE plpgsql
AS $$

BEGIN
    
    UPDATE produto
	SET quantidade = quantidade + quantidaden
	WHERE codigo_ean = codigo_eann;
			
	RAISE NOTICE 'Produto atualizado!';
	
	EXCEPTION
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao atualizar produto: %', SQLERRM;
	
	
END;
$$;