


select distinct SOD.SalesOrderID, 
PPE.FirstName,
soh.OrderDate,
PP.Name AS Product_name, 
ppc.Name as Category_name, 
psc.Name as Subcategory_name, 
sod.OrderQty, pp.StandardCost, sod.UnitPrice, SR.name as SalesReason,
sod.LineTotal, profit = SOD.OrderQty * (SOD.UNITPRICE - PP.StandardCost),
CASE
    WHEN (SOD.OrderQty * (SOD.UNITPRICE - PP.StandardCost)) <= 400 THEN 'profitable'
    WHEN (SOD.OrderQty * (SOD.UNITPRICE - PP.StandardCost)) < 1000 THEN 'mid profitable'
    ELSE 'high profitable'
END as Price_segment,
pa.City, 
SOH.OnlineOrderFlag ,
sst.name as Country_name, SVPD.Education,
hre.Gender, hre.MaritalStatus, hre.JobTitle 
from Production.Product as PP 
INNER JOIN Production.ProductSubcategory as PSC ON PSC.ProductSubcategoryID = PP.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PPC ON PPC.ProductCategoryID = PSC.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail AS SOD ON SOD.ProductID = PP.ProductID
INNER JOIN Sales.SalesOrderHeader AS SOH ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN Sales.SalesTerritory AS SST ON SST.TerritoryID = SOH.TerritoryID
INNER JOIN Sales.SalesPerson AS SSP ON SSP.TerritoryID = SST.TerritoryID
INNER JOIN HumanResources.Employee AS HRE ON HRE.BusinessEntityID = SSP.BusinessEntityID
INNER JOIN Person.[Address] AS PA ON PA.AddressID = SOH.BillToAddressID
INNER JOIN person.person PPE on ppe.BusinessEntityID = hre.BusinessEntityID
inner join sales.SalesOrderHeaderSalesReason as SOHSR ON SOHSR.salesorderid = SOD.SalesOrderID
inner join Sales.SalesReason as SR ON SR.Salesreasonid = SOHSR.Salesreasonid
inner join sales.vpersondemographics as SVPD on SVPD.BusinessEntityID = Hre.BusinessEntityID
where SOH.onlineorderflag = 1
order by SOD.SalesOrderID