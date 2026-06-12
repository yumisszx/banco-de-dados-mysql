CREATE DATABASE triggers;
USE triggers;

-- tabelas principais
CREATE TABLE categoria(
	idCategoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    categoria VARCHAR(120)
);

INSERT INTO categoria VALUES
(0, "ELETRÔNICO"),
(0, "CASA E COZINHA"),
(0, "MODA E VESTUÁRIO"),
(0, "SAÚDE E BELEZA"),
(0, "ALIMENTOS");

CREATE TABLE produto(
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria),
    descricao VARCHAR(60),
    preco DECIMAL(8,2),
    estoque INT
);

INSERT INTO produto VALUES
(0, 1, "SMARTPHONE", 2799.99, 50),
(0, 1, "NOTEBOOK", 3592.80, 10),
(0, 2, "CAFETEIRA", 66.70, 22),
(0, 2, "LIQUIDIFICADOR", 99.90, 6),
(0, 3, "CAMISETA", 36.99, 100),
(0, 3, "TÊNIS", 387.78, 15),
(0, 4, "SHAMPOO", 22.45, 150),
(0, 4, "PROTETOR SOLAR", 40.50, 64),
(0, 5, "ARROZ", 25.99, 300),
(0, 5, "CHOCOLATE", 11.88, 87);

UPDATE produto SET preco = 4392.60 WHERE idProduto = 2;

CREATE TABLE itemVenda (
	idItemVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
    quantidade INT
);

INSERT INTO itemVenda VALUES
(0, 1, 1),
(0, 3, 2),
(0, 5, 5),
(0, 8, 1),
(0, 10, 7);

-- tabelas triggers
CREATE TABLE auditoria_produto_preco(
	idAudProdPreco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
    precoAntigo DECIMAL(8,2),
    precoNovo DECIMAL(8,2),
    dataAlteracao DATETIME
);

CREATE TABLE auditoria_novo_produto(
	idAudNovoProd INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(100),
    dataInclusao DATETIME
);

CREATE TABLE auditoria_saida_estoque(
	idAudSaidaEstoque INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensagemProduto VARCHAR(250),
    mensagemQntd VARCHAR(100),
    dataSaida DATETIME
);

DELIMITER $$
-- alteração preço produto
CREATE TRIGGER trg_auditoria_produto_preco
AFTER UPDATE
ON produto
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_produto_preco(
		idProduto,
        precoAntigo,
        precoNovo,
        dataAlteracao
	)
    VALUES(
		NEW.idProduto,
        OLD.preco,
        NEW.preco,
        NOW()
    );
END;

-- novo produto
CREATE TRIGGER trg_auditoria_novo_produto
AFTER INSERT 
ON produto
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_novo_produto(
		mensagem,
        dataInclusao
    )
	VALUES(
		CONCAT('Produto adicionado: ', NEW.descricao),
        NOW()
    );
END;

-- saida de estoque
CREATE TRIGGER trg_auditoria_saida_estoque
AFTER INSERT
ON itemVenda
FOR EACH ROW
BEGIN
	-- atualiza
	UPDATE produto
    SET estoque = estoque - NEW.quantidade
    WHERE idProduto = NEW.idProduto;

	-- mensagem
	INSERT INTO auditoria_saida_estoque(
		mensagemProduto,
        mensagemQntd,
        dataSaida
    )
    VALUES(
		CONCAT('Produto vendido: ', NEW.idProduto),
        CONCAT('Quantidade ', NEW.quantidade),
		NOW()
    );
END $$
DELIMITER ;

SELECT * FROM produto;

SELECT * FROM itemVenda;

SELECT * FROM auditoria_saida_estoque;

SELECT * FROM auditoria_novo_produto;

SELECT * FROM auditoria_produto_preco;