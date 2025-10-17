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
		
		IF TG_OP = 'INSERT'
		THEN
			INSERT INTO movimentacao (
					produto_id, 
					tipo_movimentacao_id,
					data,
					new_quantidade
				) VALUES
				(NEW.id, 
				 (SELECT id FROM tipo_movimentacao WHERE tipo = 'BAIXA'),
				 current_timestamp,
				 new_quantidade
				);

		
		ELSE
			IF old_quantidade > new_quantidade
			THEN 
				INSERT INTO movimentacao (
					produto_id, 
					tipo_movimentacao_id,
					data,
					old_quantidade,
					new_quantidade,
					diferenca
				) VALUES
				(NEW.id, 
				 (SELECT id FROM tipo_movimentacao WHERE tipo = 'BAIXA'),
				 current_timestamp,
				 old_quantidade,
				 new_quantidade,
				 (old_quantidade - new_quantidade) * -1
				);

			ELSE
				INSERT INTO movimentacao (
					produto_id, 
					tipo_movimentacao_id,
					data,
					old_quantidade,
					new_quantidade,
					diferenca
				) VALUES
				(NEW.id, 
				 (SELECT id FROM tipo_movimentacao WHERE tipo = 'ENTRADA'),
				 current_timestamp,
				 old_quantidade,
				 new_quantidade,
				 (old_quantidade - new_quantidade) * -1
				);

			END IF;
		END IF;	
		
		RETURN NEW;
		
	END;
$$
LANGUAGE plpgsql;