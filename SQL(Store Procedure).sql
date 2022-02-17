



--Stored Procedure (Saklý Yordam)
--TSQL komutlarýný ile hazýrladýðýmýz iþlmeleri bütün olarka ayný anda derlemek için kullandýðýmýz yapýlardýr. 
--Kompleks Create, Read, Update ve Delete iþlemlerinin iþ mantýklarýný çözümlediðimiz yapýlardýr.
--Fonksiyonlar gibi bir kez yazýp, istediðimiz yerde istediðimiz kadar çaðýrýp kullanabiliriz.
--Özellikle read operasyonlarýnda query'lerimiz için parametre getirirler. Yani parametre alan ve almayan diye ikiye ayýrabiliriz.
--Job olarak tanýmlanabilirler ve schedule edilebilinirler. Yani belirli gün ve saatete çalýþtýrýlabilinirler.

--Çalýþýþanalrýmýn ne kadar satýþ yaptýðýný bulalým bir nevi çalýþan performans deðerlendirme


CREATE PROCEDURE sp_CalýsanPerformans @Name nvarchar(30)
as 
select e.EmployeeID ,
       (e.FirstName + SPACE(1) + e.LastName) as [Full Name],
	   cast(SUM(od.Quantity * od.UnitPrice * (1-od.Discount)) as decimal ) as [Gelir]
from 
Employees e join Orders o
on o.EmployeeID = e.EmployeeID
join [Order Details] od 
on od.OrderID = o.OrderID
where e.FirstName = @Name
group By e.EmployeeID, e.FirstName+SPACE(1)+e.LastName



execute sp_CalýsanPerformans 'Andrew'

/*Store Procedure yazmaktaki amacýmýz yukardeki gibi sutunlarý tekrar tekrar yazýp(Employee tablosundan ýd,isim Order Details tablosundan discout gibi
yada her bir çalýþan için tekrar tekrar join yazmak) veri tekrarý yapmak yerine procedure oluþturup istenilen bilgilere uygun olan veriyi döndürmektir.*/


--Emekliliðe yakýn olan çalýþanalrýmýn yaþlarýný getirelim
CREATE PROCEDURE sp_CalýsanYas @yas int
as
  begin
 select  EmployeeID,
       (FirstName + SPACE(1) + LastName),
	   DATEDIFF("YY",BirthDate,GETDATE()) as [Yas]
 from Employees
 where DATEDIFF("YY",BirthDate,GETDATE()) > @yas
 end



 execute sp_CalýsanYas 60



 --Ad ve soyadýna göre çalýþan bilgilerini getiren sp yazýnýz


CREATE  PROCEDURE sp_GetEmployeeByFullName @firstName nvarchar(25), @lastName nvarchar(25)
as
	begin
		select * 
		from Employees
		where FirstName = @firstName and LastName = @lastName
	end

execute sp_GetEmployeeByFullName 'Nancy', 'Davolio'






--Kullanýcýdan alýnan iki tarih arasýndaki sipariþleri göstemesi için Store Procedure yazalým




CREATE PROCEDURE sp_Datedýf @ilktarih datetime, @sontarih datetime
as
	begin
		select OrderID,
		       OrderDate,
			   ShippedDate
		from Orders
		where OrderDate between @ilktarih and @sontarih
	end


	
	execute sp_Datedýf '01/01/1996', '12/12/1996'

