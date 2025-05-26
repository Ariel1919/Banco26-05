----------------------------procedures


CREATE OR REPLACE PROCEDURE aplicar_multa_pagamentos_em_atraso()
LANGUAGE plpgsql
AS $$
DECLARE
    registro_pagamento RECORD;
BEGIN
    FOR registro_pagamento IN
        SELECT id_pagamento, valor FROM pagamento_condominio WHERE status = 'em atraso'
    LOOP
        UPDATE pagamento_condominio
        SET valor = valor * 1.05
        WHERE id_pagamento = registro_pagamento.id_pagamento;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE listar_moradores(---multiplos parametros e com cursor
    refcursor_out OUT REFCURSOR,--ele percorre toda a tabelas dali de baixo ou seja cursor == percorrer tabelas
    nome_busca VARCHAR DEFAULT NULL,
    numero_apartamento VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN refcursor_out FOR
        SELECT morador.id_morador, morador.nome, morador.id_apartamento, morador.cpf
        FROM morador
        LEFT JOIN apartamento ON morador.id_apartamento = apartamento.id_apartamento
        WHERE
            (nome_busca IS NULL OR morador.nome ILIKE '%' || nome_busca || '%')
            AND (numero_apartamento IS NULL OR apartamento.numero = numero_apartamento);
END;
$$;




CREATE OR REPLACE PROCEDURE atualizar_status_pagamento()--rapaz sera que a logica ta certa? ta rodando dms tem algo de errado
LANGUAGE plpgsql--simples sem nada
AS $$
BEGIN
    UPDATE pagamento_condominio
    SET status = 'pago'
    WHERE data_pagamento IS NOT NULL AND status != 'pago';
END;
$$;
