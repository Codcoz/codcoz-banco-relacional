CREATE OR REPLACE FUNCTION func_auditoria_tarefa()
RETURNS TRIGGER
AS
$$
	BEGIN
		
		INSERT INTO auditoria_tarefa (
			tarefa_id,
			data_modificacao) VALUES
		(NEW.id,
		 current_timestamp);
			
		RETURN NEW;
	
	END;
$$
LANGUAGE plpgsql;