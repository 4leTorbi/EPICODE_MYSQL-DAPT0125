/* Esercizio_1
Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct
 sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?
*/

select ProductKey
, count(*)
from dimproduct
group by ProductKey
having count(*) = 1
;



/* Esercizio_2
Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber
 e SalesOrderLineNumber sia una PK.
*/

select SalesOrderNumber
, SalesOrderLineNumber
, count(*)
from factresellersales
group by SalesOrderNumber, SalesOrderLineNumber
having count(*) > 1
;

/* Esercizio_3
Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
*/

 select OrderDate as Data
, count(OrderDate) as Ordini_Giornalieri
 from 
(select SalesOrderNumber 
, SalesOrderLineNumber
, OrderDate
from factresellersales 
where OrderDate >='2020-01-01'
union
select SalesOrderNumber
, SalesOrderLineNumber
, OrderDate
from factinternetsales
where OrderDate >= '2020-01-01') as Vendite
group by OrderDate
;

select SalesOrderNumber -- Righe di codice per verificare se abbiamo fatto corretto prima
, SalesOrderLineNumber
from factresellersales
where orderdate = '2020-06-09'
union
select SalesOrderNumber
, SalesOrderLineNumber
from factinternetsales
where orderdate = '2020-06-09'
;

/* Esercizio_4
Calcola il fatturato totale (FactResellerSales.SalesAmount), 
la quantità totale venduta (FactResellerSales.OrderQuantity) e 
il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct)
 a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, 
 il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
 I campi in output devono essere parlanti!
 */
 
 select Sales.ProductKey as ID
 , Products.EnglishProductName as Prodotto
 , sum(SalesAmount) as Totale_Fatturato
 , sum(OrderQuantity) as Quantità_Totale_Di_Vendita
 , avg(UnitPrice) as Prezzo_Medio_Vendita
 , sum(SalesAmount)/sum(OrderQuantity) as Rapporto_Fatturato_Vendite 
 from factresellersales as Sales
 inner join dimproduct as Products
 on Sales.ProductKey = Products.ProductKey
 where OrderDate >= '2020-01-01'
 group by EnglishProductName, Sales.ProductKey
 ;
 
 select *
 from factresellersales
 where ProductKey = 591 and OrderDate >= '2020-01-01'
 ;
 
 
 

