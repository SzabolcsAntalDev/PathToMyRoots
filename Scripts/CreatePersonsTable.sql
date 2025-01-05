CREATE TABLE Persons
(
	ID INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR (50) NOT NULL,
	LastName NVARCHAR (50) NOT NULL,
	MaidenName NVARCHAR (50),
	OtherNames NVARCHAR (250),
	IsMale BIT NOT NULL,
	BirthDate DATE,
	DeathDate DATE,
	BiologicalMotherID INT,
	BiologicalFatherID INT,
	SpouseID INT,

	FOREIGN KEY (BiologicalMotherID) REFERENCES Persons(ID),
	FOREIGN KEY (BiologicalFatherID) REFERENCES Persons(ID),
	FOREIGN KEY (SpouseID) REFERENCES Persons(ID)
)

select * from persons