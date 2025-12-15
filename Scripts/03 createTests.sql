-- Tooltips range is 1 -> 4.999
	-- 1 - biological - should not use index 0 cause that is considered as a false value in javascript
	-- 41 - extended
	-- 81 - complete

-- Tests range is 5.000 -> 19.999
	-- 5.000 - biological
	-- 10.000 - extended
	-- 15.000 - complete

-- Szabolcs Antal's family range is 20.000 -> up, each generations takes up 1.000



DECLARE @idBuffer INT = 40;
DECLARE @id INT = 0;

DELETE FROM Persons
WHERE ID BETWEEN 5000 AND 19999;

SET IDENTITY_INSERT Persons ON;

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
-- HOURGLASS_BIOLOGICAL - When person has child with spouse, they have children and descendants depth is 1, children without spouse is displayed
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
-- HOURGLASS_BIOLOGICAL - When ancestors and descendants depth are both 2, generations until those levels are displayed
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
-- HOURGLASS_BIOLOGICAL - When children of descendants are married and do not have children, they are displayed only once and separately
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
-- HOURGLASS_BIOLOGICAL - When children of descendants are married and have children, they are displayed only once and married
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
-- HOURGLASS_BIOLOGICAL - When children are married but do not have children, they are displayed only once and not married, with descendants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married but do not have children, they are displayed only once and not married, with descendants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When children are married and do have children, they are displayed only once and not married, with descendants depth 1
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
-- HOURGLASS_BIOLOGICAL - When children are married and do have children, they are displayed only once and married, with descendants depth All
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

-- ==========================================================================================================================
-- HOURGLASS_BIOLOGICAL - When grandchild of person is adopted by child of person, adoptive line is not displayed and siblings are not grouped together
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 1,	 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male1',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female1',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 4,	'L1 Male2',			NULL,			NULL,			NULL,			@id + 0, 			@id + 1,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Female2',		NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L2 Male1',			NULL,			NULL,			NULL,			@id + 2,			@id + 3,			@id + 4, 			@id + 5,			NULL,		 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 7,	'L2 Male2',			NULL,			NULL,			NULL,			@id + 4, 			@id + 5,			NULL,				NULL,				NULL,			NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)



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
-- HOURGLASS_EXTENDED - When person has adoptive descendants, its descendants are not displayed
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
-- HOURGLASS_EXTENDED - When person has biological and adoptive descendants, they are all displayed and sorted by birthDates
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
-- HOURGLASS_EXTENDED - When children of descendants are married and have children, they are displayed only once and married
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
-- HOURGLASS_EXTENDED - When ancestors and descendants depth are both 2, generations until those levels are displayed
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
-- HOURGLASS_EXTENDED - When children of descendants are married and do not have children, they are displayed only once and not married
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
-- HOURGLASS_EXTENDED - When children of descendants are married and have children, they are displayed only once and married
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
-- HOURGLASS_EXTENDED - When children are married but do not have children, they are displayed only once and not married, with descendants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married but do not have children, they are displayed only once and not married, with descendants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When children are married and do have children, they are displayed only once and married, with descendants depth 1
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
-- HOURGLASS_EXTENDED - When children are married and do have children, they are displayed only once and married, with descendants depth All
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

-- ==========================================================================================================================
-- HOURGLASS_EXTENDED - When parents of male were born later, they are still displayed first because of parents sorting based on children
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			@id + 5,	 		@id + 6,			NULL,				NULL,				NULL,		 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,	 		@id + 2,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)



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
-- COMPLETE - When ancestors and descendants depth are both 2, generations until those levels are displayed
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
-- COMPLETE - When female is double married, marriage entities with both husbands are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Female',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2, 		@id + 1,		NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When male is double married, marriage entities with both wives are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,			NULL,					NULL, 						1, 		NULL,			NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0, 		NULL,				NULL,					NULL, 						0, 		NULL,			NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,				NULL,					NULL, 						0, 		NULL,			NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When second wife of male has first spouse, that first spouse marriage entity is also displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES

		(	@id + 0,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1, 		@id + 2,		NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female2',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 3,		@id + 0,		NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When child has biological and adoptive parents, biological and adoptive paths are displayed
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,	DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male1',			NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 1,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 0, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 2,	'L0 Male2',			NULL,			NULL,			NULL, 			NULL, 				NULL, 				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL),
		(	@id + 3,	'L0 Female2', 		NULL,			NULL,			NULL,			NULL, 				NULL, 				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						0, 		NULL, 			NULL,	NULL),
		(	@id + 4,	'L1 Male', 			NULL,			NULL,			NULL,			@id + 0, 			@id + 1, 			@id + 2,			@id + 3,			NULL, 			NULL,			NULL,					NULL, 						1, 		NULL, 			NULL,	NULL)

-- ==========================================================================================================================
-- COMPLETE - When siblings are not sorted when loaded, they are sorted after loading
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
-- COMPLETE - When children have common parents, they are displayed in a common sibling group
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
-- COMPLETE - When male in marriage entity has default birthDate, female birthDate is used for sorting
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
-- COMPLETE - When marriage entity with male has unknown and female null birthDate, unknown of male instead of null birthDate from female is used for sorting
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
-- COMPLETE - When children of descendants are married and do not have children, they are displayed only once and married
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
-- COMPLETE - When children of descendants are married and have children, they are displayed only once and married
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
-- COMPLETE - When children are married but do not have children, they are displayed only once and married, with descendants depth 1
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married but do not have children, they are displayed only once and married, with descendants depth All
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L0 Male',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 1,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Female',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 0,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 2,	'L1 Male',			NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 3,		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L1 Female',		NULL,			NULL,			NULL,			@id + 0,			@id + 1,			NULL,				NULL,				@id + 2,		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

-- ==========================================================================================================================
-- COMPLETE - When children are married and do have children, they are displayed only once and married, with descendants depth 1
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
-- COMPLETE - When children are married and do have children, they are displayed only once and married, with descendants depth All
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

-- ==========================================================================================================================
-- COMPLETE - When parents of male were born later, they are sorted based on children and still appear first
SET @id = @id + @idBuffer;
INSERT INTO Persons (
			ID,			FirstName,			LastName,		MaidenName,		OtherNames,		BiologicalFatherID,	BiologicalMotherID,	AdoptiveFatherID,	AdoptiveMotherID,	FirstSpouseID,	SecondSpouseID,	FirstMarriageStartDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,	ImageUrl)
VALUES
		(	@id + 0,	'L2 Male',			NULL,			NULL,			NULL,			@id + 5,	 		@id + 6,			NULL,				NULL,				NULL,		 	NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 1,	'L0 Male1',			NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 2, 		NULL,			NULL,					NULL, 						1, 		'+1992mmdd',	NULL,		NULL),
		(	@id + 2,	'L0 Female1',		NULL,			NULL,			NULL,			NULL, 				NULL,				NULL,				NULL,				@id + 1, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 3,	'L0 Male2',			NULL,			NULL,			NULL,			NULL,	 			NULL,				NULL,				NULL,				@id + 4, 		NULL,			NULL,					NULL, 						1, 		'+1991mmdd',	NULL,		NULL),
		(	@id + 4,	'L0 Female2',		NULL,			NULL,			NULL,			NULL,				NULL,				NULL,				NULL,				@id + 3, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 5,	'L1 Male',			NULL,			NULL,			NULL,			@id + 1,	 		@id + 2,			NULL,				NULL,				@id + 6, 		NULL,			NULL,					NULL, 						1, 		'+yyyymmdd',	NULL,		NULL),
		(	@id + 6,	'L1 Female',		NULL,			NULL,			NULL,			@id + 3, 			@id + 4,			NULL,				NULL,				@id + 5, 		NULL,			NULL,					NULL, 						0, 		'+yyyymmdd',	NULL,		NULL)

SET IDENTITY_INSERT Persons OFF;