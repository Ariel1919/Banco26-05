
-------------------Subconsultas


-- SUBCONSULTA NO FROM total de pagamentos por morador
SELECT nome, cpf, total_pago
FROM (
    SELECT morador.nome, morador.cpf, SUM(pagamento_condominio.valor) AS total_pago
    FROM morador
    JOIN pagamento_condominio ON morador.id_morador = pagamento_condominio.id_morador
    GROUP BY morador.nome, morador.cpf
) AS resumo_pagamentos;

-- SUBCONSULTA NO SELECT total de reservas por morador
SELECT nome,
       (SELECT COUNT(*)
        FROM reserva_area
        WHERE reserva_area.id_morador = morador.id_morador) AS total_reservas
FROM morador;

-- SUBCONSULTA COM EXISTS moradores que tem pagamento em atraso
SELECT nome
FROM morador
WHERE EXISTS (
    SELECT 1
    FROM pagamento_condominio
    WHERE pagamento_condominio.id_morador = morador.id_morador
      AND pagamento_condominio.status = 'Em Atraso'
);

-- SUBCONSULTA COM NOT EXISTS moradores que nao tem vaga de garagem
SELECT nome
FROM morador
WHERE NOT EXISTS (
    SELECT 1
    FROM vaga
    WHERE vaga.id_morador = morador.id_morador
);

-- SUBCONSULTA COM HAVING moradores que pagaram mais de 2000 reais no total
SELECT morador.nome, morador.cpf, SUM(pagamento_condominio.valor) AS total_pago
FROM morador
JOIN pagamento_condominio ON morador.id_morador = pagamento_condominio.id_morador
GROUP BY morador.nome, morador.cpf
HAVING SUM(pagamento_condominio.valor) > 2000;


