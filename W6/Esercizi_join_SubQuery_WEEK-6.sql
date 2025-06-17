SELECT *
FROM dimproduct
-- where ProductKey is null
;

SELECT *
FROM dimproductsubcategory
;

select *
from dimproductcategory
;

-- Esercizio_1
SELECT ProductKey as ID_Prodotto
, P.EnglishProductName AS Nome_Prodotto
, SC.EnglishProductSubcategoryName as Nome_Sottocategoria
, P.ProductSubcategoryKey as ID_Sottocategoria
, SC.ProductSubcategoryKey as ID_Sottocategoria
FROM dimproduct AS P
INNER join dimproductsubcategory AS SC  -- INNER JOIN tra le tabelle Product e Subcategory usando come 
on P.ProductSubcategoryKey = SC.ProductSubcategoryKey -- campo in comune ProductSubcategoryKey
;

-- Esercizio_2
select ProductKey AS ID_Prodotto
, EnglishProductName as Nome_Prodotto
, StandardCost as Costo_Standard
, SC.ProductSubcategoryKey AS ID_Sottocategoria
, SC.EnglishProductSubcategoryName as Nome_Sottocategoria
, C.ProductCategoryKey AS ID_Categoria
, C.EnglishProductCategoryName AS Nome_Categoria
from dimproduct as P
inner join dimproductsubcategory as SC
ON P.ProductSubcategoryKey = SC.ProductSubcategoryKey
inner JOIN dimproductcategory AS C  -- Doppio INNER JOIN tra le tabelle Product, Category e Subcategory
ON SC.ProductCategoryKey = C.ProductCategoryKey -- usando per ciascun JOIN un campo chiave
;

select *
from factresellersales
-- where ProductKey is null
;

-- Esercizio_3
select distinct
P.ProductKey as ID_Prodotto
, EnglishProductName as Nome_Prodotto
, S.OrderQuantity as Quantità_Prodotto
, S.SalesAmount 
from dimproduct as P -- Tabella con i prodotti (venduti e non)
inner join factresellersales as S -- Tabella con le vendite
on P.ProductKey = S.ProductKey
order by SalesAmount
;

-- Esercizio_4
select
P.ProductKey as ID_Prodotto 
, P.EnglishProductName as Nome_Prodotto
, P.FinishedGoodsFlag 
from dimproduct as P -- Prendiamo tutte le righe di Product e le corrispondenze con quelle di Sales
left join factresellersales as S
on P.ProductKey = S.ProductKey
where P.FinishedGoodsFlag = 1 -- Prendiamo solo i prodotti finiti 
and S.SalesOrderNumber is null -- e quelli non venduti
;

-- Esercizio_5
select 
P.EnglishProductName as Nome_Prodotto
, S.*
from dimproduct as P
inner join factresellersales as S -- Elenchiamo le transazioni di vendita
on S.ProductKey = P.ProductKey
;


-- Esercizio_6
select 
P.ProductKey as ID
, P.EnglishProductName as Prodotto
, PSC.EnglishProductSubcategoryName as Sottocategoria
, PC.EnglishProductCategoryName as Categoria
, S.*
from dimproduct as P
inner join dimproductsubcategory as PSC
on P.ProductSubcategoryKey = PSC.ProductSubcategoryKey
inner join dimproductcategory as PC
on PSC.ProductCategoryKey = PC.ProductCategoryKey
inner join factresellersales as S
on P.ProductKey = S.ProductKey
-- where year (orderdate) between 2019 and 2020
;

-- Esercizio_7 
select *
from dimreseller -- E' associata a DimGeography
;

select *
from dimgeography -- Esploriamo la Tabella Dimgeography
;				  -- per vedere se ci sono altre info utili da tirare fuori per l'es.8

select *
from dimsalesterritory
;

-- Esercizio_8
select
Res.ResellerKey as ID_Venditore
, Res.ResellerName as Venditore
, Geo.GeographyKey as ID_Paese
, Geo.EnglishCountryRegionName Paese
, Geo.City as Città
from dimreseller as Res
inner join dimgeography as Geo
on Res.GeographyKey = Geo.GeographyKey
;

-- Esercizio_9
select 
Sales.SalesOrderNumber as Ordine
, Sales.SalesOrderLineNumber as Linea_Ordine
, P.EnglishProductName as Prodotto
, Cat.EnglishProductCategoryName as Categoria
, SubCat.EnglishProductSubcategoryName as Sottocategoria
, Sales.OrderDate as Data_Ordine
, Sales.UnitPrice as Prezzo 
, Sales.OrderQuantity as Quantità
, Sales.TotalProductCost as Costo_Totale
, Res.ResellerName as Venditore
, Geo.EnglishCountryRegionName as Paese
from dimproduct as P
inner join dimproductsubcategory as SubCat
on P.ProductSubcategoryKey = SubCat.ProductSubcategoryKey
inner join dimproductcategory as Cat
on SubCat.ProductCategoryKey = Cat.ProductCategoryKey
inner join factresellersales as Sales
on P.ProductKey = Sales.ProductKey
inner join dimreseller as Res
on Sales.ResellerKey = Res.ResellerKey
inner join dimgeography as Geo
on Res.GeographyKey = Geo.GeographyKey
;
