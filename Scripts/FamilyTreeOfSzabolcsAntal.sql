DROP TABLE Persons;

CREATE TABLE Persons
(
	ID INT PRIMARY KEY IDENTITY,
	NobleTitle NVARCHAR (50),
	FirstName NVARCHAR (50) NOT NULL,
	LastName NVARCHAR (50),
	MaidenName NVARCHAR (50),
	OtherNames NVARCHAR (250),
	IsMale BIT NOT NULL,
	BirthDate CHAR (9),
	DeathDate CHAR (9),
	BiologicalFatherID INT,
	BiologicalMotherID INT,
	AdoptiveFatherID INT,
	AdoptiveMotherID INT,
	FirstSpouseID INT,
	SecondSpouseID INT,
	FirstMarriageStartDate CHAR (9),
	FirstMarriageEndDate CHAR (9),
	SecondMarriageStartDate CHAR (9),
	SecondMarriageEndDate CHAR (9),
	ImageUrl NVARCHAR (110),
)

INSERT INTO Persons (
			FirstName, 			LastName, 				MaidenName, 	OtherNames, 	BiologicalFatherID, BiologicalMotherID, AdoptiveFatherID, AdoptiveMotherID, FirstSpouseID,	SecondSpouseID, FirstMarriageStartDate, SecondMarriageStartDate,	IsMale, BirthDate, 		DeathDate, 		ImageUrl)
VALUES                                                                                                                                                                                                                                                                                          
/* 1  */ (	'András', 			'Antal', 				NULL, 			'Púj', 			7, 					8, 					NULL,				NULL,			2, 				NULL,			NULL,					NULL, 						1, 		'+19580310', 	NULL, 			'a802a6f1-cf37-47f9-9384-dcac755b2596.png'	),
/* 2  */ (	'Irénke', 			'Antal', 				'Korpos', 		'Rigó',			6, 					5, 					NULL,				NULL,			1, 				NULL,			NULL,					NULL, 						0, 		'+19620501', 	NULL, 			'd4691786-9873-4f29-bf20-ec23359cd1ae.png'	),
/* 3  */ (	'Szabolcs-Csongor', 'Antal', 				NULL, 			NULL, 			1, 					2, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+19910816', 	NULL, 			'b045774e-7737-4c0b-b5b6-2b2a13abc112.png'	),
/* 4  */ (	'Orsolya', 			'Antal', 				NULL, 			'Púj', 			1, 					2, 					NULL,				NULL,			17, 			NULL,			NULL,					NULL, 						0, 		'+19830906', 	NULL, 			'38be15b0-386c-4527-a480-9f013f86487a.png'	),
/* 5  */ (	'Katalin', 			'Korpos', 				'Gál-Máté',		'Czondi', 		15, 				16, 				NULL,				NULL,			6, 				NULL,			NULL,					NULL, 						0, 		'+19410104', 	'+20130710',	'1de14600-ffdb-41fd-9628-37b0ddc7e078.png'	),
/* 6  */ (	'János', 			'Korpos', 				NULL, 			'Rigó, Ács', 	13, 				14, 				NULL,				NULL,			5, 				NULL,			NULL,					NULL, 						1, 		'+19320423', 	'+19960909',	'111e1d9c-9e72-42c9-9074-3ebdead96f48.png'	),
/* 7  */ (	'András', 			'Antal', 				NULL,	 		'Púj', 			9, 					10, 				NULL,				NULL,			8, 				NULL,			NULL,					NULL, 						1, 		'+19370601', 	'+19880818',	'618db659-b641-498f-b3f0-d9eb3e710061.png'	),
/* 8  */ (	'Ilona', 			'Antal', 				'Márton', 		'Kűpál',		11, 				12, 				NULL,				NULL,			7, 				NULL,			NULL,					NULL, 						0, 		'+19400925', 	NULL, 			'415ccbbc-16d9-4ec1-9622-2fc0e41000ec.png'	),
/* 9  */ (	'János', 			'Antal', 				NULL, 			'Púj',		 	62, 				63, 				NULL,				NULL,			10, 			NULL,			NULL,					NULL, 						1, 		'+19100625', 	'+19990406',	'39cc7ae0-68be-4960-9358-44bc9e725962.png'	),
/* 10 */ (	'Erzsébet',			'Antal', 				'Kovács',		'Baka', 		53, 				54, 				NULL,				NULL,			9, 				NULL,			NULL,					NULL, 						0, 		'+19140201', 	'+19930428',	'c35271dd-b992-4a6c-b101-cf0af9ea0625.png'	),
/* 11 */ (	'János', 			'Márton', 				NULL, 			'Kűpál',		NULL, 				NULL, 				NULL,				NULL,			12, 			NULL,			NULL,					NULL, 						1, 		'+19090929', 	'+19690927',	NULL										),
/* 12 */ (	'Ilona', 			'Márton', 				'Mihály',		NULL,		 	NULL, 				NULL, 				NULL,				NULL,			11, 			NULL,			NULL,					NULL, 						0, 		'+19101205', 	'+19840428',	NULL										),
/* 13 */ (	'Márton', 			'Korpos', 				NULL, 			'Rigó, Ács',	NULL, 				NULL, 				NULL,				NULL,			14, 			NULL,			NULL,					NULL, 						1, 		'+20190101', 	'+20190106',	NULL										),
/* 14 */ (	'Katalin', 			'Korpos', 				'Albert',		'Kukó',	 		NULL, 				NULL, 				NULL,				NULL,			13, 			NULL,			NULL,					NULL, 						0, 		'+20191125', 	'+20191120', 	NULL										),
/* 15 */ (	'Márton', 			'Gál-Máté', 			NULL, 			'Czondi', 		NULL, 				NULL, 				NULL,				NULL,			16, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
/* 16 */ (	'Katalin',			'Gál-Máté', 			'Ambrus-Péter', 'Péter', 		NULL, 				NULL, 				NULL,				NULL,			15, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
/* 17 */ (	'Lóránd', 			'Silye', 				NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,			4, 				NULL,			NULL,					NULL, 						1, 		'+19800820', 	NULL, 			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
/* 18 */ (	'Sámuel', 			'Silye', 				NULL,			NULL, 			17, 				4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+20200226', 	NULL, 			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	),
/* 19 */ (	'Albert', 			'Antal', 				NULL,			NULL, 			7, 					8, 					NULL,				NULL,			20, 			NULL,			NULL,					NULL, 						1, 		'+19660816', 	NULL,			'82d99b02-6436-4066-883f-4fedc76befee.png'	),
/* 20 */ (	'Ildikó', 			'Antal', 				'Mihály',		'Gulé', 		NULL, 				NULL, 				NULL,				NULL,			19, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+yyyymmdd', 	'ee6cd0db-3079-461f-82cd-b05715efd8ca.png'	),
/* 21 */ (	'Emese', 			'Báint-Kovács Antal', 	'Antal', 		'Púj', 			19, 				20, 				NULL,				NULL,			22, 			NULL,			NULL,					NULL, 						0, 		'+19910830', 	NULL, 			'537dedfd-9314-4606-8e3f-2a4e58c49b95.png'	),
/* 22 */ (	'Zsolt', 			'Kovács', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			21, 			NULL,			NULL,					NULL, 						1, 		'+19881025', 	NULL, 			'61f08d10-a000-48b6-8a7c-b8cff7ce4650.png'	),
/* 23 */ (	'Éva', 				'Ekler', 				'Antal', 		'Púj', 			19, 				20, 				NULL,				NULL,			24, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'1e672af6-c2d7-4b34-b7fe-475b47530c31.png'	),
/* 24 */ (	'Péter', 			'Ekler', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			23, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'0c5cbc5b-3f89-4380-9b61-93df1432afd1.png'	),
/* 25 */ (	'Lili', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'dad07321-9861-4fd5-bf9b-4b0371560218.png'	),
/* 26 */ (	'Áron', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'9f508c01-575e-4d99-91ba-f0d6786f3228.png'	),
/* 27 */ (	'Ádám', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'0c7519f9-6db7-443c-98eb-6f34358efe5e.png'	),
/* 28 */ (	'Attila', 			'Korpos', 				NULL, 			NULL, 			6, 					5, 					NULL,				NULL,			29, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	'e6615a1a-dfcc-4b41-b791-4cda4f335666.png'	),
/* 29 */ (	'Kati', 			'Korpos', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			28, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'09a089ea-0e23-43c1-a8b9-6593b6414d1d.png'	),
/* 30 */ (	'Lehel', 			'Korpos', 				NULL, 			NULL, 			28, 				29, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'a8b546f2-1976-4f71-89fe-63772b29becc.png'	),
/* 31 */ (	'Anna-Dóra', 		'Silye', 				NULL, 			NULL, 			17, 				4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						0, 		'+20240308', 	NULL, 			'1944c64b-0ebc-44ed-98f8-53d371205b53.png'	),
/* 32 */ (	'János', 			'Antal', 				NULL, 			'Magyar', 		NULL, 				NULL, 				NULL,				NULL,			52, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	'15f539b4-f773-4246-a469-24fb6a788b09.png'	),
/* 33 */ (	'Erzsébet', 		'Antal', 				'Kovács',		'Baka',			NULL, 				NULL, 				NULL,				NULL,			33, 			NULL,			NULL,					NULL, 						0, 		'+20190509', 	'+19410509', 	NULL 										),
/* 34 */ (	'Miklós', 			'Péntek', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			35, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'f3df6706-a6b9-4934-ae1c-5d6e0e53c482.png'	),
/* 35 */ (	'Anna', 			'Péntek', 				'Antal', 		'Magyar', 		32, 				52, 				NULL,				NULL,			34, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'3282b3a0-4cd6-4e2c-9c49-efeaa0d53ca5.png'	),
/* 36 */ (	'Rezső', 			'Zalányi', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			37, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'1ed17ba3-b9f6-4b4b-bff5-05f0ebb154fd.png'	),
/* 37 */ (	'Tímea', 			'Zalányi-Péntek', 		'Péntek',		'Piszikiri',	34, 				35, 				NULL,				NULL,			36, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'bec0a203-db18-4a24-9e06-885c25a6870b.png'	),
/* 38 */ (	'Csilla',			'Péntek',				'Péntek',		'Piszkiri',		34, 				35, 				NULL, 				NULL,			39, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'0bc341fc-d2e8-40ff-a347-3e1142d3221c.png'	),
/* 39 */ (	'Róbert',			'Péntek',				NULL,			'Laci',			NULL, 				NULL, 				NULL, 				NULL,			38, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'e96c8649-35c4-4185-9a3e-a6f12530006f.png'	),
/* 40 */ (	'Lehel',			'Zalányi',				NULL,			NULL,			36, 				37, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
/* 41 */ (	'Gyerek1',			'Péntek',				NULL,			NULL,			39, 				38, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
/* 42 */ (	'Gyerek2',			'Péntek',				NULL,			NULL,			39, 				38, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
/* 43 */ (	'Erzsébet',			'Szalai',				'Gál-Máté',		'Czondi',		15, 				16, 				NULL, 				NULL,			44, 			NULL, 			NULL,					NULL, 						0, 		'+1926mmdd',  	'+1998mmdd', 	'6fc5d2e4-656b-42bc-a324-217c5ccba0f0.png'	),
/* 44 */ (	'Ferenc',			'Szalai',				NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			43, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL 										),
/* 45 */ (	'Katalin',			'Ruzsa-Gyuri',			'Szalai',		NULL,			44, 				43, 				NULL, 				NULL,			46, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'a9ecf1f1-c146-4071-9a12-c206615c65cd.png'	),
/* 46 */ (	'Márton',			'Ruzsa-Gyuri',			NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			45, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL,		 	'3a8247cd-b2e4-4c48-8f3c-5475c026784e.png'	),
/* 47 */ (	'Mártonka',			'Ruzsa-Gyuri',			NULL,			NULL,			46, 				45, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL 										),
/* 48 */ (	'Gerlinde',			'Schmaler Ruzsa',		NULL,			NULL,			58, 				57, 				46, 				45,				59, 			49, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'02612545-c561-4f08-b55a-5f09268c8280.png'	),
/* 49 */ (	'László',			'Gál',					NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			48, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'f64e8bd1-9059-408e-af50-6cc5852f7cd0.png'	),
/* 50 */ (	'Rebeka',			'Gál',					NULL,			NULL,			49, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'f8c61e5a-cc91-456b-89a5-ad7516e63404.png'	),
/* 51 */ (	'Tamás',			'Gál',					NULL,			NULL,			49, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'8dda7278-93eb-41d3-86e4-b2ca0607a9f5.png' 	),
/* 52 */ (	'Erzsébet',			'Antal',				'Kovács',		'Baka',			9, 					10, 				55, 				56,				32, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	'+yyyymmdd', 	'30a1a445-3814-4f2f-bd7c-56b63c906898.png'	),
/* 53 */ (	'György',			'Kovács',				NULL,			'Baka',			NULL, 				NULL, 				NULL, 				NULL,			54, 			NULL, 			NULL,					NULL, 						1, 		'+18720523', 	'+19161226', 	'014fde85-12c2-437f-b958-b27316ddc2f9.png'	),
/* 54 */ (	'Ilona',			'Péntek',				'Kis',			NULL,			NULL, 				NULL, 				NULL, 				NULL,			53, 			NULL, 			NULL,					NULL, 						0, 		'+18770307', 	'+19190615', 	NULL 										),
/* 55 */ (	'György',			'Kovács',				NULL,			'Baka',			53, 				54, 				NULL, 				NULL,			56, 			NULL, 			NULL,					NULL, 						1, 		'+18990811', 	'+yyyymmdd', 	'7a57c3d8-fffe-43e7-8647-7f7d97572d68.png'	),
/* 56 */ (	'Katalin',			'Kovács',				'Antal',		'Púj',			62, 				63, 				NULL, 				NULL,			55, 			NULL, 			NULL,					NULL, 						0, 		'+19001021', 	NULL,			'02bd4eeb-df2a-44ab-8f38-bd9c623a8f06.png'	),
/* 57 */ (	'Anyja',			'Lindanak',				NULL,           NULL,			NULL, 				NULL, 				NULL, 				NULL,			58, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL 										),
/* 58 */ (	'Apja',				'Lindanak',				NULL,           NULL,			NULL, 				NULL, 				NULL, 				NULL,			57, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
/* 59 */ (	'Zoltán Pál',		'Takács',				NULL,           NULL,			66, 				67, 				NULL, 				NULL,			48, 			60, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'64afb2cf-3fa0-482d-8caf-ebf8b09587d6.png' 	),
/* 60 */ (	'Kata',				'Takács',				'Kató',         NULL,			NULL, 				NULL, 				NULL, 				NULL,			59, 			NULL, 			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'a981ad6a-456f-42c5-bbed-fd0d98db864f.png' 	),
/* 61 */ (	'Benjámin',			'Takács',				NULL,           NULL,			59, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'22436f79-f212-459c-b7c1-e3f0fe2175f4.png' 	),
/* 62 */ (	'János',			'Antal',				NULL,           'Púj',			NULL, 				NULL, 				NULL, 				NULL,			63, 			NULL, 			'+18981130',			NULL, 						1, 		'+18741028',  	'+19540916',	NULL									 	),
/* 63 */ (	'Erzsébet',			'Antal',				'Péntek',       'Pistika, Jankó',NULL, 				NULL, 				NULL, 				NULL,			62, 			NULL, 			'+18981130',			NULL, 						0, 		'+18780706',  	'+19540913', 	NULL									 	),
/* 64 */ (	'János',			'Ambrus',				NULL,           'Pál-Pista',	NULL, 				NULL, 				NULL, 				NULL,			65, 			NULL, 			'+yyyymmdd',			NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd',	NULL									 	),
/* 65 */ (	'Anna',				'Ambrus',				'Gál-Máté',     'Czondi',		15, 				16, 				NULL, 				NULL,			64, 			NULL, 			'+yyyymmdd',			NULL, 						0, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL									 	),
/* 66 */ (	'Apja',				'Pál Zoltán',			'Takács',     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			67, 			NULL, 			'+yyyymmdd',			NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL									 	),
/* 67 */ (	'Anyja',			'Pál Zoltán',			'Takács',     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			66, 			NULL, 			'+yyyymmdd',			NULL, 						0, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL									 	)

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_BiologicalFatherID
    FOREIGN KEY (BiologicalFatherID) REFERENCES Persons(ID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_BiologicalMotherID
    FOREIGN KEY (BiologicalMotherID) REFERENCES Persons(ID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_AdoptiveFatherID
    FOREIGN KEY (AdoptiveFatherID) REFERENCES Persons(ID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_AdoptiveMotherID
    FOREIGN KEY (AdoptiveMotherID) REFERENCES Persons(ID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_FirstSpouseID
    FOREIGN KEY (FirstSpouseID) REFERENCES Persons(ID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_SecondSpouseID
    FOREIGN KEY (SecondSpouseID) REFERENCES Persons(ID);