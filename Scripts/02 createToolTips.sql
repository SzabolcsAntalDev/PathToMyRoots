-- Tooltips range is 0 -> 4.999
	-- 0 - biological
	-- 40 - extended
	-- 80 - complete

-- Tests range is 5.000 -> 19.999
	-- 5.000 - biological
	-- 10.000 - extended
	-- 15.000 - complete

-- Szabolcs Antal's family range is 20.000 -> up, each generations takes up 1.000



DECLARE @idBuffer INT = 40;
DECLARE @id INT = 0;

DELETE FROM Persons
WHERE ID BETWEEN 0 AND 4999;

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

SET IDENTITY_INSERT Persons OFF;