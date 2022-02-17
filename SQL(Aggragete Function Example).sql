
--Aggragete Function Example

--1952 ile 1960 y�llar� aras�nda do�an �al��anlar�m�n ad� ve soyad�n� tek bir s�tunda, �nvan�n� ve do�um tarihini listeleyin
--Not: Employees tablosunda Birthdate bilgisi 1948-12-08 00:00:00.000 �ekilnde tutulmu�. Buradan y�l bilgisini s�k�p almak i�in SQL i�erisinde g�m�l olarak bulunan (built-in) Year() fonksiyonunu kullanaca��z.

select EmployeeID,
	   (FirstName+' '+LastName) as [Full Name],
	   YEAR(BirthDate) as [Birth Year],
	   Title
from Employees
where YEAR(BirthDate) between 1952 and 1960

--Ya�� 60'dan b�y�k olan �al��anlar� listeleyiniz
--DateDiff() => Ya� hesaplarken kullanabilece�imiz bir built-in methodtur. 

select (FirstName+' '+LastName) as [Full Name],
		YEAR(BirthDate) as [Birth Year],
		DATEDIFF("YY", BirthDate, GETDATE()) as Age
from Employees
where DATEDIFF("YY", BirthDate, GETDATE()) > 60
--Not: DATEDIFF() => Fonksiyonu i�erisine parametre olarak verilen BirthDate ve GetDate() de�erlerinden ilk parametre olarak verdi�imiz de�ere g�re "YY" bilgisini alarak ��kartacak.


select GETDATE() -- System saatini yani bize an� teslim eder


--�al��anlar�n Id'si 2 ile 5 aras�nda olan kullan�c�lar� FirstName'lerine g�re a'dan z'ye s�ralay�n�z
select (FirstName+' '+LastName) as [FullName],
	   Title,
	   DATEDIFF("YY", BirthDate, GETDATE()) as Age
from Employees
where EmployeeID between 2 and 5
order by FirstName asc --Not: Order by ile asc kullanmaya gerek yoktur. ��nk� order by deyiminin varsay�lan (default) de�eri "asc"dir.


--Aggragete Function
--Sum() => ��erisine parametre olarak verilen de�eri toplar
select Sum(EmployeeID) as [Id'lerin Toplam�] from Employees

--Toplam stok durumu nedir?
select Sum(UnitsInStock) as [Total Stock] from Products

--Order Details tablosundan faydalanarak, sipari�lerin toplam tutar�
select Sum(Quantity * UnitPrice * (1 - Discount)) from [Order Details]

--�al��anlar�n ya�lar�n�n toplam�
select SUM(DATEDIFF("YY", BirthDate, GetDate())) as [Total Age] from Employees

--Count() => Sorgu sonucunda d�nen veri k�mesinin sat�r say�s�n� sayar
select COUNT(*) as [Toplam �al��an Say�s�] from Employees

--Toplamda ka� sipari� ger�ekle�tirmi�im (Order)
select COUNT(OrderId) from Orders

--Ka� farkl� �ehirde oturan �al��an�m var
select Count(distinct City) from Employees
--Not: "distinct" anahtar s�zc��� ile count fonksiyonu i�eriisnde kullan�lan parametredeki s�tun i�erisinde ki tekrar eden sat�rlar� g�rmezden gelir. 
--Uyar�: Count() fonksiyonunu kullan�rken �ok dikkatli olmal�y�z. �ayet Count i�erisine verece�imiz parametrede tekrar eden de�erler var ise �ok yanl�� sonu�lar elde edebiliriz. 

--Average() => Ortamay� hesaplar

--�al��anlar�n ya�lar�n�n ortalamas�n� bulal�m
select Avg(DATEDIFF("YY", BirthDate, GETDATE())) from Employees

--Sipari�leirmden elde etti�im gelirin ortalamas�
select Cast(Avg(Quantity * UnitPrice * (1 - Discount)) as smallmoney) from [Order Details]

--Min() & Max()
select Min(UnitsInStock) from Products
select Max(UnitsInStock) from Products

--En gen� �al��an ve En ya�l� �al��an� bulun
select Min(DATEDIFF("YY", BirthDate, GETDATE())) as [En K���k �al��an],
	   MAX(DATEDIFF("YY", BirthDate, GetDate())) as [En B�y�k �al��an] from Employees

--Group By: Sorgu sonucunda d�nen veri k�mesi �zerinde gruplama i�lemleri yapmka i�in kullan�l�r. Aggregate function kullan�ld���nda select ala�nda birdan fazla s�tun varsa sorgu sonucunda bu s�tunlardan herhangi birine g�re gruplama yapmak gerekmektedir. Burada ki d���nce mant���m�z� ��ylede kurabiliriz. Group by kulland���mda verdi�im parametreyi select alan�nda da kullanmal�y�m.

--hangi category alt�nda ka� �r�n�m var
select CategoryID,
	   COUNT(*) as Adet
from Products
group by CategoryID

select ProductID, CategoryID, ProductName from Products where CategoryID = 1

--UnitPrice 35'den b�y�k olan ka� tane �r�n�m var ve bu �r�nleri Categorilerine g�re gruplay�n�z
select CategoryID,
	   COUNT(*) as Adet -- burada count her bir CategoryId i�in �al��acak
from Products
where UnitPrice > 35
group by CategoryID


--Her bir sipari�ten ne kadar para kazanm���m? (Her sipari�in tutar�na g�re gruplay�n�z)
select OrderID,
	   Sum(Quantity * UnitPrice * (1- Discount)) as [Sipari� Tutar�] -- burada aggregate function her bir order�d i�in �al��acak
from [Order Details]
group by OrderID
order by [Sipari� Tutar�] desc

--�r�n ba� harfi A-K aral���nda olan, stok bilgisi 5 ile 50 aras�nda olan �r�nleri kategorilerine g�re gruplay�n�z. Elde edilen adet say�s�na g�re �oktan aza s�ralay�n�z
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

--Ingilterede oturan kad�nlar�n, ad� , soyad� birle�tirerek, �nvan�, �lkesi, do�um tarihini listeliyinz
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

--Unvan� Mr. olanlar veya ya�� 60'tan b�y�k olanlar�n, Id, Ad�, Soyad�, Do�um Tarihi, �nvan� bilgilerini getirin
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

--Region bilgisi olmayan �al��anlar� listeleyin
select * from Employees where Region is null

--Alfabetik olarak Janet ve Robert aras�nda olan �al��a�anlar� listeleyin
select FirstName,
	   LastName
from Employees
where FirstName between 'Janet' and 'Robert'
order by FirstName

--Fosil olan �al��al� bulal�m
select Top 1 FirstName+SPACE(1)+LastName as [Full Name],
	   YEAR(BirthDate) as Age
from Employees
order by Age asc

--Hangi �lkede ka� �al��al�m var
select Country,
	   COUNT(*) as [Employee Count]
from Employees
--where Country is not null -- �al��t���m�z tabloda null alanlar varsa muhakak bu where mant���da d���n�lmelidir
group by Country

--Having
--Sorgu sonucunda d�nen veri k�mesi �zerinde Aggreagete Fonksiyonlara ba�l� olarak filtreleme i�lemlerinde kullan�l�r. �ayet sorguda aggregate function yoksa where kullan�labilinir. Aggregate function sonucunda d�nen veri k�mesi �zerinde filtreleme i�in where kullan�lamaz. 

--Hangi category alt�ndaki �r�nlerin stok miktar�lar� 400'�n alt�ndad�r
select CategoryID,
	   Sum(UnitsInStock) as [Stock]
from Products
group by CategoryID
having Sum(UnitsInStock) < 400
order by Stock desc

--Her bir sipari�teki toplam �r�n say�s� 200 �zerinde olan sipari�leri listeleyiniz
select OrderID,
       Sum(Quantity) as [Total Product]
from [Order Details]
group by OrderID
having Sum(Quantity) > 200
order by [Total Product] desc

--Toplam Tutar� 2500 ile 3500 aras�nda olan siparileri s�ralayal�m
select OrderID,
	   Cast(Sum(Quantity * UnitPrice * (1 - Discount)) as decimal) as [Total Income]
from [Order Details]
group by OrderID
having Sum(Quantity * UnitPrice * (1 - Discount)) between 2500 and 3500
order by 2 desc
