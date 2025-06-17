
-- drop schema if exists ToysGroupDB;
create schema ToysGroupDB;
use ToysGroupDB;

-- drop table if exists Toy;
create table Toy (
ID_TOY	int auto_increment
, NOME_TOY varchar(50)
, ID_CATEGORIA int
, PREZZO_UNITA int
, constraint PK_Toy primary key(ID_TOY)
);

-- drop table if exists Categoria;
create table Categoria (
ID_CATEGORIA int auto_increment
, NOME_CATEGORIA varchar(50)
, constraint PK_Categoria primary key(ID_CATEGORIA)
);

-- drop table if exists Regione;
create table Regione (
ID_REGIONE int auto_increment
, NOME_REGIONE varchar(50)
, constraint PK_Regione primary key(ID_REGIONE)
);

-- drop table if exists Stato;
create table Stato (
ID_STATO int auto_increment
, NOME_STATO varchar(50)
, ID_REGIONE int
, constraint PK_Stato primary key(ID_STATO)
);

-- drop table if exists Sales;
create table Sales (
ID_ORDINE int auto_increment
, DATA_ORDINE date
, ID_TOY int
, QTA_PRODOTTO int
, ID_STATO int
, PREZZO_FINALE int
, constraint PK_Sales primary key(ID_ORDINE)
);

alter table toy
add constraint FK_Categoria_Toy foreign key(ID_Categoria) references Categoria(ID_Categoria)
;

alter table stato
add constraint FK_Regione_Stato foreign key(ID_Regione) references Regione(ID_Regione)
;

alter table Sales
add constraint FK_Toy_Sales foreign key(ID_Toy) references Toy(ID_Toy)
, add constraint FK_Stato_Sales foreign key(ID_Stato) references Stato(ID_Stato)
;

insert into Regione(Nome_Regione) values 
('Europa Occidentale')
, ('Europa Orientale')
, ('Europa Meridionale')
, ('Europa Settentrionale')
, ('USA Occidentale')
, ('USA Orientale')
, ('USA Meridionale')
, ('USA Settentrionale')
;

insert into Categoria(Nome_Categoria) values 
('Giochi prima infanzia')
, ('Giochi educativi e creativi')
, ('Giochi di ruolo')
, ('Veicoli e costruzioni')
, ('Giochi musicali e sportivi')
;

insert into Toy(Nome_Toy, ID_Categoria, Prezzo_Unita) values
('Tappetino sensoriale', 1, 19.99) 
, ('Sonaglio', 1, 8.00) 
, ('Peluche interattivo', 1, 15.00) 
, ('Giostrina da culla', 1, 29.99) 
, ('Palestrina baby', 1, 35.00)
, ('Puzzle in legno', 2, 12.99) 
, ('Libro interattivo sonoro', 2, 18.99) 
, ('Sapientino', 2, 18.00)
, ('Lavagna magnetica', 2, 22.00) 
, ('Giochi di incastri geometrici', 2, 15.00) 
, ('Cucina giocattolo', 3, 39.99) 
, ('Valigetta dottore', 3, 15.99) 
, ('Cassetta attrezzi giocattolo', 3, 20.00) 
, ('Set gioco da campeggio', 3, 38.99) 
, ('Set da tè giocattolo', 3, 12.99) 
, ('Pista per biglie', 4, 17.00) 
, ('Macchina telecomandata', 4, 24.00) 
, ('Set costruzione LEGO', 4, 21.99) 
, ('Trattore giocattolo', 4, 16.00) 
, ('Trenino in legno', 4, 20.00) 
, ('Cantastorie', 5, 27.99) 
, ('Ukulele giocattolo', 5, 19.99) 
, ('Xilofono colorato', 5, 16.00)
, ('Tamburello', 5, 18.00) 
, ('Mini canestro', 5, 21.99)
;

insert into Stato(Nome_stato, ID_Regione) values
('Portogallo', 1)
, ('Svezia', 4)
, ('Polonia', 2)
, ('Italia', 3)
, ('Grecia', 3)
, ('Norvegia', 4)
, ('Germania', 1)
, ('Francia', 1)
, ('Gran Bretagna', 4)
, ('Scozia', 4)
, ('Olanda', 1)
, ('Danimarca', 4)
, ('Lettonia', 2)
, ('Lituania', 2)
, ('Albania', 3)
, ('Croazia', 3)
, ('Svizzera', 1)
, ('Turchia', 3)
, ('Repubblica Ceca', 1)
, ('Islanda', 4)
, ('Ucraina', 2)
, ('Iowa', 8)
, ('California', 5)
, ('Alaska', 8)
, ('Wyoming', 8)
, ('Oregon', 5)
, ('Arkansas', 7)
, ('Mississipi', 7)
, ('Alabama', 6)
, ('Texas' , 7)
, ('Florida', 7)
, ('Ohio', 6)
, ('Pennsylvania', 6)
, ('Oklahoma', 5)
, ('Arizona', 5)
, ('Washington', 5)
, ('Michigan', 8)
, ('Wisconsin', 8)
, ('Louisiana', 6)
, ('Connecticut', 6)
;

insert into Sales(Data_Ordine, ID_Toy, QTA_Prodotto, ID_Stato, Prezzo_Finale) values
('2020-05-22', 19, 4, 15, 64.00) 
, ('2018-05-12', 5, 1, 27, 35.00) 
, ('2016-08-25', 2, 2, 3, 16.00) 
, ('2022-09-06', 24, 4, 19, 72.00) 
, ('2024-08-17', 23, 3, 36, 48.00) 
, ('2016-05-02', 23, 2, 22, 32.00) 
, ('2017-12-15', 16, 1, 11, 17.00) 
, ('2024-03-25', 6, 3, 6,  38.97) 
, ('2023-12-17', 21, 1, 32, 27.99) 
, ('2020-11-11', 6, 1, 40, 12.99) 
, ('2022-06-15', 7, 4, 5, 75.96) 
, ('2022-03-04', 1, 2, 8, 39.98) 
, ('2022-09-24', 11, 2, 25, 79.98) 
, ('2018-06-23', 1, 3, 12, 59.97) 
, ('2016-02-22', 15, 1, 28, 12.99) 
, ('2021-02-19', 11, 4, 7, 159.96) 
, ('2018-04-08', 14, 1, 31, 38.99) 
, ('2015-11-02', 5, 1, 14, 35.00)  
, ('2024-09-28', 22, 1, 9, 19.99)  
, ('2017-10-18', 4, 2, 24, 59.98)  
, ('2019-04-12', 16, 2, 1, 77.98)  
, ('2020-01-24', 18, 2, 37, 37.98)  
, ('2024-06-25', 2, 3, 18, 24.00)  
, ('2023-09-18', 15, 2, 39, 25.98)  
, ('2020-05-01', 22, 1, 21, 19.99)  
, ('2021-11-22', 7, 4, 33, 75.96) 
, ('2018-07-21', 15, 3, 26, 38.97) 
, ('2015-01-04', 8, 2, 13, 36.00)  
, ('2023-03-27', 24, 2, 10, 36.00) 
, ('2017-01-23', 2, 2, 29, 16.00)  
, ('2017-06-09', 6, 1, 17, 12.99)  
, ('2018-08-03', 23, 3, 35, 48.00)  
, ('2016-03-17', 20, 1, 38, 20.00)  
, ('2024-10-07', 18, 4, 2, 87.96)  
, ('2021-10-29', 13, 1, 30, 20.00) 
, ('2021-02-25', 18, 1, 4, 21.99)  
, ('2018-05-03', 19, 2, 20, 32.00)  
, ('2023-09-23', 12, 1, 16, 15.99)  
, ('2019-06-01', 20, 2, 34, 40.00)  
, ('2020-11-21', 3, 3, 23, 45.00)  
, ('2017-08-15', 10, 1, 4, 15.00)  
, ('2023-07-02', 22, 1, 22, 19.99)  
, ('2021-06-01', 7, 4, 32, 75.96)  
, ('2023-03-18', 11, 1, 34, 22.00)  
, ('2020-05-21', 7, 2, 11, 37.98) 
, ('2017-07-25', 5, 2, 7, 70.00) 
, ('2023-07-21', 8, 2, 29, 36.00) 
, ('2020-07-13', 5, 3, 40, 105.00) 
, ('2017-10-07', 4, 2, 1, 59.98) 
, ('2015-05-18', 9, 2, 12, 44.00) 
, ('2024-02-17', 21, 1, 31, 27.99) 
, ('2015-05-21', 17, 2, 28, 48.00)  
, ('2020-10-20', 20, 2, 9, 40.00)  
, ('2024-02-08', 14, 1, 20, 38.99)  
, ('2024-03-10', 1, 1, 2, 19.99)  
, ('2023-06-06', 7, 4, 30, 75.96)  
, ('2016-11-08', 20, 4, 19, 80.00)  
, ('2024-09-29', 22, 3, 33, 59.97)  
, ('2020-04-29', 4, 1, 5, 29.99)  
, ('2024-02-03', 3, 1, 25, 15.00) 
;












