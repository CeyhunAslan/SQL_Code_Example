use NetflixDB

Create table [dbo].[Movies]
(
  [MovieID] INT IDENTITY (1,1) NOT NULL,
      

	  [MovieName] NVARCHAR(40) NOT NULL,
	  [GenreID] INT NOT NULL,
	  [ActorID] INT NOT NULL,
	  [Vision Date] DATE NOT NULL,
	  [Access] BIT  NOT NULL, /*HOcAyA sOr BÝT*/
	 


	  CONSTRAINT [PK_MOVÝES] PRIMARY KEY CLUSTERED ([MovieID] ASC),
      /*CONSTRAINT [FK_Genres_GenreID] Foreign Key ([GenreID]) REFERENCES [dbo]. [Genres] ([GenreID]),*/
	 /* CONSTRAINT [FK_Actors_ActorID] Foreign Key ([ActorID]) REFERENCES [dbo]. [Acthors] ([ActhorID])*/

 )
 /*ALTER TABLE Movies ADD Foreign Key (GenreID) REFERENCES [dbo].[Genres] ([GenreID])*/
 




 /*Çalýþtýrmadan dahi yazým sýrasý çok önemli çünkü yazýlmamýþ veriYÝ references veremezsýn kýzrarýr:D */


go Create Table [dbo]. [Actors]
 (
   [ActorID] INT IDENTITY (1,1) NOT NULL ,
    

	 [FirstName] NVARCHAR(40) NOT NULL,
	 [LastName] NVARCHAR(40) NOT NULL,
	 [City] NVARCHAR(20) NOT NULL,
	 [Country] NVARCHAR(20) NOT NULL,

	 CONSTRAINT [PK_ACTORS] PRIMARY KEY CLUSTERED ([ActorID] ASC),
 )  go


 go Create Table [dbo]. [ActorDetails]
 (
   [ActorID] int NOT NULL,
   [MovieID] int NOT NULL,

   CONSTRAINT [FK_AwardDetails_MoviesID] FOREIGN KEY ([MovieID]) REFERENCES [dbo]. [Movies] ([MovieID]),
   CONSTRAINT [FK_AwardDetails_ActorID] FOREIGN KEY  ([ActorID]) REFERENCES [dbo]. [Actors] ([ActorID])
 ) go

go Create Table [dbo]. [Genres]
(
   [GenreID] INT IDENTITY(1,1) NOT NULL,
      
	  
	  [GenreName] NVARCHAR(40) NOT NULL,
	  [Subgenre] NVARCHAR(40) NOT NULL,
	  [Description] NVARCHAR(500) NOT NULL,


	  CONSTRAINT [PK_GENRES] PRIMARY KEY CLUSTERED ([GenreID] ASC),
) go


go Create Table [dbo]. [Users]
 (
  [UserID] INT IDENTITY (1,1) NOT NULL,
  
     
	  [UserName] NVARCHAR(40) NOT NULL,
	  [UserLastName] NVARCHAR(40) NOT NULL,
	  [BirthDate] DATE NOT NULL,
	  [UserNick] NVARCHAR(15) NOT NULL,
	  [Account Date] DATETIME2(7) NOT NULL,/*7 NE ANLAMA GELÝYOR*/
	  [Country] NVARCHAR(20) NOT NULL,
	  
	  CONSTRAINT [PK_Users] PRIMARY KEY ([UserID] ASC) 
 ) go

go Create Table [dbo]. [UserDetails]
 (
    [UserID] INT NOT NULL,
	[GenreID] INT NOT NULL,
	[MovieID] INT NOT NULL,

	CONSTRAINT [FK_UserDatails_UserID] Foreign Key ([UserID]) REFERENCES [dbo]. [Users] ([UserID]),
	CONSTRAINT [FK_Genres_GenreID] Foreign Key ([GenreID]) REFERENCES [dbo]. [Genres] ([GenreID]),
	CONSTRAINT [FK_Movies_MovieID] Foreign Key ([MovieID]) REFERENCES [dbo]. [Movies] ([MovieID])

 ) go
 

 /*1- Tablo oluþma sýrasý ve foreign key */
 /*2-bit veri tipi*/