--Joins
--Birden fazla tablodan veri almamýza imkan veren bir yapýdýr. Join yaparken tablolarýn primary key ve foreign key yapýlarýndan yararlanmaktadýr. 

use Northwind


--Products ve Categories tablolarýný birleþtirmek için Categories tablosunun primary key (CategoryId), Products tablosunun foreign key (CategoryId) faydalandýk.

select p.ProductID,
       p.CategoryID  
	   ProductName,
	   CategoryName,
	   UnitsInStock,
	   UnitPrice
from 
Products p join Categories c
on p.CategoryID = c.CategoryID


/*Yukarýda yaptýðýmýz join iþlemi : "Select * from 'tablename'" 'den sonra join operatörünü çaðýrýp baðlýyacaðýmýz tabloyu 
sonrada o tablodan iliþkili olan sutunlarý belirtiriz.Tabloya p. gibi kýsaltma vermemizin sebebi join iþleminde 2 tablo ile 
çalýþtýðýmýz için benzer satýrlarý çaðýrýrken daha belirleyici olmak istememizdir.*/ 



--Suppliers tablosundan SupplierId, CompanyName, ContantName
--Products talosundan ProductId, ProductName, UnitInStock


select s.SupplierID,
       s.CompanyName,
	   s.ContactName,
	   ProductID,
	   ProductName,
	   UnitsInStock
from 
Products p join Suppliers s
on p.SupplierID = s.SupplierID



--Supplier, Product ve Category tablolarýný birleþtirelim


select c.CategoryName,
       p.ProductName,
	   p.UnitsInStock,
	   s.CompanyName	 
from 
Suppliers s join Products p
on s.SupplierID = p.SupplierID
join Categories c
on c.CategoryID = p.CategoryID
order by 1 asc --Order by 1 select den sonraki 1.(c.CategoryName) sutunu sýralar



-- Kategorilerine göre stok miktarým nedir?
select c.CategoryName,
       SUM(p.UnitsInStock) as [Stock]
from Products p
join Categories c on p.CategoryID = c.CategoryID
group by c.CategoryName
order by [Stock] desc



--Her bir çalýþan ne kadarlýk satýþ yapmýþ?
select (e.FirstName+SPACE(1)+e.LastName) as [Full Name],
       CAST(SUM(od.Quantity * od.UnitPrice * (1-od.Discount)) as decimal) as [Satýþ]
from 
Employees e join Orders o 
on e.EmployeeID = o.EmployeeID
join [Order Details] od 
on o.OrderID = od.OrderID
group by (e.FirstName+SPACE(1)+e.LastName)
order by 2 desc



--Ürünlerime göre satýþlarým nasýl?
select p.ProductName,
       Sum(od.Quantity) as [Amount],
	   CAST(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as decimal) as [Satýþ]
from
Products p join [Order Details] od 
on p.ProductID = Od.ProductID
group by p.ProductName
order by 3 desc


--Categorilerime göre satýþlarým nasýl?
select c.CategoryName,
       Sum(od.Quantity) as [Amount],
	   CAST(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as decimal) as [Satýþ]
from Categories c
join Products p on c.CategoryID = p.CategoryID
join [Order Details] od on p.ProductID = od.ProductID
group by c.CategoryName
order by 3 desc



--Hangi kargo þirketine ne kadar ödeme yapmýþým (Nakliyat Ödemesi = Freight)

select s.CompanyName,
       SUM(o.Freight) as [Nakliyat Ödemesi]
from 
Orders o join Shippers s 
on s.ShipperID = o.ShipVia
group by s.CompanyName
order by [Nakliyat Ödemesi]


--Hangi tedarikçiden aldýðým ürün den kaç adet satmýþým ne kadar gelir elde etmiþim

select s.CompanyName, 
       p.ProductName,
	   SUM(od.Quantity) as Adet,
	   Cast(Sum(od.Quantity * od.UnitPrice * (1 - od.Discount)) as decimal) as Gelir
from 
Suppliers s join Products p 
on s.SupplierID = p.SupplierID
join [Order Details] od 
on p.ProductID = od.ProductID
group by s.CompanyName, p.ProductName
order by 4 desc



--Hangi müþteri
--Hangi sipariþi vermiþ
--Hangi çalýþan almýþ
--hangi tarihte gerçekleþmiþ
--hangi kargo firmasý taþýmýþ
--hangi fiyattan alýnmýþ
--hangi kategoriye aitmiþ
--bu ürünü hangi tedarikçiden almýþým
--Ýlgili tablolarý joinleme iþlemi ile istenilen satýlarý getirelim


select o.OrderID,
       c.CompanyName,
	   e.FirstName+SPACE(1)+e.LastName as [Full Name],
	   o.OrderDate,
	   s.CompanyName,
	   p.ProductName,
	   ca.CategoryName,
	   su.CompanyName,
	   od.Quantity * od.UnitPrice * (1 - od.Discount) as Income
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join Customers c on c.CustomerID = o.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID
join Categories ca on ca.CategoryID = p.CategoryID
join Suppliers su on su.SupplierID = p.SupplierID
join Shippers s on s.ShipperID = o.ShipVia


/*Left Join , Rigth Join ve Inner Join isimlerinden anlaþýlacaðý gibi benzer 
iþlemleri soldaki tablonun tamamý ve istenilen satýlar veya sað daki tablonun tamamý */


 