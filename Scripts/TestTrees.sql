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


SET IDENTITY_INSERT Persons ON;
DECLARE @id INT;
-- three simple generations
SET @id = 0;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,	DeathDate,	ImageUrl)
VALUES
		(	@id + 0, 	'GrandFather1', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 1,	'GrandMother1', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 2,	'GrandFather2', 	NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 3,	'GrandMother2', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 4,	'Father1', 			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 5,	'Mother', 			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 6,	'Child',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 7,	'Father2', 			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL)

-- ==========================================================================================================================
-- child with biological and adoptive parents
SET @id = 10;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,	DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'BiologicalFather', NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 1,	'BiologicalMother', NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 2,	'AdoptoveMother', 	NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 3,	'AdoptiveFather', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 4,	'Child', 			NULL,			NULL,			NULL,			@id + 0, 			@id + 1, 			@id + 2,			@id + 3,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL)

-- ==========================================================================================================================
-- sort two generations by birthdays
SET @id = 20;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'ChildFemale5',		NULL,			NULL,			NULL,			@id + 6, 			@id + 5,			NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+20080101',	NULL,	NULL),
		(	@id + 1,	'ChildMale4',		NULL,			NULL,			NULL,			@id + 8, 			@id + 7,			NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		'+20070101',	NULL,	NULL),
		(	@id + 2,	'ChildFemale4', 	NULL,			NULL,			NULL, 			@id + 8, 			@id + 7,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						0, 		'+20060101',	NULL,	NULL),
		(	@id + 3,	'ChildFemale3', 	NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+20050101',	NULL,	NULL),
		(	@id + 4,	'ChildMale3', 		NULL,			NULL,			NULL,			@id + 8, 			@id + 7, 			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+20040101',	NULL,	NULL),
		(	@id + 5,	'ParentFemale2', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+20030101',	NULL,	NULL),
		(	@id + 6,	'ParentMale2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+20020101',	NULL,	NULL),
		(	@id + 7,	'ParentFemale1', 	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+20010101',	NULL,	NULL),
		(	@id + 8,	'ParentMale1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+20000101',	NULL,	NULL)

-- ==========================================================================================================================
-- tie spouses in two generations
SET @id = 30;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'ChildFemale4',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'ChildMale4',		NULL,			NULL,			NULL,			@id + 9, 			@id + 8,			NULL,				NULL,				@id + 2, 		@id + 0,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'ChildFemale3',		NULL,			NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,				@id + 1,		@id + 3,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 3,	'ChildMale3', 		NULL,			NULL,			NULL,			@id + 11, 			@id + 10,			NULL,				NULL,				@id + 5, 		@id + 2,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 4,	'ChildMale2', 		NULL,			NULL,			NULL,			@id + 12, 			@id + 13, 			NULL,				NULL,				@id + 7, 		@id + 5,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 5,	'ChildFemale2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 3, 		@id + 4,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 6,	'ChildMale1', 		NULL,			NULL,			NULL,			@id + 14, 			@id + 15,			NULL,				NULL,				@id + 7, 		NULL,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 7,	'ChildFemale1',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 4, 		@id + 6,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 8,	'ParentFemale4',	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 9, 		NULL,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 9,	'ParentMale4', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 10, 		@id + 8,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 10,	'ParentFemale3',	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 9, 		@id + 11,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 11,	'ParentMale3', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 13, 		@id + 10,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 12,	'ParentMale2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 15, 		@id + 13,	NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 13,	'ParentFemale2',	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 11, 		@id + 12,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 14,	'ParentMale1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 15, 		NULL,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 15,	'ParentFemale1',	NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 12, 		@id + 14,	NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- double married female
SET @id = 50;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'Female1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 1,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'Male2',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL)


-- ==========================================================================================================================
-- double married male
SET @id = 60;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'Female1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 0,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'Female2',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- divorced female with biological and adoptive children
SET @id = 70;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'Male',				NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 4,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 1,	'Female1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 2,	'BiologicalChild',	NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 3,	'AdoptiveChild',	NULL,			NULL,			NULL,			NULL, 				NULL,				@id + 0,			@id + 1,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 4,	'Female2',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

SET IDENTITY_INSERT Persons OFF;

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