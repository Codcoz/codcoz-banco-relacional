CREATE OR REPLACE FUNCTION func_quantidade_produto_log() 
RETURNS TRIGGER
AS 
$$
DECLARE 
	old_quantidade INT;
	new_quantidade INT;
	BEGIN
		old_quantidade := OLD.quantidade;
    	new_quantidade := NEW.quantidade;
	
		IF old_quantidade > new_quantidade
		THEN 
			INSERT INTO movimentacao (
				produto_id, 
				tipo_movimentacao_id,
				data) VALUES
			(NEW.id, 
			 (SELECT id FROM tipo_movimentacao WHERE tipo = 'BAIXA'),
			 current_timestamp);
			 
		ELSE
			INSERT INTO movimentacao (
				produto_id, 
				tipo_movimentacao_id,
				data) VALUES
			(NEW.id, 
			 (SELECT id FROM tipo_movimentacao WHERE tipo = 'ENTRADA'),
			 current_timestamp);
			
		END IF;
		
		RETURN NEW;
		
	END;
$$
LANGUAGE plpgsql;