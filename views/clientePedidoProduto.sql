CREATE DATABASE views;
USE views;

CREATE TABLE clientes (
idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nomeCliente VARCHAR(100),
cidade VARCHAR(50),
ativo BIT
);

CREATE TABLE pedidos(
idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idCliente INT,
valor DECIMAL(10,2),
dataPedido DATE,
status VARCHAR(20), -- "aberto", "fechado", "cancelado"
FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE produtos(
idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nomeProduto VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);

CREATE VIEW vwClienteAtivo AS
SELECT nomeCliente, cidade 
FROM clientes
WHERE ativo=1;

INSERT INTO clientes VALUES
(0,"Sabrina Sato", "São Paulo",1),
(0,"Cristiano Ronaldo","Taquarituba",1),
(0,"Anitta","Itai",0),
(0,"Pablo Vittar","Coronel Macedo",0);

SELECT * from vwClienteAtivo;

INSERT INTO pedidos VALUES
(0,1,5000,"2026-03-12","Fechado"),
(0,2,2300,"2026-03-13","Fechado"),
(0,3,6700,"2026-03-13","Fechado"),
(0,1,40,"2026-03-13","Aberto"),
(0,4,8200,"2026-03-13","Cancelado");

-- nome cliente, data pedido,valor pedido
CREATE VIEW vwClientesPedidos AS
SELECT nomeCliente,dataPedido,valor
FROM clientes c
INNER JOIN pedidos p
ON c.idCliente=p.idCliente;

SELECT * FROM vwClientesPedidos;

CREATE VIEW vwTotalGastoCliente AS
SELECT nomeCliente, COUNT(idPedido) AS "Total Pedido", SUM(valor) AS "Total Gasto"
FROM clientes c
INNER JOIN pedidos p
ON c.idCliente=p.idCliente
GROUP BY nomeCliente;

SELECT * FROM vwTotalGastoCliente;

INSERT INTO produtos VALUES
(0,"memória RAM",2400,6),
(0,"placa mãe",7000,10),
(0,"placa de vídeo",6700,9),
(0,"mouse",40,100);

CREATE VIEW vwEstoqueBaixo AS
SELECT nomeProduto,estoque
FROM produtos
WHERE estoque<10;

SELECT * FROM vwEstoqueBaixo;

-- Crie uma view que liste todos os pedidos cancelados com o nome do cliente e o valor.

CREATE VIEW vwPedidosCancelados AS
SELECT nomeCliente,valor,status
FROM clientes c
INNER JOIN pedidos p
ON c.idCliente=p.idCliente
WHERE status="Cancelado";

SELECT * FROM vwPedidosCancelados;

-- Crie uma view que mostre os produtos mais vendidos, com quantidade total vendida.

CREATE TABLE venda(
idVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idProduto INT NOT NULL,
IdPedido INT NOT NULL,
FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido),
qntdProduto INT
);

INSERT INTO venda VALUES
(0,1,1,2),
(0,1,2,1),
(0,3,3,1),
(0,4,4,1),
(0,1,5,1),
(0,3,5,1);

CREATE VIEW vwProdutoMaisVendido AS
SELECT nomeProduto, SUM(qntdProduto) AS "Quantidade Vendida"
FROM venda v
INNER JOIN produtos p
ON v.idProduto=p.idProduto
GROUP BY nomeProduto
ORDER BY "Quantidade Vendida" DESC;

-- LIMIT 2 - aparece apenas duas colunas

SELECT * FROM vwProdutoMaisVendido;