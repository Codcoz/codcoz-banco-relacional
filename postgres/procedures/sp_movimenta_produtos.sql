CREATE OR REPLACE PROCEDURE sp_movimenta_produtos( 
	produto_idn INTEGER,
	quantidaden INTEGER
)
LANGUAGE plpgsql
AS $$

BEGIN
    
    UPDATE produto
	SET quantidade = quantidade + quantidaden
	WHERE id = produto_idn;
			
	RAISE NOTICE 'Produto atualizado!';
	
	EXCEPTION
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao atualizar produto: %', SQLERRM;
	
	
END;
$$;