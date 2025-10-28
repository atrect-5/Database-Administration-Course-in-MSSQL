-- Utilizamos nuestra base de datos
USE AzulSchoolMSSQLAdministration;
GO

-- Creamos otra tabla de materias para probar las tablas temporales
CREATE TABLE dbo.Materias(
	IdMateria	INT IDENTITY PRIMARY KEY,
	Materia		VARCHAR(20) NOT NULL,		/*Nombre de la materia*/
	Curso		VARCHAR(60) NOT NULL,		/*Curso donde se da la materia*/
	Dia			VARCHAR(10),				/*Dia que se da la materia*/
	SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,	/*Almacena la fecha y hora en que la fila comenzó a ser válida (Automatico por SQL Server)*/
	SysEndTime	DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,		/*Almacena la fecha y hora en que la fila dejó de ser válida (Automatico por SQL Server)*/
	PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime) 
)
WITH (SYSTEM_VERSIONING = ON)  -- Indica que se guarda un registro de las modificaciones que han habido dentro de la tabla
GO

-- Agregamos datos a la tabla
INSERT INTO Materias (Materia, Curso, Dia) 
VALUES ('T-SQL', 'Curso de administracion de bases de datos en SQL Server', 'Lunes'),
('Algoritmia', 'Curso profesional de C#', 'Martes'),
('POO', 'Curso profesional de C#', 'Miercoles'),
('Teoria musical', 'Curso de masterizacion musical', 'Jueves'),
('Circuitos Integrados', 'Curso de sistemas digitales', 'Viernes')

-- Solo se mostraran los datos actuales de la tabla
SELECT * FROM Materias
GO

-- Modificamos y/o eliminamos informacion
UPDATE Materias 
	SET Dia = 'Martes'
	WHERE Materia = 'T-SQL'
GO

DELETE FROM Materias 
	WHERE Materia = 'T-SQL'
GO

-- Se mostraran todos los datos que han estado en la tabla, inclyendo el momento que empezaron a ser validos (SysStartTime) y cuando dejaron de ser validos por que fueron actualizados o eliminados (SysEndTime)
SELECT * FROM Materias
	FOR SYSTEM_TIME ALL
GO


