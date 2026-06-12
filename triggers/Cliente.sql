CREATE DATABASE triggers;
USE triggers;

CREATE TABLE cliente(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150),
    dataNascimento DATE
);

INSERT INTO cliente  VALUES
(0, "Maria Clara Fernandes", "2000-07-15"),
(0, "Carol Oliveira Ferraz", "2006-04-26"),
(0, "Bruna Medeiros Lima", "1999-11-03"),
(0, "Paulo Gustavo Silva", "1990-09-17"),
(0, "Fatima Gomes Trindade", "2005-01-22");

CREATE TABLE logCliente (
	idLog INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Mensagem VARCHAR(200),
    DataRegistro DATETIME
);

DELIMITER $$
CREATE TRIGGER trg_insert_clientes 
AFTER INSERT
ON cliente
FOR EACH ROW 
BEGIN
	INSERT INTO logCliente(
		Mensagem,
        DataRegistro
	)
    VALUES(
		CONCAT('Cliente cadastrado: ', NEW.nome),
        NOW()
	);
END $$
DELIMITER ;

INSERT INTO cliente VALUE (0, "Ursula Miranda Gomes", "2001-06-30");

SELECT * FROM cliente;

SELECT * FROM logCliente;