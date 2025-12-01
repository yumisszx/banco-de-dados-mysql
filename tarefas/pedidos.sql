CREATE DATABASE tarefaPedido;
USE tarefaPedido;

--TABELA CLIENTE
CREATE TABLE cliente (
  idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nomeCliente VARCHAR(55) NOT NULL,
  email VARCHAR(100) NOT NULL,
  cidade VARCHAR(50) NOT NULL
);

--DADOS TABELA CLIENTE
INSERT INTO cliente VALUES
(0, 'Heloisa Silva', 'heloisasilva@gmail.com','Curitiba'),
(0, 'Arthur Rodrigues', 'arthrodrigues@gmail.com', 'Avaré'),
(0, 'Olivia Nunes', 'olivianunes@gmail.com', 'Rio de Janeiro'),
(0, 'Joaquim Lima', 'joaqlima@gmail.com', 'Fartura'),
(0, 'Jenifer Silva', 'jenisilva@gmail.com', 'São Paulo'),
(0, 'Esther Martins', 'esthmartins@gmail.com', 'Rio de Janeiro');

SELECT * FROM cliente;

--TABELA PEDIDO
CREATE TABLE pedido(
  idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  idCliente INT NOT NULL,
  FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
  dataPedido TIMESTAMP DEFAULT current_timestamp,
  valorTotal DECIMAL(10,2) NOT NULL,
  statusPedido ENUM ('Concluído', 'Pedente', 'Cancelado') DEFAULT 'Pendente'
);

--DADOS TABELA PEDIDOS
INSERT INTO pedido VALUES
(0, 1, '2022-09-14', 257.99, 'Concluído'),
(0, 2, '2023-06-28', 1499.90, 'Concluído'),
(0, 3, '2024-02-06', 586.50, 'Cancelado'),
(0, 4, '2024-05-01', 199.90, 'Pendente'),
(0, 5, '2025-01-01', 476.90, 'Concluído'),
(0, 6, '2025-03-07', 967.25, 'Concluído'),
(0, 3, '2025-06-12', 2788.80, 'Cancelado'),
(0, 5, '2025-08-25', 49.99, 'Pendente');

SELECT * FROM pedido;

--NOME DO CLIENTE E DATA DO PEDIDO
SELECT nomeCliente, dataPedido
FROM cliente c
INNER JOIN pedido p
ON c.idCliente=p.idCliente;

--CLIENTE INICIAL J
SELECT * FROM cliente WHERE nomeCliente LIKE 'J%';

--PEDIDDOS STATUS CONCLUÍDO OU CANCELADO
SELECT * FROM pedido WHERE statusPedido IN('Concluído', 'Cancelado');

--NOME DO CLIENTE E VALOR DE PEDIDOS MAIROES QUE 500 COM STATUS CONCLUÍDO OU CLIENTE MORE EM SÃO PAULO
SELECT nomeCliente, valorPedido
FROM cliente c
INNER JOIN pedido p
ON c.idCliente=p.idCliente
WHERE valorTotal>500
AND statusPedido='Concluído'
OR cidade='São Paulo';

--DATA E VALOR DO PEDIDO DO CLIENTE COM ID 3 EM ORDEM DECRESCENTE
SELECT dataPedido, valorTotal
FROM cliente c
INNER JOIN pedido p
ON c.idCliente=p.idCliente
WHERE idCliente=3
ORDER BY valorTotal DESC;

--ID PEDIDO E VALOR DE PEDIDOS ONDE CLIENTE MORE NO RIO DE JANEIRO
SELECT idPedido, valorTotal
FROM pedido p
INNER JOIN cliente c
ON p.idCliente=c.idCliente
WHERE cidade='Rio de Janeiro';

--NOME DOS CLIENTES EM ORDEM ALFABÉTICA
SELECT * FROM cliente ORDER BY nomeCliente ASC;

--NOME DO CLIENTE E DATA DOS PEDIDOS A PARTIR DE 01/01/2023
SELECT nomeCliente, dataPedido
FROM cliente c
INNER JOIN pedido p
ON c.idCliente=p.idCliente
WHERE dataPedido>'2023-01-01';

--ID PEDIDO E VALOR DO PEDIDO ONDE CLIENTE POSSUA SILVA NO NOME
SELECT idPedido, valorTotal
FROM pedido p
INNER JOIN cliente c
ON p.idPedido=c.idCliente
WHERE nomeCliente LIKE '%Silva';

--NOME DO CLIENTE E VALOR DO PEDIDO ONDE STATUS É PENDENTE E VALOR É MAIOR QUE 100
SELECT nomeCliente, valorTotal
FROM cliente c
INNER JOIN pedido p
ON c.idCliente=p.idCliente
WHERE statusPedido='Pendente'
AND valorTotal>100;
