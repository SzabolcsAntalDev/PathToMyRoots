-- Tooltips range is 0 -> 5.000
	-- 0 - biological
	-- 40 - extended
	-- 80 - complete

-- Tests range is 5.000 -> 20.000
	-- 5.000 - biological
	-- 10.000 - extended
	-- 15.000 - complete

-- Szabolcs Antal's family range is 20.000 -> 25.000

DECLARE @addFamily BIT = 0;
DECLARE @idBuffer INT = 40;
DECLARE @id INT = 0;

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



-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================



SET IDENTITY_INSERT Persons ON;

-- ==========================================================================================================================
-- HOURGLASS-BIOLOGICAL tooltip
SET @id = 0;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male2',			NULL,			NULL,			NULL,			@id + 9, 		@id + 10,				NULL,				NULL,				@id + 12, 		@id + 1,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Female2',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male1',			NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female1',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2, 		@id + 3,				NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female2',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L2 Male2',			NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 4, 		@id + 5,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L2 Female1',		NULL,			NULL,			NULL,			@id + 6, 		@id + 7,				NULL,				NULL,				@id + 8, 		@id + 9,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L3 Male3',			NULL,			NULL,			NULL,			@id + 8, 		@id + 10,				NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L3 Female1',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L4 Male1',			NULL,			NULL,			NULL,			@id + 0, 		@id + 12,				NULL,				NULL,				@id + 14, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L4 Female1',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L4 Female2',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 16, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L4 Male3',			NULL,			NULL,			NULL,			@id + 0, 		@id + 1,				NULL,				NULL,				@id + 15, 		@id + 17,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L4 Female3',		NULL,			NULL,			NULL,			NULL, 			NULL,					NULL,				NULL,				@id + 16, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L4 Male4',			NULL,			NULL,			NULL,			@id + 0, 		@id + 1,				NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L0 Male1',			NULL,			NULL,			NULL,			@id + 13, 		@id + 14,				NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L0 Male2',			NULL,			NULL,			NULL,			@id + 16, 		@id + 15,				NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L0 Male3',			NULL,			NULL,			NULL,			@id + 16, 		@id + 17,				NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED tooltip
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Female3',		NULL,			NULL,			NULL,			@id + 14, 			@id + 15,			NULL,				NULL,				@id + 19,		@id + 1,		NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 5,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 7,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L0 Female3',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 9,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			@id + 6,			@id + 7,			@id + 8,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 11,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10,		@id + 12,		NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L1 Female3',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 11,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L2 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 14,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 8, 			@id + 9,			NULL,				NULL,				@id + 13,		@id + 15,		NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L2 Female2',		NULL,			NULL,			NULL,			@id + 11, 			@id + 12,			NULL,				NULL,				@id + 14,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L3 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 17,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L3 Male2',			NULL,			NULL,			NULL,			@id + 14, 			@id + 13,			NULL,				NULL,				@id + 16,		@id + 18,		NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L3 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 17,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L3 Male4',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L3 Male5',			NULL,			NULL,			NULL,			NULL,	 			NULL,				@id + 14, 			@id + 15,			NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L4 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 0,			NULL,				NULL,				@id + 22,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L4 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 21,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L4 Male2',			NULL,			NULL,			NULL,			@id + 19, 			@id + 0,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L4 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				@id + 19,			@id + 0,			@id + 25,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 25,	'L4 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 24,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 26,	'L5 Male1',			NULL,			NULL,			NULL,			@id + 21,			@id + 22,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 27,	'L5 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				@id + 21,			@id + 22,			NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE tooltip
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 7,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 1,			@id + 2,			@id + 6,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 3,			@id + 4,			NULL,				NULL,				@id + 5,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 0,		@id + 8,		NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 9,		@id + 7,		NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Male3',			NULL,			NULL,			NULL,			NULL,				NULL	,			NULL,				NULL,				@id + 8,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Male4',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 11,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Female4',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 10,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 5,			@id + 6,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 5,			@id + 6,			NULL,				NULL,				@id + 14,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L2 Female2',		NULL,			NULL,			NULL,			@id + 10,			@id + 11,			NULL,				NULL,				@id + 13,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L2 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 7,			@id + 0,			@id + 16,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L2 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 15,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L2 Male4',			NULL,			NULL,			NULL,			@id + 7,			@id + 8,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L2 Female5',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 19,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L2 Male6',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 9,			@id + 8,			@id + 18,		@id + 20,		NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L2 Female6',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L3 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 13,			@id + 14,			@id + 22,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L3 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 23,		@id + 21,		NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L3 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 22,		NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L3 Male3',			NULL,			NULL,			NULL,			@id + 15,			@id + 16,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 25,	'L3 Male4',			NULL,			NULL,			NULL,			@id + 19,			@id + 20,			NULL,				NULL,				NULL,			NULL,			NULL, 					NULL,						1, 		'+yyyymmdd',	NULL,		NULL)



-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================



-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When only male ancestors are present, fake ancestors are added
SET @id = 5000;

INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L2 Male',			NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L2 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When only female ancestors are present, fake ancestors are added
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Female',		NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L2 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L2 Female',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female',		NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						0, 		'+1991mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has siblings from multiple parents, only ancestors of biological parents are displayed

SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4,	 		@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L2 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 5,			@id + 6,			NULL,				NULL,				@id + 4,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are second married and person does not have siblings, other spouses of parents are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are second married and person has sibling only from mothers first marriage, fathers first spouse is not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are second married and person has sibling from fathers first marriage, mothers first spouse is not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are second married and person has siblings from other spouses of parents, other spouses are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are first married and person does not have siblings, other spouses of parents are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 3,			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		@id + 1,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		@id + 4,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are first married and person has sibling from mothers second marriage, fathers second spouse is not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 3,			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		@id + 1,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		@id + 4,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are first married and person has sibling from fathers second marriage, mothers second spouse is not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 3,			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		@id + 1,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		@id + 4,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When parents are first married and person has siblings from other spouses of parents, other spouses are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 3,			@id + 2,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		@id + 1,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		@id + 4,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When male has two wives, but has children only with the first wife, only the first wife and children is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)
		
-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When male has two wives, but has children only with the second wife, only the second wife and children is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When male has two wives, and has children with both, both wives and children are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When male has two wives, but has children with none of them, none of them is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When female has two husbands, but has children only with the first husband, only the first husband and children is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 0,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When female has two husbands, but has children only with the second husband, only the second husband and children is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 0,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When female has two husbands, and has children with both, both husbands and children are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1,			@id + 0,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2,			@id + 0,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When female has two husbands, but has children with none of them, none of them is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has sibling with spouses, sibling is displayed without his spouses and siblings are sorted
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male2',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 3,		@id + 5,		NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When ancestors depth is 0, siblings of person are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has multiple children, children are sorted by their birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has child with spouse and they do not have children, child without spouse is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has child with spouse and they have children, child with spouse and their children is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has child with spouse, they have children and descedants depth is 1, children without spouse is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When ancestors and descedants depth are both 2, generations until those levels are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6, 			@id + 7,			NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L4 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L4 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L5 Male',			NULL,			NULL,			NULL,			@id + 8, 			@id + 9,			NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L5 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L6 Male',			NULL,			NULL,			NULL,			@id + 10, 			@id + 11,			NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L6 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When ancestors are duplicated, they are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L4 Male',			NULL,			NULL,			NULL,			@id + 23, 			@id + 24,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L01 Male3',		NULL,			NULL,			NULL,			@id + 9, 			@id + 10,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L01 Female3',		NULL,			NULL,			NULL,			@id + 11, 			@id + 12,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L01 Male4',		NULL,			NULL,			NULL,			@id + 13, 			@id + 14,			NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L01 Female4',		NULL,			NULL,			NULL,			@id + 15, 			@id + 16, 			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L0 Male5',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L0 Female5',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L0 Male6',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L0 Female6',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L0 Male7',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 14, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L0 Female7',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L0 Male8',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 16, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L0 Female8',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 15, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 18, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 17, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				@id + 20, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L12 Female2',		NULL,			NULL,			NULL,			@id + 7, 			@id + 8,			NULL,				NULL,				@id + 19, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L2 Male',			NULL,			NULL,			NULL,			@id + 17, 			@id + 18,			NULL,				NULL,				@id + 22, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L2 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 21, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L3 Male',			NULL,			NULL,			NULL,			@id + 21, 			@id + 22,			NULL,				NULL,				@id + 24, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L3 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 23, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has sibling from his father and female sibling, duplicated female siblings are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L01 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When person has child with his own sibling, sibling and child are displayed only once
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children of descedants are married and do not have children, they are displayed only once and separately
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children of descedants are married and have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6,			@id + 7,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married but do not have children, they are displayed only once and not married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married but do not have children, they are displayed only once and not married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married and do have children, they are displayed only once and not married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married and do have children, they are displayed only once and married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When male sibling of person has child with persons child, duplicated male siblings are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Female',		NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When female sibling of person has child with persons child, duplicated female siblings are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Female2',		NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 5, 			@id + 4,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When child of person has child from persons grandchild, duplicated children of person are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L23 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When two children and one duplicated pair are in the same generation, horizontal children and duplicated paths are displayed correctly
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		@id + 4,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When three children and one duplicated pair are in the same generation, horizontal children and duplicated paths are displayed correctly
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		@id + 4,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When four children and two duplicated pairs are in the same generation, horizontal children and duplicated paths are displayed correctly
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female12',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		@id + 4,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female34',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 5,		@id + 7,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Male4',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L2 Male3',			NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L2 Male4',			NULL,			NULL,			NULL,			@id + 7, 			@id + 6,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When different duplicated persons are in different generations, duplicated persons in same generations are connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		@id + 4,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5,	 	@id + 7,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L2 Male4',			NULL,			NULL,			NULL,			@id + 4, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L3 Male1',			NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L3 Male2',			NULL,			NULL,			NULL,			@id + 7, 			@id + 6,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When duplicated persons are in same and different generations, duplicated persons in same and different generations are connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Female2',		NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5, 		@id + 6,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Male1',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 4,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L23 Male1',		NULL,			NULL,			NULL,			@id + 5, 			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L23 Male2',		NULL,			NULL,			NULL,			@id + 6, 			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)



-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================



-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When ancestors have multiple spouses, their spouses are displayed
SET @id = 10000;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L4 Male',			NULL,			NULL,			NULL,			@id + 1, 				@id + 2,		NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Male',			NULL,			NULL,			NULL,			@id + 3, 				@id + 4,		NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L3 Female',		NULL,			NULL,			NULL,			@id + 5,				@id + 6,		NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 7, 				@id + 8,		NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Female1',		NULL,			NULL,			NULL,			@id + 9,				@id + 10,		NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 11,				@id + 12,		NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Female2',		NULL,			NULL,			NULL,			@id + 13,				@id + 14,		NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 15,				@id + 16,		NULL,				NULL,				@id + 8,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 17,				@id + 18,		NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 21,				@id + 22,		NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Female2',		NULL,			NULL,			NULL,			@id + 24,				@id + 25,		NULL,				NULL,				@id + 9,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 29,				@id + 28,		NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L1 Female3',		NULL,			NULL,			NULL,			@id + 31,				@id + 30,		NULL,				NULL,				@id + 11,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L1 Male4',			NULL,			NULL,			NULL,			@id + 35,				@id + 34, 		NULL,				NULL,				@id + 14,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L1 Female4',		NULL,			NULL,			NULL,			NULL,					NULL,			NULL,				NULL,				@id + 13,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 16,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 15,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 18,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 19,		@id + 17,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 18,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L0 Female4',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 21,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L0 Male5',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 20,		@id + 22,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L0 Female5',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 21,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L0 Female6',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 24,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L0 Male7',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 23,		@id + 25,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 25,	'L0 Female7',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 26,		@id + 24,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 26,	'L0 Male8',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 25,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 27,	'L0 Male9',			NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 28,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 28,	'L0 Female9',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 29,		@id + 27,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 29,	'L0 Male10',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 28,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 30,	'L0 Female11',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 31,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 31,	'L0 Male12',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 30,		@id + 32,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 32,	'L0 Female12',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 31,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 33,	'L0 Male13',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 34,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 34,	'L0 Female13',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 35,		@id + 33,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 35,	'L0 Male14',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 34,		@id + 36,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 36,	'L0 Female14',		NULL,			NULL,			NULL,			NULL, 					NULL,			NULL,				NULL,				@id + 35,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When ancestors have adoptive parents, the ancestors of the adoptive parents are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			@id + 3,			@id + 4,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L2 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 6,			@id + 7,			@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L2 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 8,			@id + 9,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5,		@id + 3,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Male3',			NULL,			NULL,			NULL,			@id + 10,			@id + 11,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 12,			@id + 13,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 9,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 11,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When parents of adoptive parents are displayed, paths are displayed between them
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			@id + 3,			@id + 4,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 5,			@id + 6,			NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 5,			@id + 6,			NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When adoptive grandparent has hidden biological child, adoptive path is horizontally centered
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			@id + 3,			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				@id + 1,			@id + 2,			@id + 4,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has biological siblings, they and their spouses and displayed and sorted by birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 6,		@id + 1,		NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 1,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL, 				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female4',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 7,		@id + 9,		NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Male5',			NULL,			NULL,			NULL,			@id + 5, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+1993mmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 4,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has adoptive siblings, they and their spouses and displayed and sorted by birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 2, 			@id + 3,			@id + 6,		@id + 1,		NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 1,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5, 		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female4',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 2, 			@id + 3,			@id + 7,		@id + 9,		NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L1 Male5',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 5, 			@id + 3,			NULL,			NULL,			NULL,					NULL, 						1, 		'+1993mmdd',	NULL,		NULL),
		(	@id + 11,	'L1 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 2, 			@id + 4,			NULL, 			NULL,			NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has adoptive and biological siblings, they are all displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			@id + 3,			@id + 4,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 1,			@id + 2,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 3,			@id + 4,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male4',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 3,			@id + 4,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When ancestors depth is 0, siblings of person are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has adoptive child, adoptive child is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL, 				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 0,			@id + 1,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has adoptive grandchild, adoptive grandchild is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL, 				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 2,			@id + 3,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has adoptive descedants, its descedants are not displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL, 				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 0,			@id + 1,			@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)
		
-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has biological and adoptive descedants, they are all displayed and sorted by birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL, 				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL, 					NULL,						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				@id + 0,			@id + 1,			@id + 3,		@id + 5,		NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NUll,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When sibling is adopting child of person, adoptive path is displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			@id + 4,			@id + 5,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When grandchild is adopted by siblings and first sibling is the biological parent, grandchild is displayed only once
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L2 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			@id + 4,			@id + 5,			NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children of descedants are married and have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6,			@id + 7,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When ancestors and descedants depth are both 2, generations until those levels are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6, 			@id + 7,			NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L4 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L4 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L5 Male',			NULL,			NULL,			NULL,			@id + 8, 			@id + 9,			NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L5 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L6 Male',			NULL,			NULL,			NULL,			@id + 10, 			@id + 11,			NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L6 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When ancestors are duplicated, they are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L4 Male',			NULL,			NULL,			NULL,			@id + 23, 			@id + 24,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L01 Male3',		NULL,			NULL,			NULL,			@id + 9, 			@id + 10,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L01 Female3',		NULL,			NULL,			NULL,			@id + 11, 			@id + 12,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L01 Male4',		NULL,			NULL,			NULL,			@id + 13, 			@id + 14,			NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L01 Female4',		NULL,			NULL,			NULL,			@id + 15, 			@id + 16, 			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L0 Male5',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L0 Female5',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L0 Male6',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L0 Female6',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L0 Male7',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 14, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L0 Female7',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L0 Male8',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 16, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L0 Female8',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 15, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 18, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 17, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				@id + 20, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L12 Female2',		NULL,			NULL,			NULL,			@id + 7, 			@id + 8,			NULL,				NULL,				@id + 19, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L2 Male',			NULL,			NULL,			NULL,			@id + 17, 			@id + 18,			NULL,				NULL,				@id + 22, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L2 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 21, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L3 Male',			NULL,			NULL,			NULL,			@id + 21, 			@id + 22,			NULL,				NULL,				@id + 24, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L3 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 23, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has sibling from his father and female sibling, duplicated father and female siblings are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L01 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L01 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When person has child with his own sibling, sibling and child are displayed only once
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children of descedants are married and do not have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children of descedants are married and have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6,			@id + 7,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married but do not have children, they are displayed only once and married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married but do not have children, they are displayed only once and married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married and do have children, they are displayed only once and married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married and do have children, they are displayed only once and married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When male sibling of person has child with persons child, duplicated male sibling and persons child are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Female',		NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When female sibling of person has child with persons child, duplicated female sibling and persons child are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Female',		NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 5, 			@id + 4,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When child of person has child from persons grandchild, duplicated children of person are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Male2',		NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L23 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)



---- ===================================================================================================================================================================
---- ===================================================================================================================================================================
---- ===================================================================================================================================================================



-- ==========================================================================================================================
-- COMPLETE - When a person has a three generation family, generations are displayed on three levels
SET @id = 15000;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,	DeathDate,	ImageUrl)
VALUES
		(	@id + 0, 	'L0 Male1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 1,	'L0 Female1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 2,	'L0 Male2', 		NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 3,	'L0 Female2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 4,	'L1 Male1', 		NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 5,	'L1 Female1', 		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		NULL, 		NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL),
		(	@id + 7,	'L1 Male2', 		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		NULL, 		NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When child has biological and adoptive parents, biological and adoptive paths are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,				LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,	DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male1',				NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 1,	'L0 Female1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 2,	'L0 Male2',				NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 3,	'L0 Female2', 			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 4,	'L1 Male', 				NULL,			NULL,			NULL,			@id + 0, 			@id + 1, 			@id + 2,			@id + 3,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL)

-- ==========================================================================================================================
-- COMPLETE - When sibling groups and siblings are not sorted when loaded, they are sorted after loading
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Female',		NULL,			NULL,			NULL,			@id + 6, 			@id + 5,			NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+20080101',	NULL,	NULL),
		(	@id + 1,	'L1 Male',			NULL,			NULL,			NULL,			@id + 8, 			@id + 7,			NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		'+20070101',	NULL,	NULL),
		(	@id + 2,	'L1 Female2', 		NULL,			NULL,			NULL, 			@id + 8, 			@id + 7,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						0, 		'+20060101',	NULL,	NULL),
		(	@id + 3,	'L1 Female1', 		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+20050101',	NULL,	NULL),
		(	@id + 4,	'L1 Male1', 		NULL,			NULL,			NULL,			@id + 8, 			@id + 7, 			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+20040101',	NULL,	NULL),
		(	@id + 5,	'L0 Female2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+20030101',	NULL,	NULL),
		(	@id + 6,	'L0 Male2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+20020101',	NULL,	NULL),
		(	@id + 7,	'L0 Female1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+20010101',	NULL,	NULL),
		(	@id + 8,	'L0 Male1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+20000101',	NULL,	NULL)

-- ==========================================================================================================================
-- COMPLETE - When female is double married, both husbands are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 1,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL)


-- ==========================================================================================================================
-- COMPLETE - When male is double married, both wives are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 0,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When extended marriages have secondary marriage, they are chained based on the second marriage
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L1 Male',			NULL,			NULL,			NULL,			@id + 9, 			@id + 8,			NULL,				NULL,				@id + 2, 		@id + 0,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L1 Female3',		NULL,			NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,				@id + 1,		@id + 3,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 3,	'L1 Male3', 		NULL,			NULL,			NULL,			@id + 11, 			@id + 10,			NULL,				NULL,				@id + 5, 		@id + 2,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 4,	'L1 Male2', 		NULL,			NULL,			NULL,			@id + 12, 			@id + 13, 			NULL,				NULL,				@id + 7, 		@id + 5,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 3, 		@id + 4,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 6,	'L1 Male1', 		NULL,			NULL,			NULL,			@id + 14, 			@id + 15,			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 7,	'L1 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 4, 		@id + 6,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 8,	'L0 Female4',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 9,	'L0 Male4', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 10, 		@id + 8,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 10,	'L0 Female3',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 9, 		@id + 11,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 11,	'L0 Male3', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 13, 		@id + 10,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 12,	'L0 Male2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 15, 		@id + 13,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 13,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 11, 		@id + 12,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 14,	'L0 Male1', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 15, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 15,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 12, 		@id + 14,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When second wife of male has first spouse, that first spouse is also displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES

		(	@id + 0,	'L0 Mal2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3, 		@id + 1,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4,		@id + 0,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0,		@id + 2,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Male3',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When secondary marriage has biological and adoptive children, biological and adoptive paths are displayed from secondary marriage
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 4,		NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 3,	'L1 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				@id + 0,			@id + 1,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When older parents have younger children, children are sorted by parents first instead of birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+1993mmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+1994mmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+1995mmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+1996mmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+1997mmdd',	NULL,		NULL),
		(	@id + 8,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						1, 		'+1998mmdd',	NULL,		NULL),
		(	@id + 9,	'L2 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+1999mmdd',	NULL,		NULL),
		(	@id + 10,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 6, 			@id + 7,			NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						1, 		'+2000mmdd',	NULL,		NULL),
		(	@id + 11,	'L2 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						0, 		'+2001mmdd',	NULL,		NULL),
		(	@id + 12,	'L3 Male',			NULL,			NULL,			NULL,			@id + 8, 			@id + 9,			NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						1, 		'+2002mmdd',	NULL,		NULL),
		(	@id + 13,	'L3 Female',		NULL,			NULL,			NULL,			@id + 10,			@id + 11,			NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						0, 		'+2003mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When female is loaded first, her first husband is still loaded
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 0,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children have common parents, they are displayed in separate sibling groups
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 0,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male3',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male5',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L1 Male4',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL, 			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L1 Male6',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When parents are orphans on the second level, they are sorted by birthDates
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male3',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+1994mmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female3',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+1995mmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Male2',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 7,	 	NULL,			NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 7,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+1993mmdd',	NULL,		NULL),
		(	@id + 8,	'L2 Female1',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				@id + 8,	 	@id + 10,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L2 Female2',		NULL,			NULL,			NULL,			@id + 6, 			@id + 7,			NULL,				NULL,				@id + 9,	 	NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When marriage male has default birthDate, use female birthDate for sorting
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+1990mmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When having marriage with male having unknown birthDate and null female, use unknown birthDate of male instead of null from female for sorting
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When ancestors and descedants depth are both 2, generations until those levels are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6, 			@id + 7,			NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L3 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L4 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L4 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L5 Male',			NULL,			NULL,			NULL,			@id + 8, 			@id + 9,			NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L5 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L6 Male',			NULL,			NULL,			NULL,			@id + 10, 			@id + 11,			NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L6 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When ancestors are duplicated, they are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L4 Male',			NULL,			NULL,			NULL,			@id + 23, 			@id + 24,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L0 Male3',			NULL,			NULL,			NULL,			@id + 9, 			@id + 10,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L0 Female3',		NULL,			NULL,			NULL,			@id + 11, 			@id + 12,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L0 Male4',			NULL,			NULL,			NULL,			@id + 13, 			@id + 14,			NULL,				NULL,				@id + 8, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L0 Female4',		NULL,			NULL,			NULL,			@id + 15, 			@id + 16, 			NULL,				NULL,				@id + 7, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 9,	'L0 Male5',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 10, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 10,	'L0 Female5',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 9, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 11,	'L0 Male6',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 12, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 12,	'L0 Female6',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 11, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 13,	'L0 Male7',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 14, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 14,	'L0 Female7',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 13, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 15,	'L0 Male8',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 16, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 16,	'L0 Female8',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 15, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 17,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 18, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 18,	'L1 Female1',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 17, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 19,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 5, 			@id + 6,			NULL,				NULL,				@id + 20, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 20,	'L1 Female2',		NULL,			NULL,			NULL,			@id + 7, 			@id + 8,			NULL,				NULL,				@id + 19, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 21,	'L2 Male',			NULL,			NULL,			NULL,			@id + 17, 			@id + 18,			NULL,				NULL,				@id + 22, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 22,	'L2 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 21, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 23,	'L3 Male',			NULL,			NULL,			NULL,			@id + 21, 			@id + 22,			NULL,				NULL,				@id + 24, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 24,	'L23 Female',		NULL,			NULL,			NULL,			@id + 19, 			@id + 20,			NULL,				NULL,				@id + 23, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When person has sibling from his father and female sibling, duplicated female siblings are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 3,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L01 Female12',		NULL,			NULL,			NULL,			@id + 2, 			@id + 1,			NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When person has child with his own sibling, sibling and child are displayed only once
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 1,			@id + 2,			NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children of descedants are married and do not have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children of descedants are married and have children, they are displayed only once and married
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 5,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 4,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				@id + 7,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Female',		NULL,			NULL,			NULL,			@id + 4,			@id + 5,			NULL,				NULL,				@id + 6,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 8,	'L3 Male',			NULL,			NULL,			NULL,			@id + 6,			@id + 7,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married but do not have children, they are displayed only once and married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married but do not have children, they are displayed only once and married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married and do have children, they are displayed only once and married, with descedants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married and do have children, they are displayed only once and married, with descedants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L2 Male',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When male sibling of person has child with persons child, duplicated persons child are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Female',		NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When female sibling of person has child with persons child, duplicated persons child are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 3,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Female2',		NULL,			NULL,			NULL,			@id + 1, 			@id + 2,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L12 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 5, 			@id + 4,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When child of person has child from persons grandchild, duplicated child of person are marked and connected to each other
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L12 Male',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L2 Female',		NULL,			NULL,			NULL,			@id + 2, 			@id + 3,			NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L3 Male',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,	 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)



-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================



IF @addFamily = 1
BEGIN
	INSERT INTO Persons (
				FirstName, 			LastName, 				MaidenName, 	OtherNames, 	BiologicalFatherID, BiologicalMotherID, AdoptiveFatherID, AdoptiveMotherID, FirstSpouseID,	SecondSpouseID, FirstMarriageStartDate,	FirstMarriageEndDate,	SecondMarriageStartDate,	IsMale, BirthDate, 		DeathDate, 		ImageUrl)
	VALUES
	/* 1   */ (	'András', 			'Antal', 				NULL, 			'Púj', 			7, 					8, 					NULL,				NULL,			2, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19580310', 	NULL, 			'a802a6f1-cf37-47f9-9384-dcac755b2596.png'	),
	/* 2   */ (	'Irénke', 			'Antal', 				'Korpos', 		'Rigó',			6, 					5, 					NULL,				NULL,			1, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19620501', 	NULL, 			'd4691786-9873-4f29-bf20-ec23359cd1ae.png'	),
	/* 3   */ (	'Szabolcs-Csongor', 'Antal', 				NULL, 			NULL, 			1, 					2, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						1, 		'+19910816', 	NULL, 			'b045774e-7737-4c0b-b5b6-2b2a13abc112.png'	),
	/* 4   */ (	'Orsolya', 			'Antal', 				NULL, 			'Púj', 			1, 					2, 					NULL,				NULL,			17, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19830906', 	NULL, 			'38be15b0-386c-4527-a480-9f013f86487a.png'	),
	/* 5   */ (	'Katalin', 			'Korpos', 				'Gál-Máté',		'Czondi', 		15, 				16, 				NULL,				NULL,			6, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19410104', 	'+20130710',	'1de14600-ffdb-41fd-9628-37b0ddc7e078.png'	),
	/* 6   */ (	'János', 			'Korpos', 				NULL, 			'Rigó, Ács', 	13, 				14, 				NULL,				NULL,			5, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19320423', 	'+19960909',	'111e1d9c-9e72-42c9-9074-3ebdead96f48.png'	),
	/* 7   */ (	'András', 			'Antal', 				NULL,	 		'Púj', 			9, 					10, 				NULL,				NULL,			8, 				NULL,			'+19570928',			NULL,					NULL, 						1, 		'+19370601', 	'+19880818',	'618db659-b641-498f-b3f0-d9eb3e710061.png'	),
	/* 8   */ (	'Ilona', 			'Antal', 				'Márton', 		'Kűpál',		11, 				12, 				NULL,				NULL,			7, 				NULL,			'+19570928',			NULL,					NULL, 						0, 		'+19400925', 	NULL, 			'415ccbbc-16d9-4ec1-9622-2fc0e41000ec.png'	),
	/* 9   */ (	'János', 			'Antal', 				NULL, 			'Púj',		 	62, 				63, 				NULL,				NULL,			10, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19100625', 	'+19990406',	'39cc7ae0-68be-4960-9358-44bc9e725962.png'	),
	/* 10  */ (	'Erzsébet',			'Antal', 				'Kovács',		'Baka', 		53, 				54, 				NULL,				NULL,			9, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19140201', 	'+19930428',	'c35271dd-b992-4a6c-b101-cf0af9ea0625.png'	),
	/* 11  */ (	'János', 			'Márton', 				NULL, 			'Kűpál',		254, 				255, 				NULL,				NULL,			12, 			NULL,			'+19290831',			NULL,					NULL, 						1, 		'+19090929', 	'+19690927',	'3b37e71c-ea22-49be-aafe-f8d67a30661d.png'	),
	/* 12  */ (	'Ilona', 			'Márton', 				'Mihály',		'Bori',		 	195, 				196, 				NULL,				NULL,			11, 			NULL,			'+19290831',			NULL,					NULL, 						0, 		'+19101205', 	'+19840428',	'f7d28d6b-fad6-4b17-8460-c4400fce4222.png'	),
	/* 13  */ (	'Márton', 			'Korpos', 				NULL, 			'Rigó, Ács',	153, 				154, 				NULL,				NULL,			14, 			NULL,			'+19270924',			NULL,					NULL, 						1, 		'+1902mmdd', 	'+19640106',	NULL										),
	/* 14  */ (	'Katalin', 			'Korpos', 				'Albert',		'Kukó',	 		111, 				113, 				NULL,				NULL,			13, 			NULL,			'+19270924',			NULL,					NULL, 						0, 		'+19081125', 	'+19901120', 	NULL										),
	/* 15  */ (	'Márton', 			'Gál-Máté', 			NULL, 			'Czondi', 		95, 				97, 				NULL,				NULL,			16, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
	/* 16  */ (	'Katalin',			'Gál-Máté', 			'Ambrus-Péter', 'Péter', 		101, 				102, 				NULL,				NULL,			15, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+yyyymmdd', 	NULL										),
	/* 17  */ (	'Lóránd', 			'Silye', 				NULL,			NULL, 			NULL, 				NULL,				NULL,				NULL,			4, 				NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19800820', 	NULL, 			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
	/* 18  */ (	'Sámuel', 			'Silye', 				NULL,			NULL, 			17, 				4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						1, 		'+20200226', 	NULL, 			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	),
	/* 19  */ (	'Albert', 			'Antal', 				NULL,			NULL, 			7, 					8, 					NULL,				NULL,			20, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19660816', 	NULL,			'82d99b02-6436-4066-883f-4fedc76befee.png'	),
	/* 20  */ (	'Ildikó', 			'Antal', 				'Mihály',		'Gulé', 		NULL, 				NULL, 				NULL,				NULL,			19, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+yyyymmdd', 	'ee6cd0db-3079-461f-82cd-b05715efd8ca.png'	),
	/* 21  */ (	'Emese', 			'Báint-Kovács Antal', 	'Antal', 		'Púj', 			19, 				20, 				NULL,				NULL,			22, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19910830', 	NULL, 			'537dedfd-9314-4606-8e3f-2a4e58c49b95.png'	),
	/* 22  */ (	'Zsolt', 			'Kovács', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			21, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19881025', 	NULL, 			'61f08d10-a000-48b6-8a7c-b8cff7ce4650.png'	),
	/* 23  */ (	'Éva', 				'Ekler', 				'Antal', 		'Púj', 			19, 				20, 				NULL,				NULL,			24, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'1e672af6-c2d7-4b34-b7fe-475b47530c31.png'	),
	/* 24  */ (	'Péter', 			'Ekler', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			23, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'0c5cbc5b-3f89-4380-9b61-93df1432afd1.png'	),
	/* 25  */ (	'Lili', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'dad07321-9861-4fd5-bf9b-4b0371560218.png'	),
	/* 26  */ (	'Áron', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'9f508c01-575e-4d99-91ba-f0d6786f3228.png'	),
	/* 27  */ (	'Ádám', 			'Ekler', 				NULL, 			NULL, 			24, 				23, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'0c7519f9-6db7-443c-98eb-6f34358efe5e.png'	),
	/* 28  */ (	'Attila', 			'Korpos', 				NULL, 			NULL, 			6, 					5, 					NULL,				NULL,			29, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	'e6615a1a-dfcc-4b41-b791-4cda4f335666.png'	),
	/* 29  */ (	'Kati', 			'Korpos', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			28, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'09a089ea-0e23-43c1-a8b9-6593b6414d1d.png'	),
	/* 30  */ (	'Lehel', 			'Korpos', 				NULL, 			NULL, 			28, 				29, 				NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'a8b546f2-1976-4f71-89fe-63772b29becc.png'	),
	/* 31  */ (	'Anna-Dóra', 		'Silye', 				NULL, 			NULL, 			17, 				4, 					NULL,				NULL,			NULL, 			NULL,			NULL,					NULL,					NULL, 						0, 		'+20240308', 	NULL, 			'1944c64b-0ebc-44ed-98f8-53d371205b53.png'	),
	/* 32  */ (	'János', 			'Antal', 				NULL, 			'Magyar', 		NULL, 				NULL, 				NULL,				NULL,			52, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	'+yyyymmdd', 	'15f539b4-f773-4246-a469-24fb6a788b09.png'	),
	/* 33  */ (	'Erzsébet', 		'Antal', 				'Kovács',		'Baka',			NULL, 				NULL, 				NULL,				NULL,			33, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+20190509', 	'+19410509', 	NULL 										),
	/* 34  */ (	'Miklós', 			'Péntek', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			35, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'f3df6706-a6b9-4934-ae1c-5d6e0e53c482.png'	),
	/* 35  */ (	'Anna', 			'Péntek', 				'Antal', 		'Magyar', 		32, 				52, 				NULL,				NULL,			34, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'3282b3a0-4cd6-4e2c-9c49-efeaa0d53ca5.png'	),
	/* 36  */ (	'Rezső', 			'Zalányi', 				NULL, 			NULL, 			NULL, 				NULL, 				NULL,				NULL,			37, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'1ed17ba3-b9f6-4b4b-bff5-05f0ebb154fd.png'	),
	/* 37  */ (	'Tímea', 			'Zalányi-Péntek', 		'Péntek',		'Piszikiri',	34, 				35, 				NULL,				NULL,			36, 			NULL,			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'bec0a203-db18-4a24-9e06-885c25a6870b.png'	),
	/* 38  */ (	'Csilla',			'Péntek',				'Péntek',		'Piszkiri',		34, 				35, 				NULL, 				NULL,			39, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'0bc341fc-d2e8-40ff-a347-3e1142d3221c.png'	),
	/* 39  */ (	'Róbert',			'Péntek',				NULL,			'Laci',			NULL, 				NULL, 				NULL, 				NULL,			38, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'e96c8649-35c4-4185-9a3e-a6f12530006f.png'	),
	/* 40  */ (	'Lehel',			'Zalányi',				NULL,			NULL,			36, 				37, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 41  */ (	'Gyerek1',			'Péntek',				NULL,			NULL,			39, 				38, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 42  */ (	'Gyerek2',			'Péntek',				NULL,			NULL,			39, 				38, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 43  */ (	'Erzsébet',			'Szalai',				'Gál-Máté',		'Czondi',		15, 				16, 				NULL, 				NULL,			44, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1926mmdd',  	'+1998mmdd', 	'6fc5d2e4-656b-42bc-a324-217c5ccba0f0.png'	),
	/* 44  */ (	'Ferenc',			'Szalai',				NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			43, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL 										),
	/* 45  */ (	'Katalin',			'Ruzsa-Gyuri',			'Szalai',		NULL,			44, 				43, 				NULL, 				NULL,			46, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'a9ecf1f1-c146-4071-9a12-c206615c65cd.png'	),
	/* 46  */ (	'Márton',			'Ruzsa-Gyuri',			NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			45, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL,		 	'3a8247cd-b2e4-4c48-8f3c-5475c026784e.png'	),
	/* 47  */ (	'Mártonka',			'Ruzsa-Gyuri',			NULL,			NULL,			46, 				45, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL 										),
	/* 48  */ (	'Gerlinde',			'Schmaler Ruzsa',		NULL,			NULL,			58, 				57, 				46, 				45,				59, 			49, 			'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd', 				0, 		'+yyyymmdd',  	NULL, 			'02612545-c561-4f08-b55a-5f09268c8280.png'	),
	/* 49  */ (	'László',			'Gál',					NULL,			NULL,			NULL, 				NULL, 				NULL, 				NULL,			48, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'f64e8bd1-9059-408e-af50-6cc5852f7cd0.png'	),
	/* 50  */ (	'Rebeka',			'Gál',					NULL,			NULL,			49, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'f8c61e5a-cc91-456b-89a5-ad7516e63404.png'	),
	/* 51  */ (	'Tamás',			'Gál',					NULL,			NULL,			49, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'8dda7278-93eb-41d3-86e4-b2ca0607a9f5.png' 	),
	/* 52  */ (	'Erzsébet',			'Antal',				'Kovács',		'Baka',			9, 					10, 				55, 				56,				32, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	'+yyyymmdd', 	'30a1a445-3814-4f2f-bd7c-56b63c906898.png'	),
	/* 53  */ (	'György',			'Kovács',				NULL,			'Baka',			291, 				292, 				NULL, 				NULL,			54, 			NULL, 			'+18981112',			NULL,					NULL, 						1, 		'+18720523', 	'+19161226', 	'014fde85-12c2-437f-b958-b27316ddc2f9.png'	),
	/* 54  */ (	'Ilona',			'Péntek',				'Kis',			NULL,			NULL, 				NULL, 				NULL, 				NULL,			53, 			NULL, 			'+18981112',			NULL,					NULL, 						0, 		'+18770307', 	'+19480121', 	NULL 										),
	/* 55  */ (	'György',			'Kovács',				NULL,			'Baka',			53, 				54, 				NULL, 				NULL,			56, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18990811', 	'+yyyymmdd', 	'7a57c3d8-fffe-43e7-8647-7f7d97572d68.png'	),
	/* 56  */ (	'Katalin',			'Kovács',				'Antal',		'Púj',			62, 				63, 				NULL, 				NULL,			55, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19001021', 	NULL,			'02bd4eeb-df2a-44ab-8f38-bd9c623a8f06.png'	),
	/* 57  */ (	'Anyja',			'Lindanak',				NULL,           NULL,			NULL, 				NULL, 				NULL, 				NULL,			58, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 58  */ (	'Apja',				'Lindanak',				NULL,           NULL,			NULL, 				NULL, 				NULL, 				NULL,			57, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 59  */ (	'Zoltán Pál',		'Takács',				NULL,           NULL,			NULL, 				NULL, 				NULL, 				NULL,			48, 			60, 			'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd', 				1, 		'+yyyymmdd',  	NULL, 			'64afb2cf-3fa0-482d-8caf-ebf8b09587d6.png' 	),
	/* 60  */ (	'Kata',				'Takács',				'Kató',         NULL,			NULL, 				NULL, 				NULL, 				NULL,			59, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'a981ad6a-456f-42c5-bbed-fd0d98db864f.png' 	),
	/* 61  */ (	'Benjámin',			'Takács',				NULL,           NULL,			59, 				48, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'22436f79-f212-459c-b7c1-e3f0fe2175f4.png' 	),
	/* 62  */ (	'János',			'Antal',				NULL,           'Púj',			349, 				350, 				NULL, 				NULL,			63, 			NULL, 			'+18981130',			NULL,					NULL, 						1, 		'+18741028',  	'+19540916',	NULL									 	),
	/* 63  */ (	'Erzsébet',			'Antal',				'Péntek',       'Pistika, Jankó',296, 				297, 				NULL, 				NULL,			62, 			NULL, 			'+18981130',			NULL,					NULL, 						0, 		'+18780706',  	'+19540913', 	'453661ed-0751-4ef5-89ab-3d66172021a8.png' 	),
	/* 64  */ (	'János',			'Ambrus',				NULL,           'Pál-Pista',	NULL, 				NULL, 				NULL, 				NULL,			65, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd',	NULL									 	),
	/* 65  */ (	'Anna',				'Ambrus',				'Gál-Máté',     'Czondi',		15, 				16, 				NULL, 				NULL,			64, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL									 	),
	/* 66  */ (	'Kata',			    'Zalányi',				NULL,			NULL,			36, 				37, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 67  */ (	'Gyerek3',			'Péntek',				NULL,			NULL,			39, 				38, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL 										),
	/* 68  */ (	'Ferenc',			'Szalai',				NULL,	     	NULL,			44, 				43, 				NULL, 				NULL,			69, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'61566e2a-9917-4835-b936-0d5fc225be7e.png'	),
	/* 69  */ (	'felesége',			'Szalai',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			68, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL									 	),
	/* 70  */ (	'Júlia',			'Salajan',				'Szalai',	   	NULL,			68, 				69, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL,	 		'543a10fa-56d2-4aeb-b889-fa71486126e9.png'	),
	/* 71  */ (	'László',			'Szalai',				NULL,	     	NULL,			44, 				43, 				NULL, 				NULL,			72, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL									 	),
	/* 72  */ (	'Irénke',			'Szalai',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			71, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL									 	),
	/* 73  */ (	'Laszló',			'Szalai',				NULL,	     	NULL,			71, 				72, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'dcf782a8-0199-4ae6-af58-43c58534aefb.png'	),
	/* 74  */ (	'Levente',			'Szalai',				NULL,	     	NULL,			71, 				72, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'260af449-9ea8-4232-b801-3017b2cfcfe2.png'	),
	/* 75  */ (	'?',				'Csüdöm',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			76, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'299e06b0-a8d1-440f-a738-22658a98a030.png'	),
	/* 76  */ (	'Judit',			'Csüdömné Szalai',		'Szalai',     	NULL,			71, 				72, 				NULL, 				NULL,			75, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'45c973cf-0cbd-4500-b237-07529ef6620f.png'	),
	/* 77  */ (	'?',				'Csüdöm',				NULL,	     	NULL,			75, 				76, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'71656d0a-d6e0-458d-899e-f18d9a4242a0.png'	),
	/* 78  */ (	'?',				'Csüdöm',				NULL,	     	NULL,			75, 				76, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'0bc3e1d4-bdc9-4eaf-8e7e-32472dc3141f.png'	),
	/* 79  */ (	'Ernő',				'Ambrus',				NULL,	     	NULL,			64, 				65, 				NULL, 				NULL,			80, 			NULL, 			'+19761016',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'ed1673ea-aabc-4665-9cc5-1621e3bc999f.png'	),
	/* 80  */ (	'Annus',			'Ambrus',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			79, 			NULL, 			'+19761016',			NULL,					NULL, 						0, 		'+yyyymmdd', 	'+2018mmdd',	'92951830-3bff-4f49-96c8-dcac30f22989.png'	),
	/* 81  */ (	'Levente',			'Gál Boncsi',			NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			82, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'9cc048b9-cd5e-4d72-86e7-5e156f556feb.png'	),
	/* 82  */ (	'Krisztina Andrea',	'Gál Boncsi',			'Ambrus',     	NULL,			79, 				80, 				NULL, 				NULL,			81, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'a048e041-2a31-4b74-a23c-b2671414b504.png'	),
	/* 83  */ (	'Zita',				'Gál Boncsi  ',			NULL,	     	NULL,			81, 				82, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'47d6e9c9-2eea-47c8-8d48-f2c4798a6087.png'	),
	/* 84  */ (	'Szandi',			'Gál Boncsi',			NULL,	     	NULL,			81, 				82, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'b8530b35-06e9-4b67-a92f-5e99a0c9ec74.png'	),
	/* 85  */ (	'László',			'Kállay',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			86, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'11152c58-8e31-4178-9f72-7293f73d94d4.png'	),
	/* 86  */ (	'Katalin',			'Kállay',				'Ambrus',     	NULL,			79, 				80, 				NULL, 				NULL,			85, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'fb6bce99-6521-4d24-9196-5ffdd3cc26f4.png'	),
	/* 87  */ (	'Roland',			'Kállay',				NULL,	     	NULL,			85, 				86, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'4be0d892-f762-4e05-a8c3-75b646596f7c.png'	),
	/* 88  */ (	'Krisztián',		'Kállay',				NULL,	     	NULL,			85, 				86, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'963d49d4-88bf-40e5-b92f-0b9b01890134.png'	),
	/* 89  */ (	'János',			'Ambrus',				NULL,	     	NULL,			64, 				65, 				NULL, 				NULL,			90, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'd8c21ea5-404b-4d3e-96c0-1871dd687c08.png'	),
	/* 90  */ (	'Hajnal',			'Ambrus',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			89, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'168f7a90-6703-4f97-9465-d27b8d248194.png'	),
	/* 91  */ (	'Róbert',			'Ambrus',				NULL,	     	NULL,			89, 				90, 				NULL, 				NULL,			92, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			'ee7f79b7-9a4c-4ef9-870c-7164022bfad9.png'	),
	/* 92  */ (	'Ildikó',			'Ambrus',				'Birta',     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			91, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			'b79834b6-7ef1-416f-bd39-157c690dc6ce.png'	),
	/* 93  */ (	'Tóni',				'Ambrus',				NULL,	     	NULL,			89, 				90, 				NULL, 				NULL,			94, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 94  */ (	'felesége',			'Ambrus',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			93, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 95  */ (	'János',			'Gál-Máté',				NULL,	     	'Czondi',		NULL, 				NULL, 				NULL, 				NULL,			96, 			97, 			'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd', 				1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 96  */ (	'János e. felesége','Gál-Máté',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			95, 			NULL, 			'+yyyymmdd',			'+yyyymmdd',			NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 97  */ (	'János m. felesége','Gál-Máté',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			95, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 98  */ (	'István',			'Gál-Máté',				NULL,	     	'Czondi',		95, 				97, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 99  */ (	'János',			'Ambrus',				NULL,	     	'Pál-Pista',	NULL, 				NULL, 				NULL, 				NULL,			100, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 100 */ (	'Erzsébet',			'Ambrus',				'Gál-Máté',	    'Czondi',		95, 				97, 				NULL, 				NULL,			99, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 101 */ (	'?',				'Ambrus-Péter',			NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			102, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 102 */ (	'?',				'Ambrus-Péter',			NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			101, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 103 */ (	'István',			'Ambrus-Péter',			NULL,	     	'Péter',		101, 				102, 				NULL, 				NULL,			104, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 104 */ (	'?',				'Ambrus-Péter',			NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			103, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 105 */ (	'István',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 106 */ (	'János',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 107 */ (	'Sándor',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 108 */ (	'Ferenc',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 109 */ (	'Márton',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 110 */ (	'Erzsébet',			'Ambrus-Péter',			NULL,	     	'Péter',		103, 				104, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',  	NULL, 			NULL	),
	/* 111 */ (	'György',			'Albert',				NULL,	     	'Kukó',			123, 				124, 				NULL, 				NULL,			112, 			113, 			'+18840521',			'+yyyymmdd',			'+19060604', 				1, 		'+18610301',  	'+19260320', 	NULL	),
	/* 112 */ (	'Kata',				'Albert',				'Tamás',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			111, 			NULL, 			'+18840521',			'+yyyymmdd',			NULL, 						0, 		'+18641029',  	'+19051122', 	NULL	),
	/* 113 */ (	'Kata',				'Albert',				'Albert',	    NULL,			117, 				118, 				NULL, 				NULL,			111, 			NULL, 			'+19060604',			NULL,					NULL, 						0, 		'+18831217',  	'+19190517', 	NULL	),
	/* 114 */ (	'András',			'Kovács',				NULL,	     	NULL,			NULL, 				NULL, 				NULL, 				NULL,			115, 			NULL, 			'+19030209',			NULL,					NULL, 						1, 		'+18800627',  	'+19560702', 	NULL	),
	/* 115 */ (	'Erzsébet',			'Kovács',				'Albert',	    NULL,			117, 				118, 				NULL, 				NULL,			114, 			NULL, 			'+19030209',			NULL,					NULL, 						0, 		'+18870214',  	'+19450206', 	NULL	),
	/* 116 */ (	'Erzsébet',			'Albert',				'Mihály',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			117, 			NULL, 			'+18700223',			'+yyyymmdd',			NULL, 						0, 		'+18521201',  	'+18720711', 	NULL	),
	/* 117 */ (	'György',			'Albert',				NULL,	    	'Pali',			NULL, 				NULL, 				NULL, 				NULL,			116, 			118, 			'+18700223',			'+yyyymmdd',			'+yyyymmdd', 				1, 		'+18440416',  	'+18921216', 	NULL	),
	/* 118 */ (	'Kata',				'Albert',				'Hadházi',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			117, 			119, 			'+yyyymmdd',			'+yyyymmdd',			'+18950417', 				0, 		'+yyyymmdd',  	'+19260916', 	NULL	),
	/* 119 */ (	'György',			'Antal',				NULL,		    NULL,			NULL, 				NULL, 				NULL, 				NULL,			118, 			NULL, 			'+18950417',			NULL,					NULL, 						1, 		'+yyyymmdd',  	'+yyyymmdd', 	NULL	),
	/* 120 */ (	'Albert',			'Ferenc',				NULL,		    'Gyuri',		123, 				124, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18710316',  	'+yyyymmdd', 	NULL	),
	/* 121 */ (	'János',			'Márton',				NULL,		    'Balogh',		NULL, 				NULL, 				NULL, 				NULL,			122, 			NULL, 			'+18810517',			NULL,					NULL, 						1, 		'+18571107',  	'+19220324', 	NULL	),
	/* 122 */ (	'Erzsébet',			'Márton',				'Albert',		'Gyuri',		123, 				124, 				NULL, 				NULL,			121, 			NULL, 			'+18810517',			NULL,					NULL, 						0, 		'+18640512',  	'+19411014', 	NULL	),
	/* 123 */ (	'György',			'Albert',				NULL,		    'Gyuri',		NULL, 				NULL, 				NULL, 				NULL,			124, 			NULL, 			'+18580526',			NULL,					NULL, 						1, 		'+18360120',  	'+19080428', 	NULL	),
	/* 124 */ (	'Anna',				'Albert',				'Péntek',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			123, 			NULL, 			'+18950417',			NULL,					NULL, 						0, 		'+18390529',  	'+19090505', 	NULL	),
	/* 125 */ (	'?',				'Albert',				NULL,	    	'Kukó',			111, 				113, 				NULL, 				NULL,			126, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 126 */ (	'?',				'Albert',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			125, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 127 */ (	'?',				'Albert',				NULL,	    	'Depó',			NULL, 				NULL, 				NULL, 				NULL,			128, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 128 */ (	'?',				'Albert',				'?',	    	'Kukó',			111, 				113, 				NULL, 				NULL,			127, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 129 */ (	'Albert',			'Albert',				NULL,	    	'Kukó',			125, 				126, 				NULL, 				NULL,			130, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 130 */ (	'Katalin',			'Albert',				'Albert',	    'Kokas',		NULL, 				NULL, 				NULL, 				NULL,			129, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 131 */ (	'Ferenc',			'Albert',				NULL,	    	'Depó',			127, 				128, 				NULL, 				NULL,			132, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 132 */ (	'Katalin',			'Albert',				'?',	    	'Depó',			NULL, 				NULL, 				NULL, 				NULL,			131, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 133 */ (	'Piroska',			'?',					'Albert',	    'Depó',			127, 				128, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 134 */ (	'?',				'Balázs',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			135, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 135 */ (	'Erzsébet',			'Balázs',				'Albert',	    NULL,			127, 				128, 				NULL, 				NULL,			134, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			NULL	),
	/* 136 */ (	'Albert',			'Albert',				NULL,	    	'Kukó',			129, 				130, 				NULL, 				NULL,			137, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'eebf2c58-73ae-4c29-a524-f4b58cd3a5f0.png'	),
	/* 137 */ (	'Gyöngyi',			'Albert',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			136, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'8204850d-59a1-429b-b9e7-c648fefec07d.png'	),
	/* 138 */ (	'?',				'Vincze',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			139, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'a62def92-c5ee-452c-9d8b-6c728436fe7a.png'	),
	/* 139 */ (	'Ibolya',			'Vincze',				'Albert',	    'Depó',			131, 				132, 				NULL, 				NULL,			138, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'fcf380ba-38d9-47f7-b3a3-a4a27f27bdba.png'	),
	/* 140 */ (	'Gyula',			'Balázs',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			141, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'820fd319-0363-4fd2-9cba-f2f19cb60599.png'	),
	/* 141 */ (	'Éva',				'Balázs',				'Balázs',	    'Cicika',		134, 				135, 				NULL, 				NULL,			140, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'97a0514f-3e4e-467e-b8e1-4740ad9cbb97.png'	),
	/* 142 */ (	'Hédi',				'Albert',				NULL,	    	'Kukó',			136, 				137, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'0f6bfb33-1b62-432c-b211-c67e78546c57.png'	),
	/* 143 */ (	'Szilárd',			'Vincze',				NULL,	    	NULL,			138, 				139, 				NULL, 				NULL,			144, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'f22cc14d-2d07-4422-9e9f-36f1c41ddb62.png'	),
	/* 144 */ (	'Tímea',			'Vincze',				'?',		    NULL,			NULL, 				NULL, 				NULL, 				NULL,			143, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'125916db-e0df-4960-a331-f88dea79e311.png'	),
	/* 145 */ (	'Ernő',				'Kupas',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			146, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'5e895ef6-2522-4a3f-b7e8-f93cc5b380e5.png'	),
	/* 146 */ (	'Noémi',			'Kupas',				'Vincze',    	NULL,			138, 				139, 				NULL, 				NULL,			145, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd', 	NULL, 			'b3d3f4ef-ac26-47c9-a1d5-928f5aa9d912.png'	),
	/* 147 */ (	'Tibor',			'Balázs',				NULL,	    	NULL,			140, 				141, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'3433fa7b-548a-449f-ae26-514f070cce00.png'	),
	/* 148 */ (	'Zoltán',			'Balázs',				NULL,	    	NULL,			140, 				141, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'4a05af5b-1694-46bc-862a-7ada1e9310ba.png'	),
	/* 149 */ (	'Márk',				'Kupas',				NULL,	    	NULL,			145, 				146, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd', 	NULL, 			'5687b3a9-7338-4d93-852c-0bb5d29b9a21.png'	),
	/* 150 */ (	'Erzsébet',			'Korpos',				'Korpos',	    'Újgazda',		159, 				160, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL,						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 151 */ (	'András',			'Korpos',				NULL,	    	'Ács, Rigó',	13, 				14, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL,						1, 		'+19281117',	'+19290912', 	NULL	),
	/* 152 */ (	'Albert',			'Korpos',				NULL,	    	'Ács, Rigó',	13, 				14, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL,						1, 		'+19300713',	'+19300713', 	NULL	),
	/* 153 */ (	'?',				'Korpos',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			154, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 154 */ (	'?',				'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			153, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 155 */ (	'János',			'Korpos',				NULL,	    	'Újgazda',		153, 				154, 				NULL, 				NULL,			156, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 156 */ (	'?',				'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			155, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 157 */ (	'?',				'Kovács',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			158, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 158 */ (	'Kata',				'Kovács',				'Korpos',		'Újgazda',		153, 				154, 				NULL, 				NULL,			157, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 159 */ (	'Dezső',			'Korpos',				NULL,	    	'Újgazda',		155, 				156, 				NULL, 				NULL,			160, 			NULL, 			'+194905dd',			NULL,					NULL,						1, 		'+19220831',	'+19870907', 	NULL	),
	/* 160 */ (	'Erzsébet',			'Korpos',				'Kovács',		'Jankó',		NULL, 				NULL, 				NULL, 				NULL,			159, 			NULL, 			'+194905dd',			NULL,					NULL, 						0, 		'+19250304',	'+20110902', 	NULL	),
	/* 161 */ (	'Ferenc',			'Korpos',				NULL,	    	'Újgazda',		155, 				156, 				NULL, 				NULL,			162, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 162 */ (	'Erzsébet',			'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			161, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 163 */ (	'Erzsébet',			'?',					'Korpos',		'Újgazda',		155, 				156, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 164 */ (	'András',			'Korpos',				NULL,	    	'Újgazda',		155, 				156, 				NULL, 				NULL,			165, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 165 */ (	'Éva',				'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			164, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 166 */ (	'Dezső',			'Korpos',				NULL,	    	'Újgazda',		159, 				160, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 167 */ (	'Albert',			'Korpos',				NULL,	    	'Újgazda',		159, 				160, 				NULL, 				NULL,			168, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'f6a4a51f-cede-4c7f-9d6d-95a986225300.png'	),
	/* 168 */ (	'Krisztina',		'Korpos',				NULL,	    	'Újgazda',		NULL, 				NULL, 				NULL, 				NULL,			167, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'da7eed46-154c-4fa7-b8f2-07255c4891ac.png'	),
	/* 169 */ (	'István',			'Korpos',				'?',	    	'Újgazda',		159, 				160, 				NULL, 				NULL,			170, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'5a070f67-c17f-47cf-8983-0c19490d11e6.png'	),
	/* 170 */ (	'Jutka',			'Korpos',				'Márton',	    'Csige',		NULL, 				NULL, 				NULL, 				NULL,			169, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'2eae212d-1072-4775-9620-3f06f47353e3.png'	),
	/* 171 */ (	'Ferenc',			'Korpos',				NULL,	    	'Újgazda',		161, 				162, 				NULL, 				NULL,			172, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 172 */ (	'Piroska',			'Korpos',				'?',	    	'Újgazda',		NULL, 				NULL, 				NULL, 				NULL,			171, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'd18fa675-5ea8-47fd-9a61-994638e691b8.png'	),
	/* 173 */ (	'Gyula',			'Bakki',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			174, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 174 */ (	'Tünde',			'Bakki',				'Korpos',	    'Újgazda',		161, 				162, 				NULL, 				NULL,			173, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 175 */ (	'János',			'Péter',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			176, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 176 */ (	'Éva',				'Péter',				'Korpos',	    NULL,			164, 				165, 				NULL, 				NULL,			175, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 177 */ (	'Levente',			'Kulcsár',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			178, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'0fe3388a-c2de-436c-a79b-9a03d7d56b13.png'	),
	/* 178 */ (	'Mónika',			'Kulcsár',				'Korpos',	    NULL,			171, 				172, 				NULL, 				NULL,			177, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'ccc28156-0b93-4265-ae7f-976a4c41cdce.png'	),
	/* 179 */ (	'Krisztián',		'Plesa',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			180, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'b1f0aacd-bc2c-4d5a-b99a-ed1aebcc3bc0.png'	),
	/* 180 */ (	'Csilla',			'Plesa-Korpos',			'Korpos',	    NULL,			171, 				172, 				NULL, 				NULL,			179, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'9fbeddc7-21f6-4e52-9b49-ede9a0983871.png'	),
	/* 181 */ (	'?',				'Bakki',				NULL,	    	NULL,			173, 				174, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 182 */ (	'?',				'Bakki',				NULL,	    	NULL,			173, 				174, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 183 */ (	'Csongor Barna',	'Péter',				NULL,	    	NULL,			175, 				176, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'49c80022-52f2-4f8d-b47e-676f44d05041.png'	),
	/* 184 */ (	'Éva',				'Péter',				'Péter',	    NULL,			175, 				176, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'89270707-5963-4627-b4aa-8665bd6cc02f.png'	),
	/* 185 */ (	'?',				'Takács',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			186, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 186 */ (	'Kinga',			'Takács',				'Péter',	    NULL,			175, 				176, 				NULL, 				NULL,			185, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'09581ab3-1b8d-430f-bde8-d99a9c74a0b6.png'	),
	/* 187 */ (	'?',				'Kulcsár',				NULL,	    	NULL,			177, 				178, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'8e634c92-7c62-4a4c-bfb2-4648e7665400.png'	),
	/* 188 */ (	'?',				'Kulcsár',				NULL,	    	NULL,			177, 				178, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'46600c76-1e52-4a18-bc6d-aa033eae5084.png'	),
	/* 189 */ (	'Erzsébet',			'Mihály',				'Márton',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			190, 			NULL, 			'+18480516',			'+yyyymmdd',			NULL, 						0, 		'+18291223',	'+18610811', 	NULL	),
	/* 190 */ (	'Márton',			'Mihály',				NULL,	    	'Bori',			NULL, 				NULL, 				NULL, 				NULL,			189, 			191, 			'+18480516',			'+yyyymmdd',			'+18620115', 				1, 		'+18290214',	'+18900629', 	NULL	),
	/* 191 */ (	'Anna',				'Mihály',				'Péntek',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			190, 			NULL, 			'+18620115',			NULL,					NULL, 						0, 		'+18410601',	'+yyyymmdd', 	NULL	),
	/* 192 */ (	'János',			'Kovács',				NULL,	    	'Mocsi',		NULL, 				NULL, 				NULL, 				NULL,			193, 			NULL, 			'+18740606',			NULL,					NULL, 						1, 		'+18480213',	'+yyyymmdd', 	NULL	),
	/* 193 */ (	'Borbála',			'Kovács',				'Mihály',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			192, 			NULL, 			'+18740606',			NULL,					NULL, 						0, 		'+18531212',	'+19340901', 	NULL	),
	/* 194 */ (	'Márton',			'Mihály',				NULL,	    	'Bori',			190, 				189, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18560717',	'+18830526', 	NULL	),
	/* 195 */ (	'János',			'Mihály',				NULL,	    	'Bori Zsidó',	190, 				191, 				NULL, 				NULL,			197, 			196, 			'+18890911',			'+yyyymmdd',			'+18970320', 				1, 		'+18630130',	'+19451110', 	NULL	),
	/* 196 */ (	'Erzsébet',			'Mihály',				'Kovács',	    'Bori',			192, 				193, 				NULL, 				NULL,			195, 			NULL, 			'+18970320',			NULL,					NULL, 						0, 		'+18770920',	'+19611124', 	NULL	),
	/* 197 */ (	'Kata',				'Mihály',				NULL,	    	'Újkovács',		NULL, 				NULL, 				NULL, 				NULL,			195, 			NULL, 			'+18890911',			'+yyyymmdd',			NULL, 						0, 		'+18721206',	'+18960120', 	NULL	),
	/* 198 */ (	'Erzsébet',			'Mihály',				NULL,	    	'Bori',			195, 				197, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+18901129',	'+18910103', 	NULL	),
	/* 199 */ (	'?',				'?',					NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			200, 			NULL, 			'+19110417',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 200 */ (	'Kata',				'Mihály',				NULL,	    	'Bori',			195, 				197, 				NULL, 				NULL,			199, 			NULL, 			'+19110417',			NULL,					NULL, 						0, 		'+18920611',	'+yyyymmdd', 	NULL	),
	/* 201 */ (	'János',			'Mihály',				NULL,	    	'Bori',			195, 				197, 				NULL, 				NULL,			202, 			NULL, 			'+19140601',			NULL,					NULL, 						1, 		'+18940926',	'+yyyymmdd', 	NULL	),
	/* 202 */ (	'?',				'Mihály',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			201, 			NULL, 			'+19140601',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 203 */ (	'Ferenc',			'Mihály',				NULL,	    	'Bori',			195, 				196, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18980205',	'+yyyymmdd', 	NULL	),
	/* 204 */ (	'Márton',			'Mihály',				NULL,	    	'Bori',			195, 				196, 				NULL, 				NULL,			205, 			NULL, 			'+19200626',			NULL,					NULL, 						1, 		'+18991101',	'+yyyymmdd', 	NULL	),
	/* 205 */ (	'Kata',				'Mihály',				'?',	    	'Borigyuri',	NULL, 				NULL, 				NULL, 				NULL,			204, 			NULL, 			'+19200626',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 206 */ (	'Erzsébet',			'Mihály',				NULL,	    	'Bori',			195, 				196, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+19020813',	'+19041218', 	NULL	),
	/* 207 */ (	'Anna',				'Mihály',				NULL,	    	'Bori',			195, 				196, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+19040503',	'+19060801', 	NULL	),
	/* 208 */ (	'György',			'Péntek',				NULL,	    	'Bakki',		NULL, 				NULL, 				NULL, 				NULL,			209, 			NULL, 			'+19351231',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 209 */ (	'Anna',				'Péntek',				'Mihály',	    'Bori',			195, 				196, 				NULL, 				NULL,			208, 			NULL, 			'+19351231',			NULL,					NULL, 						0, 		'+19121030',	'+yyyymmdd', 	NULL	),
	/* 210 */ (	'János',			'Tamás',				NULL,	    	'Déni',			NULL, 				NULL, 				NULL, 				NULL,			211, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 211 */ (	'Erzsébet',			'Tamás',				'Mihály',	    'Bori',			195, 				196, 				NULL, 				NULL,			210, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19060616',	'+yyyymmdd', 	NULL	),
	/* 212 */ (	'György',			'Mihály',				NULL,	    	'Borigyuri',	195, 				196, 				NULL, 				NULL,			213, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19141206',	'+1989mmdd', 	NULL	),
	/* 213 */ (	'Erzsébet',			'Mihály',				'Kovács',	    'Gulé',			NULL, 				NULL, 				NULL, 				NULL,			212, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 214 */ (	'János',			'Mihály',				NULL,	    	'Bori',			204, 				205, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 215 */ (	'János',			'Gróza',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			216, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 216 */ (	'Erzsébet',			'Gróza',				'Péntek',	    'Bakki',		208, 				209, 				NULL, 				NULL,			215, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 217 */ (	'János',			'Tamás',				NULL,	    	'Déni',			210, 				211, 				NULL, 				NULL,			218, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 218 */ (	'Erzsébet',			'Tamás',				'?',	    	'Kontos',		NULL, 				NULL, 				NULL, 				NULL,			217, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 219 */ (	'Béla',				'Antal',				NULL,	    	'Bolygó',		NULL, 				NULL, 				NULL, 				NULL,			220, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 220 */ (	'Ilona',			'Antal',				'Mihály',	    'Hadi',			212, 				213, 				NULL, 				NULL,			219, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+1941mmdd', 	NULL	),
	/* 221 */ (	'István',			'Gróza',				NULL,	    	NULL,			215, 				216, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'495c3718-3c3c-4fb8-97e5-e1837c522880.png'	),
	/* 222 */ (	'Attila',			'Gróza',				NULL,	    	NULL,			215, 				216, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'45491481-6294-48e8-9f1b-4514ff0577d7.png'	),
	/* 223 */ (	'János',			'Gróza',				NULL,	    	NULL,			215, 				216, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 224 */ (	'?',				'Szatmári',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			225, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 225 */ (	'Erzsébet',			'Szatmári',				'Gróza',	    NULL,			215, 				216, 				NULL, 				NULL,			224, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'9aa117c4-917d-44a0-88ad-d53399b1f5ed.png'	),
	/* 226 */ (	'Márton',			'Tamás',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			227, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'8adcfd38-3425-431f-8bdb-7aef8772b5a2.png'	),
	/* 227 */ (	'Éva',				'Tamás',				'?',	    	'Déni',			217, 				218, 				NULL, 				NULL,			226, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'02426658-2c85-4905-8185-b228d57cd244.png'	),
	/* 228 */ (	'István',			'Péntek',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			229, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 229 */ (	'Ibolya',			'Péntek',				'Antal',	    'Bolygó',		219, 				220, 				NULL, 				NULL,			228, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 230 */ (	'?',				'Mihály',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			231, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'5185a57b-574c-4354-8bcd-af1dd08d62db.png'	),
	/* 231 */ (	'Tünde',			'Mihály',				'Antal',	    'Bolygó',		219, 				220, 				NULL, 				NULL,			230, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19650928',	'+yyyymmdd', 	'7a050b1e-99ce-4f54-b391-def3ca95033a.png'	),
	/* 232 */ (	'Elemér',			'Kovács',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			233, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'1fffbc72-5b69-4f10-9888-342b2d20b1b0.png'	),
	/* 233 */ (	'Melinda',			'Kovács',				'Tamás',	    NULL,			226, 				227, 				NULL, 				NULL,			232, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'd538d15b-8109-4935-84d2-d8ff1f246b65.png'	),
	/* 234 */ (	'Máté',				'Kovács',				NULL,	    	NULL,			232, 				233, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'd23fdb4a-1fba-40eb-9842-bf5d31dcb4dd.png'	),
	/* 235 */ (	'Réka',				'Kovács',				NULL,	    	NULL,			232, 				233, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'e7556150-7899-4509-9238-f8266c49efb5.png'	),
	/* 236 */ (	'István',			'Kovács',				NULL,	    	'Pendzsi',		NULL, 				NULL, 				NULL, 				NULL,			237, 			NULL, 			'+19571102',			NULL,					NULL, 						1, 		'+19331205',	'+20100429', 	'ba9ece43-23bd-4c34-95b6-f09f01a67b8b.png'	),
	/* 237 */ (	'Erzsébet',			'Kovács',				'Márton',    	'Kűpál',		11, 				12, 				NULL, 				NULL,			236, 			NULL, 			'+19571102',			NULL,					NULL, 						0, 		'+19350816',	'+20190603', 	'477bf0f2-6ad5-489d-b915-3378acb0c08b.png'	),
	/* 238 */ (	'Ferenc',			'Kovács',				NULL,	    	'Sátán',		NULL, 				NULL, 				NULL, 				NULL,			239, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 239 */ (	'Éva',				'Kovács',				'?',	    	'Pendzsi',		236, 				237,				NULL,				NULL,			238, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1958mmdd',	'+yyyymmdd', 	'd1382c43-a1a8-49a7-aeb7-4f55d3fc614e.png'	),
	/* 240 */ (	'István',			'Kovács',				NULL,	    	'Pendzsi',		236, 				237,				NULL,				NULL,			241, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1962mmdd',	NULL, 			'f9cf8b75-516d-42e6-95ad-daea2f3a7d14.png'	),
	/* 241 */ (	'Tünde',			'Kovács',				'Mihály',    	'Pál',			NULL, 				NULL, 				NULL, 				NULL,			240, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'ed58ab5d-8842-4527-b72f-d145de337764.png'	),
	/* 242 */ (	'Áron',				'Kovács',				NULL,	    	NULL,			238, 				239,				NULL,				NULL,			243, 			NULL, 			'+19991009',			NULL,					NULL, 						1, 		'+19771223',	NULL, 			'f25a6453-08ab-4b87-b02e-db92b713fb4a.png'	),
	/* 243 */ (	'Anna',				'Kovács',				'Péntek',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			242, 			NULL, 			'+19991009',			NULL,					NULL, 						0, 		'+19781113',	NULL, 			'66bf986a-8934-47f4-98ed-4f4e063dd518.png'	),
	/* 244 */ (	'Ferenc',			'Antal',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			245, 			NULL, 			'+20220618',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'de5f88c9-b389-41a9-9b5c-85efc04ebdbc.png'	),
	/* 245 */ (	'Edina',			'Antal',				'Kovács',    	'Pendzsi',		240, 				241,				NULL,				NULL,			244, 			NULL, 			'+20220618',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'4fbf7506-c7dc-42be-b8f9-96d09c5491b1.png'	),
	/* 246 */ (	'Nóra Anna',		'Kovács',				NULL,	    	NULL,			242, 				243,				NULL,				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+20041007',	NULL, 			'698543a4-07be-46ad-a96e-863b6b0a6edc.png'	),
	/* 247 */ (	'Áron Hunor',		'Kovács',				NULL,	    	NULL,			242, 				243,				NULL,				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+20100917',	NULL, 			'72dde241-dad8-4e3b-bc3a-1c59b0f5d146.png'	),
	/* 248 */ (	'András',			'Márton',				NULL,	    	'Szűcs',		NULL, 				NULL, 				NULL, 				NULL,			249, 			NULL, 			'+18700706',			NULL,					NULL, 						1, 		'+18460104',	'+19170118', 	NULL	),
	/* 249 */ (	'Anna',				'Márton',				'Kispál',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			248, 			NULL, 			'+18700706',			NULL,					NULL, 						0, 		'+18501215',	'+19200408', 	NULL	),
	/* 250 */ (	'Ferenc',			'Korpos',				NULL,	    	'Ferce',		NULL, 				NULL, 				NULL, 				NULL,			251, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18501210',	'+18990408', 	NULL	),
	/* 251 */ (	'Kata',				'Korpos',				'Márton',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			250, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+19360227', 	NULL	),
	/* 252 */ (	'János',			'Márton',				NULL,	    	'Szűcs',		248, 				249, 				NULL, 				NULL,			253, 			NULL, 			'+18950622',			NULL,					NULL, 						1, 		'+18711230',	'+yyyymmdd', 	NULL	),
	/* 253 */ (	'Kata',				'Márton',				'Péntek',    	'Bika',			NULL, 				NULL, 				NULL, 				NULL,			252, 			NULL, 			'+18950622',			NULL,					NULL, 						0, 		'+18770328',	'+19360330', 	NULL	),
	/* 254 */ (	'Márton',			'Márton',				NULL,	    	'Szűcs Kűpál',	248, 				249, 				NULL, 				NULL,			255, 			NULL, 			'+19020927',			NULL,					NULL, 						1, 		'+18781019',	'+19240325', 	NULL	),
	/* 255 */ (	'Kata',				'Márton',				'Korpos',    	'Ferce',		250, 				251, 				NULL, 				NULL,			254, 			NULL, 			'+19020927',			NULL,					NULL, 						0, 		'+18811028',	'+19190926', 	NULL	),
	/* 256 */ (	'?',				'?',					NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			257, 			NULL, 			'+18970515',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 257 */ (	'Erzsébet',			'?',					'Korpos',    	'Ferce',		250, 				251, 				NULL, 				NULL,			256, 			NULL, 			'+18970515',			NULL,					NULL, 						0, 		'+18790512',	'+yyyymmdd', 	NULL	),
	/* 258 */ (	'János',			'Korpos',				NULL,	    	'Ferce',		250, 				251, 				NULL, 				NULL,			259, 			NULL, 			'+19110225',			NULL,					NULL, 						1, 		'+18830412',	'+yyyymmdd', 	NULL	),
	/* 259 */ (	'?',				'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			258, 			NULL, 			'+19110225',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 260 */ (	'György',			'Korpos',				NULL,	    	'Ferce',		250, 				251, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18870405',	'+yyyymmdd', 	NULL	),
	/* 261 */ (	'Ferenc',			'Korpos',				NULL,	    	'Ferce',		250, 				251, 				NULL, 				NULL,			262, 			NULL, 			'+19190301',			NULL,					NULL, 						1, 		'+18890420',	'+yyyymmdd', 	NULL	),
	/* 262 */ (	'?',				'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			261, 			NULL, 			'+19190301',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 263 */ (	'István',			'Korpos',				NULL,	    	'Ferce',		250, 				251, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18910626',	'+yyyymmdd', 	NULL	),
	/* 264 */ (	'?',				'Korpos',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			265, 			NULL, 			'+19240719',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 265 */ (	'Ilona',			'Korpos',				'Korpos',    	'Ferce',		250, 				251, 				NULL, 				NULL,			264, 			NULL, 			'+19240719',			NULL,					NULL, 						0, 		'+1895mmdd',	'+yyyymmdd', 	NULL	),
	/* 266 */ (	'György Ifjú',		'Tamás',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			267, 			NULL, 			'+19140520',			NULL,					NULL, 						1, 		'+18910227',	'+19611020', 	NULL	),
	/* 267 */ (	'Erzsébet',			'Tamás',				'Márton',    	'Szűcs',		252, 				253, 				NULL, 				NULL,			266, 			NULL, 			'+19140520',			NULL,					NULL, 						0, 		'+18960514',	'+19611215', 	NULL	),
	/* 268 */ (	'György',			'Antal',				NULL,	    	'Bandi',		NULL, 				NULL, 				NULL, 				NULL,			269, 			NULL, 			'+19140228',			NULL,					NULL, 						1, 		'+18931229',	'+19440809', 	NULL	),
	/* 269 */ (	'Kata',				'Antal',				'Márton',    	'Szűcs',		252, 				253, 				NULL, 				NULL,			268, 			NULL, 			'+19140228',			NULL,					NULL, 						0, 		'+18980403',	'+19651129', 	NULL	),
	/* 270 */ (	'?',				'Márton',				NULL,	    	NULL,			252, 				253, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+19060806',	'+19060806', 	NULL	),
	/* 271 */ (	'János',			'Péntek',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			272, 			NULL, 			'+19261226',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 272 */ (	'Ilona',			'Péntek',				'Márton',    	'Szűcs',		252, 				253, 				NULL, 				NULL,			271, 			NULL, 			'+19261226',			NULL,					NULL, 						0, 		'+19090801',	'+yyyymmdd', 	NULL	),
	/* 273 */ (	'István',			'Márton',				NULL,	    	'Kűpál',		254, 				255, 				NULL, 				NULL,			274, 			NULL, 			'+19371211',			NULL,					NULL, 						1, 		'+19160127',	'+20030223', 	NULL	),
	/* 274 */ (	'Piroska',			'Márton',				'Kovács',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			273, 			NULL, 			'+19371211',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 275 */ (	'András',			'Márton',				NULL,	    	'Kűpál',		254, 				255, 				NULL, 				NULL,			276, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+19171230',	'+yyyymmdd', 	NULL	),
	/* 276 */ (	'Erzsébet',			'Márton',				'Albert',    	'Bigye',		NULL, 				NULL, 				NULL, 				NULL,			275, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 277 */ (	'János',			'Márton',				NULL,	    	'Kűpál',		273, 				274, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 278 */ (	'Piroska',			'?',					'Márton',	    'Kűpál',		273, 				274, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 279 */ (	'Katalin',			'?',					'Márton',	    'Kűpál',		273, 				274, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+1944mmdd',	NULL, 			NULL	),
	/* 280 */ (	'Éva',				'?',					'Márton',	    'Kűpál',		273, 				274, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 281 */ (	'Erzsébet',			'?',					'Márton',	    'Kűpál',		273, 				274, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 282 */ (	'András',			'Márton',				NULL,	    	'Kűpál',		275, 				276, 				NULL, 				NULL,			283, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 283 */ (	'Erzsébet',			'Márton',				'Albert',	    'Bigye',		NULL, 				NULL, 				NULL, 				NULL,			282, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 284 */ (	'Zsolt',			'Márton',				NULL,	    	'Kűpál',		282, 				283, 				NULL, 				NULL,			396, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'9badd01c-dea6-4aae-be51-72d5c93aff94.png'	),
	/* 285 */ (	'András',			'Márton',				NULL,	    	'Kűpál',		282, 				283, 				NULL, 				NULL,			286, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'c1c820eb-3524-45b7-a4e7-b18c7982d5dd.png'	),
	/* 286 */ (	'Kinga',			'Márton',				'András',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			285, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'a07c6cc1-7f21-4cca-bfac-c5fe871fd32d.png'	),
	/* 287 */ (	'Balázs',			'Márton',				NULL,	    	'Kűpál',		285, 				286, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'd2bf7dcd-0a77-427c-9a50-2bc94af056a4.png'	),
	/* 288 */ (	'Abigél',			'Márton',				NULL,	    	'Kűpál',		285, 				286, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'62920d28-5eb6-4550-b900-6cfbcde57d94.png'	),
	/* 289 */ (	'János',			'Kovács',				NULL,	    	'Baka',			NULL, 				NULL, 				NULL, 				NULL,			290, 			NULL, 			'+18390612',			NULL,					NULL, 						1, 		'+181608dd',	'+18890315', 	NULL	),
	/* 290 */ (	'?',				'Kovács',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			289, 			NULL, 			'+18390612',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 291 */ (	'György',			'Kovács',				NULL,	    	'Baka',			289, 				290, 				NULL, 				NULL,			292, 			NULL, 			'+18701029',			NULL,					NULL, 						1, 		'+18450321',	'+19221213', 	NULL	),
	/* 292 */ (	'Kata',				'Kovács',				'Tamás',    	'Déni',			NULL, 				NULL, 				NULL, 				NULL,			291, 			NULL, 			'+18701029',			NULL,					NULL, 						0, 		'+18471216',	'+19190615', 	NULL	),
	/* 293 */ (	'János',			'Kovács',				NULL,	    	'Baka',			291, 				292, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18780817',	'+yyyymmdd', 	NULL	),
	/* 294 */ (	'Kata',				'Kovács',				NULL,	    	'Baka',			291, 				292, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+18760401',	'+yyyymmdd', 	NULL	),
	/* 295 */ (	'János',			'Kovács',				NULL,	    	'Baka',			291, 				292, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18710130',	'+18710206', 	NULL	),
	/* 296 */ (	'?',				'Péntek',				NULL,	    	'Pistika',		NULL, 				NULL, 				NULL, 				NULL,			297, 			NULL, 			'+1872mmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 297 */ (	'Kata',				'Péntek',				'Vincze',	   	NULL,			NULL, 				NULL, 				NULL, 				NULL,			296, 			NULL, 			'+1872mmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 298 */ (	'Gyula',			'Antal',				NULL,	    	'Púj',			62, 				63, 				NULL, 				NULL,			299, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19150831',	'+19831107', 	'857c7227-3e9b-473d-b091-286e1798066e.png'	),
	/* 299 */ (	'Jolán',			'Antal',				'Albert',	   	'Kukó',			NULL, 				NULL, 				NULL, 				NULL,			298, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 300 */ (	'György',			'Albert',				NULL,	    	'Patac',		NULL, 				NULL, 				NULL, 				NULL,			301, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 301 */ (	'Erzsébet',			'Albert',				'?',	    	'Magyar',		NULL, 				NULL, 				NULL, 				NULL,			300, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 302 */ (	'György',			'Péntek',				NULL,	    	'Marci',		NULL, 				NULL, 				NULL, 				NULL,			303, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 303 */ (	'Katalin',			'Péntek',				'Antal',	   	'Púj',			298, 				299, 				NULL, 				NULL,			302, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'70f61b52-0752-41c3-8437-0b871e5de390.png'	),
	/* 304 */ (	'István',			'Antal',				NULL,	    	'Púj',			298, 				299, 				NULL, 				NULL,			305, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'7ff891bd-e03d-4037-8bd4-a337bd632173.png'	),
	/* 305 */ (	'Éva',				'Antal',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			304, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'd8609be4-d9a8-4f00-bc54-f788f682cd72.png'	),
	/* 306 */ (	'Attila Csaba',		'Albert',				NULL,	    	'Patac',		300, 				301, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 307 */ (	'György Csongor',	'Albert',				NULL,	    	'Patac',		300, 				301, 				NULL, 				NULL,			308, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 308 */ (	'Éva',				'Albert',				'Péntek',	   	'Marci',		302, 				303, 				NULL, 				NULL,			307, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	'1b736aeb-85c1-4d1b-be8f-87a5acf61f71.png'	),
	/* 309 */ (	'Miklós',			'Péntek',				NULL,	    	'Marci',		302, 				303, 				NULL, 				NULL,			310, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 310 */ (	'Gyöngyi',			'Péntek',				'Márton',	   	'Kűpál',		NULL, 				NULL, 				NULL, 				NULL,			309, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 311 */ (	'Gergő',			'Albert',				NULL,	    	'Patac',		307, 				308, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	'b55cee3c-f0e1-404f-87e0-715d776e92bf.png'	),
	/* 312 */ (	'György',			'Antal',				NULL,	    	'Púj',			62, 				63, 				NULL, 				NULL,			313, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19030330',	'+19861116', 	'588d011c-910e-4a9c-9d8f-b9d590ffb6fc.png'	),
	/* 313 */ (	'Erzsébet',			'Antal',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			312, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 314 */ (	'János',			'Péntek',				NULL,	    	'Linka',		NULL, 				NULL, 				NULL, 				NULL,			315, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 315 */ (	'Erzsébet',			'Péntek',				'Antal',	   	'Púj',			62, 				63, 				NULL, 				NULL,			314, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19060524',	'+19840810', 	'efd20aca-3586-4bd3-ae38-0d29d3998cfc.png'	),
	/* 316 */ (	'János',			'Antal',				NULL,	    	'Púj',			312, 				313, 				NULL, 				NULL,			317, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'8751b697-e361-4cda-8b2c-b3991a76fe11.png'	),
	/* 317 */ (	'Erzsébet',			'Antal',				'Szatmári',	   	'Lajos',		NULL, 				NULL, 				NULL, 				NULL,			316, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'ac13e87b-a553-4beb-8d8f-d51ac49b26a2.png'	),
	/* 318 */ (	'György',			'Antal',				NULL,	    	'Púj',			312, 				313, 				NULL, 				NULL,			319, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'dc554fdc-6b8c-48f1-90b1-7337bcd07b67.png'	),
	/* 319 */ (	'Ilona',			'Antal',				'?',	    	'Köntös',		NULL, 				NULL, 				NULL, 				NULL,			318, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'9f3ab9d5-eafe-4934-b449-43a8a656d0d5.png'	),
	/* 320 */ (	'Andor',			'Albert',				NULL,	    	'Bigye',		NULL, 				NULL, 				NULL, 				NULL,			321, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 321 */ (	'Erzsébet',			'Albert',				'Péntek',	   	'Linka',		314, 				315, 				NULL, 				NULL,			320, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 322 */ (	'Ferenc',			'Korpos',				NULL,	    	'Batye',		NULL, 				NULL, 				NULL, 				NULL,			323, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 323 */ (	'Júlia',			'Korpos',				'Péntek',	   	'Linka',		314, 				315, 				NULL, 				NULL,			322, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 324 */ (	'László',			'Mihály',				NULL,	    	'Újkovács',		NULL, 				NULL, 				NULL, 				NULL,			325, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 325 */ (	'Anna Irén',		'Mihály',				'Antal',	   	'Púj',			316, 				317, 				NULL, 				NULL,			324, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'cb801236-26f7-40db-be51-dad9f4a2d12e.png'	),
	/* 326 */ (	'Csaba',			'Antal',				NULL,	    	'Púj',			316, 				317, 				NULL, 				NULL,			327, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'8f40d9d6-7275-4c19-8df2-c4c17aeaed99.png'	),
	/* 327 */ (	'Emese',			'Antal',				'Mihály',	   	NULL,			NULL, 				NULL, 				NULL, 				NULL,			326, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'ca880eb7-7e55-4ae6-8cb1-390cb82fa1b8.png'	),
	/* 328 */ (	'György',			'Antal',				NULL,	    	'Púj',			318, 				319, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 329 */ (	'Andor',			'Albert',				NULL,	    	'Bigye',		320, 				321, 				NULL, 				NULL,			330, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'49cace9b-69c9-4f9c-a179-8af7fc518501.png'	),
	/* 330 */ (	'Ilonka',			'Albert',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			329, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'47824b1b-4120-47f4-8f91-03ef744b51b6.png'	),
	/* 331 */ (	'Erzsébet',			'Albert',				'Márton',	   	'Szűcs',		320, 				321, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 332 */ (	'Ferenc',			'Korpos',				NULL,	    	'Batye',		322, 				323, 				NULL, 				NULL,			333, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 333 */ (	'Ildikó',			'Korpos',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			332, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 334 */ (	'Csaba',			'Korpos',				NULL,	    	'Batye',		322, 				323, 				NULL, 				NULL,			335, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'c7b2d89a-33df-45d8-935a-ef3d888e4bfb.png'	),
	/* 335 */ (	'Erzsébet',			'Korpos',				'Péntek',	   	'Laci',			NULL, 				NULL, 				NULL, 				NULL,			334, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'cf032677-c96c-468d-a436-2f70e3405ebe.png'	),
	/* 336 */ (	'Csaba',			'Mihály',				NULL,	    	'Újkovács',		324, 				325, 				NULL, 				NULL,			337, 			NULL, 			'+20220822',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'85bf9b76-4138-4f59-af62-8b14939deca7.png'	),
	/* 337 */ (	'Emőke',			'Mihály',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			336, 			NULL, 			'+20220822',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'2dd38ec0-e16d-41ea-b222-c7635b8fe1aa.png'	),
	/* 338 */ (	'Csaba',			'Antal',				NULL,	    	'Púj',			326, 				327, 				NULL, 				NULL,			339, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'1c6955e9-2390-4e25-a767-5a34df68fd2e.png'	),
	/* 339 */ (	'Dorka',			'Antal',				'Tamás',	   	NULL,			NULL, 				NULL, 				NULL, 				NULL,			338, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'21f218c8-9341-40bd-b183-19a36c3f1c68.png'	),
	/* 340 */ (	'Katalin',			'Antal',				NULL,	    	'Púj',			326, 				327, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'dde0f9a2-606e-40e7-a0a2-1d177d2ff625.png'	),
	/* 341 */ (	'Angéla',			'Korpos',				NULL,	    	NULL,			332, 				333, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'b0155c49-9392-4693-ae9d-8e30c4507cf4.png'	),
	/* 342 */ (	'Csaba',			'Korpos',				NULL,	    	'Batye',		334, 				335, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'18eb2132-3896-459a-bf21-35c84534f756.png'	),
	/* 343 */ (	'Noel',				'Korpos',				NULL,	    	'Batye',		334, 				335, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'089d785a-5776-4b9f-bc39-3b8b68026bef.png'	),
	/* 344 */ (	'Péter',			'Mihály',				NULL,	    	NULL,			336, 				337, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 345 */ (	'?',				'Antal',				NULL,	    	'Púj',			NULL, 				NULL, 				NULL, 				NULL,			346, 			NULL, 			'+18431209',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 346 */ (	'Kata',				'Antal',				'Varga',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			345, 			NULL, 			'+18431209',			NULL,					NULL, 						0, 		'+18251014',	'+18870223', 	NULL	),
	/* 347 */ (	'István',			'Péntek',				NULL,	    	'Csapa',		NULL, 				NULL, 				NULL, 				NULL,			348, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18240111',	'+yyyymmdd', 	NULL	),
	/* 348 */ (	'Erzsébet',			'Péntek',				'Kovács',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			347, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+18300905',	'+yyyymmdd', 	NULL	),
	/* 349 */ (	'András',			'Antal',				NULL,	    	'Púj',			345, 				346, 				NULL, 				NULL,			350, 			NULL, 			'+18670529',			NULL,					NULL, 						1, 		'+18441122',	'+19031207', 	NULL	),
	/* 350 */ (	'Kata',				'Antal',				'Antal',	    NULL,			NULL, 				NULL, 				NULL, 				NULL,			349, 			NULL, 			'+18670529',			NULL,					NULL, 						0, 		'+18481222',	'+18850417', 	NULL	),
	/* 351 */ (	'István',			'Péntek',				NULL,	    	'Csapa',		347, 				348, 				NULL, 				NULL,			352, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18650115',	'+yyyymmdd', 	NULL	),
	/* 352 */ (	'Erzsébet',			'Péntek',				'Antal',	    NULL,			349, 				350, 				NULL, 				NULL,			351, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+18710622',	'+yyyymmdd', 	NULL	),
	/* 353 */ (	'Kata',				'?',					'Antal',	    'Púj',			349, 				350, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+18681125',	'+yyyymmdd', 	NULL	),
	/* 354 */ (	'György',			'Antal',				NULL,	    	'Púj',			349, 				350, 				NULL,				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+18831020',	'+yyyymmdd', 	NULL	),
	/* 355 */ (	'János',			'Bódizs',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			356, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1905mmdd',	'+1962mmdd', 	NULL	),
	/* 356 */ (	'Anna',				'Bódizs',				'Péntek',	   	NULL,			351, 				352, 				NULL, 				NULL,			355, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 357 */ (	'Erzsébet',			'?',					'Péntek',	   	NULL,			351, 				352, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 358 */ (	'István',			'Mihály',				NULL,	    	'Postás',		374, 				375, 				355, 				356,			359, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19380330',	'+2014mmdd', 	NULL	),
	/* 359 */ (	'Anna',				'Mihály',				'Tóth',	    	'Nusi',			NULL, 				NULL, 				NULL, 				NULL,			358, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+19351207',	'+2013mmdd', 	NULL	),
	/* 360 */ (	'István',			'Mihály',				NULL,	    	NULL,			358, 				359, 				NULL, 				NULL,			361, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1962mmdd',	NULL, 			'bfb285a2-7662-4066-8e42-86840d9b0f6b.png'	),
	/* 361 */ (	'Ildikó',			'Mihály',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			360, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1961mmdd',	NULL, 			'd48fedf6-8eb0-4024-a25b-e631a6cdb6cc.png'	),
	/* 362 */ (	'Attila',			'Czucza',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			363, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19650409',	NULL, 			'ed3d9141-2dc3-40ee-aea6-74ebc1833082.png'	),
	/* 363 */ (	'Anna Mária',		'Czucza',				'Mihály',	   	NULL,			358, 				359, 				NULL, 				NULL,			362, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'6687fb82-6c7d-4aad-8580-5752c6ecd807.png'	),
	/* 364 */ (	'Anita',			'Mihály',				NULL,	    	NULL,			360, 				361, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+19900917',	NULL, 			'9ac3ec83-12a6-4dc6-96fc-f6c5a0cbd1f7.png'	),
	/* 365 */ (	'István',			'Tamás',				'Czucza',	   	NULL,			NULL, 				NULL, 				NULL, 				NULL,			366, 			NULL, 			'+20180630',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'fa16fbc6-50ae-4328-a7fc-63110820172e.png'	),
	/* 366 */ (	'Annamária',		'Tamás',				NULL,	    	NULL,			NULL, 				NULL, 				362, 				363,			365, 			NULL, 			'+20180630',			NULL,					NULL, 						0, 		'+19950615',	NULL, 			'fe806df7-a16e-4136-bde4-94a664452628.png'	),
	/* 367 */ (	'Natasha Anna',		'Tamás',				NULL,	    	NULL,			365, 				366, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+20191023',	NULL, 			'08750518-fad9-4eef-a17c-c95a83e8b5bb.png'	),
	/* 368 */ (	'Márton',			'Kovács',				NULL,	    	'Pendzsi',		NULL, 				NULL, 				NULL, 				NULL,			369, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18340523',	'+yyyymmdd', 	NULL	),
	/* 369 */ (	'Borbála',			'Kovács',				'Péntek',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			368, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+18341223',	'+yyyymmdd', 	NULL	),
	/* 370 */ (	'Márton',			'Albert',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			371, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18410825',	'+yyyymmdd', 	NULL	),
	/* 371 */ (	'Erzsébet',			'Albert',				'Korpos',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			370, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+18480218',	'+yyyymmdd', 	NULL	),
	/* 372 */ (	'György',			'Kovács',			 	NULL,	    	'Pendzsi',		368, 				369, 				NULL, 				NULL,			373, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+18600415',	'+yyyymmdd', 	NULL	),
	/* 373 */ (	'Kata',				'Kovács',				'Albert',    	NULL,			370, 				371, 				NULL, 				NULL,			372, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+18640923',	'+yyyymmdd', 	NULL	),
	/* 374 */ (	'István',			'Kovács',				NULL,	    	'Pendzsi',		372, 				373, 				NULL, 				NULL,			375, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19000917',	'+1937mmdd', 	NULL	),
	/* 375 */ (	'Kata',				'Kovács',				'Péntek',    	'Csapa',		351, 				352, 				NULL, 				NULL,			374, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1908mmdd',	'+1998mmdd', 	NULL	),
	/* 376 */ (	'Gyula',			'Mihály',				NULL,	    	'Pendzsi',		NULL, 				NULL, 				NULL, 				NULL,			377, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 377 */ (	'Erzsébet',			'Mihály',				'Kovács',    	NULL,			374, 				375, 				NULL, 				NULL,			376, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1929mmdd',	'+1996mmdd', 	NULL	),
	/* 378 */ (	'Lajos',			'Kovács',				NULL,	    	'Pendzsi',		374, 				375, 				NULL, 				NULL,			379, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1927mmdd',	'+yyyymmdd', 	NULL	),
	/* 379 */ (	'Margit',			'Kovács',				'Albert',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			378, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	'+yyyymmdd', 	NULL	),
	/* 380 */ (	'Lajos',			'Mihály',				NULL,	    	'Pendzsi',		376, 				377, 				NULL, 				NULL,			381, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1948mmdd',	NULL, 			NULL	),
	/* 381 */ (	'Erzsébet',			'Mihály',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			380, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1952mmdd',	NULL, 			NULL	),
	/* 382 */ (	'Gyula',			'Mihály',				NULL,	    	'Pendzsi',		376, 				377, 				NULL, 				NULL,			383, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1959mmdd',	NULL, 			NULL	),
	/* 383 */ (	'Lenuța',			'Mihály',				'?',	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			382, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 384 */ (	'Sándor',			'Tóth',					NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			385, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 385 */ (	'Anna',				'Tóth',					'Kovács',    	'Pendzsi',		378, 				379, 				NULL, 				NULL,			384, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 386 */ (	'Béla',				'Péntek',				NULL,	    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			387, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+1959mmdd',	'+1985mmdd', 	NULL	),
	/* 387 */ (	'Erzsébet',			'Péntek',				'Kovács',    	'Pendzsi',		378, 				379, 				NULL, 				NULL,			386, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+1956mmdd',	NULL, 			NULL	),
	/* 388 */ (	'Mihály',			'Mihály',				NULL,	    	'Pendzsi',		380, 				381, 				NULL, 				NULL,			389, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19710101',	NULL, 			'5086b83f-eb25-4f49-ac2e-902f60a5d95e.png'	),
	/* 389 */ (	'Hajnal Emese',		'Mihály',				'Albert',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			388, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+197109dd',	NULL, 			'64625139-7d9a-4943-b5af-ee55b9b35a19.png'	),
	/* 390 */ (	'Pál',				'Mihály',				NULL,	    	'Pendzsi',		380, 				381, 				NULL, 				NULL,			391, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						1, 		'+19770325',	NULL, 			'0d36a1f3-3a27-466b-a1a9-f97c89356653.png'	),
	/* 391 */ (	'Edit',				'Mihály',				'Péntek',    	NULL,			NULL, 				NULL, 				NULL, 				NULL,			390, 			NULL, 			'+yyyymmdd',			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'ae328f90-9a09-47e8-a5fb-76fab698138b.png'	),
	/* 392 */ (	'Gyula',			'Mihály',				NULL,	    	NULL,			382, 				383, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+19890416',	NULL, 			NULL	),
	/* 393 */ (	'Csongor',			'Tóth',					NULL,	    	NULL,			384, 				385, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			NULL	),
	/* 394 */ (	'Beáta',			'Tóth',					'?',	    	NULL,			384, 				385, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+19770114',	NULL, 			NULL	),
	/* 395 */ (	'Tamara',			'Mihály',				NULL,	    	'Pendzsi',		388, 				389, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'bf562941-39be-4fe3-bd98-6c0f07b9e4a9.png'	),
	/* 396 */ (	'Éva',				'Márton',				'Tamás',	    'Déni',			226, 				227, 				NULL, 				NULL,			284, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'ab7b110c-504e-4cc3-8ff6-f4b7969afd9c.png'	),
	/* 397 */ (	'Sára',				'Márton',				NULL,		    'Kűpál',		284, 				396, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						0, 		'+yyyymmdd',	NULL, 			'0317b629-7007-4166-bf77-a89411b03ea7.png'	),
	/* 398 */ (	'Bence',			'Márton',				NULL,		    'Kűpál',		284, 				396, 				NULL, 				NULL,			NULL, 			NULL, 			NULL,					NULL,					NULL, 						1, 		'+yyyymmdd',	NULL, 			'ed904d5b-5716-4b04-97e7-265853ff3981.png'	)
END


-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================



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