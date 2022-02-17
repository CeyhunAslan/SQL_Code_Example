--Joins
--Birden fazla tablodan veri almam�za imkan veren bir yap�d�r. Join yaparken tablolar�n primary key ve foreign key yap�lar�ndan yararlanmaktad�r. 

use Northwind


--Products ve Categories tablolar�n� birle�tirmek i�in Categories tablosunun primary key (CategoryId), Products tablosunun foreign key (CategoryId) faydaland�k.

select p.ProductID,
       p.CategoryID  
	   ProductName,
	   CategoryName,
	   UnitsInStock,
	   UnitPrice
from 
Products p join Categories c
on p.CategoryID = c.CategoryID


/*Yukar�da yapt���m�z join i�lemi : "Select * from 'tablename'" 'den sonra join operat�r�n� �a��r�p ba�l�yaca��m�z tabloyu 
sonrada o tablodan ili�kili olan sutunlar� belirtiriz.Tabloya p. gibi k�saltma vermemizin sebebi join i�leminde 2 tablo ile 
�al��t���m�z i�in benzer sat�rlar� �a��r�rken daha belirleyici olmak istememizdir.*/ 



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



--Supplier, Product ve Category tablolar�n� birle�tirelim


select c.CategoryName,
       p.ProductName,
	   p.UnitsInStock,
	   s.CompanyName	 
from 
Suppliers s join Products p
on s.SupplierID = p.SupplierID
join Categories c
on c.CategoryID = p.CategoryID
order by 1 asc --Order by 1 select den sonraki 1.(c.CategoryName) sutunu s�ralar



-- Kategorilerine g�re stok miktar�m nedir?
select c.CategoryName,
       SUM(p.UnitsInStock) as [Stock]
from Products p
join Categories c on p.CategoryID = c.CategoryID
group by c.CategoryName
order by [Stock] desc



--Her bir �al��an ne kadarl�k sat�� yapm��?
select (e.FirstName+SPACE(1)+e.LastName) as [Full Name],
       CAST(SUM(od.Quantity * od.UnitPrice * (1-od.Discount)) as decimal) as [Sat��]
from 
Employees e join Orders o 
on e.EmployeeID = o.EmployeeID
join [Order Details] od 
on o.OrderID = od.OrderID
group by (e.FirstName+SPACE(1)+e.LastName)
order by 2 desc



--�r�nlerime g�re sat��lar�m nas�l?
select p.ProductName,
       Sum(od.Quantity) as [Amount],
	   CAST(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as decimal) as [Sat��]
from
Products p join [Order Details] od 
on p.ProductID = Od.ProductID
group by p.ProductName
order by 3 desc


--Categorilerime g�re sat��lar�m nas�l?
select c.CategoryName,
       Sum(od.Quantity) as [Amount],
	   CAST(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as decimal) as [Sat��]
from Categories c
join Products p on c.CategoryID = p.CategoryID
join [Order Details] od on p.ProductID = od.ProductID
group by c.CategoryName
order by 3 desc



--Hangi kargo �irketine ne kadar �deme yapm���m (Nakliyat �demesi = Freight)

select s.CompanyName,
       SUM(o.Freight) as [Nakliyat �demesi]
from 
Orders o join Shippers s 
on s.ShipperID = o.ShipVia
group by s.CompanyName
order by [Nakliyat �demesi]


--Hangi tedarik�iden ald���m �r�n den ka� adet satm���m ne kadar gelir elde etmi�im

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



--Hangi m��teri
--Hangi sipari�i vermi�
--Hangi �al��an alm��
--hangi tarihte ger�ekle�mi�
--hangi kargo firmas� ta��m��
--hangi fiyattan al�nm��
--hangi kategoriye aitmi�
--bu �r�n� hangi tedarik�iden alm���m
--�lgili tablolar� joinleme i�lemi ile istenilen sat�lar� getirelim


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


/*Left Join , Rigth Join ve Inner Join isimlerinden anla��laca�� gibi benzer 
i�lemleri soldaki tablonun tamam� ve istenilen sat�lar veya sa� daki tablonun tamam� */


 