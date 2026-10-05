CREATE DATABASE IF NOT EXISTS oficina_mecanica_DAVD;

USE oficina_mecanica_DAVD;


-- =========================================
-- TABELA DE CLIENTES
-- =========================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- =========================================
-- TABELA DE VEÍCULOS
-- =========================================

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(8) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(30),

    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);


-- =========================================
-- TABELA DE MECÂNICOS
-- =========================================

CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    especialidade VARCHAR(80) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);


-- =========================================
-- TABELA DE SERVIÇOS
-- =========================================

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL
);


-- =========================================
-- TABELA DE ORDENS DE SERVIÇO
-- =========================================

CREATE TABLE ordens_servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_fechamento DATETIME NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Aberta',
    observacoes VARCHAR(255),

    CONSTRAINT fk_ordem_veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculos(id_veiculo),

    CONSTRAINT fk_ordem_mecanico
        FOREIGN KEY (id_mecanico)
        REFERENCES mecanicos(id_mecanico)
);


-- =========================================
-- TABELA DE SERVIÇOS REALIZADOS
-- =========================================

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


-- =========================================
-- TABELA DE HISTÓRICO
-- =========================================

CREATE TABLE historico_ordens (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    status_anterior VARCHAR(30),
    status_novo VARCHAR(30) NOT NULL,
    data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(255),

    CONSTRAINT fk_historico_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordens_servico(id_ordem)
);

-- =========================================
-- PARTE 3 - CLIENTES
-- =========================================

INSERT INTO clientes (nome, cpf, telefone, email) VALUES
('João da Silva', '111.111.111-11', '(48) 99911-1111', 'joao@email.com'),
('Maria Oliveira', '222.222.222-22', '(48) 99922-2222', 'maria@email.com'),
('Carlos Souza', '333.333.333-33', '(48) 99933-3333', 'carlos@email.com'),
('Ana Costa', '444.444.444-44', '(48) 99944-4444', 'ana@email.com'),
('Pedro Santos', '555.555.555-55', '(48) 99955-5555', 'pedro@email.com'),
('Lucas Pereira', '666.666.666-66', '(48) 99966-6666', 'lucas@email.com'),
('Juliana Alves', '777.777.777-77', '(48) 99977-7777', 'juliana@email.com'),
('Rafael Martins', '888.888.888-88', '(48) 99988-8888', 'rafael@email.com'),
('Beatriz Lima', '999.999.999-99', '(48) 99999-9999', 'beatriz@email.com'),
('Gabriel Rocha', '123.456.789-00', '(48) 98888-0000', 'gabriel@email.com');

-- =========================================
-- PARTE 3 - VEÍCULOS
-- =========================================

INSERT INTO veiculos
(id_cliente, placa, marca, modelo, ano, cor) VALUES
(1, 'ABC1A23', 'Volkswagen', 'Gol', 2018, 'Prata'),
(1, 'DEF2B34', 'Chevrolet', 'Onix', 2021, 'Branco'),
(2, 'GHI3C45', 'Fiat', 'Argo', 2020, 'Vermelho'),
(2, 'JKL4D56', 'Toyota', 'Corolla', 2022, 'Preto'),
(3, 'MNO5E67', 'Honda', 'Civic', 2019, 'Cinza'),
(4, 'PQR6F78', 'Ford', 'Ka', 2017, 'Azul'),
(5, 'STU7G89', 'Hyundai', 'HB20', 2021, 'Branco'),
(6, 'VWX8H90', 'Renault', 'Sandero', 2019, 'Prata'),
(7, 'YZA9I01', 'Fiat', 'Uno', 2016, 'Preto'),
(8, 'BCD0J12', 'Volkswagen', 'T-Cross', 2023, 'Cinza'),
(9, 'EFG1K23', 'Jeep', 'Renegade', 2022, 'Branco'),
(10, 'HIJ2L34', 'Chevrolet', 'Tracker', 2023, 'Vermelho');

-- =========================================
-- PARTE 3 - MECÂNICOS
-- =========================================

INSERT INTO mecanicos
(nome, cpf, telefone, especialidade) VALUES
('Marcos Ferreira', '101.101.101-10', '(48) 99111-1111', 'Motor'),
('Bruno Almeida', '202.202.202-20', '(48) 99222-2222', 'Freios'),
('Diego Rodrigues', '303.303.303-30', '(48) 99333-3333', 'Suspensão'),
('Felipe Gomes', '404.404.404-40', '(48) 99444-4444', 'Elétrica'),
('André Barbosa', '505.505.505-50', '(48) 99555-5555', 'Injeção eletrônica');

-- =========================================
-- PARTE 3 - SERVIÇOS
-- =========================================

INSERT INTO servicos
(nome, descricao, preco) VALUES
('Troca de óleo', 'Troca de óleo do motor', 150.00),
('Alinhamento', 'Alinhamento das rodas', 120.00),
('Balanceamento', 'Balanceamento das rodas', 100.00),
('Troca de pastilhas', 'Troca das pastilhas de freio', 350.00),
('Revisão do motor', 'Revisão geral do motor', 750.00),
('Troca de bateria', 'Substituição da bateria', 600.00),
('Troca de suspensão', 'Substituição de componentes da suspensão', 900.00),
('Diagnóstico eletrônico', 'Diagnóstico com scanner', 200.00),
('Troca de correia dentada', 'Substituição da correia dentada', 650.00),
('Revisão completa', 'Revisão completa do veículo', 1200.00);

-- =========================================
-- PARTE 3 - ORDENS DE SERVIÇO
-- =========================================

INSERT INTO ordens_servico
(id_veiculo, id_mecanico, status, observacoes) VALUES
(1, 1, 'Concluída', 'Revisão do veículo'),
(2, 2, 'Em andamento', 'Problema nos freios'),
(3, 3, 'Aberta', 'Verificar suspensão'),
(4, 4, 'Concluída', 'Problema elétrico'),
(5, 5, 'Em andamento', 'Diagnóstico do motor'),
(6, 1, 'Aberta', 'Troca de óleo'),
(7, 2, 'Concluída', 'Troca de pastilhas'),
(8, 3, 'Em andamento', 'Problema na suspensão'),
(9, 4, 'Aberta', 'Diagnóstico eletrônico'),
(10, 5, 'Concluída', 'Revisão completa');
-- Preenche a data de fechamento das ordens concluídas
UPDATE ordens_servico
SET data_fechamento = CURRENT_TIMESTAMP
WHERE status = 'Concluída';

-- =========================================
-- PARTE 3 - ITENS DE SERVIÇO
-- =========================================

INSERT INTO itens_ordem
(id_ordem, id_servico, quantidade, preco_unitario) VALUES
(1, 5, 1, 750.00),
(1, 1, 1, 150.00),

(2, 4, 1, 350.00),
(2, 2, 1, 120.00),

(3, 7, 1, 900.00),

(4, 8, 1, 200.00),
(4, 6, 1, 600.00),

(5, 5, 1, 750.00),

(6, 1, 1, 150.00),

(7, 4, 1, 350.00),

(8, 7, 1, 900.00),
(8, 3, 2, 100.00),

(9, 8, 1, 200.00),

(10, 10, 1, 1200.00),
(10, 9, 1, 650.00);


-- =========================================
-- PARTE 4 - CREATE / INSERT
-- =========================================

INSERT INTO clientes
(nome, cpf, telefone, email)
VALUES
('Teste Um', '111.222.333-44', '(48) 90000-1111', 'teste1@email.com');

INSERT INTO clientes
(nome, cpf, telefone, email)
VALUES
('Teste Dois', '222.333.444-55', '(48) 90000-2222', 'teste2@email.com');

-- =========================================
-- PARTE 4 - READ / SELECT
-- =========================================

SELECT * FROM clientes;

SELECT * FROM veiculos
WHERE id_cliente = 1;


-- =========================================
-- PARTE 4 - UPDATE
-- =========================================

UPDATE clientes
SET telefone = '(48) 98888-1111'
WHERE nome = 'Teste Um';

UPDATE clientes
SET email = 'teste2_novo@email.com'
WHERE nome = 'Teste Dois';

-- =========================================
-- PARTE 4 - DELETE
-- =========================================

DELETE FROM clientes
WHERE nome = 'Teste Um';

DELETE FROM clientes
WHERE nome = 'Teste Dois';

-- =========================================
-- PARTE 5 - CONSULTAS E FILTROS
-- =========================================


-- 1. Clientes cadastrados
SELECT *
FROM clientes
ORDER BY nome;

-- 2. Veículos de um cliente
SELECT *
FROM veiculos
WHERE id_cliente = 1
ORDER BY modelo;

-- 3. Serviços acima de R$ 500
SELECT *
FROM servicos
WHERE preco > 500
ORDER BY preco DESC;

-- 4. Serviços entre R$ 100 e R$ 500
SELECT *
FROM servicos
WHERE preco BETWEEN 100 AND 500
ORDER BY preco;

-- 5. Clientes que começam com A ou M
SELECT *
FROM clientes
WHERE nome LIKE 'A%'
   OR nome LIKE 'M%'
ORDER BY nome;

-- 6. Ordens abertas ou em andamento
SELECT *
FROM ordens_servico
WHERE status IN ('Aberta', 'Em andamento')
ORDER BY data_abertura;

-- 7. Cinco serviços mais caros
SELECT *
FROM servicos
ORDER BY preco DESC
LIMIT 5;

-- 8. Exemplo utilizando AND
SELECT *
FROM servicos
WHERE preco >= 100
  AND preco <= 500
ORDER BY preco;


-- =========================================
-- PARTE 6 - FUNÇÕES DE AGREGAÇÃO
-- =========================================

-- =========================================
-- PARTE 6 - FUNÇÕES DE AGREGAÇÃO
-- =========================================

-- Quantidade de clientes
SELECT COUNT(*) AS total_clientes
FROM clientes;

-- Quantidade de veículos
SELECT COUNT(*) AS total_veiculos
FROM veiculos;

-- Serviço mais caro
SELECT MAX(preco) AS maior_preco
FROM servicos;

-- Serviço mais barato
SELECT MIN(preco) AS menor_preco
FROM servicos;

-- Preço médio dos serviços
SELECT AVG(preco) AS preco_medio
FROM servicos;

-- Valor total dos serviços cadastrados
SELECT SUM(preco) AS valor_total_servicos
FROM servicos;

-- =========================================
-- PARTE 7 - GROUP BY E HAVING
-- =========================================

-- Quantidade de veículos por cliente
SELECT id_cliente, COUNT(*) AS quantidade_veiculos
FROM veiculos
GROUP BY id_cliente;

-- Quantidade de ordens atendidas por mecânico
SELECT id_mecanico, COUNT(*) AS quantidade_ordens
FROM ordens_servico
GROUP BY id_mecanico;

-- Mecânicos que participaram de mais de uma ordem
SELECT id_mecanico, COUNT(*) AS quantidade_ordens
FROM ordens_servico
GROUP BY id_mecanico
HAVING COUNT(*) > 1;

-- =========================================
-- PARTE 8 - JOINS
-- =========================================

-- 1. Cliente + veículos
SELECT c.nome, v.placa, v.marca, v.modelo
FROM clientes c
INNER JOIN veiculos v
    ON c.id_cliente = v.id_cliente;

-- 2. Ordem + cliente + veículo
SELECT o.id_ordem, c.nome, v.modelo, v.placa, o.status
FROM ordens_servico o
INNER JOIN veiculos v
    ON o.id_veiculo = v.id_veiculo
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente;

-- 3. Ordem + mecânico
SELECT o.id_ordem, m.nome AS mecanico, o.status
FROM ordens_servico o
INNER JOIN mecanicos m
    ON o.id_mecanico = m.id_mecanico;

-- 4. Ordem + serviços realizados
SELECT o.id_ordem, s.nome AS servico, i.quantidade, i.preco_unitario
FROM ordens_servico o
INNER JOIN itens_ordem i
    ON o.id_ordem = i.id_ordem
INNER JOIN servicos s
    ON i.id_servico = s.id_servico;

-- 5. Consulta completa
SELECT
    c.nome AS cliente,
    v.modelo AS veiculo,
    v.placa,
    m.nome AS mecanico,
    s.nome AS servico,
    i.preco_unitario AS valor,
    o.data_abertura AS data,
    o.status
FROM ordens_servico o
INNER JOIN veiculos v
    ON o.id_veiculo = v.id_veiculo
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN mecanicos m
    ON o.id_mecanico = m.id_mecanico
INNER JOIN itens_ordem i
    ON o.id_ordem = i.id_ordem
INNER JOIN servicos s
    ON i.id_servico = s.id_servico;

-- 6. LEFT JOIN
SELECT c.nome AS cliente, v.placa, v.modelo
FROM clientes c
LEFT JOIN veiculos v
    ON c.id_cliente = v.id_cliente;
    
-- =========================================
-- PARTE 9 - SUBQUERIES
-- =========================================

-- 1. Serviços com preço acima da média geral
SELECT nome, preco
FROM servicos
WHERE preco > (
    SELECT AVG(preco)
    FROM servicos
);

-- 2. Clientes que possuem mais de um veículo
SELECT nome
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM veiculos
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);

-- 3. Mecânicos que possuem mais de uma ordem
SELECT nome
FROM mecanicos
WHERE id_mecanico IN (
    SELECT id_mecanico
    FROM ordens_servico
    GROUP BY id_mecanico
    HAVING COUNT(*) > 1
);

-- =========================================
-- PARTE 10 - STORED PROCEDURES
-- =========================================

DELIMITER $$

-- 1. Cadastrar cliente
CREATE PROCEDURE cadastrar_cliente(
    IN p_nome VARCHAR(100),
    IN p_cpf VARCHAR(14),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO clientes (nome, cpf, telefone, email)
    VALUES (p_nome, p_cpf, p_telefone, p_email);
END $$


-- 2. Abrir ordem de serviço
CREATE PROCEDURE abrir_ordem(
    IN p_id_veiculo INT,
    IN p_id_mecanico INT,
    IN p_observacoes VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM veiculos
        WHERE id_veiculo = p_id_veiculo
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Veículo não encontrado';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM mecanicos
        WHERE id_mecanico = p_id_mecanico
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mecânico não encontrado';
    END IF;

    INSERT INTO ordens_servico
        (id_veiculo, id_mecanico, observacoes)
    VALUES
        (p_id_veiculo, p_id_mecanico, p_observacoes);
END $$


-- 3. Alterar status da ordem
CREATE PROCEDURE alterar_status_ordem(
    IN p_id_ordem INT,
    IN p_novo_status VARCHAR(30)
)
BEGIN
    UPDATE ordens_servico
    SET status = p_novo_status
    WHERE id_ordem = p_id_ordem;
END $$


-- 4. Cadastrar serviço
CREATE PROCEDURE cadastrar_servico(
    IN p_nome VARCHAR(100),
    IN p_descricao VARCHAR(255),
    IN p_preco DECIMAL(10,2)
)
BEGIN
    INSERT INTO servicos (nome, descricao, preco)
    VALUES (p_nome, p_descricao, p_preco);
END $$

DELIMITER ;

-- =========================================
-- PARTE 11 - TRIGGERS
-- =========================================

-- Tabela para registrar alterações de preço
CREATE TABLE historico_precos (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_servico INT NOT NULL,
    preco_anterior DECIMAL(10,2) NOT NULL,
    preco_novo DECIMAL(10,2) NOT NULL,
    data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historico_servico
        FOREIGN KEY (id_servico)
        REFERENCES servicos(id_servico)
);

DELIMITER $$

-- =========================================
-- TRIGGER 1 - HISTÓRICO DE PREÇO
-- =========================================

CREATE TRIGGER trg_historico_preco
AFTER UPDATE ON servicos
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO historico_precos
            (id_servico, preco_anterior, preco_novo)
        VALUES
            (OLD.id_servico, OLD.preco, NEW.preco);
    END IF;
END $$


-- =========================================
-- TRIGGER 2 - DATA DE FINALIZAÇÃO
-- =========================================

CREATE TRIGGER trg_finalizar_ordem
BEFORE UPDATE ON ordens_servico
FOR EACH ROW
BEGIN
    IF NEW.status = 'Concluída'
       AND OLD.status <> 'Concluída' THEN
        SET NEW.data_fechamento = CURRENT_TIMESTAMP;
    END IF;
END $$


-- =========================================
-- TRIGGER 3 - HISTÓRICO DE STATUS
-- =========================================

CREATE TRIGGER trg_historico_status
AFTER UPDATE ON ordens_servico
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO historico_ordens
            (id_ordem, status_anterior, status_novo, observacao)
        VALUES
            (NEW.id_ordem, OLD.status, NEW.status,
             'Status alterado automaticamente pelo sistema');
    END IF;
END $$

DELIMITER ;