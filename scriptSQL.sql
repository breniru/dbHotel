/* Mostrar os bancos de dados existentes no servidor */
show databases;
show tables;
/* Criar um novo banco */
create database dbHotel;

/* Selecionar o banco de dados */
use dbHotel;

/* Excluir a tabela do banco */
drop table funcionarios;

/* Criar uma nova tabela */
create table funcionarios (
	/*Int: se refere ao tipo do campo na tabela.
    primary key: determina que o campo idFunc seja uma chave primária responsável por identificar cada funcionário.
    auto_increment: determina que o MySQL dê um id novo a cada cadastro. */
	idFunc int primary key auto_increment,
    
    /* varchar: é a quantidade variável de caracteres no nome (nesse caso, até 100 caracteres).
    not null: determina que o campo seja obrigatório */
    /*nomeFunc varchar (100) not null,*/
    
    /* unique: determina que o campo seja único e o valor não possa repetir */
    login varchar(20) not null unique,
    senha varchar(255) not null,
    cargo varchar(20)
);

/* descreve os campos da tabela funcionarios */
describe funcionarios;/* Mostrar as tabelas */
show tables;

/*inserir um novo funcionario na tabela, com nome, login, senha criptografada e cargo | CREATE no crud*/
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Administrador", "admin", md5("admin"), "Administrador");

insert into funcionarios(nomeFunc, login, senha, cargo) values ("Pamella Pereto", "pamellapereto", md5("123@senac"), "TI");

insert into funcionarios(nomeFunc, login, senha, cargo) values ("Breno Silva", "brenosilva", md5("123@senac"), "Contabilidade");

insert into funcionarios(nomeFunc, login, senha, cargo) values ("Victoria Cardoso", "victoriacardoso", md5("123@senac"), "RH");

insert into funcionarios(nomeFunc, login, senha) values ("Laura Lopes", "lauralopes", md5("123@senac"));

insert into funcionarios(nomeFunc, login, senha) values ("Fellipe Coelho", "fellipe", md5("123@senac"));

/* Ler/Buscar as informações da tabela funcionários | READ no crud */
select * from funcionarios;

/* UPDATE no crud */
update funcionarios set login = "fellipecoelho" where idFunc = 6; 

update funcionarios set cargo = "Gerencia" where idFunc = 3; 
update funcionarios set cargo = "Gerencia" where idFunc = 4; 

/* Adicionar o campo email à tabela funcionarios */
alter table funcionarios add column email varchar(50);

/* Excluir um campo da tabela */
alter table funcionarios drop column email;

/*Modificar o campo email para que se torne obrigatório, ou seja, não nulo (not null) */
alter table funcionarios modify column email varchar(50) not null;

/*Reposicionar o campo email para que ele fique após o campo login */
alter table funcionarios modify column email varchar(50) not null after login;

delete from funcionarios where idFunc = 6;

update funcionarios set email = "administrador@gmail.com" where idFunc = 1;

/* Buscar o login e a senha da tabela funcionarios em que login seja admin e senha seja admin */
select login as Login, senha as Senha from funcionarios where login = "admin" and senha = md5("admin");

select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc asc;

select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc desc;

/* Buscar os campos ID com o apelido ID_Funcionario, nomeFunc com o apelido Nome_Funcionario e cargo com apelido
Cargo_Funcionario da tabela funcionarios ordenando de forma descendente (do maior ID o menor)*/
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios order by idFunc desc;

/* Buscar os campos ID com o apelido ID_Funcionario, nomeFunc com o apelido Nome_Funcionario e cargo com apelido
Cargo_Funcionario da tabela funcionarios onde cargo seja diferente de nulo e ordenando de forma ascendente e ID (do maior para o menor)
<> ESTE SINAL SIGNIFIGA DIFERENTE, SIGINIFICA ESSE CARINHA AQUI --> ≠ */
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios where cargo <> "null" order by idFunc desc;

select * from funcionarios where cargo = "Gerencia" order by nomeFunc asc;

create table quartos (
	IdQuarto int primary key auto_increment,
    andar varchar(10) not null, 
    tipoQuarto varchar(50) not null,
    ocupacaoMax int not null,
    situacao char(3) not null,
    nome varchar(50) not null, 
    descricao text, 
    preco decimal(10,2) not null,
    tipoCama varchar(20),
    varanda char(3)
);

describe quartos;

alter table quartos add column numeroQuarto varchar(10) not null after andar;
alter table quartos add column cafeDaManha char(3) not null after preco;
alter table quartos add column foto varchar(255) not null after descricao;

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values ("5º", "505", "Superior Premier", 3, "não", "Familiar", "O quarto de 32m² com piso frio, varanda - vista para o mar. Oferece ar condicionado individual, TV LCD 42'', wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.", "https://imagens-revista.vivadecora.com.br/uploads/2019/05/quarto-de-hotel-decorado-em-cores-neutras-com-amplas-janelas.jpg", 750.90, "sim", "Queen Size", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values ("7º", "703", "Superior Premier Twin", 5, "sim", "Familiar", "O quarto de 54m² com piso frio, varanda - vista para o mar. Oferece ar condicionado individual, TV LCD 64'', Playstation 5, wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo, chapinha e amenities e mesa de trabalho.", "https://www.revistasim.com.br/wp-content/uploads/2021/03/revistaSIM_Arquitetura_Quarto-de-hotel-em-casa_Destaque_Credito_Eduardo-Pozella-1155x500.jpg", 1150.90, "sim", "King Size", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values ("2º", "203", "Classic Premier", 2, "não", "Familiar", "O quarto de 84m² com piso frio, varanda - vista para o mar. Oferece ar condicionado individual, TV LCD 32'', wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.", "https://i.pinimg.com/736x/54/99/8d/54998daa4afc482a4b42b1dd7a9a53b4.jpg", 650.90, "sim", "Queen Size", "sim");


select * from quartos;

select * from quartos where situacao = "não";

select * from quartos where situacao = "não" and cafeDaManha = "sim";

select * from quartos where situacao = "não" and cafeDaManha = "sim" and varanda = "sim";

select * from quartos where preco < 700.00 and situacao = "não";

select * from quartos where situacao = "não" order by preco asc;

drop table pedido;

create table pedido (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado") not null,
    idCliente int not null,
    foreign key (idCliente) references clientes(idCliente)
);

insert into pedido (statusPedido, idCliente) values ("Pendente", 1);
insert into pedido (statusPedido, idCliente) values ("Finalizado", 2);

select * from pedido;

describe pedido;

create table reservas (
	idReserva int primary key auto_increment,
    idPedido int not null,
    idQuarto int not null,
    foreign key (idPedido) references pedido(idPedido),
    foreign key (idQuarto) references quartos(idQuarto)
);

describe reservas;

create table clientes (
	idCliente int primary key auto_increment,
    nomeCompleto varchar(100) not null,
    cpf char(14) not null unique, 
    rg char(14) not null unique,
	email varchar(50) unique,
    celular varchar(30) not null,
    numeroCartao varchar(20) not null unique,
    nomeTitular varchar(100) not null,
    validade date not null,
    cvv char(3) not null,
    checkin datetime not null,
    checkout datetime not null
);

 select * from clientes;

drop table clientes;

describe clientes;

insert into clientes (nomeCompleto, cpf, rg, email, celular, numeroCartao, nomeTitular, validade, cvv, checkin, checkout) values
("José de Assis", "829.942.570-09",  "48.353.888-7", "josedeassis@gmail.com", "(96) 99338-2003", "5526 4863 8286 2543", "José de Assis", "2025-03-31",
 "452", "2023-11-02 14:00:00", "2023-11-05 12:00:00"); 

insert into clientes (nomeCompleto, cpf, rg, email, celular, numeroCartao, nomeTitular, validade, cvv, checkin, checkout) values
("Maria das Graças", "925.042.518-71",  "68.814.376-3", "mariadasgracas@gmail.com", "(11) 93629-1094", "9226 4156 2256 1543", "Maria das Graças", "2027-08-31",
 "368", "2023-11-07 17:30:25", "2023-11-12 12:30:00");    
 

 
  /* Buscar TODAS AS INFORMAÇÕES da tabela quartos que está vincula à tabela clientes pelo campo idQuarto */
 select * from quartos inner join clientes on quartos.idQuarto = clientes.idQuarto;
 
 /* Buscar o nome completo e o celular de clientes que alugou o quarto de número 505, pois a tabela quartos está vinculada à tabela clientes pelo campo idQuarto*/
 select clientes.nomeCompleto, clientes.celular from quartos inner join clientes on quartos.idQuarto = clientes.idQuarto where numeroQuarto = 505;
 
 /* Buscar o nome completo e data/horário de checkout do cliente que alugou o quarto de número 505*/
 select clientes.nomeCompleto, date_format(clientes.checkout, '%d/%m/%Y - %H:%i	:%s') as Checkout from quartos inner join clientes on quartos.idQuarto = clientes.idQuarto where numeroQuarto = 505;
 
/* ATIVIDADE AVALIATIVA */
