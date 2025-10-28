CREATE OR REPLACE PROCEDURE sp_cria_ingredientes(
    categoria_ingrediente_idn INTEGER[],
    nomes TEXT[],
    descricoes TEXT[],
    quantidades_minimas INTEGER[],
	empresa_id INTEGER[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..array_length(nomes, 1) LOOP
        IF NOT EXISTS (SELECT 1 FROM ingrediente WHERE nome = nomes[i]) THEN
            INSERT INTO ingrediente (
                categoria_ingrediente_id,
                nome,
                descricao,
                quantidade_minima,
				empresa_id
            ) VALUES (
                categoria_ingrediente_idn[i],
                nomes[i],
                descricoes[i],
                quantidades_minimas[i],
				empresa_id[i]
            );
        ELSE
            RAISE NOTICE 'Ingrediente % já existe. Ignorando inserção.', nomes[i];
        END IF;
    END LOOP;
	
	RAISE NOTICE 'Novo ingrediente cadastrado!';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Erro inesperado ao inserir ingredientes: %', SQLERRM;
END;
$$;