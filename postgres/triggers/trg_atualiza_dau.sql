CREATE TRIGGER trg_atualiza_dau
AFTER INSERT ON acesso
FOR EACH ROW
EXECUTE FUNCTION func_atualiza_dau();