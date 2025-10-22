-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;
GO
/* Sintaxis
CREATE PROCEDURE/PROC nombre_procedimiento
[ {@nombre_parametro tipo_dato_parametro }
	[ = default ]
[ OUT | INPUT ] ] [ ,...n ]
AS
{
	[ ; ] [ ...n ] |
}
*/

-- Creamos nuestro procedimiento almacenado para obtener todos los cursos
CREATE PROCEDURE dbo.usp_GetCourses
AS -- Sin parametros
	SELECT * FROM dbo.Cursos
GO

-- Ejecutamos nuesto procedimiento almacenado
EXEC dbo.usp_GetCourses;
GO



-- Creamos nuestro procedimiento almacenado para obtener la informacion de un usuario segun su correo
CREATE PROCEDURE dbo.usp_GetUserInfoByEmail
	@correo VARCHAR(100) 
AS
	SELECT IdEstudiante, NombreEstudiante + ' ' + ApellidoEstudiante AS Nombre, Correo
	FROM Estudiantes 
	WHERE Correo = @correo
GO

-- Modificamos nuestro procedimiento almacenado para obtener la informacion de los usuarios que compartan el filtro de correo
ALTER PROCEDURE dbo.usp_GetUserInfoByEmail
	@correo VARCHAR(100) = '' -- Valor por defecto en caso de que no se mande el parametro
AS
	SELECT IdEstudiante, NombreEstudiante + ' ' + ApellidoEstudiante AS Nombre, Correo
	FROM Estudiantes 
	WHERE Correo LIKE '%'+@correo+'%'
GO

-- Ejecutamos nuesto procedimiento almacenado
EXEC dbo.usp_GetUserInfoByEmail @correo = '@gmail.com';
GO



-- Creamos nuestro procedimiento almacenado para obtener los cursos donde esta inscrito un usuario
CREATE PROCEDURE dbo.usp_GetCoursesEnroled
	@idEstudiante INT,
	@cantidadCursos INT OUTPUT -- Es un parametro de salida
AS
	SELECT @cantidadCursos = COUNT(*)
	FROM InscripcionEstudianteCurso
	WHERE IdEstudiante = @idEstudiante
GO

-- Ejecutamos nuesto procedimiento almacenado
DECLARE @cantidadCursos INT
EXEC dbo.usp_GetCoursesEnroled @idEstudiante = 1, @cantidadCursos = @cantidadCursos OUTPUT;
SELECT @cantidadCursos AS 'Cantidad de cursos';
GO


-- Para eliminar procedimientos almacenados
DROP PROC IF EXISTS dbo.usp_GetCourses;
DROP PROC IF EXISTS dbo.usp_GetUserInfoByEmail;
DROP PROC IF EXISTS dbo.usp_GetCoursesEnroled;
GO