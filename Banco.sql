-- =========================================================
-- TRABALHO INTEGRADOR - BANCO DE DADOS
-- OFICINA MECÂNICA - EMETEC
-- =========================================================

DROP DATABASE IF EXISTS oficina_mecanica_DAVD;
CREATE DATABASE oficina_mecanica_DAVD;
USE oficina_mecanica_DAVD;

-- =========================================================
-- PARTE 1 - CRIAÇÃO DAS TABELAS
-- =========================================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(8) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(30),
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT chk_veiculo_ano
        CHECK (ano BETWEEN 1950 AND 2100)
);

CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    especialidade VARCHAR(80) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_servico_preco CHECK (preco >= 0)
);

CREATE TABLE ordens_servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_fechamento DATETIME NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Aberta',
    observacoes VARCHAR(255),
    CONSTRAINT fk_ordem_veiculo
        FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
    CONSTRAINT fk_ordem_mecanico
        FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico),
    CONSTRAINT chk_ordem_status
        CHECK (status IN (
            'Aberta',
            'Em andamento',
            'Concluída',
            'Cancelada'
        ))
);

CREATE TABLE itens_ordem (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_ordem
        FOREIGN KEY (id_ordem) REFERENCES ordens_servico(id_ordem),
    CONSTRAINT fk_item_servico
        FOREIGN KEY (id_servico) REFERENCES servicos(id_servico),
    CONSTRAINT chk_item_quantidade CHECK (quantidade > 0),
    CONSTRAINT chk_item_preco CHECK (preco_unitario >= 0)
);

CREATE TABLE historico_ordens (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    status_anterior VARCHAR(30),
    status_novo VARCHAR(30) NOT NULL,
    data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(255),
    CONSTRAINT fk_historico_ordem
        FOREIGN KEY (id_ordem) REFERENCES ordens_servico(id_ordem)
);

CREATE TABLE historico_precos (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_servico INT NOT NULL,
    preco_anterior DECIMAL(10,2) NOT NULL,
    preco_novo DECIMAL(10,2) NOT NULL,
    data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_historico_servico
        FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

-- =========================================================
-- PARTE 2 - INSERÇÃO DE DADOS
-- =========================================================

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

INSERT INTO mecanicos (nome, cpf, telefone, especialidade) VALUES
('Marcos Ferreira', '101.101.101-10', '(48) 99111-1111', 'Motor'),
('Bruno Almeida', '202.202.202-20', '(48) 99222-2222', 'Freios'),
('Diego Rodrigues', '303.303.303-30', '(48) 99333-3333', 'Suspensão'),
('Felipe Gomes', '404.404.404-40', '(48) 99444-4444', 'Elétrica'),
('André Barbosa', '505.505.505-50', '(48) 99555-5555', 'Injeção eletrônica');

INSERT INTO servicos (nome, descricao, preco) VALUES
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

-- CORREÇÃO DO SAFE UPDATE MODE:
-- O WHERE utiliza a chave primária id_ordem.

UPDATE ordens_servico
SET data_fechamento = CURRENT_TIMESTAMP
WHERE status = 'Concluída'
  AND id_ordem > 0;

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

-- =========================================================
-- PARTE 3 - CRUD
-- =========================================================

INSERT INTO clientes (nome, cpf, telefone, email)
VALUES ('Teste Um', '111.222.333-44',
        '(48) 90000-1111', 'teste1@email.com');

INSERT INTO clientes (nome, cpf, telefone, email)
VALUES ('Teste Dois', '222.333.444-55',
        '(48) 90000-2222', 'teste2@email.com');

SELECT * FROM clientes;
SELECT * FROM veiculos WHERE id_cliente = 1;

UPDATE clientes
SET telefone = '(48) 98888-1111'
WHERE cpf = '111.222.333-44'
  AND id_cliente > 0;

UPDATE clientes
SET email = 'teste2_novo@email.com'
WHERE cpf = '222.333.444-55'
  AND id_cliente > 0;

DELETE FROM clientes
WHERE cpf = '111.222.333-44'
  AND id_cliente > 0;

DELETE FROM clientes
WHERE cpf = '222.333.444-55'
  AND id_cliente > 0;

-- =========================================================
-- PARTE 4 - CONSULTAS E FILTROS
-- =========================================================

SELECT * FROM clientes ORDER BY nome;

SELECT * FROM veiculos
WHERE id_cliente = 1
ORDER BY modelo;

SELECT * FROM servicos
WHERE preco > 500
ORDER BY preco DESC;

SELECT * FROM servicos
WHERE preco BETWEEN 100 AND 500
ORDER BY preco;

SELECT * FROM clientes
WHERE nome LIKE 'A%' OR nome LIKE 'M%'
ORDER BY nome;

SELECT * FROM ordens_servico
WHERE status IN ('Aberta', 'Em andamento')
ORDER BY data_abertura;

SELECT * FROM servicos
ORDER BY preco DESC
LIMIT 5;

SELECT * FROM servicos
WHERE preco >= 100 AND preco <= 500
ORDER BY preco;

SELECT nome, especialidade
FROM mecanicos
WHERE ativo = TRUE
ORDER BY nome;

-- =========================================================
-- PARTE 5 - FUNÇÕES DE AGREGAÇÃO
-- =========================================================

SELECT COUNT(*) AS total_clientes FROM clientes;

SELECT COUNT(*) AS total_veiculos FROM veiculos;

SELECT nome, preco
FROM servicos
WHERE preco = (SELECT MAX(preco) FROM servicos);

SELECT nome, preco
FROM servicos
WHERE preco = (SELECT MIN(preco) FROM servicos);

SELECT AVG(preco) AS preco_medio FROM servicos;

SELECT SUM(preco) AS valor_total_servicos FROM servicos;

SELECT MAX(preco) AS maior_preco,
       MIN(preco) AS menor_preco
FROM servicos;

-- =========================================================
-- PARTE 6 - GROUP BY E HAVING
-- =========================================================

SELECT c.id_cliente, c.nome,
       COUNT(v.id_veiculo) AS quantidade_veiculos
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY quantidade_veiculos DESC;

SELECT m.id_mecanico, m.nome,
       COUNT(o.id_ordem) AS quantidade_ordens
FROM mecanicos m
LEFT JOIN ordens_servico o ON m.id_mecanico = o.id_mecanico
GROUP BY m.id_mecanico, m.nome
ORDER BY quantidade_ordens DESC;

SELECT m.id_mecanico, m.nome,
       COUNT(o.id_ordem) AS quantidade_ordens
FROM mecanicos m
INNER JOIN ordens_servico o ON m.id_mecanico = o.id_mecanico
GROUP BY m.id_mecanico, m.nome
HAVING COUNT(o.id_ordem) > 1;

-- =========================================================
-- PARTE 7 - JOINS
-- =========================================================

SELECT c.nome AS cliente, v.placa, v.marca, v.modelo
FROM clientes c
INNER JOIN veiculos v ON c.id_cliente = v.id_cliente;

SELECT o.id_ordem, c.nome AS cliente,
       v.modelo, v.placa, o.status
FROM ordens_servico o
INNER JOIN veiculos v ON o.id_veiculo = v.id_veiculo
INNER JOIN clientes c ON v.id_cliente = c.id_cliente;

SELECT o.id_ordem, m.nome AS mecanico, o.status
FROM ordens_servico o
INNER JOIN mecanicos m ON o.id_mecanico = m.id_mecanico;

SELECT o.id_ordem, s.nome AS servico, i.quantidade,
       i.preco_unitario,
       (i.quantidade * i.preco_unitario) AS subtotal
FROM ordens_servico o
INNER JOIN itens_ordem i ON o.id_ordem = i.id_ordem
INNER JOIN servicos s ON i.id_servico = s.id_servico;

SELECT c.nome AS cliente,
       v.modelo AS veiculo,
       v.placa,
       m.nome AS mecanico,
       s.nome AS servico,
       i.quantidade,
       i.preco_unitario AS valor_unitario,
       (i.quantidade * i.preco_unitario) AS subtotal,
       o.data_abertura,
       o.status
FROM ordens_servico o
INNER JOIN veiculos v ON o.id_veiculo = v.id_veiculo
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN mecanicos m ON o.id_mecanico = m.id_mecanico
INNER JOIN itens_ordem i ON o.id_ordem = i.id_ordem
INNER JOIN servicos s ON i.id_servico = s.id_servico
ORDER BY o.data_abertura DESC;

SELECT c.nome AS cliente, v.placa, v.modelo
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente
ORDER BY c.nome;

-- =========================================================
-- PARTE 8 - SUBQUERIES
-- =========================================================

SELECT nome, preco
FROM servicos
WHERE preco > (SELECT AVG(preco) FROM servicos);

SELECT nome
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM veiculos
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);

SELECT nome
FROM mecanicos
WHERE id_mecanico IN (
    SELECT id_mecanico
    FROM ordens_servico
    GROUP BY id_mecanico
    HAVING COUNT(*) > 1
);

-- =========================================================
-- PARTE 9 - STORED PROCEDURES
-- =========================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS cadastrar_cliente$$
CREATE PROCEDURE cadastrar_cliente(
    IN p_nome VARCHAR(100),
    IN p_cpf VARCHAR(14),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100)
)
BEGIN
    IF p_nome IS NULL OR TRIM(p_nome) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O nome do cliente é obrigatório';
    END IF;

    IF p_cpf IS NULL OR TRIM(p_cpf) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O CPF do cliente é obrigatório';
    END IF;

    INSERT INTO clientes (nome, cpf, telefone, email)
    VALUES (p_nome, p_cpf, p_telefone, p_email);
END$$

DROP PROCEDURE IF EXISTS abrir_ordem$$
CREATE PROCEDURE abrir_ordem(
    IN p_id_veiculo INT,
    IN p_id_mecanico INT,
    IN p_observacoes VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM veiculos
        WHERE id_veiculo = p_id_veiculo
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Veículo não encontrado';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM mecanicos
        WHERE id_mecanico = p_id_mecanico
          AND ativo = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mecânico não encontrado ou inativo';
    END IF;

    INSERT INTO ordens_servico
        (id_veiculo, id_mecanico, observacoes)
    VALUES
        (p_id_veiculo, p_id_mecanico, p_observacoes);
END$$

DROP PROCEDURE IF EXISTS alterar_status_ordem$$
CREATE PROCEDURE alterar_status_ordem(
    IN p_id_ordem INT,
    IN p_novo_status VARCHAR(30)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM ordens_servico
        WHERE id_ordem = p_id_ordem
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ordem não encontrada';

    ELSEIF p_novo_status IS NULL
        OR p_novo_status NOT IN (
            'Aberta',
            'Em andamento',
            'Concluída',
            'Cancelada'
        ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status inválido';

    ELSE
        UPDATE ordens_servico
        SET status = p_novo_status
        WHERE id_ordem = p_id_ordem;
    END IF;
END$$

DROP PROCEDURE IF EXISTS cadastrar_servico$$
CREATE PROCEDURE cadastrar_servico(
    IN p_nome VARCHAR(100),
    IN p_descricao VARCHAR(255),
    IN p_preco DECIMAL(10,2)
)
BEGIN
    IF p_preco IS NULL OR p_preco < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O preço não pode ser negativo ou nulo';
    END IF;

    INSERT INTO servicos (nome, descricao, preco)
    VALUES (p_nome, p_descricao, p_preco);
END$$

DELIMITER ;

-- =========================================================
-- PARTE 10 - TRIGGERS
-- =========================================================

DELIMITER $$

DROP TRIGGER IF EXISTS trg_historico_preco$$
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
END$$

DROP TRIGGER IF EXISTS trg_finalizar_ordem$$
CREATE TRIGGER trg_finalizar_ordem
BEFORE UPDATE ON ordens_servico
FOR EACH ROW
BEGIN
    IF NEW.status = 'Concluída'
       AND OLD.status <> 'Concluída' THEN
        SET NEW.data_fechamento = CURRENT_TIMESTAMP;
    END IF;

    IF NEW.status <> 'Concluída'
       AND OLD.status = 'Concluída' THEN
        SET NEW.data_fechamento = NULL;
    END IF;
END$$

-- TRIGGER CORRIGIDO: NEW.id_ordem SEM BARRA INVERTIDA

DROP TRIGGER IF EXISTS trg_historico_status$$
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
END$$

DELIMITER ;

-- =========================================================
-- PARTE 11 - TESTES DE INTEGRIDADE
-- Descomente um teste por vez para executá-lo.
-- =========================================================

-- Teste 1: CPF duplicado
-- INSERT INTO clientes (nome, cpf, telefone)
-- VALUES ('CPF Duplicado', '111.111.111-11', '(48) 90000-0000');

-- Teste 2: veículo com cliente inexistente
-- INSERT INTO veiculos (id_cliente, placa, marca, modelo, ano)
-- VALUES (9999, 'ZZZ9Z99', 'Fiat', 'Uno', 2020);

-- Teste 3: preço negativo
-- INSERT INTO servicos (nome, descricao, preco)
-- VALUES ('Serviço Inválido', 'Teste de preço', -100.00);

-- Teste 4: excluir cliente que possui veículo
-- DELETE FROM clientes WHERE id_cliente = 1;

-- Teste 5: ordem com veículo inexistente
-- INSERT INTO ordens_servico (id_veiculo, id_mecanico, observacoes)
-- VALUES (9999, 1, 'Teste de integridade');

-- Teste 6: quantidade zero
-- INSERT INTO itens_ordem
-- (id_ordem, id_servico, quantidade, preco_unitario)
-- VALUES (1, 1, 0, 150.00);

-- =========================================================
-- PARTE 12 - RELATÓRIO DE GASTOS POR CLIENTE
-- =========================================================

SELECT
    c.id_cliente,
    c.nome AS cliente,
    COUNT(DISTINCT o.id_ordem) AS quantidade_ordens,
    COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS total_gasto
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente
LEFT JOIN ordens_servico o
    ON v.id_veiculo = o.id_veiculo
   AND o.status = 'Concluída'
LEFT JOIN itens_ordem i ON o.id_ordem = i.id_ordem
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;

-- =========================================================
-- PARTE 13 - MECÂNICO COM MAIOR VALOR EM SERVIÇOS
-- =========================================================

SELECT
    m.nome AS mecanico,
    COUNT(DISTINCT o.id_ordem) AS quantidade_ordens,
    COUNT(i.id_item) AS quantidade_itens_servico,
    COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS valor_total
FROM mecanicos m
LEFT JOIN ordens_servico o ON m.id_mecanico = o.id_mecanico
LEFT JOIN itens_ordem i ON o.id_ordem = i.id_ordem
GROUP BY m.id_mecanico, m.nome
ORDER BY valor_total DESC
LIMIT 1;

-- =========================================================
-- PARTE 14 - TESTES FUNCIONAIS
-- =========================================================

SELECT * FROM clientes;
SELECT * FROM veiculos;

SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(*) AS total_veiculos FROM veiculos;

SELECT * FROM servicos WHERE preco > 500;

SELECT nome, preco
FROM servicos
ORDER BY preco DESC
LIMIT 5;

SELECT * FROM ordens_servico
WHERE status = 'Aberta';

SELECT * FROM historico_precos;
SELECT * FROM historico_ordens;

SELECT m.nome AS mecanico,
       COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS valor_total
FROM mecanicos m
LEFT JOIN ordens_servico o ON m.id_mecanico = o.id_mecanico
LEFT JOIN itens_ordem i ON o.id_ordem = i.id_ordem
GROUP BY m.id_mecanico, m.nome
ORDER BY valor_total DESC;

-- =========================================================
-- TESTES DAS PROCEDURES E TRIGGERS
-- Descomente e execute individualmente.
-- =========================================================

-- Cadastro de cliente:
-- CALL cadastrar_cliente(
--     'Cliente Procedure',
--     '987.654.321-00',
--     '(48) 97777-7777',
--     'procedure@email.com'
-- );

-- Teste do histórico de preços:
-- UPDATE servicos
-- SET preco = 155.00
-- WHERE id_servico = 1 AND id_servico > 0;
-- SELECT * FROM historico_precos;

-- Teste da alteração de status:
-- CALL alterar_status_ordem(2, 'Concluída');
-- SELECT * FROM historico_ordens WHERE id_ordem = 2;
-- SELECT id_ordem, status, data_fechamento
-- FROM ordens_servico WHERE id_ordem = 2;
