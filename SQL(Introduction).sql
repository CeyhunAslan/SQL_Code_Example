use Northwind

select ProductID ,
       ProductName,
	   CategoryID
from Products 
where ProductID =5
/*SQL server her t�rl� veriyi(bilgiyi ) d�zenli bir �ekilde  depolay�p CREATE , DELETE , UPDATE , READ operasyonlar�n�  yapabilece�imiz birden fazla ki�iyle yetkilendirip �al��abilece�imiz bir veritaban�d�r */
select GETDATE()

/* Temel sorgu "select * from -tablo ismi-" (select i�lem ba��nda yaz�l�r * t�m tabloyu getirmek i�in from [den " dan ] o tablodan anlma�nda kullan�l�r)*/
select * from Employees

/*tablo kolonlardan ve sat�rlardan olu�ur ama biz bu kolonlar�n isimlerini �a�r� amac�na g�re de�i�tirebiliriz*/
select FirstName [isim] ,
       LastName [Soyad�],
	   Title [Unvan]
      from Employees

select (FirstName +' '+ LastName) as [full Name] from Employees

/*year metodunun i�ine getdate yazarak g�ncel tarihi elde etmi� olduk bu tarihi year (y�ll cinsinden ) �al��nlar�n do�um tarihinden ��kart�rsak ya�lar� bulmu� oluruz  */
select(FirstName +' '+LastName) as [Full Name] , 
      BirthDate as [Do�um Y�l�] ,
	  year(getdate()) - year(BirthDate) as [Ya�]
      from Employees

	  /*Where : belirli bir kolondan bilgi getirir*/

	  select ProductID ,
	  ProductName
	  from Products
	  where  ProductID = 5

	  select EmployeeID,
	         FirstName,
			 LastName,
			 BirthDate
	  from Employees
	  	  where BirthDate = 1966 /*Sor*/

		  /*and , �n ,or*/ 

	  	
select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where EmployeeID in (1,2,3)

/*between*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where EmployeeID between 1 and 2 

/*Like Karaterin ilgili kolonda olup olmad���n� sorgular*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '%a%'

/*Ba� harf arama */
select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a%'

/*a yada b harfi ile ba�layan*/
select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '[ab]%'

/*a ile ba�lay�p e ile biten*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a%e'

/*a ile ba�lay�p 4 harf�l� ismi olan*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a___'

/*�ikinci harfi n alan isimler*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '_n%'

select DATEPART(YEAR,GETDATE()) as 'y�ll'

select FirstName,
       LastName,
	   Title,
	   BirthDate,
	   year(getdate()) - year(BirthDate) as [Ya�]
from Employees where Ya� = 73 /*Ya� K�rm�z� hocaya sor*/