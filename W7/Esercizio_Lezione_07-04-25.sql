-- Esponi i ricavi totali per anno, mese e categoria prodotto.

create view VW_Vendite as(
select EnglishProductCategoryName as Categoria
, year(orderdate) as Anno
, month(orderdate) as Mese
-- , count(EnglishProductCategoryName) as Tot_Per_Categoria
, sum(SalesAmount) as Tot_Ricavi
from factresellersales as Vendite
inner join dimproduct as Prodotti
on Vendite.ProductKey = Prodotti.ProductKey
inner join dimproductsubcategory as Sottocategoria
on Prodotti.ProductSubcategoryKey = Sottocategoria.ProductSubcategoryKey
inner join dimproductcategory as Categoria
on Sottocategoria.ProductCategoryKey = Categoria.ProductCategoryKey
group by year(orderdate), month(orderdate), EnglishProductCategoryName
);
