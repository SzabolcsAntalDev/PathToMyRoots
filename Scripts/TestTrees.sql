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
			FirstName, 			LastName, 		MaidenName, 	OtherNames, 	BiologicalFatherID, BiologicalMotherID, AdoptiveFatherID, AdoptiveMotherID, FirstSpouseID,	SecondSpouseID, FirstMarriageStartDate, SecondMarriageStartDate,	IsMale, BirthDate, 		DeathDate, 		ImageUrl)
VALUES

-- 3 simple generations
/* 1  */ (	'GrandFather1', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			2, 				NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 2  */ (	'GrandMother1', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			1, 				NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 3  */ (	'GrandFather2', 	NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,			4, 				NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 4  */ (	'GrandMother2', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			3, 				NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 5  */ (	'Father', 			NULL,			NULL,			NULL,			1, 					2, 					NULL,				NULL,			6,	 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 6  */ (	'Mother', 			NULL,			NULL,			NULL,			3, 					4, 					NULL,				NULL,			5, 				NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 7  */ (	'Child',			NULL,			NULL,			NULL,			5, 					6, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),

-- child with biological and adoptive parents
/* 8  */ (	'BiologicalFather', NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			9, 				NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 9  */ (	'BiologicalMother', NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			8, 				NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 10 */ (	'AdoptoveMother', 	NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,			11, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 11 */ (	'AdoptiveFather', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			10, 			NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 12 */ (	'Child', 			NULL,			NULL,			NULL,			8, 					9, 					10,					11,				NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),

-- male with 2 spouses
/* 13  */ (	'Male1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			14, 			15,				NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 14  */ (	'Female1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			13, 			NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 15 */ (	'Female2', 			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,			13, 			NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,			NULL),
/* 16 */ (	'Child1', 			NULL,			NULL,			NULL,			13, 				14, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL),
/* 17 */ (	'Child2', 			NULL,			NULL,			NULL,			13, 				15, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,			NULL)


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