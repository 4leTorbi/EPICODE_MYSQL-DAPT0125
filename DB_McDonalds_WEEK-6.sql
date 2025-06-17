-- drop database if exists MCDONALDS;
create database MCDONALDS; -- Creato un DB di nome MCDONALDS
use MCDONALDS;

-- drop table if exists PANINI;
create table PANINI(
ID_PANINO int
, NOME varchar(30)
, constraint PK_PANINI primary key (ID_PANINO)); -- Vincolo di PK

-- drop table if exists FINGER FOOD;
create table FINGER_FOOD(
ID_FINGER_FOOD int
, NOME varchar(30)
, constraint PK_FINGER_FOOD primary key (ID_FINGER_FOOD)  -- Vincolo di PK
);

-- drop table if exists BIBITE;
create table BIBITE(
ID_BIBITA int
, NOME varchar(20)
, constraint PK_BIBITE primary key (ID_BIBITA)  -- Vincolo di PK
);

-- drop table if exists MENU;
create table MENU(
ID_MENU int
, FORMULA varchar(30)
, ID_PANINO int
, ID_FINGER_FOOD int
, ID_BIBITA int
, PREZZO decimal(4,2)
, constraint PK_MENU primary key (ID_MENU) -- Vincolo di PK 
, constraint FK_PANINI_MENU foreign key (ID_PANINO) references PANINI(ID_PANINO) -- Vincolo di FK
, constraint FK_FINGER_FOOD_MENU foreign key (ID_FINGER_FOOD) references FINGER_FOOD(ID_FINGER_FOOD) -- Vincolo di FK
, constraint FK_BIBITE_MENU foreign key (ID_BIBITA) references BIBITE(ID_BIBITA) -- Vincolo di FK
); 

-- drop table if exists PUNTO_VENDITA;
create table PUNTO_VENDITA(
ID_PUNTO_VENDITA int
, LOCALITA varchar(20)
, constraint PK_PUNTO_VENDITA primary key (ID_PUNTO_VENDITA) -- Vincolo di PK 
);

-- drop table if exists DIPENDENTI;
create table DIPENDENTI(
ID_DIPENDENTE int
, NOME varchar(12)
, COGNOME varchar(12)
, constraint PK_DIPENDENTI primary key (ID_DIPENDENTE) -- Vincolo di PK 
);

-- drop table if exists SCONTO_CLIENTE;
create table SCONTO_CLIENTE(
ID_SCONTO int
, SCONTO float
, ID_CLIENTE int
, constraint PK_SCONTO_CLIENTE primary key (ID_SCONTO) -- Vincolo di PK 
);

select *
FROM SCONTO_CLIENTE;

-- drop table if exists ANAGRAFICA_CLIENTE;
create table ANAGRAFICA_CLIENTE(
ID_CLIENTE int
, NOME varchar(10)
, COGNOME varchar(10)
, RESIDENZA varchar(50)
, constraint PK_ANAGRAFICA_CLIENTE primary key (ID_CLIENTE) -- Vincolo di PK 
, constraint FK_SCONTO_CLIENTE_ANAGRAFICA_CLIENTE foreign key (ID_CLIENTE) references SCONTO_CLIENTE(ID_SCONTO) -- Vincolo di FK
);

select *
FROM ANAGRAFICA_CLIENTE;

-- drop table if exists ORDINE_CLIENTE;
create table ORDINE_CLIENTE(
ID_ORDINE int
, ID_CLIENTE int	
, ID_MENU int
, PREZZO decimal(4,2)
, ID_SCONTO int
, ID_DIPENDENTE int
, ID_PUNTO_VENDITA INT
, TOTALE decimal(4,2)
, constraint PK_ORDINE_CLIENTE primary key (ID_ORDINE) -- Vincolo di PK
, constraint FK_ANAGRAFICA_CLIENTE_ORDINE_CLIENTE foreign key (ID_CLIENTE) references ANAGRAFICA_CLIENTE (ID_CLIENTE) -- Vincolo di FK
, constraint FK_MENU_ORDINE_CLIENTE foreign key (ID_MENU) references MENU (ID_MENU) -- Vincolo di FK
, constraint FK_PUNTO_VENDITA_CLIENTE_ORDINE_CLIENTE foreign key (ID_PUNTO_VENDITA) references PUNTO_VENDITA (ID_PUNTO_VENDITA) -- Vincolo di FK
, constraint FK_SCONTO_CLIENTE_CLIENTE_ORDINE_CLIENTE foreign key (ID_SCONTO) references SCONTO_CLIENTE (ID_SCONTO) -- Vincolo di FK
, constraint FK_DIPENDENTI_ORDINE_CLIENTE foreign key (ID_DIPENDENTE) references DIPENDENTI (ID_DIPENDENTE) -- Vincolo di FK
);

select *
FROM ORDINE_CLIENTE;

-- SET FOREIGN_KEY_CHECKS = 0; -- Disabilita momentaneamente le FK delle tabelle
-- TRUNCATE table BIBITE; -- Cancella i valori della tabella selezionata
-- SET FOREIGN_KEY_CHECKS = 1; -- Riattiva i vincoli di FK

insert into PANINI values -- Popolo la tabella selezionata
(1, "Hamburger")
, (2, "Cheeseburger")
, (3, "Double Cheeseburger")
, (4, "Big Mac")
, (5, "Crispy McBacon")
, (6, "Gran Crispy McBacon")
, (7, "McChicken")
, (8, "McToast")
, (9, "MySelection")
, (10, "McFiletto");

select *
FROM panini;

insert into FINGER_FOOD values -- Popolo la tabella selezionata
(1, "Patatine")
, (2, "Alette")
, (3, "Panzerotti")
, (4, "Nuggets")
, (5, "SpicyNuggets")
, (6, "RiccheCheddar")
, (7, "RiccheBacon");

select *
FROM FINGER_FOOD;

insert into BIBITE values -- Popolo la tabella selezionata
(101, "CocaCola")
, (102, "CocaZero")
, (103, "Sprite")
, (104, "Fanta")
, (105, "The Pesca")
, (106, "The Limone")
, (107, "Acqua Naturale")
, (108, "Acqua Frizzante")
, (109, "Succo Arancia")
, (110, "Birra");

select *
from BIBITE;

insert into menu values -- Popolo la tabella selezionata
(1,	"McMenu Small", 4, 1, 102, 8.50) 
, (2, "McMenu Medium", 2, 3, 101, 12.00)
, (3, "McMenu Large", 9, 4, 104, 16.00) 
, (4, "Happy Meal", 1, 1, 105, 7.50) 
, (5, "McMenu Personalizzato 1", 10, 5, 107,	14.00) 
, (6, "McMenu Personalizzato 2", 5, 2, 110, 12.50) 
, (7, "McMenu Personalizzato 3", 8, 4, 101, 15.00) 
, (8, "McMenu Personalizzato 4",7, 7, 109, 11.50);

select *
from menu;

insert into PUNTO_VENDITA values -- Popolo la tabella selezionata
(1, "Cinque Lune")
, (2, "Spagna")
, (3, "Romanina")
, (4, "Tor Tre Teste")
, (5, "Tuscolana")
, (6, "Re Di Roma")
, (7, "Trevi")
, (8, "Corso Francia")
, (9,	"Frattocchie")
, (10, "Porta Di Roma");

select *
from punto_vendita;

insert into DIPENDENTI values -- Popolo la tabella selezionata
(1, "Paolo", "Piva")
, (2, "Can", "Yaman")
, (3, "Diletta", "Leotta")
, (4, "Alessandro", "Borghese")
, (5, "Carlo", "Conti")
, (6, "Terence", "Hill")
, (7, "Sabrina", "Ferilli");

select *
from dipendenti;

insert into SCONTO_CLIENTE values -- Popolo la tabella selezionata
(1, 12.0, 1)
, (2, 17.0, 2)
, (3, 0.0, 3)
, (4, 20.0, 4)
, (5, 10.0, 5)
, (6, 50.0, 6)
, (7, 8.0, 7)
, (8, 14.0, 8);

select *
from SCONTO_CLIENTE;

INSERT INTO ANAGRAFICA_CLIENTE values -- Popolo la tabella selezionata
(1, "Lino", "Topo", "Via Rossi 45 00183 RM")
, (2, "Titti", "Smith", "Via Bianchi 11 00179 RM")
, (3, "Paolo", "Condò", "Via Brombeis 67 00186 RM")
, (4, "Brad", "Pitty", "Via Verdi 11 00153 RM")
, (5, "Anna", "Karenina", "Via Gialli 29 00115 RM")
, (6, "Gianni", "Sperti", "Piazza Garibaldi 2 00146 RM")
, (7, "Harry", "Potter", "Corso Magellano 78 00184 RM")
, (8, "Andy", "Norton", "Viale Del Tramonto 00113 RM");

SELECT *
FROM ANAGRAFICA_CLIENTE;

insert INTO ORDINE_CLIENTE values -- Popolo la tabella selezionata
(1, 7, 5, 14.00, 7, 2, 2, 12.88)
, (2, 2, 1, 8.50, 2, 7, 10, 7.06)
, (3, 1, 7, 15.00, 1, 1, 4, 13.20)
, (4, 8, 8, 11.50, 8, 4, 8, 9.89)
, (5, 5, 3, 16.00, 5, 5, 5, 14.40)
, (6, 6, 2,	12.00, 6, 3, 1, 6.00)
, (7, 3, 4, 7.50, 3, 2, 3, 7.50)
, (8, 4, 6,	12.50, 4, 6, 7, 10.00);

SELECT *
FROM ORDINE_CLIENTE;







