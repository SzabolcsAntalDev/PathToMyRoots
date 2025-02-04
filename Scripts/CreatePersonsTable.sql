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

select * from persons


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
	
% Scaffold-DbContext "Server=localhost;Database=PathToMyRootsDB;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -Tables Persons