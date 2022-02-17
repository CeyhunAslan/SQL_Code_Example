/*Triger kullan�yorum ��nk� ; Yapmak istedi�im �ey ; Bir kullan�c� sipari� verdi�inde otomatik olarak sipari�teki �r�n�n adedi kadar �r�n tablosundan �r�nn�n stok miktar� n�n otomatik olarak azalmas�n� istiyorum */

/*Create Triger yaz�p triggerrimizi yarat�yoruz sonra "trg_" dedikten sonra trigger ismini giriyoruz "on" yaz�p hangi tablodan i�lem yapacaksak onu veriyoruz */
/*Ard�ndan DDL konusu olan insert "after insert" yani insertden sonra ne olacak*/
Create Trigger trg_InserOrder on [Order Details]
After Insert--hangi i�lemi tapaca��m�z� belirtir--
AS 
/*Declare sql de de�i�ken tan�mlarken kulland���m�z bir komuttur. De�i�ken tan�mlam�z�n sebebi kullan�c�n�n verdi�i sipari� hangi �r�n (�r�n� Id[Primary Key]'lerinden buluyoruz �r�n� ) */
/*@ka�adet de�i�keni ise kullan�c�n�n alaca�� �r�n�nden nekadar alaca��n� yakalamam�z� sa�l�yor */

 Declare  @hangiUrunId int , @ka�Adet int  

 /* Trigger �a�l��t���nda arkaplanda ge�ici bir sanal tablo olu�turur.Burdaki "�nserted Sanal" tablosudur.
 Sanal Trigger Insert tablosundan yani trigger insert i�lemi yapt���m�z da olu�an sanal taplodan ProductId ye denk d��en �r�n�n stok miktar�n� alacaks�n diyorum */

 select @hangiUrunId = ProductID , @ka�Adet = Quantity from inserted

 /*En sonunda g�ncelenecek tablonun(Products) stok miktar�n� (UnitInStok)'u kulan�c�n�n girdi�i 
 aded'den (@ka�Adet) ��kart�r.
 where'lede products tablosundaki t�m sutunlar� de�i�mesinin engelleyip sadece kullan�c�n�n
 sipari� veridi�i �r�n� yakalas�n diye ProductID 'y� kullan�c�n�n verdi�i (@hangiUrunId)'yi e�iteyerek 
 sadece kullan�c�n�n istedi�i �r�ne m�dahele ederiz*/

 Update Products
 SET UnitsInStock = UnitsInStock - @ka�Adet
 WHERE ProductID = @hangiUrunId




 --Trigger (Tetikleyiciler)
--Bir tablo �zerinde insert, update ve delete i�lemlerinden biri yap�ld�ktan sonra otomatik olarak devreye girmesini istedi�imiz i�lemleri trigger kullanarak yerine getirebiliriz. BU i�lemler esnas�nda bize yard�m olacak 2 tane sanal tablo bulunmaktad�r. Bunlar inserted ve deleted tablolar�d�r. Triger'�n t�r�ne ve bu kapsamda yapt��� i�leme g�re yani insert i�lemi ger�ekle�ti�inde inserted sanal tablosu, deleted i�lemi ger�ekle�ti�inde deleted tablosu �al��maktad�r. Bu tablolar triger'�n i�erisinde ki base tablolard�r. Updated i�leminde ise inserted ve deleted tablolar� birlikte �al��maktad�r. Yani trigger i�erisinde updated gibi bir base tablo bulunmamaktad�r.

--Triger'lar iki ayr�l�rlar
--DDL (Data Definition Language) ve DML (Data Manuplation Language) olamk �zere iki ayr�l�rlar.
-- DDL ise kendi i�erisinde iki ayr�lmaktad�r. Bunlar "after" ve "insted of" trigger'lard�r.
--After trigger yapt���m�z i�lemden sonra devreye girmektedir. (Insert, update ve delete)
--Insted of ise bir i�lem yap�lmak istendi�inde o i�lem yerine devreye giren trigger'lard�r.

--Not: After trigger'da herhangi bir tabloya insert, update ve delete i�lemleri ger�ekle�tikten sonra otomatik olarka devreye girecek trigger'lar yazaca��z.

--Bir �r�nden sipari� al�n�nca, ilgili �r�n�n stok miktar�n� d���nmemiz gerekmketedir. Her bir sipari� al�n�d��nda stok d���rme i�lemini ele yapmam�z sa�mal�k olur. �rn�in bir e-ticaret sitedinde s�ratli bir �eklilde sipari� al�nd�k�a ilgili �r�n�n stok durumu d���r�lmelidir ve bunu manuel yapmam�z s�z konusu de�ildir. Burada tam olarak trigger devreye giremektedi. Order details tablosuna bir insert i�lemi ger�ekle�ti�inde yazaca��m�z trigger devreye girecek ve Products tablosundaki stok miktar�n� sipari�in quantity bilgisine g�re d���recektir.

--Trigger'�n yarat�l�rken hangi tabloda tetiklenece�ini belirtmemiz gerekmektedir. Bu y�zden trigger create ederken �al��aca�� tabloyu belirtiyoruz


create trigger trg_SiparisSilidi on [Order Details]
after delete
as
	Begin
		declare @kacAdet int, @hangiUrun int;
		select @hangiUrun = ProductID, @kacAdet = Quantity from deleted -- bu businnes'ta delete i�lemi ger�ekle�ti�inden "deleted" sanal tablosundan faydalan�yoruz

		Update Products
		Set UnitsInStock = UnitsInStock + @kacAdet
		where ProductID = @hangiUrun
	End


	--Delete i�lemi ger�ekle�irken yazd���m�z trigger "trg_SiparisSilidi" otomatik tetiklenecek ve Product tablsunda ProductID = 42 olan �r�n�n stok miktar�n� tetiklenecek.
delete from [Order Details] where OrderID = 10248 and ProductID = 42



--Employees tablomuzdan bir kullan�c�y�siliyoruz.Lakin ger�ekle�ecek delete i�lemi yerine bir trigger tetikleyece�iz. Bu senaryo i�in ilk �nce Employess tablomuza isDelete s�tunu ekleyelim
alter table Employees add isDelete int --Emloyees tablosundan "isDelete" isimli "int" alan�na sahip bir s�tun yaratt�k.

select * from Employees

--Yukar�daki i�lemden sonra art�k bir kullan�c� silece�imiz zaman bu �al��an veri taban�ndan ger�ekten remove etmek yerine ilgili �al��an� passif yada aktive �ekece�iz. Silme i�lemi yerine �al��acak trigger yazal�m.
create trigger trg_FiredEmployee on Employees
instead of delete
as
	declare @firedEmployeeId int;
	select @firedEmployeeId=EmployeeID from deleted
	update Employees set isDelete=1 where EmployeeID = @firedEmployeeId

delete from Employees where EmployeeID =4
