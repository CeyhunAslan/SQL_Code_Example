
--Aggragete Function Example

--1952 ile 1960 yýllarý arasýnda doðan çalýþanlarýmýn adý ve soyadýný tek bir sütunda, ünvanýný ve doðum tarihini listeleyin
--Not: Employees tablosunda Birthdate bilgisi 1948-12-08 00:00:00.000 þekilnde tutulmuþ. Buradan yýl bilgisini söküp almak için SQL içerisinde gömül olarak bulunan (built-in) Year() fonksiyonunu kullanacaðýz.

select EmployeeID,
	   (FirstName+' '+LastName) as [Full Name],
	   YEAR(BirthDate) as [Birth Year],
	   Title
from Employees
where YEAR(BirthDate) between 1952 and 1960

--Yaþý 60'dan büyük olan çalýþanlarý listeleyiniz
--DateDiff() => Yaþ hesaplarken kullanabileceðimiz bir built-in methodtur. 

select (FirstName+' '+LastName) as [Full Name],
		YEAR(BirthDate) as [Birth Year],
		DATEDIFF("YY", BirthDate, GETDATE()) as Age
from Employees
where DATEDIFF("YY", BirthDate, GETDATE()) > 60
--Not: DATEDIFF() => Fonksiyonu içerisine parametre olarak verilen BirthDate ve GetDate() deðerlerinden ilk parametre olarak verdiðimiz deðere göre "YY" bilgisini alarak çýkartacak.


select GETDATE() -- System saatini yani bize aný teslim eder


--Çalýþanlarýn Id'si 2 ile 5 arasýnda olan kullanýcýlarý FirstName'lerine göre a'dan z'ye sýralayýnýz
select (FirstName+' '+LastName) as [FullName],
	   Title,
	   DATEDIFF("YY", BirthDate, GETDATE()) as Age
from Employees
where EmployeeID between 2 and 5
order by FirstName asc --Not: Order by ile asc kullanmaya gerek yoktur. Çünkü order by deyiminin varsayýlan (default) deðeri "asc"dir.


--Aggragete Function
--Sum() => Ýçerisine parametre olarak verilen deðeri toplar
select Sum(EmployeeID) as [Id'lerin Toplamý] from Employees

--Toplam stok durumu nedir?
select Sum(UnitsInStock) as [Total Stock] from Products

--Order Details tablosundan faydalanarak, sipariþlerin toplam tutarý
select Sum(Quantity * UnitPrice * (1 - Discount)) from [Order Details]

--Çalýþanlarýn yaþlarýnýn toplamý
select SUM(DATEDIFF("YY", BirthDate, GetDate())) as [Total Age] from Employees

--Count() => Sorgu sonucunda dönen veri kümesinin satýr sayýsýný sayar
select COUNT(*) as [Toplam Çalýþan Sayýsý] from Employees

--Toplamda kaç sipariþ gerçekleþtirmiþim (Order)
select COUNT(OrderId) from Orders

--Kaç farklý þehirde oturan çalýþaným var
select Count(distinct City) from Employees
--Not: "distinct" anahtar sözcüðü ile count fonksiyonu içeriisnde kullanýlan parametredeki sütun içerisinde ki tekrar eden satýrlarý görmezden gelir. 
--Uyarý: Count() fonksiyonunu kullanýrken çok dikkatli olmalýyýz. Þayet Count içerisine vereceðimiz parametrede tekrar eden deðerler var ise çok yanlýþ sonuçlar elde edebiliriz. 

--Average() => Ortamayý hesaplar

--Çalýþanlarýn yaþlarýnýn ortalamasýný bulalým
select Avg(DATEDIFF("YY", BirthDate, GETDATE())) from Employees

--Sipariþleirmden elde ettiðim gelirin ortalamasý
select Cast(Avg(Quantity * UnitPrice * (1 - Discount)) as smallmoney) from [Order Details]

--Min() & Max()
select Min(UnitsInStock) from Products
select Max(UnitsInStock) from Products

--En genç çalýþan ve En yaþlý çalýþaný bulun
select Min(DATEDIFF("YY", BirthDate, GETDATE())) as [En Küçük Çalýþan],
	   MAX(DATEDIFF("YY", BirthDate, GetDate())) as [En Büyük Çalýþan] from Employees

--Group By: Sorgu sonucunda dönen veri kümesi üzerinde gruplama iþlemleri yapmka için kullanýlýr. Aggregate function kullanýldýðýnda select alaýnda birdan fazla sütun varsa sorgu sonucunda bu sütunlardan herhangi birine göre gruplama yapmak gerekmektedir. Burada ki düþünce mantýðýmýzý þöylede kurabiliriz. Group by kullandýðýmda verdiðim parametreyi select alanýnda da kullanmalýyým.

--hangi category altýnda kaç ürünüm var
select CategoryID,
	   COUNT(*) as Adet
from Products
group by CategoryID

select ProductID, CategoryID, ProductName from Products where CategoryID = 1

--UnitPrice 35'den büyük olan kaç tane ürünüm var ve bu ürünleri Categorilerine göre gruplayýnýz
select CategoryID,
	   COUNT(*) as Adet -- burada count her bir CategoryId için çalýþacak
from Products
where UnitPrice > 35
group by CategoryID


--Her bir sipariþten ne kadar para kazanmýþým? (Her sipariþin tutarýna göre gruplayýnýz)
select OrderID,
	   Sum(Quantity * UnitPrice * (1- Discount)) as [Sipariþ Tutarý] -- burada aggregate function her bir orderýd için çalýþacak
from [Order Details]
group by OrderID
order by [Sipariþ Tutarý] desc

--Ürün baþ harfi A-K aralýðýnda olan, stok bilgisi 5 ile 50 arasýnda olan ürünleri kategorilerine göre gruplayýnýz. Elde edilen adet sayýsýna göre çoktan aza sýralayýnýz
select CategoryID,
	   Count(*) as Adet
from Products
where (ProductName like '[A-K]%') and 
	  (UnitsInStock between 5 and 50)
group by CategoryID
order by Adet Desc

select CategoryID,
	   Count(*) as Adet
from Products
where (ProductName between 'A%' and 'K%') and 
	  (UnitsInStock between 5 and 50)
group by CategoryID
order by Adet Desc

--Ingilterede oturan kadýnlarýn, adý , soyadý birleþtirerek, ünvaný, ülkesi, doðum tarihini listeliyinz
select EmployeeID,
       (FirstName+SPACE(1)+LastName) as [Full Name],
	   Title,
	   TitleOfCourtesy
from Employees
where (Country = 'UK')
and
(TitleOfCourtesy = 'Mrs.' or TitleOfCourtesy = 'Ms.')
and 
(FirstName like 'A%')

--Unvaný Mr. olanlar veya yaþý 60'tan büyük olanlarýn, Id, Adý, Soyadý, Doðum Tarihi, ünvaný bilgilerini getirin
select (TitleOfCourtesy+SPACE(1)+FirstName+SPACE(1)+LastName) as [Full Name],
	   (
			Cast(YEAR(BirthDate) as varchar)
			+'.'+
			Cast(MONTH(BirthDate) as varchar)
			+'.'+
			Cast(DAY(BirthDate) as varchar)
	   ) as [Birth Date]
from Employees
where (TitleOfCourtesy = 'Mr.')
or
(DATEDIFF("YY", BirthDate, GETDATE()) > 60)

--Region bilgisi olmayan çalýþanlarý listeleyin
select * from Employees where Region is null

--Alfabetik olarak Janet ve Robert arasýnda olan çalýþaçanlarý listeleyin
select FirstName,
	   LastName
from Employees
where FirstName between 'Janet' and 'Robert'
order by FirstName

--Fosil olan çalýþalý bulalým
select Top 1 FirstName+SPACE(1)+LastName as [Full Name],
	   YEAR(BirthDate) as Age
from Employees
order by Age asc

--Hangi ülkede kaç çalýþalým var
select Country,
	   COUNT(*) as [Employee Count]
from Employees
--where Country is not null -- çalýþtýðýmýz tabloda null alanlar varsa muhakak bu where mantýðýda düþünülmelidir
group by Country

--Having
--Sorgu sonucunda dönen veri kümesi üzerinde Aggreagete Fonksiyonlara baðlý olarak filtreleme iþlemlerinde kullanýlýr. Þayet sorguda aggregate function yoksa where kullanýlabilinir. Aggregate function sonucunda dönen veri kümesi üzerinde filtreleme için where kullanýlamaz. 

--Hangi category altýndaki ürünlerin stok miktarýlarý 400'ün altýndadýr
select CategoryID,
	   Sum(UnitsInStock) as [Stock]
from Products
group by CategoryID
having Sum(UnitsInStock) < 400
order by Stock desc

--Her bir sipariþteki toplam ürün sayýsý 200 üzerinde olan sipariþleri listeleyiniz
select OrderID,
       Sum(Quantity) as [Total Product]
from [Order Details]
group by OrderID
having Sum(Quantity) > 200
order by [Total Product] desc

--Toplam Tutarý 2500 ile 3500 arasýnda olan siparileri sýralayalým
select OrderID,
	   Cast(Sum(Quantity * UnitPrice * (1 - Discount)) as decimal) as [Total Income]
from [Order Details]
group by OrderID
having Sum(Quantity * UnitPrice * (1 - Discount)) between 2500 and 3500
order by 2 desc
