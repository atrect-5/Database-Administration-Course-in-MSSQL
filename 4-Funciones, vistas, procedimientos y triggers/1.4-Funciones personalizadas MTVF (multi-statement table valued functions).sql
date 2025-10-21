-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;
GO
/****** Funciones personalizadas MTVF ******/
/* Sintaxis
CREATE FUNCTION nombre_funcion
( [ {@nombre_parametro [AS] tipo_dato_parametro
	[ = default ]}
	[,...n]
   ]
)
RETURNS @return_variable TABLE
<definicion_tipo_tabla>
AS
BEGIN
	cuerpo_funcion
	RETURN
END [;]
*/


-- Creamos una funcion que obtiene los cursos a los que esta inscrito un alumno por su id
CREATE FUNCTION dbo.GetCoursesStudentsById
( @studentId INT )
RETURNS @studentCourses TABLE 
( -- Se requiere definir la tabla para este tipo de funciones
	IdEstudiante INT NOT NULL,
	NombreEstudiante TEXT NOT NULL,
	ApellidoEstudiante TEXT NOT NULL,
	NombreCurso TEXT NOT NULL,
	FechaInscripcion DATE NOT NULL
)
AS 
BEGIN
	INSERT @studentCourses
	SELECT es.IdEstudiante, es.NombreEstudiante,es.ApellidoEstudiante, c.NombreCurso, iec.FechaInscripcion
	FROM dbo.Estudiantes AS es
	INNER JOIN dbo.InscripcionEstudianteCurso AS iec ON es.IdEstudiante = iec.IdEstudiante
	INNER JOIN dbo.Cursos AS c ON iec.IdCurso = c.IdCurso
	WHERE es.IdEstudiante = @studentId
	RETURN 
END;
GO

-- Probamos la funcion
SELECT * FROM dbo.GetCoursesStudentsById(1)
GO

-- Para actualizar la funcion
ALTER FUNCTION dbo.GetCoursesStudentsById
( @studentId INT )
RETURNS @studentCourses TABLE 
( -- Se requiere definir la tabla para este tipo de funciones
	IdEstudiante INT NOT NULL,
	Estudiante TEXT NOT NULL,
	Curso TEXT NOT NULL,
	FechaInscripcion DATE NOT NULL
)
AS 
BEGIN
	INSERT @studentCourses
	SELECT es.IdEstudiante, es.NombreEstudiante + ' ' + es.ApellidoEstudiante AS Estudiante, c.NombreCurso AS Curso, iec.FechaInscripcion
	FROM dbo.Estudiantes AS es
	INNER JOIN dbo.InscripcionEstudianteCurso AS iec ON es.IdEstudiante = iec.IdEstudiante
	INNER JOIN dbo.Cursos AS c ON iec.IdCurso = c.IdCurso
	WHERE es.IdEstudiante = @studentId
	RETURN 
END;
GO

-- Probamos la funcion actualizada
SELECT * FROM dbo.GetCoursesStudentsById(1)


-- Para eliminar la funcion
DROP FUNCTION dbo.GetCoursesStudentsById