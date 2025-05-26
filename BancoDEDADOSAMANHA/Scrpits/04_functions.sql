--------------------------------funcoes

CREATE OR REPLACE FUNCTION total_pago_por_morador(id_morador_param INT)------retorna o total que o morador pagou(funcao escalar)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE
    total_pago DECIMAL := 0;
BEGIN
    SELECT SUM(valor) INTO total_pago
    FROM pagamento_condominio
    WHERE id_morador = id_morador_param;
    
    RETURN COALESCE(total_pago, 0);
END;
$$;


CREATE OR REPLACE FUNCTION moradores_inadimplentes()
RETURNS TABLE (nome VARCHAR, apartamento VARCHAR, status VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT morador.nome, apartamento.numero, pagamento_condominio.status
    FROM morador
    JOIN apartamento ON morador.id_apartamento = apartamento.id_apartamento
    JOIN pagamento_condominio ON morador.id_morador = pagamento_condominio.id_morador
    WHERE pagamento_condominio.status = 'em atraso';
END;
$$;

CREATE OR REPLACE FUNCTION inserir_morador_unico(------se o cpf ja existe/mordador da erro mas se no ele cria(funcao com erro)
    nome_param VARCHAR,
    cpf_param VARCHAR,
    id_apartamento_param INT
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    ja_existe INT;
BEGIN
    SELECT COUNT(*) INTO ja_existe FROM morador WHERE cpf = cpf_param;
    
    IF ja_existe > 0 THEN
        RETURN 'Erro: CPF já cadastrado.';
    ELSE
        INSERT INTO morador (nome, cpf, id_apartamento, data_entrada)
        VALUES (nome_param, cpf_param, id_apartamento_param, CURRENT_DATE);
        
        RETURN 'Morador inserido com sucesso.';
    END IF;
END;
$$;