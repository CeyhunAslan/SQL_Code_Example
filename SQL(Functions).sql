

--User Defined Function
--Useru Defined Function'lar sorgu sonucunda dönen veri kümesi üzerinde kullanýlabilinirler(select ). Biz bugüne kadar sql içerisinde gömülü olarak kullanýlan 
--fonksiyonlarý kullandýk. Öenðin, DATEDIFF, Cast, Space vb. Bu fonksiyonlar sahip olduklarý parametreler aracýlýðýyla kullanýcýdan 
--gelen deðerleri karþýlamakta ve iþlemler yaparak bize bir sonuç dönmekteydiler. Örneðin en sýk kullanýdýðýmýz DATEDIFF() fonksiyonu 3 
--parametre almakta ve bize int tipinde bir sonuç dönmekteydi.UDF'ler ile biz kendi custom fonksiyonlarýmýzý yazabileceðiz.

--Fonksiyon kullanmamýzdaki amaç yapýlacak bir iþ için yazýlan tekrar kodlarýný engelemektir. Örneðin bir iþi handle etmek için 20 satýr 
--kod yazmamýz gerekiyor ve bu iþ için ayný kodlarý uygulamada 20 kez kullanmamýz gerekmektedir. Bu süreç bize 400 koda mal olmaktadýr. 
--Ama  bu süreci fonksiyon kullansaydýk bu kodlarý bir kez yazýp onu ihtiyacýmýz olan yerde çaðýrsaydýk bize daha temiz ve bakýmý, onarýmý 
--daha kolay olan kod bloklarý ile süreç daha yönetilebilir bir hale gelirdi. 


use Northwind



go
CREATE FUNCTION KDVHESAPLA(@fiyat money)             /*Fonksiyonu oluþturacaðýmýz için "Create Function" + Foksiyon ismi(Yaptýðý göreve uygun bir isim) +*/
returns money    -- geriye döndürülecek veri tipini belirtiyorum      /* (@girilecek deðer ismi + yapýlmak istelinen iþe ve  deðere uygun veri tipi )*/ 
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



--Satýþlardan elde eidlen geliri hespalarken kullandýðýmýz formülü bir fonksiyona taþýyýlam 2debir yazmayalým

go
CREATE FUNCTION SATIS(@miktar smallint, @birimfiyati money, @iskonto real)
RETURNS int
	BEGIN
		return  @miktar *  @birimfiyati * 1 - @iskonto
	END
go



select OrderID,
       SUM(DBO.SATIS(Quantity, UnitPrice, Discount)) as [SATIÞ]
from [Order Details]
group by OrderID
order by SATIÞ desc



--Tablo döndüren fonksiyonlar. 
--Hangi ürünüm ne kadardan  fazla satýþ almýþ , hangi ürün ilgi görmüþ görebileceðimiz bir tablo yaratalým
go
CREATE FUNCTION CTGRYS (@miktar int)
returns Table
	  return
	    select p.ProductName,
		      			
			   cast(sum(od.Quantity * od.UnitPrice * (1-Discount)) as decimal) [Satýs]
		from 
		Categories c join Products p
	    on c.CategoryID = p. CategoryID
		join [Order Details] od
		on od.ProductID = p.ProductID
		Group By p.ProductName
		Having sum(od.Quantity * od.UnitPrice * (1-Discount))  >= @miktar

go


select * from CTGRYS(10)--



--Kullanýcýdan alýnana kategori bilgisine göre, ilgili kategori altýndaki ürünlerin satýþýndan ne kadar gelir elde etmiþim?
go
CREATE FUNCTION GetCategoryBySold(@category_name varchar(max))
RETURNS TABLE	
	return select c.CategoryName,
				  sum(Quantity) as [Satýlan Ürün Adedi],
				  (CAST(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) as decimal)) as [Toplam Satýþ]
		   from Products p
		   join [Order Details] od on od.ProductID = p.ProductID
		   join Categories c on c.CategoryID = p.CategoryID
		   group by c.CategoryName
		   having c.CategoryName = @category_name
go

select * from GetCategoryBySold('Beverages')



--Kullanýcýdan alýnan çalýþan isim ve soyisim bilgisine göre, ilgili çalýþan ne kadar satýþ getçekleþtirmiþ

CREATE FUNCTION Soru1(@Fullname nvarchar(20))
  RETURNS TABLE 
      Return select e.FirstName,
	                
	                 Cast(SUM(od.Quantity * od.UnitPrice * (1- Discount)) as decimal) as [Satýþ] 	                   
	  from 
	  Employees e join Orders o
	  on e.EmployeeID = o.EmployeeID
	  join [Order Details] od 
	  on od.OrderID = o.OrderID
	  Group By e.FirstName
	  having e.FirstName = @Fullname
	  

select * from Soru1('Andrew')




