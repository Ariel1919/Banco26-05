--------------------inserts
-- Condominio
INSERT INTO condominio (nome, endereco, telefone, email, quantidade_andares, apartamentos_por_andar) VALUES
('Condomínio Jardim das Flores', 'Rua das Acácias, 100', '1133334444', 'contato@jardimflores.com', 5, 4),
('Condomínio Vila Verde', 'Av. das Palmeiras, 200', '1144445555', 'vila.verde@email.com', 10, 6);

-- Apartamento / condominio
INSERT INTO apartamento (id_condominio, numero, andar, tipo, metragem) VALUES
(1, '101', 1, '2 quartos', 75.50),
(1, '102', 1, '3 quartos', 90.00),
(2, '201', 2, '1 quarto', 45.00),
(2, '202', 2, '2 quartos', 60.00);

-- Morador /apartamento
INSERT INTO morador (nome, cpf, telefone, email, data_nascimento, id_apartamento, data_entrada, data_saida) VALUES
('Ana Silva', '123.456.789-00', '11999998888', 'ana.silva@email.com', '1985-04-12', 1, '2022-01-01', NULL),
('Carlos Souza', '987.654.321-00', '11988887777', 'carlos.souza@email.com', '1990-07-20', 2, '2021-05-10', NULL),
('Maria Oliveira', '555.666.777-88', '11977776666', 'maria.oliveira@email.com', '1978-11-30', 3, '2023-02-15', NULL);

-- Pagamento Condominio / morador
INSERT INTO pagamento_condominio (id_morador, mes_referencia, valor, data_pagamento, taxa_limpeza, status) VALUES
(1, '2025-04', 350.00, '2025-04-05', 50.00, 'Pago'),
(2, '2025-04', 450.00, '2025-04-06', 60.00, 'Pago'),
(3, '2025-04', 300.00, '2025-04-07', 45.00, 'Pendente');

-- Funcionario
INSERT INTO funcionario (nome, cpf, telefone, email, cargo, salario, data_admissao) VALUES
('João Pereira', '222.333.444-55', '11999990000', 'joao.pereira@condominio.com', 'Zelador', 2500.00, '2020-03-15'),
('Sofia Costa', '333.444.555-66', '11988880000', 'sofia.costa@condominio.com', 'Recepcionista', 2000.00, '2021-08-20');


-- Servico Limpeza / funcionario e pagamento_condominio
INSERT INTO servico_limpeza (id_funcionario, id_pagamento, descricao, valor, data_servico) VALUES
(1, 1, 'Limpeza das áreas comuns do bloco 1', 150.00, '2025-04-02'),
(1, 2, 'Limpeza do hall e corredores', 120.00, '2025-04-03');

-- Reserva Area / morador
INSERT INTO reserva_area (id_morador, area_comum, data_reserva, hora_inicio, hora_fim, status) VALUES
(1, 'Churrasqueira', '2025-05-10', '18:00:00', '22:00:00', 'Confirmada'),
(2, 'Salão de festas', '2025-05-15', '14:00:00', '18:00:00', 'Pendente');

-- Vaga /morador
INSERT INTO vaga (numero, id_morador, descricao) VALUES
('V01', 1, 'Sedan branco'),
('V02', 2, 'SUV preto'),
('V03', NULL, 'Vaga livre');