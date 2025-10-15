CREATE OR REPLACE FUNCTION func_data_criacao_tarefa()
RETURNS TRIGGER
AS
$$
	BEGIN
		NEW.data_criacao = current_timestamp;
		RETURN NEW;
	
	END;
$$
LANGUAGE plpgsql;