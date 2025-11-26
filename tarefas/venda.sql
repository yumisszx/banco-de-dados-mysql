create database aulaVenda;
use aulaVenda;

create table cidade(
cidadeid int not null primary key auto_increment,
cidadenome varchar (50)
);

Insert into cidade values
(0,'Avaré'),
(0,'Itai'),
(0,'Fartura'),
(0,'Botucatu');

select * from cidade;

create table cliente(
clienteid int not null primary key auto_increment,
clientenome varchar(50),
clientenascimento date,
clientesexo char (1),
cidadeid int not null,
foreign key(cidadeid) references cidade(cidadeid)
);

insert into cliente values
(0,'paula andrade', '2000-03-12', 'f', 1),
(0,'marcos mendes', '2005-11-04', 'm', 3),
(0,'hiago lima', '1990-07-28', 'm', 1),
(0,'karol torres', '2006-09-04', 'f', 4),
(0,'carla rios', '2003-01-29', 'f', 2);

select * from cliente;

create table produto(
produtoid int not null primary key auto_increment,
produtodesc varchar (250),
produtopreco numeric (7,2)
);

Insert into produto values 
(0, 'Asus Vivobook Go 15 Ryzen 5 7520U - 8GB RAM - 256SSD - Tela 15,6 - FHD - Linux', 2294.16),
(0, 'Headset Gamer Havit H2015D', 145.50),
(0, 'SSD Kingston 1TB M.2 2280', 362.70);

select * from produto;

create table venda(
vendaid int not null primary key auto_increment,
vendadata date,
clienteid int not null,
foreign key (clienteid) references cliente(clienteid)
);

insert into venda values
(0, '2025-08-26', 5),
(0, '2025-08-28', 1),
(0, '2025-08-30', 3);

select * from venda;

create table item (
itemid int not null primary key auto_increment,
vendaid int not null,
produtoid int not null,
qtde int,
foreign key (vendaid) references venda(vendaid),
foreign key (produtoid) references produto (produtoid)
);

insert into item values
(0, 1, 1, 1),
(0, 1, 2, 1),
(0, 2, 3, 3),
(0, 3, 2, 2);

select * from item;
