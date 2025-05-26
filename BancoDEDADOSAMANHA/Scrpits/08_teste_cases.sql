-----------------------testesSORODAR(siga por etapas que eu enumerei, fiz ele meio chato com inserts ele tem rollback que e uma boa pratica, as mas oq e roll back, cara ele ajuda a simplismente não adicionar inserts a mais e dps e so executar ele dnv quando acabar que puff limpo)

-- 1. Testar a procedure que aplica multa para pagamentos em atraso
BEGIN;
CALL aplicar_multa_pagamentos_em_atraso();
SELECT id_pagamento, valor, status FROM pagamento_condominio WHERE status = 'em atraso';
ROLLBACK;

-- 2. Testar a procedure para listar moradores por nome
CALL listar_moradores('João', NULL);
CALL listar_moradores(NULL, '101');
CALL listar_moradores(NULL, NULL);

-- 3. Testar a procedure que atualiza status do pagamento para 'pago'
BEGIN;
CALL atualizar_status_pagamento();
SELECT id_pagamento, status, data_pagamento FROM pagamento_condominio WHERE data_pagamento IS NOT NULL;
ROLLBACK;

-- 4. Testar a função que retorna o total pago por um morador
SELECT total_pago_por_morador(1) AS total_pago;

-- 5. Testar função que lista moradores inadimplentes
SELECT * FROM moradores_inadimplentes();

-- 6. Testar função que insere morador apenas se CPF for único
BEGIN;
SELECT inserir_morador_unico('Ana Paula', '123.456.789-01', 1) AS resultado_insercao;--(vai dar erro se vc fizer duas vezes por conta do metodo do cpf repetido que no pode)
SELECT inserir_morador_unico('Carlos Souza', '123.456.789-00', 1) AS resultado_insercao;
ROLLBACK;

-- 7. Testar trigger que atualiza coluna ultima_alteracao ao atualizar pagamento_condominio
BEGIN;
UPDATE pagamento_condominio SET valor = valor + 10 WHERE id_pagamento = 1;
SELECT id_pagamento, ultima_alteracao FROM pagamento_condominio WHERE id_pagamento = 1;
ROLLBACK;

-- 8. Testar trigger que limpa vagas e reservas após deletar morador
BEGIN;
INSERT INTO vaga (numero, id_morador, descricao) VALUES ('Vaga 2', 1, 'Carro hatchback');

INSERT INTO reserva_area (id_morador, area_comum, data_reserva, hora_inicio, hora_fim, status)
VALUES (1, 'Churrasqueira', '2023-07-01', '12:00', '14:00', 'Pendente');

DELETE FROM morador WHERE id_morador = 1;
SELECT * FROM vaga WHERE id_morador = 1;
SELECT * FROM reserva_area WHERE id_morador = 1;
ROLLBACK;

-- 9. Teste do gatilh que bloqueia aprovação de reserva fora do horariozinho de festa
BEGIN;
INSERT INTO morador (nome, cpf, telefone, email, data_nascimento, id_apartamento, data_entrada)
VALUES ('Teste Reserva', '111.222.333-44', '9876-5432', 'teste@teste.com', '1990-01-01', 1, CURRENT_DATE);
INSERT INTO reserva_area (id_morador, area_comum, data_reserva, hora_inicio, hora_fim, status)
VALUES ((SELECT MAX(id_morador) FROM morador), 'Salão de Festas', CURRENT_DATE, '07:00', '09:00', 'Pendente');
UPDATE reserva_area SET status = 'Aprovada' WHERE id_reserva = (SELECT MAX(id_reserva) FROM reserva_area);
-- aqui gera errinho pra testar se ta pegando o gatilho
UPDATE reserva_area SET hora_inicio = '05:00', status = 'Aprovada' WHERE id_reserva = (SELECT MAX(id_reserva) FROM reserva_area);
ROLLBACK;
