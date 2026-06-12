CREATE DATABASE Subquery;
USE Subquery;

CREATE TABLE funcionarios (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150),
    salario DECIMAL(10,2),
    departamento INT,
    cargo VARCHAR(30)
);

INSERT INTO funcionarios VALUES
(1, 'Ana Trindade', 3000, 10, 'ANALISTA'),
(2, 'Bruno Marques', 4500, 20, 'GERENTE'),
(3, 'Carlos Ferreira',2000, 10, 'ASSISTENTE'),
(4, 'Daniela Alvez', 6000, 30, 'GERENTE'),
(5, 'Eduardo Nogueira', 3500, 20, 'ANALISTA'),
(6, 'Fernanda Oliveira',2500, 10, 'ASSISTENTE'),
(7, 'Gabriel Dias', 7000, 30, 'DIRETOR'),
(8, 'Helena Reis', 4000, 20, 'ANALISTA'),
(9, 'Igor Tavares', 1500, 10, 'ESTAGIARIO'),
(10,'Juliana Silva',5000, 30, 'ANALISTA');

-- 1) Liste os funcionários que ganham acima da média salarial da empresa.

SELECT nome, salario
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);

-- 2) Liste os funcionários que ganham abaixo da média salarial da empresa.

SELECT nome, salario
FROM funcionarios
WHERE salario < (SELECT AVG(salario) FROM funcionarios);

-- 3) Mostre o nome dos funcionários que possuem o maior salário da tabela.

SELECT nome
FROM funcionarios
WHERE salario = (SELECT MAX(salario) FROM funcionarios);

-- 4) Mostre o nome dos funcionários que possuem o menor salário da tabela.

SELECT nome
FROM funcionarios
WHERE salario = (SELECT MIN(salario) FROM funcionarios);

-- 5) Exiba nome, salário e a média salarial geral em cada linha.

SELECT nome, salario,
       (SELECT AVG(salario) FROM funcionarios) AS media_geral
FROM funcionarios;

-- 8) Liste funcionários que ganham acima do salário médio do departamento 10.

SELECT nome, salario
FROM funcionarios
WHERE salario > (
    SELECT AVG(salario)
    FROM funcionarios
    WHERE departamento = 10
);

-- 9) Exiba funcionários cujo salário é maior que o menor salário dos gerentes.

SELECT nome, salario
FROM funcionarios
WHERE salario > (
    SELECT MIN(salario)
    FROM funcionarios
    WHERE cargo = 'GERENTE'
);

-- 10) Liste funcionários cujo salário é igual ao salário médio da empresa (se houver).

SELECT nome, salario
FROM funcionarios
WHERE salario = (SELECT AVG(salario) FROM funcionarios);

-- 11) Reescreva uma consulta com subquery escalar usando JOIN

SELECT f.nome, f.salario
FROM funcionarios f
JOIN (
    SELECT AVG(salario) AS media FROM funcionarios
) m ON f.salario > m.media;

-- 13) Dada a tabela funcionarios(id,nome,salario,departamento), escreva a consulta para mostrar quem ganha acima da média.

SELECT nome
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);

-- 14) Crie uma consulta que mostre nome e diferença entre salário e média da empresa.

SELECT nome, salario,
       salario - (SELECT AVG(salario) FROM funcionarios) AS diferenca
FROM funcionarios;