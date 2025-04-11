DROP TABLE Persons;

CREATE TABLE Persons
(
	ID INT PRIMARY KEY IDENTITY,
	NobleTitle NVARCHAR (50),
	FirstName NVARCHAR (50) NOT NULL,
	LastName NVARCHAR (50),
	MaidenName NVARCHAR (50),
	OtherNames NVARCHAR (250),
	IsMale BIT NOT NULL DEFAULT 1,
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
/* 7  */ (	'András', 			'Antal', 				NULL,	 		'Púj', 			9, 					10, 				NULL,				NULL,			8, 				NULL,			'+19570928',			NULL, 						1, 		'+19370601', 	'+19880818',	'618db659-b641-498f-b3f0-d9eb3e710061.png'	),
/* 8  */ (	'Ilona', 			'Antal', 				'Márton', 		'Kűpál',		11, 				12, 				NULL,				NULL,			7, 				NULL,			'+19570928',			NULL, 						0, 		'+19400925', 	NULL, 			'415ccbbc-16d9-4ec1-9622-2fc0e41000ec.png'	),
/* 9  */ (	'János', 			'Antal', 				NULL, 			'Púj',		 	NUll, 				NUll, 				NULL,				NULL,			10, 			NULL,			NULL,					NULL, 						1, 		'+19100625', 	'+19990406',	'39cc7ae0-68be-4960-9358-44bc9e725962.png'	),
/* 10 */ (	'Erzsébet',			'Antal', 				'Kovács',		'Baka', 		NUll, 				NUll, 				NULL,				NULL,			9, 				NULL,			NULL,					NULL, 						0, 		'+19140201', 	'+19930428',	'c35271dd-b992-4a6c-b101-cf0af9ea0625.png'	),
/* 11 */ (	'János', 			'Márton', 				NULL, 			'Kűpál',		NUll, 				NUll, 				NULL,				NULL,			12, 			NULL,			'+19290831',			NULL, 						1, 		'+19090929', 	'+19690927',	'3b37e71c-ea22-49be-aafe-f8d67a30661d.png'	),
/* 12 */ (	'Ilona', 			'Márton', 				'Mihály',		'Bori',		 	NUll, 				NUll, 				NULL,				NULL,			11, 			NULL,			'+19290831',			NULL, 						0, 		'+19101205', 	'+19840428',	'f7d28d6b-fad6-4b17-8460-c4400fce4222.png'	),
/* 13 */ (	'Márton', 			'Korpos', 				NULL, 			'Rigó, Ács',	NUll, 				NUll, 				NULL,				NULL,			14, 			NULL,			'+19270924',			NULL, 						1, 		'+1902mmdd', 	'+19640106',	NULL										),
/* 14 */ (	'Katalin', 			'Korpos', 				'Albert',		'Kukó',	 		NUll, 				NUll, 				NULL,				NULL,			13, 			NULL,			'+19270924',			NULL, 						0, 		'+19081125', 	'+19901120', 	NULL										),
/* 15 */ (	'Márton', 			'Gál-Máté', 			NULL, 			'Czondi', 		NUll, 				NUll, 				NULL,				NULL,			16, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
/* 16 */ (	'Katalin',			'Gál-Máté', 			'Ambrus-Péter', 'Péter', 		NUll, 				NUll, 				NULL,				NULL,			15, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
/* 17 */ (	'Lóránd', 			'Silye', 				NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,			4, 				NULL,			NULL,					NULL, 						1, 		'+19800820', 	NULL, 			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
/* 18 */ (	'Sámuel', 			'Silye', 				NULL,			NULL, 			17, 				4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+20200226', 	NULL, 			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	)

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