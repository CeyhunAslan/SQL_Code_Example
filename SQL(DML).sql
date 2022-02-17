--DML (Data Manipulating Language)
--Veri taban�na veri ekleme, g�ncelleme ve silme
-- Backend developer olarak bizim omuzlar�m�zdaki en b�y�k y�k CRUD(Create-Read-Update-Delete) i�lemleridir.
--Bu i�lemler neredeyse bir projenin y�zde 70 lik dilimini temsil eder. �zellikle Create, Update ve Delete 
--i�lemlerinin ba�ar�yla y�r�t�lmesi, bunun yan�nda Read operasyonlar�nda da performans �ok �nemlidir.



--Uyar�: Insert i�leminde ilgli tablonun Id s�tunana biz de�er vermiyoruz. B�t�n veri tabalar� bu s�tuna kendisi otomatik olarak de�er verir.
-- insert i�leminde �nce insret ataca��m�z tablonun ismini daha sonra parantez i�erisinde insert at�lacak s�tun isimleri yaz�l�r. verilecek de�erler s�ras�yla bekirtilmelidir.


--Kitap tablosuna yeni bir kitap giri�i yapal�m ve Tur tablosuna kitaba uygun bir t�r sat�r� giri�i yapal�m
insert tur (ad) values ('Fantaztik')

insert kitap(ad, sayfasayisi,puan,turno) values ('KralKatilli G�ncesi', '736','100' , '20')


--Update: G�ncelleme i�lemi i�in kullan�l�r.
Update tur 
Set 
	ad = 'Fantastik' 
where turno = 20

/*delete from tur where turno = 20*/

--Not: Update ve Delete operasyonlar�nda muhakak i�lem yap�lacak bilgi Id vb. biricik(Primary Key) alanlardan filtrelenerek uygulanmal�d�r.
--Yoksa t�m tabloya Update atar.

