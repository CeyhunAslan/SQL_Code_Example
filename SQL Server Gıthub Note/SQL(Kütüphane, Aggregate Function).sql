--�ncelikle hangi veritab�� ile �al��acaksan onu belirtmemiz gerekiyor
use kutuphaneyeni

-- ogrenci  tablosundan b�t�n verilerini Read edelim

select * from ogrenci -- buradaki kod da ogrenci  tablosuna sorgu att���m�z� belirtiyoruz. Ayr�ca "*" sembol� b�t�n s�tunlar anlam�na gelmektedir.

--Employees tablosundan ogrno, ad, soyad, cinsiyet ,s�n�f  s�tunlar�n� okuyal�m--

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   sinif
from ogrenci 


--Kitap tablosundan kitapno, ad, yazarno ve puan  alanlar�n� getirelim.

select kitapno,
       ad,
	   yazarno,
	   puan
from kitap

--ogrenci tablosundan ad, soyad bilgilerini getirin. Lakin d�nen sonu� k�mesinde ki s�tun isimlerini birl�etirip isimledirelim olarak isimlen--

                                                                             /*�sim vermek istedi�in tek kelime ise '[]' kulan�lmas�na gerek olmaz ayr�ca SPACE operat�r�de kullan�labilir.*/
 select (ad +' '+ soyad) as [Full Name],                                 /* �ayet isimlendirmemiz 2 kelimeden olu�uyorsa "[]" i�erisine yazmam�z gerekmektedir.*/
       cinsiyet,
	   sinif
from ogrenci

--��lem tablosundan i�lemno , ��rencino, kitapno,al�� ve veri� tarihlerini isimlerde d�zenleme yaparak getirelim--

select islemno as [transaction number],
       ogrno as [student number],
	   kitapno as [Book Number],
	   atarih as [purchase date],
	   vtarih as [date of issue]
from islem 


--Where => Sorgu sonucunda bize d�nen veri k�mesi �zerinde filtreleme yapmak istedi�imizde kullanaca��m�z yap�d�r.�stedi�imiz �arta uygun olmayan verileri eler.

--Puan� 70 den b�y�k olan ��rencileri getirelim

select ogrno as Number,
       ad as [First Name],
	   soyad as [LastName],
	   puan
from ogrenci
where puan > 70

-- Cinsiyeti K�z Olan ��rencileri getirelim

select ogrno as Number,
       ad as [First Name],
	   soyad as [LastName],
	   puan,
	   cinsiyet
from ogrenci
where cinsiyet = 'K'


--Puan� 50 ile 70 aras� erkek ��rencileri READ edelim
--Between iki de�er aras�nda ki verileri ay�klar
select ogrno,
       ad,
	   soyad,
	   puan
from ogrenci
where (cinsiyet = 'E') 
       and 
      (puan between 50 and 70)
	  
/*Not: "and" , "or" anahtar s�zc�kleri where sorgular� ile s�kl�kla kullan�lmaktad�r. "and" bir aral�k kontrol� yapmak i�in tercih edilirken, 
"or" �artlarden herhangi birine bakar. �rne�in ya�� 60 yada 50 olan kullan�c�lar gibi. "and" ise ya�� 60 ile 50 aras�nda olanlar� getirir*/

/*ogrenci tablosundan notu  18 yada 25 olan ��rencielri  getirin*/

select ogrno as [No],
       (ad +' '+ soyad) as ��renci,
	   cinsiyet,
	   puan
from ogrenci
where puan between 18 and 25

/*In Operat�r�=> birden fazla "or" yazaca��m�z zaman tercih etti�imiz yap�d�r.*/

--Puan� 39 yada 17 yada 13 olan ��rencileri listeleyiniz

select * 
from ogrenci
where puan = 13 or puan = 17 or puan = 39


select * 
from ogrenci
where puan in (13,17,39)

select * from islem


--��lem tablosundaki ��rencilerin al�� ve veri� tarihlerini ��kart�m ka� g�n �d�n� al�nm�� getirelim 
--Not: i�lem tablosunda al�� ve veri� tarihleri bilgisi 1948-12-08 �ekilnde tutulmu�. Buradan y�l bilgisini s�k�p almak i�in SQL i�erisinde g�m�l olarak bulunan (built-in) Year() fonksiyonunu kullanaca��z.
--DateDiff() => Zaman hesaplarken kullanabilece�imiz bir built-in methodtur. �lk tarihi ikinci tarihin fark�n� al�r. �lk ba�ta yazd���m�z de�er Cinsine g�re verir(DD G�n , MM Ay, YY Y�l)

select *,
	   YEAR(atarih) as [Al�� Tarihi],
	   YEAR(vtarih) as [Veri� Tarihi],
	   DATEDIFF("DD",atarih,vtarih) as  [�d�n�_Alma_S�resi]
from islem

select GETDATE() -- System saatini yani bize an� teslim eder.


--Order By
--Sorgu sonucunda bizlere d�nen veri k�mesi �zerinde s�ralma i�lemi yapmak istiyorsak
--kullanaca��m�z yap�d�r. Order By deyiminin iki fakl� yap�s� vard�r. Bunlardan birincisi 
--ascending (asc) yani verilen de�ere g�re azdan �oka yada a'dan z'ye s�ralar. Di�er bir 
--s�ralama �l��t� ise descending (desc), verilen de�ere g�re �oktan aza yada z'den a'ya s�ralama yapar.

--Puan� 85'den b�y�k olan ��rencileri, Puan bilgisine g�re y�ksekten aza s�ralayal�m.

select ogrno,
       ad,
	   soyad,
	   puan
from ogrenci
Where puan > 85
Order by puan desc

--Puan� 75'den k���k olan ERKEK ��rencileri isimlerine g�re A'DAN Z'YE s�ralayal�m--

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

-- Notu en d���k olan ��renciyi bulal�m

select Top 1 ogrno, 
	   ad,
	   soyad,
	   puan
from ogrenci
Order By puan ASC  --Not: Order by ile asc kullanmaya gerek yoktur. ��nk� order by deyiminin varsay�lan (default) de�eri "asc"dir.



--Not: Sonu� k�mesi �zerinde istedi�miz kadar sat�r� d�nmek i�in TOP yap�s�n� kullan�ypruz. Yani TOP 1 dersem sonu� k�meisindeki birinci sat�r�, TOP 5 dersem sonu� k�mesindeki ilk 5 sat�r� bana d�ner.


--Like Operat�r�
--S�zel ifadeler �zerinde belirli bir harf kontrolleri yapamk i�in kulland���m�z bir yap�d�r.
--Lakin bu kontrolleri yaparken baz� �zel karakterlere ihtiya� duyulmakta�dr.
--Sorgu sonucunda d�nen veri k�mesi �zeirnde filtreleme yaparkan kullan�lmaktad�r.


--Ad�n�n ba� harfi 'A' ile balayan ��rencileri  getirin.

select ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like 'A%' -- ba� harfi kontrol etmek istedi�imizde ifadenin sonuna y�zde i�areti koyuyoruz


--��renci ad�n�n son harfi "N" olan �r�nleri listeleyiniz
select ad,
      soyad,
	  cinsiyet,
	  puan
from ogrenci
where ad like '%N'


--��rencilerin isimlerinde "E" harfi ge�en ��rencileri, a'dan z'ye s�ralay�n�z

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like '%E%'
Order By ad ASC


--Ad�n�n ba� harfi A, 3.harfi N olan ��rencileri listeleyiniz

select ogrno,
       ad,
	   soyad,
	   cinsiyet,
	   puan
from ogrenci
Where ad like 'A_�%'


--��erisinde M harfi olmayan ��rencileri listeleyiniz
--I.Yol
select * from ogrenci where ad not like '%M%'
--II.Yol
select * from ogrenci where ad like '%[^M]%'


--Aggragete Function
--Sum() => ��erisine parametre olarak verilen de�eri  sat�r , sat�r toplar

select Sum(ogrno) as [��renci no'lar�n�n Toplam�] from ogrenci

--��rencilerinin ya�lar�n�n toplam�

select 
SUM(DATEDIFF("YY", dtarih, GetDate())) as [Total Age] 
from ogrenci



--Count() => Sorgu sonucunda d�nen veri k�mesinin sat�r say�s�n� sayar


select COUNT(*) as [Toplam ��renci Say�s�] from ogrenci


--�smi farkl� olan  ��rencileri getirelim


select Count(distinct ad)
from ogrenci


--Not: "distinct" anahtar s�zc��� ile count fonksiyonu i�eriisnde kullan�lan parametredeki s�tun i�erisinde ki tekrar eden sat�rlar� g�rmezden gelir. 
--Uyar�: Count() fonksiyonunu kullan�rken �ok dikkatli olmal�y�z. �ayet Count i�erisine verece�imiz parametrede tekrar eden de�erler var ise �ok yanl�� sonu�lar elde edebiliriz. 


--Average() => Ortamay� hesaplar


--��rencilerin ya�lar�n�n ortalamas�n� bulal�m
select Avg(DATEDIFF("YY",dtarih, GETDATE())) from ogrenci


--En gen� �al��an ve En ya�l� �al��an� bulun
select Min(DATEDIFF("YY",dtarih, GETDATE())) as [En K���k ��renci],
	   MAX(DATEDIFF("YY",dtarih, GetDate())) as [En B�y�k ��renci] from ogrenci


--Group By: Sorgu sonucunda d�nen veri k�mesi �zerinde gruplama i�lemleri yapmka i�in kullan�l�r. 
--Aggregate function kullan�ld���nda select ala�nda birdan fazla s�tun varsa sorgu sonucunda bu s�tunlardan herhangi birine g�re gruplama yapmak gerekmektedir. 
--Burada ki d���nce mant���m�z� ��ylede kurabiliriz. Group by kulland���mda verdi�im parametreyi select alan�nda da kullanmal�y�m.



--Her bir ��rencinin ne kadar Puan ald���n� ��renelim ? (Her ��renciyi tutar�na g�re gruplay�n�z)
select ogrno,
	   Sum(puan) as [Not] -- burada aggregate function her bir ��renciNo  i�in �al��acak
from ogrenci
group by ogrno
order by [Not] desc



--Cinsiyeti Erkek olanlar veya ya�� 40'tan b�y�k olanlar�n, NO, Ad�, Soyad�, Do�um Tarihi ve s�n�f bilgilerini getirin

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
--Sorgu sonucunda d�nen veri k�mesi �zerinde Aggreagete Fonksiyonlara ba�l� olarak filtreleme i�lemlerinde kullan�l�r.
--�ayet sorguda aggregate function yoksa where kullan�labilinir. Aggregate function sonucunda d�nen veri k�mesi �zerinde 
--filtreleme i�in where kullan�lamaz. 

--Hangi ��rencilerin puan ortalamalar� 70 olanlar� getirelim.

select ogrno,
	   AVG(puan) as [Ort. Not]
from ogrenci
group by ogrno
having Avg(puan) = 70
order by puan desc
--Not : AVG ilk defa yazmam�z�n sebebi ilk AVG' y� yazmam�z�n sebebi puan sutundan ortalama almak istememiz ver i�leme girdi�i i�in yeni bir sutun olu�mu� bu sutuna isim vermemiz zorunludur.
--�kinci AVG'y� yazmam�z�n sebebi having operat�r�n�n filitreleme yapmas� i�in b�ylelikle having i�lemden ge�mi� yeni olu�mu� sutunumuzu filitreler 