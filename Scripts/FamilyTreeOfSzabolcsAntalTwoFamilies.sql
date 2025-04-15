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



/* 1  */ (	'András', 			'Antal', 				NULL, 			'Púj', 			NULL, 				NULL, 				NULL,				NULL,			2, 				NULL,			NULL,					NULL, 						1, 		'+19580310', 	NULL, 			'a802a6f1-cf37-47f9-9384-dcac755b2596.png'	),
/* 2  */ (	'Irénke', 			'Antal', 				'Korpos', 		'Rigó',			NULL, 				NULL, 				NULL,				NULL,			1, 				NULL,			NULL,					NULL, 						0, 		'+19620501', 	NULL, 			'd4691786-9873-4f29-bf20-ec23359cd1ae.png'	),
/* 3  */ (	'Szabolcs-Csongor', 'Antal', 				NULL, 			NULL, 			1, 					2, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+19910816', 	NULL, 			'b045774e-7737-4c0b-b5b6-2b2a13abc112.png'	),
/* 4  */ (	'Orsolya', 			'Antal', 				NULL, 			'Púj', 			NULL, 				NULL, 				NULL,				NULL,			5, 				NULL,			NULL,					NULL, 						0, 		'+19830906', 	NULL, 			'38be15b0-386c-4527-a480-9f013f86487a.png'	),
/* 5 */ (	'Lóránd', 			'Silye', 				NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,			4, 				NULL,			NULL,					NULL, 						1, 		'+19800820', 	NULL, 			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
/* 6 */ (	'Sámuel', 			'Silye', 				NULL,			NULL, 			5, 					4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+20200226', 	NULL, 			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	)

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