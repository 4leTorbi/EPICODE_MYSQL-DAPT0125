-- Esercizio_1
select*
from dimproduct;

-- Esercizio_2
select  ProductKey as ID_Prodotto -- seleziono le colonne della tabella DimProduct
, ProductAlternateKey as Codice_Prodotto
, EnglishProductName as Nome_Prodotto -- Alias con cui rinomino le colonne della tabella interrogata
, Color as Colore 
, StandardCost as Costo_Standard
, FinishedGoodsFlag as Prodotto_Finito
from dimproduct; -- Tabella da cui estrarre le colonne interessate

-- Esercizio_3
select  ProductKey as ID_Prodotto -- Seleziono le colonne della tabella DimProduct
, ProductAlternateKey as Codice_Prodotto
, EnglishProductName as Nome_Prodotto
, StandardCost as Costo_Standard
, FinishedGoodsFlag as Prodotto_Finito
from dimproduct -- Tabella da cui estrarre le colonne interessate
WHERE FinishedGoodsFlag = 1; -- Seleziono le righe il cui campo FinischedGoodsFlag è uguale a 1

-- Esercizio_4-5
select ProductKey as ID_Prodotto
, ProductAlternateKey as Codice_Prodotto
, EnglishProductName as Nome_Prodotto
, ListPrice as Prezzo_Listino
, StandardCost as Costo_Standard
, ListPrice - StandardCost as Markup
from dimproduct
where ProductAlternateKey like "FR%" -- Sintassi che restituisce tutte le righe i cui modelli 
or ProductAlternateKey like "BK%";   -- dei prodotti iniziano per FR o BK

-- Esercizio_6                                              
select ProductKey as ID_Prodotto
, ProductAlternateKey as Codice_Prodotto
, EnglishProductName as Nome_Prodotto
, ListPrice as Prezzo_Listino
from dimproduct
where FinishedGoodsFlag = 1 
and ListPrice between 1000 and 2000
order by ListPrice desc; -- Doppia condizione che deve verificarsi

-- Esercizio_7
select *
from dimemployee;

-- Esercizio_8
select *
from dimemployee
where SalesPersonFlag = 1;
-- order by EmployeeKey;

-- Esercizio_9
select 
SalesOrderNumber
, SalesOrderLineNumber
, OrderDate
, ProductKey
, SalesTerritoryKey
, OrderQuantity
, UnitPrice
, TotalProductCost
, SalesAmount
, SalesAmount - TotalProductCost as Markup
from factresellersales
where OrderDate > "2020-01-01"
and ProductKey in (597, 598, 477, 214) -- per elenco di item KEYWORD "in"
  






