CONDOMINIO GERENCIAR
----------------------------TABELASSS


CREATE TABLE condominio (
    id_condominio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(100),
    quantidade_andares INT NOT NULL,
    apartamentos_por_andar INT NOT NULL
);


CREATE TABLE apartamento (
    id_apartamento SERIAL PRIMARY KEY,
    id_condominio INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    andar INT NOT NULL,
    tipo VARCHAR(50),
    metragem DECIMAL(6,2),
    FOREIGN KEY (id_condominio) REFERENCES condominio(id_condominio)-- diz que a forigen key vai referenciar pra id condominio a coluna daqui
);


CREATE TABLE morador (
    id_morador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_nascimento DATE,
    id_apartamento INT NOT NULL,
    data_entrada DATE,
    data_saida DATE,
    FOREIGN KEY (id_apartamento) REFERENCES apartamento(id_apartamento)
);


CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    data_admissao DATE
);

CREATE TABLE servico_limpeza (
    id_servico SERIAL PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_pagamento INT NOT NULL,
    descricao VARCHAR(255),
    valor DECIMAL(10,2),
    data_servico DATE,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento_condominio(id_pagamento)
);


CREATE TABLE pagamento_condominio (
    id_pagamento SERIAL PRIMARY KEY,
    id_morador INT NOT NULL,
    mes_referencia CHAR(7) NOT NULL, 
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE,
    taxa_limpeza DECIMAL(10,2),   
    status VARCHAR(20),
    FOREIGN KEY (id_morador) REFERENCES morador(id_morador)
);

CREATE TABLE reserva_area (
    id_reserva SERIAL PRIMARY KEY,
    id_morador INT NOT NULL,
    area_comum VARCHAR(50) NOT NULL,
    data_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (id_morador) REFERENCES morador(id_morador)
);

CREATE TABLE vaga (
    id_vaga SERIAL PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    id_morador INT, 
    descricao VARCHAR(255),--aqui vai dizer o tipo de carro do morador e afim
    FOREIGN KEY (id_morador) REFERENCES morador(id_morador)
);

