use toysgroupdb;

alter table sales
rename column PREZZO_FINALE to PREZZO_FINALE_EURO
;
ALTER TABLE toy
rename column PREZZO_UNITA to PREZZO_UNITA_EURO
;

 /* Verificare che i campi definiti come PK siano univoci.
 In altre parole, scrivi una query per determinare l’univocità dei valori di ciascuna PK
 (una query per tabella implementata).
 */

select ID_CATEGORIA
, count(ID_CATEGORIA)
from categoria
group by ID_CATEGORIA
having count(*) = 1
;

select ID_Regione
, count(ID_Regione)
from Regione
group by ID_Regione
having count(*) = 1
;

select ID_Ordine
, count(ID_Ordine)
from Sales
group by ID_Ordine
having count(*) = 1
;

select ID_Stato
, count(ID_Stato)
from Stato
group by ID_Stato
having count(*) = 1
;

select ID_Toy
, count(ID_Toy)
from Toy
group by ID_Toy
having count(*) = 1
;

/* Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, 
il nome del prodotto, la categoria del prodotto, il nome dello stato,
il nome della regione di vendita e un campo booleano valorizzato in base alla condizione che
siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False).
 */
 
 select ID_ORDINE
 , DATA_ORDINE as DATA 
 , NOME_TOY as TOY
 , NOME_CATEGORIA as CATEGORIA
 , nome_stato as STATO
 , NOME_REGIONE as REGIONE
 /* , CASE 
	WHEN (current_date()- DATA_ORDINE) >180 THEN 'True'
		ELSE 'False' end as '+/- 180 gg'
 */
 , CASE
	WHEN datediff(current_date(), data_ordine) > 180 THEN 'True'
		ELSE 'False' end as '+/- 180 gg'
 from sales as Vendite
 inner join toy as Gioco
 on Vendite.ID_TOY = Gioco.ID_TOY
 INNER join STATO 
 ON Stato.id_stato = Vendite.ID_STATO
 inner join regione
 on regione.ID_REGIONE = stato.ID_REGIONE
 inner join categoria
 on categoria.ID_CATEGORIA = Gioco.ID_CATEGORIA
 ;
 
 /* 3)	Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore 
 della media delle vendite realizzate nell’ultimo anno censito (ogni valore della condizione deve risultare
 da una query e non deve essere inserito a mano). Nel result set devono comparire solo 
 il codice prodotto e il totale venduto.
 */
 
 select ID_TOY as id_giocattolo
 , PREZZO_FINALE_euro as Tot_in_euro
 from sales
 where PREZZO_FINALE_euro > (
	 SELECT avg(PREZZO_FINALE_euro)
	 FROM sales 
	 where year(DATA_ORDINE) = 2024
	)
 ;
 
 -- Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 
 
 select year(DATA_ORDINE) as Anno
 , toy.NOME_TOY as Giocattolo_venduto
 , count(sales.ID_TOY) as QTA_venduta
 , sum(PREZZO_FINALE_euro) as Fatturato_in_Euro
 from sales 
 inner join toy 
 on sales.ID_TOY = toy.ID_TOY
 group by year(data_ordine), toy.NOME_TOY
 order by toy.nome_toy, year(DATA_ORDINE)
 ;
 
 -- Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.
 
 select year(data_ordine) as Anno
 , nome_stato as Stato
 , sum(PREZZO_FINALE_euro) as Fatturato_totale_in_euro
 from sales 
 inner join stato
 on sales.ID_STATO = stato.ID_STATO
 group by year(data_ordine), nome_stato
 order by year(DATA_ORDINE), Fatturato_totale_in_euro desc
 ;
 
 -- Qual è la categoria di articoli maggiormente richiesta dal mercato? (risposta sotto)
 
 select NOME_CATEGORIA as Categoria
 , count(NOME_Categoria) as Tot_Venduto_per_Categoria
 from sales
 inner join toy
 on sales.ID_TOY = toy.ID_TOY
 inner join categoria
 on toy.ID_CATEGORIA = categoria.ID_CATEGORIA
 group by NOME_CATEGORIA
 order by Tot_Venduto_per_Categoria desc 
 ;
 /* Sulla base del result set ottenuto, possiamo concludere che la CATEGORIA più richiesta dal mercato
 sia quella dei GIOCHI DELLA PRIMA INFANZIA.
 */
 
 -- Quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.
 
 -- Approccio 1: 
 select distinct NOME_TOY as Giocattolo
 , case
		when ID_ORDINE is null then 'prodotto INVENDUTO'
        else 'prodotto acquistato' end as Status
 from toy
 left join sales
 on toy.ID_TOY = sales.ID_TOY
 order by Status desc
 ;
 
-- Approccio 2:
select *
from toy
left join sales
on toy.ID_TOY = sales.ID_TOY
where sales.ID_ORDINE is null
;
 
-- Approccio 3:
select ID_TOY as ID
, NOME_TOY as Giocattolo_non_Venduto
from toy
where ID_TOY not in (
select ID_TOY
from sales
);

 /* Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” 
 delle informazioni utili (codice prodotto, nome prodotto, nome categoria).
 */
 
 -- drop view if exists AT_VW_Anagrafica_Prodotti;
 create view AT_VW_Anagrafica_Prodotti as (
 select toy.ID_TOY as ID
 , toy.NOME_TOY as Giocattolo
 , categoria.NOME_CATEGORIA as Categoria
 , toy.PREZZO_UNITA_euro as Prezzo_per_Unità
 from toy
 inner join categoria
 on toy.ID_CATEGORIA = categoria.ID_CATEGORIA
 );
 
-- Creare una vista per le informazioni geografiche.

-- drop view if exists AT_VW_Anagrafica_Geo; 
create view at_vw_Anagrafica_Geo as (
select sales.ID_ORDINE as Ordine
, toy.NOME_TOY as Prodotto_Venduto
, stato.NOME_STATO as Stato_di_Acquisto
, regione.NOME_REGIONE as Regione_di_Acquisto
from toy
left join sales
on toy.ID_TOY = sales.ID_TOY
left join stato
on sales.ID_STATO = stato.ID_STATO
left join regione
on stato.ID_REGIONE = regione.ID_REGIONE
);

-- FINE.
 
 
 

 