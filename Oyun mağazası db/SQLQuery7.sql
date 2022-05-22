CREATE DATABASE OYUN_MAGAZASI;

CREATE TABLE Kullanicilar(
KullaniciID int IDENTITY(1,1),
KullaniciAdi varchar(20) NOT NULL, -- varchar(100) ile deðiþ
Sifre varchar(8) , -- not null olarak ayarla
AdSoyad varchar(50) NOT NULL,
Email varchar(50) NOT NULL,  
Cinsiyet varchar(1) NOT NULL,
DogumTarihi datetime NOT NULL,--DATE ÝLE DEÐÝÞ
UyelikTarihi date NOT NULL,-- datetime ile deðiþ
Yas int NOT NULL, --gereksiz sil
Adres varchar(50) NOT NULL --text olarak deðiþ

CONSTRAINT pk_KullaniciID primary key (KullaniciID)
);

-- Kullanýcýlar tablosu diðer özellikler
ALTER TABLE Kullanicilar ALTER COLUMN KullaniciAdi varchar(100) NOT NULL;
ALTER TABLE Kullanicilar ALTER COLUMN DogumTarihi date NOT NULL;
ALTER TABLE Kullanicilar ALTER COLUMN UyelikTarihi datetime NOT NULL;
ALTER TABLE Kullanicilar ALTER COLUMN Sifre varchar(8) NOT NULL;
ALTER TABLE Kullanicilar ALTER COLUMN Adres text NOT NULL;
ALTER TABLE Kullanicilar DROP COLUMN Yas;

UPDATE Kullanicilar SET Adres='Ýstanbul'

SELECT * FROM Kullanicilar


--INSERT INTO Kullanicilar VALUES ('mulas','123','Murat Ulaþ','mulas@gmail.com','E','2000-01-01','2022-01-01 12:00:00','Ümraniye ...')
--INSERT INTO Kullanicilar VALUES ('sdemir','456','Sadýk Demir','sdemir@gmail.com','E','2001-01-01','2022-02-01 16:00:00','Maltepe ...')
--INSERT INTO Kullanicilar VALUES ('dkosali','789','Duhan Kösali','dkosali@gmail.com','E','2002-01-01','2022-02-02 13:00:00','Ataþehir ...')
--INSERT INTO Kullanicilar VALUES ('bbuyukoz','963','Bedirhan Büyüköz','bbuyukoz@gmail.com','E','1999-01-01','2022-01-26 11:00:00','Kartal ...')
--INSERT INTO Kullanicilar VALUES ('aulgu','531','Alihan Ülgü','aulgu@gmail.com','E','2005-01-01','2022-02-03 22:00:00','Karaköy...')

CREATE TABLE Musteri(
MusteriID int IDENTITY(1,1),
AdSoyad nvarchar(50) NOT NULL,
Sifre smallint NOT NULL,
);
--Musteri tablosu diðer özellikler
DELETE FROM Musteri;



CREATE TABLE Oyunlar(
OyunID int IDENTITY(1,1),
GelistiriciID int,
KategoriID int,
OyunAdi varchar(50) , --not null yap
UrunFiyati int NOT NULL,-- float ile deðiþ
OyunHakkinda text NOT NULL, 
Boyutu int NOT NULL,
Resimler image NOT NULL,


CONSTRAINT pk_OyunID primary key (OyunID)
);

-- Oyunlar tablosu diðer özellikler
ALTER TABLE Oyunlar ADD FOREIGN KEY (GelistiriciID) REFERENCES Gelistirici(GelistiriciID) ON DELETE NO ACTION
ALTER TABLE Oyunlar ADD FOREIGN KEY (KategoriID) REFERENCES Kategori(KategoriID) ON DELETE NO ACTION
ALTER TABLE Oyunlar ALTER COLUMN OyunAdi varchar(63) NOT NULL;
ALTER TABLE Oyunlar ALTER COLUMN UrunFiyati float NOT NULL;
ALTER TABLE Oyunlar DROP COLUMN Resimler;

UPDATE Oyunlar SET OyunHakkinda='...'

SELECT * FROM Oyunlar


CREATE TABLE Sepet(
SepetID int IDENTITY(1,1),
KullaniciID int,
OyunID int,
CuzdanID int,
SepetTarihi date NOT NULL,--datetime ile deðiþ
SepetToplamTutar int NOT NULL, --float ile deðiþ

CONSTRAINT pk_SepetID primary key (SepetID)
);

-- Sepet tablosu diðer özellikler
ALTER TABLE Sepet ADD FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE NO ACTION
ALTER TABLE Sepet ADD FOREIGN KEY (OyunID) REFERENCES Oyunlar(OyunID) ON DELETE NO ACTION
ALTER TABLE Sepet ADD FOREIGN KEY (CuzdanID) REFERENCES Cuzdan(CuzdanID) ON DELETE NO ACTION 
ALTER TABLE Sepet ALTER COLUMN SepetTarihi datetime NOT NULL;
ALTER TABLE Sepet ALTER COLUMN SepetToplamTutar float NOT NULL;

SELECT * FROM Sepet

CREATE TABLE Cuzdan(
CuzdanID int IDENTITY(1,1),
Bakiye float NOT NULL,
--SepetID int,
OdemeTuru tinyint NOT NULL,
OdemeOnaylandiMi bit NOT NULL,
OdemeTarihi date NOT NULL, --datetime olarak deðiþ
OnayKodu varchar(20) NOT NULL,
OdenecekTopTutar decimal(18,4) NOT NULL,
BakiyeEkle int NOT NULL,-- float olarak deðiþ


CONSTRAINT pk_CuzdanID primary key (CuzdanID)
);

-- Cuzdan tablosu diðer özellikler
--ALTER TABLE Cuzdan FOREIGN KEY (SepetID) REFERENCES Sepet(SepetID) ON DELETE NO ACTION;
ALTER TABLE Cuzdan ALTER COLUMN OdemeTarihi datetime NOT NULL;
ALTER TABLE Cuzdan ALTER COLUMN BakiyeEkle float NOT NULL;
ALTER TABLE Cuzdan ALTER COLUMN OdemeTuru varchar(10) NOT NULL;


select * from Cuzdan


CREATE TABLE SiparisDetayi(
SiparisDetayiID int IDENTITY(1,1),
KullniciAdi int,
SepetID int,
OyunID int,
Miktar int  NOT NULL,
AdetFiyati float  NOT NULL, --decimal (18,4) ile deðiþ
TopTutar decimal(18,4) NOT NULL,
DigerSiparisler nvarchar(60) NOT NULL,

CONSTRAINT pk_SiparisDetayiID primary key (SiparisDetayiID)
);

--SiparisDetayi tablosu diðer özellikler
ALTER TABLE SiparisDetayi ADD FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE NO ACTION
ALTER TABLE SiparisDetayi ADD FOREIGN KEY (SepetID) REFERENCES Sepet(SepetID) ON DELETE NO ACTION
ALTER TABLE SiparisDetayi ADD FOREIGN KEY (OyunID) REFERENCES Oyunlar(OyunID) ON DELETE NO ACTION
ALTER TABLE SiparisDetayi ALTER COLUMN AdetFiyati decimal(18,4) NOT NULL;
ALTER TABLE SiparsiDetayi DROP COLUMN DigerSiparisler;

select * from SiparisDetayi

CREATE TABLE Kutuphane(
KutuphaneID int IDENTITY(1,1),
SiparisDetayiID int,
KullaniciID int,
OyunID int

CONSTRAINT pk_KutuphaneID primary key (KutuphaneID)
);

--Kutuphane tablosu diðer özellikler
ALTER TABLE Kutuphane ADD FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE NO ACTION
ALTER TABLE Kutuphane ADD FOREIGN KEY (SiparisDetayiID) REFERENCES SiparisDetayi(SiparisDetayiID) ON DELETE NO ACTION
ALTER TABLE Kutuphane ADD FOREIGN KEY (OyunID) REFERENCES Oyunlar(OyunID) ON DELETE NO ACTION

select * from Kutuphane

CREATE TABLE Kategori(
KategoriID int IDENTITY(1,1),
KategoriBir char(10) NOT NULL,
KategoriIki char(20) NOT NULL,
KategoriUc char(30) NOT NULL,
KategoriDort char(50) NOT NULL,

CONSTRAINT pk_KategoriID primary key (KategoriID)
);

ALTER TABLE Kategori ALTER COLUMN KategoriBir varchar(50) NOT NULL;
ALTER TABLE Kategori ALTER COLUMN KategoriIki varchar(50) NOT NULL;
ALTER TABLE Kategori ALTER COLUMN KategoriUc varchar(50) NOT NULL;
ALTER TABLE Kategori DROP COLUMN KategoriDort

UPDATE Kategori SET KategoriBir='Oyunlar'

select * from Kategori

CREATE TABLE Gelistirici(
GelistiriciID int IDENTITY(1,1),
GelistiriciAdi char(50) NOT NULL, --varchar olarak deðiþ
GelistiriciHakkinda varchar(10),--text olark deðiþ
GelistiriciFirma varchar(50) NOT NULL,

CONSTRAINT pk_GelistiriciID primary key (GelistiriciID)
);

--Gelistirici tablosu diðer özellikler
ALTER TABLE Gelistirici ALTER COLUMN GelistiriciAdi varchar(50) NOT NULL;
ALTER TABLE Gelistirici ALTER COLUMN GelistiriciHakkinda text NOT NULL;
ALTER TABLE Gelistirici DROP COLUMN GelistiriciFirma;

UPDATE Gelistirici SET GelistiriciHakkinda='Oyun Firmasý'

select * from Gelistirici

CREATE TABLE Topluluk(
ToplulukID int IDENTITY(1,1),
KullaniciID int,
ToplulukAdi varchar(50), --not null olarak deðiþ
YoneticiAdi varchar(20) NOT NULL,
UyeSayisi float NOT NULL,--smallint olarak deðiþ


CONSTRAINT pk_ToplulukID primary key (ToplulukID)
);

ALTER TABLE Topluluk ADD FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE NO ACTION
ALTER TABLE Topluluk ALTER COLUMN ToplulukAdi varchar(50) NOT NULL;
ALTER TABLE Topluluk ALTER COLUMN UyeSayisi smallint NOT NULL;
ALTER TABLE Topluluk ADD ToplulukHakkinda text NOT NULL;

select * from Topluluk

UPDATE Topluluk SET ToplulukHakkinda='Oyun Topluluðu'

SELECT Oyunlar.OyunAdi,Oyunlar.UrunFiyati FROM Oyunlar
INNER JOIN Gelistirici ON Oyunlar.GelistiriciID=Gelistirici.GelistiriciID

SELECT Kullanicilar.AdSoyad,Kutuphane.OyunID FROM Kullanicilar
INNER JOIN Kutuphane ON Kullanicilar.KullaniciID=Kutuphane.KullaniciID

SELECT Kullanicilar.AdSoyad,Sepet.SepetToplamTutar FROM Kullanicilar
INNER JOIN Sepet ON Sepet.KullaniciID=Kullanicilar.KullaniciID

SELECT SiparisDetayi.KullniciAdi ,Sepet.SepetTarihi,Sepet.SepetToplamTutar FROM Sepet
INNER JOIN SiparisDetayi ON Sepet.SepetID=SiparisDetayi.SepetID

SELECT Kategori.KategoriIki,Kategori.KategoriUc,Oyunlar.OyunAdi FROM Oyunlar
INNER JOIN Kategori ON Kategori.KategoriID=Oyunlar.KategoriID

-----
SELECT Cinsiyet,MAX(DogumTarihi) as enBuyuk, MIN(DogumTarihi) as enKucuk FROM Kullanicilar
GROUP BY Cinsiyet
Order by Cinsiyet

SELECT AdSoyad,COUNT(*) FROM Kullanicilar
GROUP BY AdSoyad
ORDER BY AdSoyad

SELECT OyunAdi,COUNT(KategoriUc) FROM Oyunlar,Kategori
GROUP BY OyunAdi
ORDER BY OyunAdi



----VIEW

CREATE VIEW Oyun
AS
SELECT Oyunlar.OyunAdi,Oyunlar.UrunFiyati FROM Oyunlar
INNER JOIN Gelistirici ON Oyunlar.GelistiriciID=Gelistirici.GelistiriciID

SELECT * FROM Oyun

CREATE VIEW Kullanici
AS
SELECT Kullanicilar.AdSoyad,Kutuphane.OyunID FROM Kullanicilar
INNER JOIN Kutuphane ON Kullanicilar.KullaniciID=Kutuphane.KullaniciID

SELECT *FROM Kullanici

CREATE VIEW Sepett
AS
SELECT Kullanicilar.AdSoyad,Sepet.SepetToplamTutar FROM Kullanicilar
INNER JOIN Sepet ON Sepet.KullaniciID=Kullanicilar.KullaniciID

SELECT * FROM Sepett

CREATE VIEW DetayliSiparis
AS
SELECT SiparisDetayi.KullniciAdi ,Sepet.SepetTarihi,Sepet.SepetToplamTutar FROM Sepet
INNER JOIN SiparisDetayi ON Sepet.SepetID=SiparisDetayi.SepetID

SELECT * FROM DetayliSiparis

CREATE VIEW Kategoriler
AS
SELECT Kategori.KategoriIki,Kategori.KategoriUc,Oyunlar.OyunAdi FROM Oyunlar
INNER JOIN Kategori ON Kategori.KategoriID=Oyunlar.KategoriID

SELECT * FROM Kategoriler

-----TRANSACTION

BEGIN TRANSACTION YeniOyun
INSERT INTO Oyunlar([GelistiriciID],[KategoriID],[OyunAdi],[UrunFiyati],[OyunHakkinda],[Boyutu]) 
VALUES(1,1,'LOL',14.99,'...',20)
COMMIT;
SELECT * FROM Oyunlar
ROLLBACK;

------TRIGGER

CREATE TRIGGER Yeni
ON Gelistirici
AFTER INSERT
AS
BEGIN
	SELECT 'Yeni Gelistirici Kaydý Tamamlandý'
END
INSERT INTO Gelistirici([GelistiriciAdi],[GelistiriciHakkinda])
VALUES ('Playground Games','...')

INSERT INTO Gelistirici([GelistiriciAdi],[GelistiriciHakkinda])
VALUES ('Krafton','...')


CREATE TRIGGER Yeniii
ON Oyunlar
AFTER INSERT
AS
BEGIN
	SELECT 'Yeni Oyun Kaydý Tamamlandý'
END
INSERT INTO Oyunlar([GelistiriciID],[KategoriID],[OyunAdi],[UrunFiyati],[OyunHakkinda],[Boyutu])
VALUES (8,2,'Forza Horizon 5',26.99,'...',26)

INSERT INTO Oyunlar([GelistiriciID],[KategoriID],[OyunAdi],[UrunFiyati],[OyunHakkinda],[Boyutu])
VALUES (9,4,'PUBG',34.99,'...',30)


-----INDEX

CREATE INDEX indexx
ON Kullanicilar([KullaniciAdi],[Sifre],[AdSoyad],[Email],[Cinsiyet],[DogumTarihi],[UyelikTarihi],[Adres])

SELECT * FROM Kullanicilar
