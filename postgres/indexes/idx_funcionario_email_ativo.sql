CREATE INDEX idx_funcionario_email_ativo
ON funcionario (email)
WHERE status = 'ATIVO';