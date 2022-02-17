--Öncelikle hangi veritabýý ile çalýþacaksan onu belirtmemiz gerekiyor
use kutuphaneyeni

-- ogrenci  tablosundan bütün verilerini Read edelim

select * from ogrenci -- buradaki kod da ogrenci  tablosuna sorgu attýðýmýzý belirtiyoruz. Ayrýca "*" sembolü bütün sütunlar anlamýna gelmektedir.

--Employees tablosundan ogrno, ad, soyad, cinsiyet ,sýnýf  sütunlarýný okuyalým--

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   sinif
from ogrenci 


--Kitap tablosundan kitapno, ad, yazarno ve puan  alanlarýný getirelim.

select kitapno,
       ad,
	   yazarno,
	   puan
from kitap

--ogrenci tablosundan ad, soyad bilgilerini getirin. Lakin dönen sonuç kümesinde ki sütun isimlerini birlþetirip isimledirelim olarak isimlen--

                                                                             /*Ýsim vermek istediðin tek kelime ise '[]' kulanýlmasýna gerek olmaz ayrýca SPACE operatörüde kullanýlabilir.*/
 select (ad +' '+ soyad) as [Full Name],                                 /* Þayet isimlendirmemiz 2 kelimeden oluþuyorsa "[]" içerisine yazmamýz gerekmektedir.*/
       cinsiyet,
	   sinif
from ogrenci

--Ýþlem tablosundan iþlemno , öðrencino, kitapno,alýþ ve veriþ tarihlerini isimlerde düzenleme yaparak getirelim--

select islemno as [transaction number],
       ogrno as [student number],
	   kitapno as [Book Number],
	   atarih as [purchase date],
	   vtarih as [date of issue]
from islem 


--Where => Sorgu sonucunda bize dönen veri kümesi üzerinde filtreleme yapmak istediðimizde kullanacaðýmýz yapýdýr.Ýstediðimiz þarta uygun olmayan verileri eler.

--Puaný 70 den büyük olan öðrencileri getirelim

select ogrno as Number,
       ad as [First Name],
	   soyad as [LastName],
	   puan
from ogrenci
where puan > 70

-- Cinsiyeti Kýz Olan öðrencileri getirelim

select ogrno as Number,
       ad as [First Name],
	   soyad as [LastName],
	   puan,
	   cinsiyet
from ogrenci
where cinsiyet = 'K'


--Puaný 50 ile 70 arasý erkek öðrencileri READ edelim
--Between iki deðer arasýnda ki verileri ayýklar
select ogrno,
       ad,
	   soyad,
	   puan
from ogrenci
where (cinsiyet = 'E') 
       and 
      (puan between 50 and 70)
	  
/*Not: "and" , "or" anahtar sözcükleri where sorgularý ile sýklýkla kullanýlmaktadýr. "and" bir aralýk kontrolü yapmak için tercih edilirken, 
"or" þartlarden herhangi birine bakar. Örneðin yaþý 60 yada 50 olan kullanýcýlar gibi. "and" ise yaþý 60 ile 50 arasýnda olanlarý getirir*/

/*ogrenci tablosundan notu  18 yada 25 olan öðrencielri  getirin*/

select ogrno as [No],
       (ad +' '+ soyad) as Öðrenci,
	   cinsiyet,
	   puan
from ogrenci
where puan between 18 and 25

/*In Operatörü=> birden fazla "or" yazacaðýmýz zaman tercih ettiðimiz yapýdýr.*/

--Puaný 39 yada 17 yada 13 olan öðrencileri listeleyiniz

select * 
from ogrenci
where puan = 13 or puan = 17 or puan = 39


select * 
from ogrenci
where puan in (13,17,39)

select * from islem


--Ýþlem tablosundaki öðrencilerin alýþ ve veriþ tarihlerini çýkartým kaç gün ödünç alýnmýþ getirelim 
--Not: iþlem tablosunda alýþ ve veriþ tarihleri bilgisi 1948-12-08 þekilnde tutulmuþ. Buradan yýl bilgisini söküp almak için SQL içerisinde gömül olarak bulunan (built-in) Year() fonksiyonunu kullanacaðýz.
--DateDiff() => Zaman hesaplarken kullanabileceðimiz bir built-in methodtur. Ýlk tarihi ikinci tarihin farkýný alýr. Ýlk baþta yazdýðýmýz deðer Cinsine göre verir(DD Gün , MM Ay, YY Yýl)

select *,
	   YEAR(atarih) as [Alýþ Tarihi],
	   YEAR(vtarih) as [Veriþ Tarihi],
	   DATEDIFF("DD",atarih,vtarih) as  [Ödünç_Alma_Süresi]
from islem

select GETDATE() -- System saatini yani bize aný teslim eder.


--Order By
--Sorgu sonucunda bizlere dönen veri kümesi üzerinde sýralma iþlemi yapmak istiyorsak
--kullanacaðýmýz yapýdýr. Order By deyiminin iki faklý yapýsý vardýr. Bunlardan birincisi 
--ascending (asc) yani verilen deðere göre azdan çoka yada a'dan z'ye sýralar. Diðer bir 
--sýralama ölçütü ise descending (desc), verilen deðere göre çoktan aza yada z'den a'ya sýralama yapar.

--Puaný 85'den büyük olan Öðrencileri, Puan bilgisine göre yüksekten aza sýralayalým.

select ogrno,
       ad,
	   soyad,
	   puan
from ogrenci
Where puan > 85
Order by puan desc

--Puaný 75'den küçük olan ERKEK öðrencileri isimlerine göre A'DAN Z'YE sýralayalým--

select ogrno,
       ad,
	   soyad,
	   puan
from ogrenci
WHERE 
(puan < 75) 
AND 
(cinsiyet = 'E')
Order BY ad ASC

-- Notu en düþük olan öðrenciyi bulalým

select Top 1 ogrno, 
	   ad,
	   soyad,
	   puan
from ogrenci
Order By puan ASC  --Not: Order by ile asc kullanmaya gerek yoktur. Çünkü order by deyiminin varsayýlan (default) deðeri "asc"dir.



--Not: Sonuç kümesi üzerinde istediðmiz kadar satýrý dönmek için TOP yapýsýný kullanýypruz. Yani TOP 1 dersem sonuç kümeisindeki birinci satýrý, TOP 5 dersem sonuç kümesindeki ilk 5 satýrý bana döner.


--Like Operatörü
--Sözel ifadeler üzerinde belirli bir harf kontrolleri yapamk için kullandýðýmýz bir yapýdýr.
--Lakin bu kontrolleri yaparken bazý özel karakterlere ihtiyaç duyulmaktaýdr.
--Sorgu sonucunda dönen veri kümesi üzeirnde filtreleme yaparkan kullanýlmaktadýr.


--Adýnýn baþ harfi 'A' ile balayan öðrencileri  getirin.

select ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like 'A%' -- baþ harfi kontrol etmek istediðimizde ifadenin sonuna yüzde iþareti koyuyoruz


--Öðrenci adýnýn son harfi "N" olan ürünleri listeleyiniz
select ad,
      soyad,
	  cinsiyet,
	  puan
from ogrenci
where ad like '%N'


--Öðrencilerin isimlerinde "E" harfi geçen Öðrencileri, a'dan z'ye sýralayýnýz

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like '%E%'
Order By ad ASC


--Adýnýn baþ harfi A, 3.harfi N olan Öðrencileri listeleyiniz

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like 'A_þ%'


--Ýçerisinde M harfi olmayan Öðrencileri listeleyiniz
--I.Yol
select * from ogrenci where ad not like '%M%'
--II.Yol
select * from ogrenci where ad like '%[^M]%'


--Aggragete Function
--Sum() => Ýçerisine parametre olarak verilen deðeri  satýr , satýr toplar

select Sum(ogrno) as [Öðrenci no'larýnýn Toplamý] from ogrenci

--Öðrencilerinin yaþlarýnýn toplamý

select 
SUM(DATEDIFF("YY", dtarih, GetDate())) as [Total Age] 
from ogrenci



--Count() => Sorgu sonucunda dönen veri kümesinin satýr sayýsýný sayar


select COUNT(*) as [Toplam Öðrenci Sayýsý] from ogrenci


--Ýsmi farklý olan  Öðrencileri getirelim


select Count(distinct ad)
from ogrenci


--Not: "distinct" anahtar sözcüðü ile count fonksiyonu içeriisnde kullanýlan parametredeki sütun içerisinde ki tekrar eden satýrlarý görmezden gelir. 
--Uyarý: Count() fonksiyonunu kullanýrken çok dikkatli olmalýyýz. Þayet Count içerisine vereceðimiz parametrede tekrar eden deðerler var ise çok yanlýþ sonuçlar elde edebiliriz. 


--Average() => Ortamayý hesaplar


--Öðrencilerin yaþlarýnýn ortalamasýný bulalým
select Avg(DATEDIFF("YY",dtarih, GETDATE())) from ogrenci


--En genç çalýþan ve En yaþlý çalýþaný bulun
select Min(DATEDIFF("YY",dtarih, GETDATE())) as [En Küçük Öðrenci],
	   MAX(DATEDIFF("YY",dtarih, GetDate())) as [En Büyük Öðrenci] from ogrenci


--Group By: Sorgu sonucunda dönen veri kümesi üzerinde gruplama iþlemleri yapmka için kullanýlýr. 
--Aggregate function kullanýldýðýnda select alaýnda birdan fazla sütun varsa sorgu sonucunda bu sütunlardan herhangi birine göre gruplama yapmak gerekmektedir. 
--Burada ki düþünce mantýðýmýzý þöylede kurabiliriz. Group by kullandýðýmda verdiðim parametreyi select alanýnda da kullanmalýyým.



--Her bir Öðrencinin ne kadar Puan aldýðýný öðrenelim ? (Her Öðrenciyi tutarýna göre gruplayýnýz)
select ogrno,
	   Sum(puan) as [Not] -- burada aggregate function her bir ÖðrenciNo  için çalýþacak
from ogrenci
group by ogrno
order by [Not] desc



--Cinsiyeti Erkek olanlar veya yaþý 40'tan büyük olanlarýn, NO, Adý, Soyadý, Doðum Tarihi ve sýnýf bilgilerini getirin

select ogrno,
       ad,
	   soyad,
	   dtarih,
	   sinif,
	    (
			Cast(YEAR(dtarih) as varchar)
			+'.'+
			Cast(MONTH(dtarih) as varchar)
			+'.'+
			Cast(DAY(dtarih) as varchar)
	   ) as [Birth Date]
from ogrenci
where (cinsiyet = 'E') or
      (dtarih > 40)


--Having
--Sorgu sonucunda dönen veri kümesi üzerinde Aggreagete Fonksiyonlara baðlý olarak filtreleme iþlemlerinde kullanýlýr.
--Þayet sorguda aggregate function yoksa where kullanýlabilinir. Aggregate function sonucunda dönen veri kümesi üzerinde 
--filtreleme için where kullanýlamaz. 

--Hangi Öðrencilerin puan ortalamalarý 70 olanlarý getirelim.

select ogrno,
	   AVG(puan) as [Ort. Not]
from ogrenci
group by ogrno
having Avg(puan) = 70
order by puan desc
--Not : AVG ilk defa yazmamýzýn sebebi ilk AVG' yý yazmamýzýn sebebi puan sutundan ortalama almak istememiz ver iþleme girdiði için yeni bir sutun oluþmuþ bu sutuna isim vermemiz zorunludur.
--Ýkinci AVG'yý yazmamýzýn sebebi having operatörünün filitreleme yapmasý için böylelikle having iþlemden geçmiþ yeni oluþmuþ sutunumuzu filitreler 