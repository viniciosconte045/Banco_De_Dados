# Oficina Mecânica — Banco de Dados

## 1. Descrição do Projeto

O projeto consiste no desenvolvimento de um banco de dados para uma oficina mecânica, com o objetivo de organizar e gerenciar informações sobre clientes, veículos, mecânicos, serviços e ordens de serviço.

O sistema permite armazenar dados, realizar consultas, atualizar registros e acompanhar os serviços realizados nos veículos.

## 2. Objetivos

- Criar um banco de dados relacional utilizando MySQL.
- Organizar as informações da oficina em tabelas relacionadas.
- Aplicar chaves primárias e estrangeiras para garantir a integridade dos dados.
- Realizar operações CRUD: cadastro, consulta, atualização e exclusão.
- Desenvolver consultas utilizando filtros, funções de agregação, `GROUP BY`, `HAVING`, `JOIN` e subconsultas.
- Implementar procedimentos armazenados e gatilhos (*triggers*).
- Gerar relatórios sobre os gastos dos clientes e os valores dos serviços realizados pelos mecânicos.

## 3. Tecnologias Utilizadas

- **MySQL:** criação e gerenciamento do banco de dados.
- **MySQL Workbench:** ferramenta utilizada para executar os comandos SQL e visualizar os resultados.
- **SQL:** linguagem utilizada para criar tabelas, inserir dados, realizar consultas e implementar regras de negócio.

## 4. Estrutura do Banco de Dados

O banco de dados utilizado no projeto é `oficina_mecanica_DAVD`.

Ele possui as seguintes tabelas:

| Tabela | Descrição |
|---|---|
| `clientes` | Armazena os dados dos clientes. |
| `veiculos` | Registra os veículos vinculados aos clientes. |
| `mecanicos` | Armazena os dados e as especialidades dos mecânicos. |
| `servicos` | Registra os serviços disponíveis e seus preços. |
| `ordens_servico` | Armazena as ordens de serviço e seus status. |
| `itens_ordem` | Relaciona os serviços executados às ordens de serviço. |
| `historico_ordens` | Registra as alterações de status das ordens. |
| `historico_precos` | Registra as alterações nos preços dos serviços. |

## 5. Relacionamentos

O banco de dados utiliza chaves primárias e estrangeiras para relacionar as tabelas.

- Um cliente pode possuir vários veículos.
- Um veículo pode estar associado a várias ordens de serviço.
- Um mecânico pode ser responsável por várias ordens de serviço.
- Uma ordem de serviço pode possuir vários itens.
- Cada item de uma ordem está associado a um serviço.
- Uma ordem pode possuir vários registros de histórico de status.
- Um serviço pode possuir vários registros de histórico de preços.

Esses relacionamentos ajudam a manter os dados organizados e consistentes.

## 6. Funcionalidades Implementadas

### 6.1. Operações CRUD

O projeto utiliza as operações básicas de manipulação de dados:

- **CREATE:** inserção de novos registros.
- **READ:** consulta de informações.
- **UPDATE:** atualização de registros existentes.
- **DELETE:** exclusão de registros.

### 6.2. Consultas SQL

Foram desenvolvidas consultas utilizando:

- `WHERE`, `ORDER BY` e `LIMIT`.
- Operadores `LIKE`, `BETWEEN` e `IN`.
- Funções `COUNT`, `SUM`, `AVG`, `MAX` e `MIN`.
- Agrupamentos com `GROUP BY` e filtros com `HAVING`.
- Junções entre tabelas com `INNER JOIN` e `LEFT JOIN`.
- Subconsultas para pesquisas e comparações de valores.

### 6.3. Stored Procedures

Foram implementados procedimentos armazenados para facilitar operações e aplicar regras de validação:

- `cadastrar_cliente`: cadastra um cliente após verificar os campos obrigatórios.
- `abrir_ordem`: abre uma ordem de serviço após verificar a existência do veículo e a situação do mecânico.
- `alterar_status_ordem`: altera o status de uma ordem de serviço após validar os dados.
- `cadastrar_servico`: cadastra um serviço após verificar o preço informado.

### 6.4. Triggers

O projeto utiliza gatilhos para automatizar tarefas:

- `trg_historico_preco`: registra alterações nos preços dos serviços.
- `trg_finalizar_ordem`: atualiza a data de fechamento quando uma ordem é concluída e remove essa data quando ela deixa de estar concluída.
- `trg_historico_status`: registra as mudanças de status das ordens de serviço.

### 6.5. Relatórios

Foram criadas consultas para apresentar:

- A quantidade de veículos por cliente.
- A quantidade de ordens por mecânico.
- Os gastos dos clientes com ordens concluídas.
- O valor total dos serviços associados a cada mecânico.
- Os serviços com maiores e menores preços.

## 7. Integridade dos Dados

O banco utiliza restrições para evitar inconsistências:

- `PRIMARY KEY`: identifica cada registro de forma única.
- `FOREIGN KEY`: garante os relacionamentos entre tabelas.
- `UNIQUE`: impede a duplicação de valores em campos definidos como únicos.
- `NOT NULL`: exige o preenchimento de campos obrigatórios.
- `CHECK`: valida condições, como preços não negativos, quantidades positivas e anos de fabricação dentro do intervalo definido.

## 8. Como Executar o Projeto

1. Instale e abra o MySQL Workbench.
2. Conecte-se ao servidor MySQL.
3. Abra um novo editor SQL.
4. Copie o script SQL do projeto e cole no editor.
5. Execute o script para criar o banco, as tabelas, os registros de exemplo, as consultas, as procedures e os triggers.
6. Verifique os resultados das consultas na área de resultados do MySQL Workbench.

**Atenção:** o script começa removendo e recriando o banco `oficina_mecanica_DAVD`. Executá-lo novamente apagará os dados existentes nesse banco.

## 9. Conclusão

O desenvolvimento deste projeto permite aplicar na prática os principais conceitos de banco de dados relacionais utilizando MySQL. A implementação das tabelas, dos relacionamentos, das consultas, das procedures e dos triggers contribui para a organização das informações e para a automatização de tarefas comuns em uma oficina mecânica.

O projeto também demonstra a importância das restrições de integridade e da utilização de consultas SQL para extrair informações úteis para o gerenciamento do negócio.

## 10. Autor

Projeto desenvolvido como atividade acadêmica do curso técnico, com foco na modelagem, implementação e consulta de bancos de dados relacionais.
