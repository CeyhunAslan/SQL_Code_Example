--DML (Data Manipulating Language)
--Veri tabanýna veri ekleme, güncelleme ve silme
-- Backend developer olarak bizim omuzlarýmýzdaki en büyük yük CRUD(Create-Read-Update-Delete) iþlemleridir.
--Bu iþlemler neredeyse bir projenin yüzde 70 lik dilimini temsil eder. Özellikle Create, Update ve Delete 
--iþlemlerinin baþarýyla yürütülmesi, bunun yanýnda Read operasyonlarýnda da performans çok önemlidir.



--Uyarý: Insert iþleminde ilgli tablonun Id sütunana biz deðer vermiyoruz. Bütün veri tabalarý bu sütuna kendisi otomatik olarak deðer verir.
-- insert iþleminde önce insret atacaðýmýz tablonun ismini daha sonra parantez içerisinde insert atýlacak sütun isimleri yazýlýr. verilecek deðerler sýrasýyla bekirtilmelidir.


--Kitap tablosuna yeni bir kitap giriþi yapalým ve Tur tablosuna kitaba uygun bir tür satýrý giriþi yapalým
insert tur (ad) values ('Fantaztik')

insert kitap(ad, sayfasayisi,puan,turno) values ('KralKatilli Güncesi', '736','100' , '20')


--Update: Güncelleme iþlemi için kullanýlýr.
Update tur 
Set 
	ad = 'Fantastik' 
where turno = 20

/*delete from tur where turno = 20*/

--Not: Update ve Delete operasyonlarýnda muhakak iþlem yapýlacak bilgi Id vb. biricik(Primary Key) alanlardan filtrelenerek uygulanmalýdýr.
--Yoksa tüm tabloya Update atar.

