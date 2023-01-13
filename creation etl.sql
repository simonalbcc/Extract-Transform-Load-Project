DROP TABLE IF EXISTS FactSale;
DROP TABLE IF EXISTS DimDate;
CREATE TABLE DimDate (
   DateKey datetime primary key,
   DayFrenchName nvarchar(100) not null,
   DayEnglishName nvarchar(100) not null,
   MonthFrenchName nvarchar(100) not null,
   MonthEnglishName nvarchar(100) not null,
   WeekNumber int not null,
   DayOfWeekNumber int not null,
   DayOfYearNumber int not null,
)
GO

DROP TABLE IF EXISTS DimCustomer;
CREATE TABLE DimCustomer (
   CustomerID nvarchar(100) primary key,
   CityEnglish nvarchar(100) not null,
   CityFrench nvarchar(100) not null,
   CountryEnglish nvarchar(100) not null,
   CountryFrench nvarchar(100) not null,
   CustomerCompany nvarchar(100) not null,
)
GO

DROP TABLE IF EXISTS DimProduct;
CREATE TABLE DimProduct (
   ProductID int primary key,
   ProductNameFrench nvarchar(100) not null,
   ProductNameEnglish nvarchar(100) not null,
   NameSupplier nvarchar(100) not null,
   CityEnglish nvarchar(100) not null,
   CityFrench nvarchar(100) not null,
   CountryEnglish nvarchar(100) not null,
   CountryFrench nvarchar(100) not null,
   CategoryNameEnglish nvarchar(100) not null,
   CategoryNameFrench nvarchar(100) not null,
)
GO

DROP TABLE IF EXISTS DimSalesRepresentative;
CREATE TABLE DimSalesRepresentative (
   EmployeeID int primary key,
   NameEmployee nvarchar(100) not null
)
GO

INSERT INTO DimSalesRepresentative (EmployeeID, NameEmployee) VALUES (404, 'Autres')

DROP TABLE IF EXISTS DimShipment
CREATE TABLE DimShipment (
   TechnicalID int primary key,
   ShipperID int not null,
   ShipperName nvarchar(100) not null,
   ShipCountryEnglish nvarchar(100) not null,
   ShipCountryFrench nvarchar(100) not null,
   ShipCityFrench nvarchar(100) not null,
   ShipCityEnglish nvarchar(100) not null,
)
GO

CREATE TABLE FactSale (
   TechnicalID int primary key identity(1,1),
   ProductID int not null,
   ProductNameEnglish nvarchar(100) not null,
   ProductNameFrench nvarchar(100) not null,
   CustomerID nvarchar(100) not null,
   IsOnline bit not null,
   EmployeeID int not null,
   ShipperID int not null,
   ShippedDate datetime,
   Quantity int not null,
   Price float not null,
   Freight float not null,
   OrderDate datetime not null,
   constraint customer_fk foreign key (CustomerID) references 	DimCustomer (CustomerID),
   constraint employee_fk foreign key (EmployeeID) references 	DimSalesRepresentative (EmployeeID),
   constraint shipper_fk  foreign key (ShipperID) references 	DimShipment (TechnicalID),
   constraint product_fk  foreign key (ProductID) references 	DimProduct (ProductID),
   constraint shipped_date  foreign key (ShippedDate) references 	DimDate (DateKey),
   constraint order_date    foreign key (OrderDate) references 	DimDate (DateKey),
)
GO
