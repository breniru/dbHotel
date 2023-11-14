/* Atividade da Padaria */
create database dbPadariaBreno;

use dbPadariaBreno;

create table fornecedores (
	idFornecedor int primary key auto_increment,
    nomeFornecedor varchar(50) not null,
    cnpjFornecedor varchar(20) not null,
    telefoneFornecedor varchar(20),
    emailFornecedor varchar(50) not null unique,
    cep char(9),
    enderecoFornecedor varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

describe fornecedores;

insert into fornecedores (nomeFornecedor, cnpjFornecedor, telefoneFornecedor, emailFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado) 
values ("Breno Silva", "84.269.302/0001-50", "(96) 99338-2003", "brenosilva@gmail.com", "02805-190", "Rua Manoel Ramos", "251", "Vila Cruz das Almas", "São Paulo", "SP");

select * from fornecedores;

create table produtos (
	idProduto int primary key auto_increment,
    nomeProduto varchar(50) not null,
    descricaoProduto text,
    ingredientesProduto text,
    pesoProduto decimal(10,2),
    validadeProduto date,
    precoProduto decimal(10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum("Pães", "Bolos", "Confeitaria", "Salgados"),
    idFornecedor int not null,
    foreign key (idFornecedor) references fornecedores(idFornecedor)
);

alter table produtos add ingredientesProduto text after descricaoProduto;
alter table produtos add pesoProduto decimal(10,2) after ingredientesProduto;
alter table produtos add validadeProduto date after pesoProduto;

update produtos set ingredientesProduto = "farinha de aveia" where idProduto = 1;
update produtos set ingredientesProduto = "farinha de trigo" where idProduto = 5;

describe produtos;

insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor)
values ("Pão Integral", "O pão francês é um pão de tamanho médio, geralmente com uma crosta crocante e um miolo macio.", 0.50, 100, "Pães", 1); 

insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor)
values ("Bolo de Chocolate", "Bolo sabor chocolate, com uma massa super macia e uma calda de chocolate por cima.", 45.00, 20, "Bolos", 1);

insert into produtos (nomeProduto, ingredientesProduto, pesoProduto, validadeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Coxinha", "sem glúten", 300.00, "2023-12-07", 8.90, 10, "Salgados", 1);

insert into produtos (nomeProduto, ingredientesProduto, pesoProduto, validadeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Bolinho de Queijo", "sem lactose", 120.00, "2023-12-07", 13.90, 5, "Salgados", 1);

insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor)
values ("Pão Francês", "O pão francês é um pão de tamanho médio, geralmente com uma crosta crocante e um miolo macio.", 0.50, 100, "Pães", 1); 

select * from produtos;
select * from produtos where categoriaProduto = "Pães";
select * from produtos where precoProduto < 50.00 order by precoProduto asc;


create table clientes (
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    cpfCliente varchar(15) not null unique,
    telefoneCliente varchar(20),
    emailCliente varchar(50) unique,
    cep varchar(9),
    enderecoCliente varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

describe clientes;

insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado)
values ("Bruno Silva", "727.243.438-40", "(11) 97462-8891", "brunosilva@gmail.com", "03192-020", "Rua Lúcio Cardoso", "57", "Jardim Itália", "São Paulo", "SP");

select * from clientes;

create table pedidos (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado"),
    idCliente int not null,
    foreign key (idCliente) references clientes(idCliente)
);

insert into pedidos (statusPedido, idCliente) values ("Finalizado", 1);

select * from pedidos;
select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;

create table itensPedidos (
	idItensPedido int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references pedidos(idPedido),
    foreign key (idProduto) references produtos(idProduto),
    quantidade int not null
);

describe itensPedidos;

insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 8);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 2);

select idPedido from pedidos;
select * from itensPedidos;

select nomeCliente, pedidos.idPedido, dataPedido, produtos.idProduto, nomeProduto, quantidade, precoProduto
from itensPedidos inner join pedidos on itensPedidos.idPedido = pedidos.idPedido
inner join produtos on itensPedidos.idProduto = produtos.idProduto
inner join clientes on pedidos.idCliente = clientes.idCliente;

select sum(produtos.precoProduto * itensPedidos.quantidade) as Total from produtos inner join itensPedidos on produtos.idProduto = itensPedidos.idProduto where idPedido = 1;

/* Filtrar produtos por validade (por exemplo, produtos com validade maior que a data do sistema) */
select * from produtos where validadeProduto > curdate();

/* Filtrar produtos que contenham um ingrediente específico */
select * from produtos where ingredientesProduto like '%glúten%';

/* ATIVIDADE: FILTRAR PÃES QUE NÃO SEJAM FEITOS À BASE DE FARINHA DE TRIGO, COM VALOR ATÉ 7.90 */

select * from produtos where ingredientesProduto like "%trigo%" and precoProduto < 7.90;
select * from produtos where ingredientesProduto like "%aveia%" and precoProduto < 7.90;
select * from produtos where ingredientesProduto not like "%trigo%" and precoProduto < 7.90;

