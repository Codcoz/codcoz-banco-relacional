CREATE TRIGGER trg_data_compra_pedido
	BEFORE INSERT ON pedido
	FOR EACH ROW 
	EXECUTE FUNCTION func_data_compra_pedido();