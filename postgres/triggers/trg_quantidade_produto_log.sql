CREATE TRIGGER trg_quantidade_produto_log
AFTER INSERT OR UPDATE OR DELETE ON produto
FOR EACH ROW
EXECUTE FUNCTION func_quantidade_produto_log();