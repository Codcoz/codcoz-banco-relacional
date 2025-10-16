CREATE OR REPLACE FUNCTION func_data_compra_pedido() 
RETURNS TRIGGER 
AS
$$
	BEGIN
		NEW.data_compra = current_timestamp;
		RETURN NEW;
	
	END;
$$
LANGUAGE plpgsql;