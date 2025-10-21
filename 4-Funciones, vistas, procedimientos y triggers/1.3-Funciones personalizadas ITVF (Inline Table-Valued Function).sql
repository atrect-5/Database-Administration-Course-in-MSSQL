-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;
GO
/****** Funciones personalizadas ITVF ******/
/* Sintaxis
CREATE FUNCTION nombre_funcion
( [ {@nombre_parametro [AS] tipo_dato_parametro
	[ = default ]}
	[,...n]
   ]
)
RETURNS table
AS
	RETURN (
		expresion_sql
	)
*/

-- Creamos una funcion que obtiene el dia de la semana
CREATE FUNCTION dbo.GetStudentById
( @studentId INT )
	RETURNS table
AS
	RETURN (
		SELECT NombreEstudiante + ' ' + ApellidoEstudiante AS 'Nombre Completo', Correo 
		FROM dbo.Estudiantes 
		WHERE IdEstudiante = @studentId
	)
GO

-- Probamos la funcion
SELECT * FROM dbo.GetStudentById(1)
GO

-- Para actualizar la funcion
ALTER FUNCTION dbo.GetStudentById
( @studentId INT )
	RETURNS table
AS
	RETURN (
		SELECT * FROM dbo.Estudiantes WHERE IdEstudiante = @studentId
	)
GO

-- Probamos la funcion actualizada
SELECT * FROM dbo.GetStudentById(1)

-- Para eliminar la funcion
DROP FUNCTION dbo.GetStudentById