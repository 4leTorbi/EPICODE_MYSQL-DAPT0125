-- Esponi tutti i prodotti venduti nel 2019 considerando sia le vendite reseller che le vendite web
-- Tabelle Dimproduct, FactResellerSales, FactInternetSales + filtro anno 2019

select ProductKey as ID
, EnglishProductName as Prodotto
from dimproduct
where ProductKey in (
 select ProductKey
 from ( select ProductKey, OrderDate
		from factinternetsales
		union
		select ProductKey, OrderDate
		from factresellersales ) as Voilà
        where year(orderdate) = '2019')
		-- where orderdate between '2019-01-01' and '2019-01-31')
;



