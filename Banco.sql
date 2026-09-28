
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



