----------------indices

-- busca de cpf na tabela moradores
SELECT cpf FROM morador;
CREATE INDEX idx_morador_cpf ON morador(cpf);

-- busca do status do pagamento na tabela condominio
SELECT status FROM pagamento_condominio;
CREATE INDEX idx_pagamento_status ON pagamento_condominio(status);

SELECT * FROM reserva_area;
CREATE INDEX idx_reserva_data_area ON reserva_area(data_reserva, area_comum);


------ sem indice compara1
DROP INDEX IF EXISTS idx_morador_cpf;

EXPLAIN ANALYZE
SELECT * FROM morador WHERE cpf = '123.456.789-00';

------com indice comparar1(teste QUE DEU CERTO ALELOIAA)
CREATE INDEX idx_morador_cpf ON morador(cpf);

EXPLAIN ANALYZE
SELECT * FROM morador WHERE cpf = '123.456.789-00';



-- Sem indice comparar2
DROP INDEX IF EXISTS idx_pagamento_status;

EXPLAIN ANALYZE
SELECT * FROM pagamento_condominio WHERE status = 'PAGO';

-- com indice comparar2
CREATE INDEX idx_pagamento_status ON pagamento_condominio(status);

EXPLAIN ANALYZE
SELECT * FROM pagamento_condominio WHERE status = 'PAGO';

-- com indice comparar3
DROP INDEX IF EXISTS idx_reserva_data_area;

EXPLAIN ANALYZE
SELECT * FROM reserva_area WHERE data_reserva = '2025-05-25' AND area_comum = 'Piscina';

-- com indice comparar3
CREATE INDEX idx_reserva_data_area ON reserva_area(data_reserva, area_comum);

EXPLAIN ANALYZE
SELECT * FROM reserva_area WHERE data_reserva = '2025-05-25' AND area_comum = 'Piscina';

