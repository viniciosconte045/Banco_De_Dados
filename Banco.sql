
CREATE DATABASE IF NOT EXISTS oficina_mecanica;

USE oficina_mecanica;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
);


CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(8) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,

    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);


CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    preco DECIMAL(10,2) NOT NULL
);


-- Tabela de ordens de serviço
CREATE TABLE ordens_servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'Aberta',

    CONSTRAINT fk_ordem_veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculos(id_veiculo),

    CONSTRAINT fk_ordem_mecanico
        FOREIGN KEY (id_mecanico)
        REFERENCES mecanicos(id_mecanico)
);


-- Tabela de serviços realizados
CREATE TABLE itens_ordem (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_item_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem),

    CONSTRAINT fk_item_servico
        FOREIGN KEY (id_servico)
        REFERENCES servicos(id_servico)
);


-- Tabela de histórico
CREATE TABLE historico_ordens (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    status_anterior VARCHAR(30),
    status_novo VARCHAR(30) NOT NULL,
    data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historico_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem)
);

INSERT INTO clientes
(nome, cpf, telefone, email)
VALUES
('João da Silva', '111.111.111-01', '(48) 99911-0001', 'joao@email.com'),
('Maria Santos', '222.222.222-02', '(48) 99922-0002', 'maria@email.com'),
('Pedro Oliveira', '333.333.333-03', '(48) 99933-0003', 'pedro@email.com'),
('Ana Souza', '444.444.444-04', '(48) 99944-0004', 'ana@email.com'),
('Carlos Pereira', '555.555.555-05', '(48) 99955-0005', 'carlos@email.com'),
('Juliana Costa', '666.666.666-06', '(48) 99966-0006', 'juliana@email.com'),
('Rafael Martins', '777.777.777-07', '(48) 99977-0007', 'rafael@email.com'),
('Fernanda Alves', '888.888.888-08', '(48) 99988-0008', 'fernanda@email.com'),
('Lucas Rocha', '999.999.999-09', '(48) 99999-0009', 'lucas@email.com'),
('Beatriz Lima', '123.456.789-10', '(48) 98888-0010', 'beatriz@email.com');


INSERT INTO veiculos
(id_cliente, placa, marca, modelo, ano, cor)
VALUES
(1, 'ABC1A23', 'Volkswagen', 'Gol', 2019, 'Prata'),
(1, 'DEF2B34', 'Honda', 'Civic', 2021, 'Preto'),
(2, 'GHI3C45', 'Toyota', 'Corolla', 2020, 'Branco'),
(3, 'JKL4D56', 'Chevrolet', 'Onix', 2022, 'Vermelho'),
(4, 'MNO5E67', 'Fiat', 'Argo', 2018, 'Cinza'),
(5, 'PQR6F78', 'Ford', 'Ka', 2017, 'Prata'),
(6, 'STU7G89', 'Hyundai', 'HB20', 2021, 'Azul'),
(7, 'VWX8H90', 'Renault', 'Kwid', 2022, 'Branco'),
(8, 'YZA9I01', 'Fiat', 'Toro', 2020, 'Preto'),
(9, 'BCD0J12', 'Jeep', 'Renegade', 2023, 'Cinza'),
(10, 'EFG1K23', 'Nissan', 'Kicks', 2021, 'Vermelho'),
(10, 'HIJ2L34', 'Volkswagen', 'T-Cross', 2022, 'Azul');



INSERT INTO mecanicos
(nome, cpf, telefone, especialidade)
VALUES
('Marcos Ribeiro', '101.101.101-01', '(48) 99111-1111', 'Motor'),
('Roberto Fernandes', '202.202.202-02', '(48) 99222-2222', 'Freios'),
('André Martins', '303.303.303-03', '(48) 99333-3333', 'Suspensão'),
('Diego Carvalho', '404.404.404-04', '(48) 99444-4444', 'Elétrica'),
('Gustavo Mendes', '505.505.505-05', '(48) 99555-5555', 'Injeção eletrônica');

INSERT INTO servicos
(nome, descricao, preco)
VALUES
('Troca de óleo', 'Troca do óleo do motor', 180.00),
('Troca de filtro de óleo', 'Substituição do filtro de óleo', 60.00),
('Alinhamento', 'Alinhamento das rodas', 120.00),
('Balanceamento', 'Balanceamento das rodas', 100.00),
('Troca de pastilhas', 'Troca das pastilhas de freio', 250.00),
('Revisão de freios', 'Verificação completa do sistema de freios', 150.00),
('Troca de bateria', 'Substituição da bateria', 450.00),
('Revisão do motor', 'Avaliação geral do motor', 500.00),
('Troca de suspensão', 'Substituição de componentes da suspensão', 700.00),
('Diagnóstico eletrônico', 'Diagnóstico utilizando scanner automotivo', 200.00);

INSERT INTO ordens_servico
(id_veiculo, id_mecanico, status, observacoes)
VALUES
(1, 1, 'Aberta', 'Cliente solicitou revisão geral'),
(2, 2, 'Em andamento', 'Verificar sistema de freios'),
(3, 3, 'Concluída', 'Manutenção preventiva'),
(4, 4, 'Aberta', 'Problema elétrico'),
(5, 5, 'Em andamento', 'Luz de injeção acesa'),
(6, 1, 'Concluída', 'Revisão do motor'),
(7, 2, 'Aberta', 'Ruído nos freios'),
(8, 3, 'Em andamento', 'Problema na suspensão'),
(9, 4, 'Concluída', 'Troca da bateria'),
(10, 5, 'Aberta', 'Diagnóstico eletrônico');

INSERT INTO itens_ordem
(id_ordem, id_servico, quantidade, preco_unitario)
VALUES
(1, 1, 1, 180.00),
(1, 2, 1, 60.00),

(2, 5, 1, 250.00),
(2, 6, 1, 150.00),

(3, 3, 1, 120.00),
(3, 4, 1, 100.00),

(4, 7, 1, 450.00),

(5, 10, 1, 200.00),
(5, 8, 1, 500.00),

(6, 8, 1, 500.00),

(7, 6, 1, 150.00),
(7, 5, 1, 250.00),

(8, 9, 1, 700.00),

(9, 7, 1, 450.00),

(10, 10, 1, 200.00);

INSERT INTO historico_ordens
(id_ordem, status_anterior, status_novo, observacao)
VALUES
(1, NULL, 'Aberta', 'Ordem criada'),
(2, 'Aberta', 'Em andamento', 'Serviço iniciado'),
(3, 'Em andamento', 'Concluída', 'Serviço finalizado'),
(4, NULL, 'Aberta', 'Ordem criada'),
(5, 'Aberta', 'Em andamento', 'Diagnóstico iniciado'),
(6, 'Em andamento', 'Concluída', 'Revisão finalizada'),
(7, NULL, 'Aberta', 'Ordem criada'),
(8, 'Aberta', 'Em andamento', 'Veículo encaminhado para manutenção'),
(9, 'Em andamento', 'Concluída', 'Bateria substituída'),
(10, NULL, 'Aberta', 'Ordem criada');

-- Exemplo 1
INSERT INTO clientes
(nome, cpf, telefone, email)
VALUES
('Cliente Teste 1', '321.321.321-11', '(48) 98888-1111', 'teste1@email.com');

-- Exemplo 2
INSERT INTO clientes
(nome, cpf, telefone, email)
VALUES
('Cliente Teste 2', '654.654.654-22', '(48) 98888-2222', 'teste2@email.com');

SELECT *
FROM clientes;

SELECT
    os.id_ordem,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    m.nome AS mecanico,
    os.status,
    os.data_abertura
FROM ordens_servico os
INNER JOIN veiculos v
    ON os.id_veiculo = v.id_veiculo
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN mecanicos m
    ON os.id_mecanico = m.id_mecanico;

UPDATE clientes
SET telefone = '(48) 98888-3333'
WHERE id_cliente = 11;

UPDATE ordens_servico
SET status = 'Concluída',
    data_fechamento = CURRENT_TIMESTAMP
WHERE id_ordem = 1;

DELETE FROM clientes
WHERE id_cliente = 11;

-- Exemplo 2
DELETE FROM clientes
WHERE id_cliente = 12;

SELECT
    c.nome AS cliente,
    v.marca,
    v.modelo,
    v.placa
FROM clientes c
INNER JOIN veiculos v
    ON c.id_cliente = v.id_cliente;


SELECT
    os.id_ordem,
    v.placa,
    s.nome AS servico,
    io.quantidade,
    io.preco_unitario
FROM itens_ordem io
INNER JOIN ordens_servico os
    ON io.id_ordem = os.id_ordem
INNER JOIN veiculos v
    ON os.id_veiculo = v.id_veiculo
INNER JOIN servicos s
    ON io.id_servico = s.id_servico;

SELECT
    os.id_ordem,
    SUM(io.quantidade * io.preco_unitario) AS valor_total
FROM ordens_servico os
INNER JOIN itens_ordem io
    ON os.id_ordem = io.id_ordem
GROUP BY os.id_ordem;

SELECT
    status,
    COUNT(*) AS quantidade
FROM ordens_servico
GROUP BY status;


