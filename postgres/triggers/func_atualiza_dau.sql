CREATE OR REPLACE FUNCTION func_atualiza_dau()
RETURNS TRIGGER
AS
$$
DECLARE
    ja_existe BOOLEAN;
	BEGIN
	
		SELECT EXISTS (
			SELECT 1 FROM acesso
			WHERE funcionario_id = NEW.funcionario_id
			  AND DATE(data) = CURRENT_DATE
			  AND id <> NEW.id
		) INTO ja_existe;
		
		IF NOT ja_existe THEN
			INSERT INTO daily_active_users (
				total_usuarios,
				data
			)
			VALUES (1, current_timestamp)
			ON CONFLICT (data)
			DO UPDATE 
				SET total_usuarios = daily_active_users.total_usuarios + 1;
		END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;