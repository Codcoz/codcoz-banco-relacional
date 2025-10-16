CREATE OR REPLACE PROCEDURE sp_cria_produtos( 
	empresa_idn INTEGER, 
	unidade_medida_idn INTEGER, 
	nomen VARCHAR(100),
	codigo_eann VARCHAR(100),
	quantidaden INTEGER,
	descricaon VARCHAR(100),
	marcan VARCHAR(100),
	quantidade_miniman INTEGER,
	descricao_ingredienten VARCHAR(100),
	validaden DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    categoria_idn INTEGER;
	ingrediente_idn INTEGER;
BEGIN
    
    IF nomen ILIKE ANY (ARRAY['%Arroz%', '%Feijão%', '%Aveia%', '%Trigo%', '%Milho%', '%Cereal%']) THEN
        categoria_idn = 1;

    ELSIF nomen ILIKE ANY (ARRAY['%Carne%', '%Frango%', '%Peixe%', '%Porco%', '%Bovino%', '%Cordeiro%']) THEN
        categoria_idn = 2;

    ELSIF nomen ILIKE ANY (ARRAY['%Maçã%', '%Banana%', '%Laranja%', '%Uva%', '%Manga%', '%Fruta%']) THEN
        categoria_idn = 3;

    ELSIF nomen ILIKE ANY (ARRAY['%Batata%', '%Cenoura%', '%Alface%', '%Tomate%', '%Pepino%', '%Legume%']) THEN
        categoria_idn = 4;

    ELSIF nomen ILIKE ANY (ARRAY['%Leite%', '%Queijo%', '%Manteiga%', '%Iogurte%', '%Derivado%']) THEN
        categoria_idn = 5;

    ELSIF nomen ILIKE ANY (ARRAY['%Pão%', '%Bolo%', '%Biscoito%', '%Torta%', '%Confeitaria%']) THEN
        categoria_idn = 6;

    ELSIF nomen ILIKE ANY (ARRAY['%Açúcar%', '%Sal%', '%Óleo%', '%Azeite%', '%Tempero%', '%Condimento%']) THEN
        categoria_idn = 7;

    ELSIF nomen ILIKE ANY (ARRAY['%Refrigerante%', '%Suco%', '%Cerveja%', '%Vinho%', '%Água%', '%Bebida%']) THEN
        categoria_idn = 8;
		
	ELSE
        categoria_idn = 9;
    END IF;
	
	SELECT id INTO ingrediente_idn
    FROM ingrediente 
    WHERE nome ILIKE '%' || nomen || '%'
    LIMIT 1;
	
	IF ingrediente_idn IS NULL 
	THEN 
		INSERT INTO ingrediente (
			categoria_ingrediente_id,
			nome, 
			descricao,
			quantidade_minima
		) VALUES (
			categoria_idn,
			nomen,
			descricao_ingredienten,
			quantidade_miniman
		)
		RETURNING id INTO ingrediente_idn;
		
	END IF;
	
	INSERT INTO produto (
		empresa_id, 
		unidade_medida_id, 
		nome,
		codigo_ean,
		quantidade,
		descricao,
		marca,
		validade
		) VALUES (
			empresa_idn, 
			unidade_medida_idn, 
			nomen,
			codigo_eann,
			quantidaden,
			descricaon,
			marcan,
			validaden
		);
		
	RAISE NOTICE 'Novo produto cadastrado!';
	
	EXCEPTION
	WHEN foreign_key_violation THEN
		RAISE NOTICE 'Empresa não existe (empresa_id=%).', empresa_idn;
	WHEN others THEN
		RAISE NOTICE 'Erro inesperado ao inserir produto: %', SQLERRM;
	
	
END;
$$;