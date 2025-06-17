/* Esercizio_1
Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
Quali considerazioni/ragionamenti è necessario che tu faccia?
*/

select *
from dimproduct
;

select ProductKey
, count(*)
from dimproduct
group by ProductKey
having count(*) > 1
; 

/* Nelle informazione della tabella in basso a sinistra è indicato il campo
che costituisce la PK. Posso anche usare le keywords DESCRIBE o SHOW KEYS:
*/

describe dimproduct -- Mi sputa fuori i metadati della tabella Dimproduct
;
show keys from dimproduct -- Mi restituisce info sulle chiavi di Dimproduct
; 

/* Esercizio_2
Scrivi una query per verificare che la combinazione 
dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
*/

select *
from factresellersales
;

-- Faccio le stesse considerazioni fatte per la tabella Dimproduct

describe factresellersales -- Mi sputa fuori i metadati della tabella Factresellersales
;
show keys from factresellersales --  Mi restituisce info sulle chiavi di Factresellersales
;

/* Esercizio_3 
Conta il numero transazioni (SalesOrderLineNumber) 
realizzate ogni giorno a partire dal 1 Gennaio 2020.
*/

select OrderDate as Data_Ordine -- da fare vedere a Salvatore a lezione
, count(orderdate) as Tot_ordini_per_giorno
from 
(select SalesOrderNumber
, SalesOrderLineNumber
, OrderDate
from factresellersales
where OrderDate >= '2020-01-01'
union
select SalesOrderNumber
, SalesOrderLineNumber
, OrderDate
from factinternetsales
where OrderDate >= '2020-01-01') as Vendite 
group by OrderDate
;

select OrderDate -- Codice di Salvatore
, count(SalesOrderNumber)
from factresellersales as Vendite_fisiche
where OrderDate >= '2020-01-01'
group by orderdate
;

/* Esercizio_4
Calcola il fatturato totale (FactResellerSales.SalesAmount), 
la quantità totale venduta (FactResellerSales.OrderQuantity) e 
il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct)
 a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, 
 il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
 I campi in output devono essere parlanti!
 */
 
 select
 Products.ProductKey as ID
 , Products.EnglishProductName as Prodotto
 , sum(SalesAmount) as Totale_Fatturato
 , count(OrderQuantity) as Quantità_Totale_Di_Vendita
 , avg(UnitPrice) as Prezzo_Medio_Di_Vendita
 , Sales.OrderDate as Data
 from factresellersales as Sales
 inner join dimproduct as Products
 on Sales.ProductKey = Products.ProductKey
 where Sales.OrderDate >= '2020-01-01'
 group by Sales.ProductKey -- la keyword GROUP BY va sempre dopo la WHERE condition
 order by Sales.ProductKey
 ;
 
 select ProductKey as ID_Prodotto -- Stesso procedimento del codice precedente
 , sum(SalesAmount)               -- ma senza INNER JOIN 	
 , count(OrderQuantity)
 , OrderDate as Data
 from factresellersales
 where OrderDate >= '2020-01-01'
 group by ProductKey
 ;
 
 /* Esercizio_5
 Calcola il fatturato totale (FactResellerSales.SalesAmount) e
 la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory).
 Il result set deve esporre pertanto il nome della categoria prodotto, 
 il fatturato totale e la quantità totale venduta. 
 I campi in output devono essere parlanti!
 */
 
 select Categoria.EnglishProductCategoryName as Categoria
 , sum(Sales.SalesAmount) as Fatturato_totale
 , sum(Sales.OrderQuantity) as Quantità_Totale_Venduta
 from factresellersales as Sales
 inner join dimproduct as Products
 on Sales.ProductKey = Products.ProductKey
 inner join dimproductsubcategory as Sottocategoria
 on Products.ProductSubcategoryKey = Sottocategoria.ProductSubcategoryKey
 inner join dimproductcategory as Categoria 
 on Sottocategoria.ProductCategoryKey = Categoria.ProductCategoryKey
 group by Categoria.EnglishProductCategoryName
 ;
 
 /* Esercizio_6
 Calcola il fatturato totale per area città (DimGeography.City)
 realizzato a partire dal 1 Gennaio 2020. 
 Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.
 */
 
 select *
 from dimgeography
 inner join dimreseller
 on dimgeography.GeographyKey = dimreseller.GeographyKey
 inner join factresellersales
 on dimreseller.ResellerKey = factresellersales.ResellerKey
 group by City
 ;

select *
 from
 (select Geo.City as Città
 , Vendite.OrderDate as Data
 , sum(Vendite.SalesAmount) as Fatturato_Totale
 from dimgeography as Geo
 inner join dimreseller as Venditore -- Dimgeography comunica con Dimreseller
 on Geo.GeographyKey = Venditore.GeographyKey
 inner join factresellersales as Vendite -- Dimreseller comunica con factresellersales
 on Venditore.ResellerKey = Vendite.ResellerKey
 -- inner join dimproduct as Prodotti -- factresellersales comunica con dimproduct
--  on Vendite.ProductKey = Prodotti.ProductKey
 where Vendite.OrderDate >= '2020-01-01'
 group by Geo.City) as Vendite_Per_Città
 where Fatturato_Totale > 60000
 ;
 
select Geo.City as Città -- Procedimento senza l'utilizzo di subquery
 , Vendite.OrderDate as Data
 , sum(Vendite.SalesAmount) as Fatturato_Totale
 from dimgeography as Geo
 inner join dimreseller as Venditore -- Dimgeography comunica con Dimreseller
 on Geo.GeographyKey = Venditore.GeographyKey
 inner join factresellersales as Vendite -- Dimreseller comunica con factresellersales
 on Venditore.ResellerKey = Vendite.ResellerKey
 inner join dimproduct as Prodotti -- factresellersales comunica con dimproduct
 on Vendite.ProductKey = Prodotti.ProductKey
 where Vendite.OrderDate >= '2020-01-01'
 group by Geo.City
 having sum(Vendite.SalesAmount) > 60000
 ;
 