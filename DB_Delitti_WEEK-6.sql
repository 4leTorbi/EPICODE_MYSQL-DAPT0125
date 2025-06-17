-- drop schema if exist KILLER;
CREATE SCHEMA KILLER;

DROP SCHEMA KILLER;

USE KILLER;

-- drop table if exists killer;
CREATE TABLE KILLER (
ID_KILLER INT
, NOME VARCHAR(50)
, COGNOME VARCHAR(50)
, GENERE CHAR(1)
, NUM_VITTIME INT
, STATUS_MORTO int
, constraint PK_KILLER PRIMARY KEY (ID_KILLER));

CREATE TABLE AREA_GEOGRAFICA(
ID_AREA int
, NOME_AREA VARCHAR(50)
, constraint PK_AREA_GEOGRAFICA primary key(ID_AREA));

CREATE TABLE ARMA (
ID_ARMA int
, NOME_ARMA VARCHAR(50)
, constraint PK_ARMA primary key(ID_ARMA));

-- drop table if exists VITTIMA;

create TABLE VITTIMA (
ID_VITTIMA INT
, NOME VARCHAR(50)
, COGNOME VARCHAR(50)
, ANNI int
, GENERE char(1)
, constraint PK_VITTIMA primary key(ID_VITTIMA));

create TABLE DELITTO (
ID_DELITTO int
, ID_KILLER INT
, ID_AREA INT
, ID_ARMA INT
, ID_VITTIMA int
, constraint PK_DELITTO primary key(ID_DELITTO)
, constraint FK_KILLER_DELITTO foreign key(ID_KILLER) references KILLER(ID_KILLER)
, constraint FK_AREA_GEOGRAFICA_DELITTO foreign key(ID_AREA) references AREA_GEOGRAFICA(ID_AREA)
, constraint FK_ARMA_DELITTO foreign key(ID_ARMA) references ARMA(ID_ARMA)
, constraint FK_VITTIMA_DELITTO foreign key(ID_VITTIMA) references VITTIMA(ID_VITTIMA)
);

 -- DROP TABLE if exists delitto;

create TABLE DELITTO (
ID_DELITTO int
, ID_KILLER INT
, ID_AREA INT
, ID_ARMA INT
, ID_VITTIMA int
, constraint PK_DELITTO primary key(ID_DELITTO)
, constraint FK_KILLER_DELITTO foreign key(ID_KILLER) references KILLER(ID_KILLER)
, constraint FK_AREA_GEOGRAFICA_DELITTO foreign key(ID_AREA) references AREA_GEOGRAFICA(ID_AREA)
, constraint FK_ARMA_DELITTO foreign key(ID_ARMA) references ARMA(ID_ARMA)
, constraint FK_VITTIMA_DELITTO foreign key(ID_VITTIMA) references VITTIMA(ID_VITTIMA)
);

INSERT INTO KILLER VALUES 
(1, "Dexter", "Morgan", "M", 2, 0)  
, (2, "Beatrix", "Kiddo", "F", 1, 0)
, (3, "Walter", "White", "M", 1, 1)
, (4, "John", "RED", "M", 2, 1)
, (5, "Hannibal", "Lecter", "M", 2, 1)
, (6, "Freddy", "Kruger", "M", 1, 1) 
, (7, "It", "It", "N", 2, 0);

select *
from killer;

insert into area_geografica values
(1, "America")
, (2, "Europa")
, (3, "Asia")
, (4, "Africa");

insert into arma values
(1, "Coltello")
, (2, "Katana")
, (3, "Droghe")
, (4, "Coltello")
, (5, "Denti")
, (6, "Lame")
, (7, "Palloncini");


insert into vittima values
(1, "Mario", "Luigi", 49, "M")
, (2, "Luigi", "Mario", 34, "M")
, (3, "Sara", "Rasa", 35, "F")
, (4, "Giulio", "Liogiu", 43, "M")
, (5, "Carlo", "Locarl", 26, "M")
, (6, "Federica", "Ricafede", 67, "F")
, (7, "Vittoria", "Persa", 73, "F")
, (8, "Riccardo", "Bettino", 15, "M")
, (9, "Tizio", "Caio", 23, "M");



select *
from vittima;

insert into delitto values
(1, 1, 1, 1, 1)
, (2, 1, 2, 2, 2)
, (3, 2, 3, 3, 3)
, (4, 3, 4, 4, 4)
, (5, 4, 2, 7, 2)
, (6, 4, 3, 6, 4)
, (7, 5, 1, 7, 2)
, (8, 6, 4, 5, 1)
, (9, 7, 2, 3, 3);



