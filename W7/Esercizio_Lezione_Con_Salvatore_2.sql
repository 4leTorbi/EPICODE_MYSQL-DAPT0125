
-- Esponiamo i prodotti non venduti per i quali il campo FinishedGoodsFlag = 1.
-- Tabelle Dimproduct e FactResellerSales.

select Prodotti.ProductKey as ID
, EnglishProductName as Prodotto
, FinishedGoodsFlag as Flag
from dimproduct as Prodotti
left outer join factresellersales as Vendite
on Prodotti.ProductKey = Vendite.ProductKey
where FinishedGoodsFlag = 1
and Vendite.ProductKey is null
;
