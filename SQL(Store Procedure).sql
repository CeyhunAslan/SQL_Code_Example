



--Stored Procedure (Sakl� Yordam)
--TSQL komutlar�n� ile haz�rlad���m�z i�lmeleri b�t�n olarka ayn� anda derlemek i�in kulland���m�z yap�lard�r. 
--Kompleks Create, Read, Update ve Delete i�lemlerinin i� mant�klar�n� ��z�mledi�imiz yap�lard�r.
--Fonksiyonlar gibi bir kez yaz�p, istedi�imiz yerde istedi�imiz kadar �a��r�p kullanabiliriz.
--�zellikle read operasyonlar�nda query'lerimiz i�in parametre getirirler. Yani parametre alan ve almayan diye ikiye ay�rabiliriz.
--Job olarak tan�mlanabilirler ve schedule edilebilinirler. Yani belirli g�n ve saatete �al��t�r�labilinirler.

--�al����analr�m�n ne kadar sat�� yapt���n� bulal�m bir nevi �al��an performans de�erlendirme


CREATE PROCEDURE sp_Cal�sanPerformans @Name nvarchar(30)
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



execute sp_Cal�sanPerformans 'Andrew'

/*Store Procedure yazmaktaki amac�m�z yukardeki gibi sutunlar� tekrar tekrar yaz�p(Employee tablosundan �d,isim Order Details tablosundan discout gibi
yada her bir �al��an i�in tekrar tekrar join yazmak) veri tekrar� yapmak yerine procedure olu�turup istenilen bilgilere uygun olan veriyi d�nd�rmektir.*/


--Emeklili�e yak�n olan �al��analr�m�n ya�lar�n� getirelim
CREATE PROCEDURE sp_Cal�sanYas @yas int
as
  begin
 select  EmployeeID,
       (FirstName + SPACE(1) + LastName),
	   DATEDIFF("YY",BirthDate,GETDATE()) as [Yas]
 from Employees
 where DATEDIFF("YY",BirthDate,GETDATE()) > @yas
 end



 execute sp_Cal�sanYas 60



 --Ad ve soyad�na g�re �al��an bilgilerini getiren sp yaz�n�z


CREATE  PROCEDURE sp_GetEmployeeByFullName @firstName nvarchar(25), @lastName nvarchar(25)
as
	begin
		select * 
		from Employees
		where FirstName = @firstName and LastName = @lastName
	end

execute sp_GetEmployeeByFullName 'Nancy', 'Davolio'






--Kullan�c�dan al�nan iki tarih aras�ndaki sipari�leri g�stemesi i�in Store Procedure yazal�m




CREATE PROCEDURE sp_Dated�f @ilktarih datetime, @sontarih datetime
as
	begin
		select OrderID,
		       OrderDate,
			   ShippedDate
		from Orders
		where OrderDate between @ilktarih and @sontarih
	end


	
	execute sp_Dated�f '01/01/1996', '12/12/1996'

