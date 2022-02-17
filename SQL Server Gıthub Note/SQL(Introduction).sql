use Northwind

select ProductID ,
       ProductName,
	   CategoryID
from Products 
where ProductID =5
/*SQL server her türlü veriyi(bilgiyi ) düzenli bir þekilde  depolayýp CREATE , DELETE , UPDATE , READ operasyonlarýný  yapabileceðimiz birden fazla kiþiyle yetkilendirip çalýþabileceðimiz bir veritabanýdýr */
select GETDATE()

/* Temel sorgu "select * from -tablo ismi-" (select iþlem baþýnda yazýlýr * tüm tabloyu getirmek için from [den " dan ] o tablodan anlmaýnda kullanýlýr)*/
select * from Employees

/*tablo kolonlardan ve satýrlardan oluþur ama biz bu kolonlarýn isimlerini çaðrý amacýna göre deðiþtirebiliriz*/
select FirstName [isim] ,
       LastName [Soyadý],
	   Title [Unvan]
      from Employees

select (FirstName +' '+ LastName) as [full Name] from Employees

/*year metodunun içine getdate yazarak güncel tarihi elde etmiþ olduk bu tarihi year (yýll cinsinden ) çalýþnlarýn doðum tarihinden çýkartýrsak yaþlarý bulmuþ oluruz  */
select(FirstName +' '+LastName) as [Full Name] , 
      BirthDate as [Doðum Yýlý] ,
	  year(getdate()) - year(BirthDate) as [Yaþ]
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

		  /*and , ýn ,or*/ 

	  	
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

/*Like Karaterin ilgili kolonda olup olmadýðýný sorgular*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '%a%'

/*Baþ harf arama */
select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a%'

/*a yada b harfi ile baþlayan*/
select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '[ab]%'

/*a ile baþlayýp e ile biten*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a%e'

/*a ile baþlayýp 4 harfýlý ismi olan*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like 'a___'

/*Ýikinci harfi n alan isimler*/

select EmployeeID,
       FirstName,
	   LastName,
	   Title
from Employees 
where FirstName like '_n%'

select DATEPART(YEAR,GETDATE()) as 'yýll'

select FirstName,
       LastName,
	   Title,
	   BirthDate,
	   year(getdate()) - year(BirthDate) as [Yaþ]
from Employees where Yaþ = 73 /*Yaþ Kýrmýzý hocaya sor*/