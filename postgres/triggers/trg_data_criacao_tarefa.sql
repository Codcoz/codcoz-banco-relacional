CREATE TRIGGER trg_data_criacao_tarefa
	BEFORE INSERT ON tarefa
	FOR EACH ROW
	EXECUTE FUNCTION func_data_criacao_tarefa();