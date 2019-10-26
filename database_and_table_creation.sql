IF NOT EXISTS (SELECT * FROM sys.databases where [name] = 'PoopScoop')
BEGIN
	CREATE DATABASE PoopScoop
END
ELSE
PRINT 'PoopScoop database already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'User')
	BEGIN
		CREATE TABLE [User] 
		(
			[id] int primary key identity(1,1),
			[imageUrl] nvarchar(250) not null,
			[name] nvarchar(250) not null,
			[city] nvarchar(250) not null,
			[state] nvarchar(2) not null,
			[dateCreated] datetime not null,
		)
	END
ELSE
	PRINT 'User table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Business')
	BEGIN
		CREATE TABLE [Business] 
		(
			[id] int primary key identity(1,1),
			[yelpId] nvarchar(250) not null,
			[zip] nvarchar(15) not null
		)
	END
ELSE
	PRINT 'Business table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'AmenityType')
	BEGIN
		CREATE TABLE [AmenityType] 
		( 
			[id] int primary key identity(1,1),
			[type] nvarchar(250) not null
		)
	END
ELSE
	PRINT 'AmenityType table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Amenity')
	BEGIN
		CREATE TABLE [Amenity] 
		(
			[id] int primary key identity(1,1),
			[businessId] int not null,
			[typeId] int not null,
			[status]  bit not null,
			[restroomType] int not null
		)
	END
ELSE
	PRINT 'Amenity table already exists'

	IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Avatar')
	BEGIN
		CREATE TABLE [Avatar] 
		(
			[avatarName] nvarChar(50) primary key,
			[avatarUrl] nvarChar(250) not null
		)
	END
ELSE
	PRINT 'Avatar table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'BusinessRating')
	BEGIN
		CREATE TABLE [BusinessRating] 
		(
			[id] int primary key identity(1,1),
			[businessId] int not null,
			[cleanliness] int not null,
			[decor] int not null,
			[restroomType] int not null,
			[review] nvarchar(350) null,
			[timeStamp] datetime not null,
			[uid] int not null
		)
	END
ELSE
	PRINT 'BusinessRating table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'RestroomType')
	BEGIN
		CREATE TABLE [RestroomType] 
		(
			[id] int primary key identity(1,1),
			[hex] nvarchar(10) not null,
			[restroomType] nvarchar(10) not null,
		)
	END
ELSE
	PRINT 'RestroomType table already exists'

IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'States')
	BEGIN
		CREATE TABLE [States] 
		(
			[stateAbbreviation] nvarchar(2) primary key,
			[stateName] nvarchar(20) not null
		)
	END
ELSE
	PRINT 'States table already exists'


IF NOT EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Cities')
	BEGIN
		CREATE TABLE [Cities] 
		(
			[id] int primary key identity(1,1),
			[stateAbbreviation] nvarchar(2) not null,
			[cityName] nvarchar(50) not null
		)
	END
ELSE
	PRINT 'User table already exists'

ALTER TABLE Amenity
ADD constraint FK_Amenity_Business 
	foreign key (businessId) 
	references Business (id)

ALTER TABLE Amenity
ADD constraint FK_Amenity_AmenityType
	foreign key (typeId) 
	references AmenityType (id)

ALTER TABLE Amenity
ADD constraint FK_Amenity_RestroomType
	foreign key (restroomType) 
	references RestroomType (id)

ALTER TABLE BusinessRating
ADD constraint FK_BusinessRating_User
	foreign key ([uid])
	references [User] (id)

ALTER TABLE BusinessRating
ADD constraint FK_BusinessRating_Business
	foreign key (businessId)
	references Business (id)

ALTER TABLE BusinessRating
ADD constraint FK_BusinessRating_RestroomType
	foreign key (restroomType)
	references RestroomType (id)

ALTER TABLE Cities
ADD constraint FK_Cities_States
	foreign key (stateAbbreviation)
	references [States] (stateAbbreviation)