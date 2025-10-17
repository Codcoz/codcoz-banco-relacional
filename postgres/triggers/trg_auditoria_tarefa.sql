CREATE TRIGGER trg_auditoria_tarefa
	BEFORE INSERT OR UPDATE OR DELETE ON tarefa
	FOR EACH ROW
	EXECUTE FUNCTION func_auditoria_tarefa();