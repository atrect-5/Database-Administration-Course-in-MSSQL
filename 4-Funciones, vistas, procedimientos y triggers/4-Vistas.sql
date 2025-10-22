-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;
GO
/* Sintaxis
CREATE VIEW nombre_vista
AS
setencia_sql
*/


-- Creamos una vista que muestre a que curso esta inscrito cada alumno con la informacion del curso, el alumno y la fecha de inscripcion
CREATE VIEW dbo.ViewInformation
AS 
	SELECT es.IdEstudiante, es.NombreEstudiante + ' ' + es.ApellidoEstudiante AS Estudiante, c.NombreCurso AS Curso, iec.FechaInscripcion
	FROM dbo.Estudiantes AS es
	INNER JOIN dbo.InscripcionEstudianteCurso AS iec ON es.IdEstudiante = iec.IdEstudiante
	INNER JOIN dbo.Cursos AS c ON iec.IdCurso = c.IdCurso
GO


-- Ejecutamos la vista como si fuera una tabla
SELECT * FROM dbo.ViewInformation;
GO

--Para eliminar una vista
DROP VIEW dbo.ViewInformation;
GO