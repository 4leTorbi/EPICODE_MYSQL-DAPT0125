/* Esercizio 07-04-25:
È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda.
Uno store è collocato in una precisa area geografica. 
In unʼarea geografica possono essere collocati store diversi. 
Cosa devi fare:
 1. Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.). 
 2. Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …).
 3. Popola le tabelle con pochi record esemplificativi.
 4. Esegui operazioni di aggiornamento, modifica ed eliminazione record.
 */


-- drop schema if exists anagrafica_Azienda;
create schema anagrafica_Azienda;
use anagrafica_Azienda;

-- drop table if exists Store;
create table Store (
ID_Store int auto_increment							 
, Nome_Store varchar(50)
, ID_Categoria int
, ID_Regione int
, Data_Apertura date
, constraint PK_Store primary key(ID_Store)
);

-- drop table if exists Categoria;
create table categoria (
ID_Categoria int auto_increment
, Nome_Categoria varchar(50)
, constraint PK_Categoria primary key(ID_Categoria)
);

-- drop table if exists Regione;
create table regione (
ID_Regione int auto_increment
, Nome_Regione varchar(50)
, Città varchar(50)
, Area_Geografica varchar(50)
, constraint PK_Regione primary key(ID_Regione)
);

alter table store
add constraint FK_Regione_Store foreign key(ID_Regione) references Regione(ID_Regione)
, add constraint FK_Categoria_Store foreign key(ID_Categoria) references Categoria(ID_Categoria)
;

insert into Store (Nome_Store, ID_Categoria, ID_Regione, Data_Apertura)  values 
('Nova Market', 2, 1, '2002-05-17'),
('Urban Point', 4, 8, '2010-03-22'),
('Green Corner', 2, 3, '2015-08-10'),
('Tech Paradise', 1, 6, '2008-11-03'),
('Fashion Hub', 3, 1, '2013-04-14'),
('Bistro Lux', 2, 5, '2005-09-01'),
('Vintage Valley', 4, 7, '2001-06-19'),
('Smart Stop', 1, 2, '2017-12-05'),
('Golden Goods', 2, 7, '2009-07-27'),
('Pixel Spot', 1, 8, '2020-01-09'),
('Daily Basket', 2, 3, '2011-10-12'),
('The Essentials', 4, 4, '2003-02-03'),
('Eco Choice', 4, 6, '2019-05-30'),
('Quick Mart', 2, 3, '2006-03-21'),
('Dream Deals', 1, 1, '2014-06-18'),
('MegaMart', 2, 5, '2004-08-25'),
('NextGen Store', 1, 7, '2016-11-15'),
('Style Zone', 3, 1, '2012-07-06'),
('Value Central', 4, 6, '2000-10-10'),
('Casa Viva', 4, 2, '2007-04-28'),
('Electro Spot', 1, 3, '2021-02-14'),
('Home & More', 4, 5, '2018-09-08'),
('ShopXpress', 2, 8, '2023-01-01'),
('Budget Lane', 1, 5, '2002-11-20'),
('Zenith Goods', 2, 3, '2010-06-16'),
('EcoSmart', 4, 1, '2022-03-03'),
('MarketVille', 2, 7, '2005-01-07'),
('Prime Point', 2, 1, '2009-09-09'),
('Fusion Store', 1, 8, '2024-04-01'),
('The Local Pick', 2, 7, '2016-05-12')
;

select *
from store
;

insert into Categoria (Nome_Categoria) values 
('Elettronica')
, ('Alimentari')
, ('Moda')
, ('Arredamento')
;

select *
from categoria
;

insert into Regione (Nome_Regione, Città, Area_Geografica) values 
('Lombardia', 'Milano', 'Nord')
, ('Veneto', 'Verona', 'Nord')
, ('Lazio', 'Roma', 'Centro')
, ('Toscana', 'Firenze', 'Centro')
, ('Campania', 'Napoli', 'Sud')
, ('Puglia', 'Bari', 'Sud')
, ('Sicilia', 'Palermo', 'Isole')
, ('Sardegna', 'Cagliari', 'Isole')
;

select *
from regione
;

select Nome_Store
, Nome_Categoria
, Data_Apertura
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
;

select Nome_Store
, Nome_Categoria
, Data_Apertura
, Città
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
inner join regione
on store.ID_Regione = regione.ID_Regione
;

select Nome_Regione as Regione
, count(Nome_Regione) as Conteggio_Store_Regione
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
inner join regione
on store.ID_Regione = regione.ID_Regione
group by Nome_Regione
;

select Nome_Categoria as Categoria
, count(Nome_Categoria) as Conteggio_Store_Categoria
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
inner join regione
on store.ID_Regione = regione.ID_Regione
group by Nome_Categoria
;

select *
from store 
where year(Data_Apertura) >= 2008
;

select year(Data_Apertura) as Inaugurazione
, Nome_Regione as Regione
, count(Nome_Regione) as Regione
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
inner join regione
on store.ID_Regione = regione.ID_Regione
group by year(Data_Apertura), Nome_Regione
order by year(Data_Apertura)
;

update store 
set Data_Apertura = '2021-02-15'
where ID_Store = 21
;

update regione
set Città = 'Sassari'
where ID_Regione = 8
;

-- drop view if exists Anagrafica_Store;
create view AT_VW_Anagrafica_Store as (
select Nome_Store as Store
, Nome_Categoria as Categoria
, Città
, Area_Geografica
, Data_Apertura as Inaugurazione 
from store 
inner join categoria
on store.ID_Categoria = categoria.ID_Categoria
inner join regione
on store.ID_Regione = regione.ID_Regione
);
