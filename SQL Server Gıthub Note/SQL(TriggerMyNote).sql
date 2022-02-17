/*Triger kullanýyorum çünkü ; Yapmak istediðim þey ; Bir kullanýcý sipariþ verdiðinde otomatik olarak sipariþteki ürünün adedi kadar Ürün tablosundan ürünnün stok miktarý nýn otomatik olarak azalmasýný istiyorum */

/*Create Triger yazýp triggerrimizi yaratýyoruz sonra "trg_" dedikten sonra trigger ismini giriyoruz "on" yazýp hangi tablodan iþlem yapacaksak onu veriyoruz */
/*Ardýndan DDL konusu olan insert "after insert" yani insertden sonra ne olacak*/
Create Trigger trg_InserOrder on [Order Details]
After Insert--hangi iþlemi tapacaðýmýzý belirtir--
AS 
/*Declare sql de deðiþken tanýmlarken kullandýðýmýz bir komuttur. Deðiþken tanýmlamýzýn sebebi kullanýcýnýn verdiði sipariþ hangi ürün (ürünü Id[Primary Key]'lerinden buluyoruz ürünü ) */
/*@kaçadet deðiþkeni ise kullanýcýnýn alacaðý ürününden nekadar alacaðýný yakalamamýzý saðlýyor */

 Declare  @hangiUrunId int , @kaçAdet int  

 /* Trigger çaþlýþtýðýnda arkaplanda geçici bir sanal tablo oluþturur.Burdaki "Ýnserted Sanal" tablosudur.
 Sanal Trigger Insert tablosundan yani trigger insert iþlemi yaptýðýmýz da oluþan sanal taplodan ProductId ye denk düþen ürünün stok miktarýný alacaksýn diyorum */

 select @hangiUrunId = ProductID , @kaçAdet = Quantity from inserted

 /*En sonunda güncelenecek tablonun(Products) stok miktarýný (UnitInStok)'u kulanýcýnýn girdiði 
 aded'den (@kaçAdet) çýkartýr.
 where'lede products tablosundaki tüm sutunlarý deðiþmesinin engelleyip sadece kullanýcýnýn
 sipariþ veridiði ürünü yakalasýn diye ProductID 'yý kullanýcýnýn verdiði (@hangiUrunId)'yi eþiteyerek 
 sadece kullanýcýnýn istediði ürüne müdahele ederiz*/

 Update Products
 SET UnitsInStock = UnitsInStock - @kaçAdet
 WHERE ProductID = @hangiUrunId




 --Trigger (Tetikleyiciler)
--Bir tablo üzerinde insert, update ve delete iþlemlerinden biri yapýldýktan sonra otomatik olarak devreye girmesini istediðimiz iþlemleri trigger kullanarak yerine getirebiliriz. BU iþlemler esnasýnda bize yardým olacak 2 tane sanal tablo bulunmaktadýr. Bunlar inserted ve deleted tablolarýdýr. Triger'ýn türüne ve bu kapsamda yaptýðý iþleme göre yani insert iþlemi gerçekleþtiðinde inserted sanal tablosu, deleted iþlemi gerçekleþtiðinde deleted tablosu çalýþmaktadýr. Bu tablolar triger'ýn içerisinde ki base tablolardýr. Updated iþleminde ise inserted ve deleted tablolarý birlikte çalýþmaktadýr. Yani trigger içerisinde updated gibi bir base tablo bulunmamaktadýr.

--Triger'lar iki ayrýlýrlar
--DDL (Data Definition Language) ve DML (Data Manuplation Language) olamk üzere iki ayrýlýrlar.
-- DDL ise kendi içerisinde iki ayrýlmaktadýr. Bunlar "after" ve "insted of" trigger'lardýr.
--After trigger yaptýðýmýz iþlemden sonra devreye girmektedir. (Insert, update ve delete)
--Insted of ise bir iþlem yapýlmak istendiðinde o iþlem yerine devreye giren trigger'lardýr.

--Not: After trigger'da herhangi bir tabloya insert, update ve delete iþlemleri gerçekleþtikten sonra otomatik olarka devreye girecek trigger'lar yazacaðýz.

--Bir üründen sipariþ alýnýnca, ilgili ürünün stok miktarýný düþünmemiz gerekmketedir. Her bir sipariþ alýnýdðýnda stok düþürme iþlemini ele yapmamýz saçmalýk olur. Örnðin bir e-ticaret sitedinde süratli bir þeklilde sipariþ alýndýkça ilgili ürünün stok durumu düþürülmelidir ve bunu manuel yapmamýz söz konusu deðildir. Burada tam olarak trigger devreye giremektedi. Order details tablosuna bir insert iþlemi gerçekleþtiðinde yazacaðýmýz trigger devreye girecek ve Products tablosundaki stok miktarýný sipariþin quantity bilgisine göre düþürecektir.

--Trigger'ýn yaratýlýrken hangi tabloda tetikleneceðini belirtmemiz gerekmektedir. Bu yüzden trigger create ederken çalýþacaðý tabloyu belirtiyoruz


create trigger trg_SiparisSilidi on [Order Details]
after delete
as
	Begin
		declare @kacAdet int, @hangiUrun int;
		select @hangiUrun = ProductID, @kacAdet = Quantity from deleted -- bu businnes'ta delete iþlemi gerçekleþtiðinden "deleted" sanal tablosundan faydalanýyoruz

		Update Products
		Set UnitsInStock = UnitsInStock + @kacAdet
		where ProductID = @hangiUrun
	End


	--Delete iþlemi gerçekleþirken yazdýðýmýz trigger "trg_SiparisSilidi" otomatik tetiklenecek ve Product tablsunda ProductID = 42 olan ürünün stok miktarýný tetiklenecek.
delete from [Order Details] where OrderID = 10248 and ProductID = 42



--Employees tablomuzdan bir kullanýcýyýsiliyoruz.Lakin gerçekleþecek delete iþlemi yerine bir trigger tetikleyeceðiz. Bu senaryo için ilk önce Employess tablomuza isDelete sütunu ekleyelim
alter table Employees add isDelete int --Emloyees tablosundan "isDelete" isimli "int" alanýna sahip bir sütun yarattýk.

select * from Employees

--Yukarýdaki iþlemden sonra artýk bir kullanýcý sileceðimiz zaman bu çalýþan veri tabanýndan gerçekten remove etmek yerine ilgili çalýþaný passif yada aktive çekeceðiz. Silme iþlemi yerine çalýþacak trigger yazalým.
create trigger trg_FiredEmployee on Employees
instead of delete
as
	declare @firedEmployeeId int;
	select @firedEmployeeId=EmployeeID from deleted
	update Employees set isDelete=1 where EmployeeID = @firedEmployeeId

delete from Employees where EmployeeID =4
