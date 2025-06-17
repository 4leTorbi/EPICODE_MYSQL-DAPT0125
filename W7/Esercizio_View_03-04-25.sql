/* Esercizio_1
Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. 
La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, 
il nome della sottocategoria associata e il nome della categoria associata.
*/

/* IMPORTANTE: BISOGNA CREARE VIEW CHE ABBIANO CAMPI IN COMUNE (PK E FK) 
DI MODO POI DA POTERLE METTERE IN COMUNICAZIONE TRA LORO IN SEDE DI BI (ES. EXCEL).
*/

 drop view if exists AT_Anagrafica_Prodotti;
create view AT_Anagrafica_Prodotti as (
select Prodotti.ProductKey as ID_Prodotto
, Prodotti.ProductAlternateKey as Codice
, Prodotti.EnglishProductName as Prodotto
, Prodotti.FinishedGoodsFlag as Flag
-- , Subcat.EnglishProductSubcategoryName as Sottocategoria
, coalesce(Subcat.EnglishProductSubcategoryName, 'N/A') as Sottocategoria -- COALESCE è come IFNULL
-- , Cat.EnglishProductCategoryName as Categoria
, coalesce(Cat.EnglishProductCategoryName, 'N/A') as Categoria
-- , StandardCost as Costo_standard
, coalesce(Prodotti.StandardCost, 'N/A') as Costo_Standard
-- , Prodotti.ListPrice as Prezzo_Di_Listino
, coalesce(Prodotti.ListPrice, 'N/A') as Prezzo_Listino
from dimproduct as Prodotti
left join dimproductsubcategory as Subcat -- LEFT JOIN perchè alcuni prodotti potrebbero non avere cat. o subcat. associate
on Prodotti.ProductSubcategoryKey = Subcat.ProductSubcategoryKey
left join dimproductcategory as Cat
on Subcat.ProductCategoryKey = Cat.ProductCategoryKey
);

select * 
from AT_anagrafica_prodotti
;

/* Esercizio_2
Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa.
La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, 
il nome della città e il nome della regione.
 */
 
-- drop view if exists AT_Anagrafica_Venditori;
 create view AT_Anagrafica_Venditori as (
 select Venditori.ResellerKey as ID_Venditore
 , Venditori.ResellerName as Venditore
 , Venditori.BusinessType as Business
 , Venditori.AddressLine1 as Indirizzo
 , Geo.City as Città
  , Geo.StateProvinceName as Provincia
 , Geo.EnglishCountryRegionName as Regione
 from dimreseller as Venditori
 left join dimgeography as Geo
 on Venditori.GeographyKey = Geo.GeographyKey
 );
 
 select *
 from AT_anagrafica_venditori
 ;
 
 /* Esercizio_3
 Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento,
 la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.
 */
 
-- drop view if exists AT_Anagrafica_Vendita;
 create view AT_Anagrafica_Vendita as (
 select SalesOrderNumber as Ordine
 , SalesOrderLineNumber as Linea_Ordine
 , Vendite.ProductKey as Prodotto_Venduto
 , ResellerKey as Venditore
 , OrderDate as Data
 , OrderQuantity as Quantità
 , StandardCost as Costo_Per_Unità
 , SalesAmount as Tot_Vendita
 /* , case when TotalProductCost is null
    then StandardCost*OrderQuantity 
	 else TotalProductCost end as Costo_Finale */
 , ifnull(totalProductCost,StandardCost*OrderQuantity) as Costo_Finale
 from factresellersales as Vendite
 inner join dimproduct as Prodotti
 on Vendite.ProductKey = Prodotti.ProductKey
 order by SalesOrderNumber, SalesOrderLineNumber
 );
 
 select *
 from AT_anagrafica_vendita
 ;
 

