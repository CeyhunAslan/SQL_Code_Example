

--User Defined Function
--Useru Defined Function'lar sorgu sonucunda d�nen veri k�mesi �zerinde kullan�labilinirler(select ). Biz bug�ne kadar sql i�erisinde g�m�l� olarak kullan�lan 
--fonksiyonlar� kulland�k. �en�in, DATEDIFF, Cast, Space vb. Bu fonksiyonlar sahip olduklar� parametreler arac�l���yla kullan�c�dan 
--gelen de�erleri kar��lamakta ve i�lemler yaparak bize bir sonu� d�nmekteydiler. �rne�in en s�k kullan�d���m�z DATEDIFF() fonksiyonu 3 
--parametre almakta ve bize int tipinde bir sonu� d�nmekteydi.UDF'ler ile biz kendi custom fonksiyonlar�m�z� yazabilece�iz.

--Fonksiyon kullanmam�zdaki ama� yap�lacak bir i� i�in yaz�lan tekrar kodlar�n� engelemektir. �rne�in bir i�i handle etmek i�in 20 sat�r 
--kod yazmam�z gerekiyor ve bu i� i�in ayn� kodlar� uygulamada 20 kez kullanmam�z gerekmektedir. Bu s�re� bize 400 koda mal olmaktad�r. 
--Ama  bu s�reci fonksiyon kullansayd�k bu kodlar� bir kez yaz�p onu ihtiyac�m�z olan yerde �a��rsayd�k bize daha temiz ve bak�m�, onar�m� 
--daha kolay olan kod bloklar� ile s�re� daha y�netilebilir bir hale gelirdi. 


use Northwind



go
CREATE FUNCTION KDVHESAPLA(@fiyat money)             /*Fonksiyonu olu�turaca��m�z i�in "Create Function" + Foksiyon ismi(Yapt��� g�reve uygun bir isim) +*/
returns money    -- geriye d�nd�r�lecek veri tipini belirtiyorum      /* (@girilecek de�er ismi + yap�lmak istelinen i�e ve  de�ere uygun veri tipi )*/ 
	begin
		return @fiyat * 1.08
	end
go

select ProductName,
       CategoryName,
	   UnitPrice,
	   dbo.KDVHESAPLA(UnitPrice) as [KDV'Li Tutar]
from Products p
join Categories c on p.CategoryID = c.CategoryID



--Sat��lardan elde eidlen geliri hespalarken kulland���m�z form�l� bir fonksiyona ta��y�lam 2debir yazmayal�m

go
CREATE FUNCTION SATIS(@miktar smallint, @birimfiyati money, @iskonto real)
RETURNS int
	BEGIN
		return  @miktar *  @birimfiyati * 1 - @iskonto
	END
go



select OrderID,
       SUM(DBO.SATIS(Quantity, UnitPrice, Discount)) as [SATI�]
from [Order Details]
group by OrderID
order by SATI� desc



--Tablo d�nd�ren fonksiyonlar. 
--Hangi �r�n�m ne kadardan  fazla sat�� alm�� , hangi �r�n ilgi g�rm�� g�rebilece�imiz bir tablo yaratal�m
go
CREATE FUNCTION CTGRYS (@miktar int)
returns Table
	  return
	    select p.ProductName,
		      			
			   cast(sum(od.Quantity * od.UnitPrice * (1-Discount)) as decimal) [Sat�s]
		from 
		Categories c join Products p
	    on c.CategoryID = p. CategoryID
		join [Order Details] od
		on od.ProductID = p.ProductID
		Group By p.ProductName
		Having sum(od.Quantity * od.UnitPrice * (1-Discount))  >= @miktar

go


select * from CTGRYS(10)--



--Kullan�c�dan al�nana kategori bilgisine g�re, ilgili kategori alt�ndaki �r�nlerin sat���ndan ne kadar gelir elde etmi�im?
go
CREATE FUNCTION GetCategoryBySold(@category_name varchar(max))
RETURNS TABLE	
	return select c.CategoryName,
				  sum(Quantity) as [Sat�lan �r�n Adedi],
				  (CAST(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) as decimal)) as [Toplam Sat��]
		   from Products p
		   join [Order Details] od on od.ProductID = p.ProductID
		   join Categories c on c.CategoryID = p.CategoryID
		   group by c.CategoryName
		   having c.CategoryName = @category_name
go

select * from GetCategoryBySold('Beverages')



--Kullan�c�dan al�nan �al��an isim ve soyisim bilgisine g�re, ilgili �al��an ne kadar sat�� get�ekle�tirmi�

CREATE FUNCTION Soru1(@Fullname nvarchar(20))
  RETURNS TABLE 
      Return select e.FirstName,
	                
	                 Cast(SUM(od.Quantity * od.UnitPrice * (1- Discount)) as decimal) as [Sat��] 	                   
	  from 
	  Employees e join Orders o
	  on e.EmployeeID = o.EmployeeID
	  join [Order Details] od 
	  on od.OrderID = o.OrderID
	  Group By e.FirstName
	  having e.FirstName = @Fullname
	  

select * from Soru1('Andrew')




