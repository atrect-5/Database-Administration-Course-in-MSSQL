-- Usamos la base de datos que hemos usado para el curso
USE AzulSchoolMSSQLAdministration;

-- Creamos nuevas tablas para trabajar este modulo
CREATE TABLE Estudiantes (
	IdEstudiante INT IDENTITY,
	NombreEstudiante VARCHAR(60) NOT NULL,
	ApellidoEstudiante VARCHAR(60) NOT NULL,
	Correo VARCHAR(60) NOT NULL DEFAULT 'No Correo',
	FechaRegistro DATE DEFAULT GETDATE(), -- Se usa la funcion GETDATE que obtiene la fecha actual
	CONSTRAINT pk_IdEstudiante PRIMARY KEY (IdEstudiante),
	CONSTRAINT ck_FechaRegistro CHECK (FechaRegistro >= '2025/10/20') -- Asegura que los valores insertados o actualizados en esa columna sean iguales o posteriores al 20 de octubre de 2025.
);

CREATE TABLE Cursos (
	IdCurso INT IDENTITY,
	NombreCurso VARCHAR(60) NOT NULL,
	UltimaActualizacion DATE DEFAULT GETDATE(),
	CONSTRAINT pk_IdCurso PRIMARY KEY (IdCurso),
	CONSTRAINT uq_NombreCurso UNIQUE (NombreCurso), -- Evita que se repita el nombre de algun curso
	CONSTRAINT ck_UltimaActualizacion CHECK (UltimaActualizacion >= '2025/10/20')
);

CREATE TABLE InscripcionEstudianteCurso ( -- Se encarga de relacionar a los estudiantes con los cursos donde estan registrados
	IdEstudiante INT NOT NULL,
	IdCurso INT NOT NULL,
	FechaInscripcion DATE DEFAULT GETDATE(),
	CONSTRAINT pk_CursoEstudiante PRIMARY KEY (IdEstudiante, IdCurso), -- Define una clave primaria compuesta (Evita que un mismo estudiante se inscriba dos veces en el mismo curso)
	CONSTRAINT fk_IdEstudiante FOREIGN KEY (IdEstudiante)
	REFERENCES Estudiantes(IdEstudiante) ON UPDATE CASCADE, -- Define una clave foránea que conecta IdEstudiante con la tabla Estudiantes. 'ON UPDATE CASCADE' indica que si el IdEstudiante cambia en la tabla Estudiantes, automáticamente se actualizará en esta tabla también.
	CONSTRAINT fk_IdCurso FOREIGN KEY (IdCurso)
	REFERENCES Cursos(IdCurso) ON UPDATE CASCADE
);

-- Insetamos datos en las tablas que creamos
INSERT INTO dbo.Estudiantes (NombreEstudiante, ApellidoEstudiante, Correo, FechaRegistro)
VALUES ('Alejandro', 'Gonzalez', 'alex1123.nel@gmail.com', '2025/10/20'),
('Miguel', 'Alatorre', 'miguel@gmail.com', '2025/10/20'),
('Bruce', 'Calderon', 'bruce@gmail.com', '2025/10/20');

INSERT INTO dbo.Cursos (NombreCurso, UltimaActualizacion) 
VALUES ('Curso profecional de SQL Server', '2025/10/20'),
('Curso profecional de Python', '2025/10/20')

INSERT INTO dbo.InscripcionEstudianteCurso (IdEstudiante, IdCurso)
VALUES (1,1), (1,2), (2,1), (3,2); -- Solo se usan los id de los estudiantes y cursos para hacer la relacion

SELECT * FROM Estudiantes;
SELECT * FROM Cursos;
SELECT * FROM InscripcionEstudianteCurso;