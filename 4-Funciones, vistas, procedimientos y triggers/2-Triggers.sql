-- Usamos nuestra base de datos
USE AzulSchoolMSSQLAdministration;
GO

/* Esqueleto para creacion de triggers
CREATE TRIGGER nombre_trigger
ON tabla_objetivo
{ FOR | AFTER }
{ [ INSERT ] [ , ] [ UPDDATE ] [ , ] [ DELETE ] }
AS
{
	declaracion_sql
	[,...n]
}
*/



/***** Trigger de inserción con AFTER e INSERTED *****/
CREATE TRIGGER dbo.INSERT_Estudiantes
	ON dbo.Estudiantes
AFTER INSERT		-- Se ejecuta después de un INSERT
AS 
BEGIN 
	SET NOCOUNT ON;
	
	INSERT INTO dbo.Log (LogName, LogValue) -- Crea un log por cada insercion que se realiza
		SELECT 
			'Trigger INSERT_Estudiantes',
			'Estudiante ' + CAST(IdEstudiante AS VARCHAR) + ' fue agregado'
    FROM INSERTED;

END
GO

-- Insertamos un nuevo estudiante, para probar si se crea el nuevo log en la tabla correspondiente
INSERT INTO dbo.Estudiantes (NombreEstudiante, ApellidoEstudiante, Correo)
VALUES ('Pedrito', 'Sola', 'pedrito@correo.com')
GO

/***** Trigger de actualización con AFTER, INSERTED y DELETED *****/
CREATE TRIGGER dbo.UPDATE_Estudiantes
	ON dbo.Estudiantes
AFTER UPDATE		-- Indicamos que se ejecutara despues de un update
AS 
BEGIN 
	SET NOCOUNT ON;

	INSERT INTO dbo.Log (LogName, LogValue)
		SELECT
			'Trigger UPDATE_Estudiantes',
			'Estudiante ' + CAST(i.IdEstudiante AS VARCHAR) + ' fue actualizado. ' +
			CASE
				WHEN i.NombreEstudiante <> d.NombreEstudiante THEN 'Cambio en Nombre.' -- Revisa cuales son los datos que cambiaron para incluirlos en el log
				WHEN i.ApellidoEstudiante <> d.ApellidoEstudiante THEN 'Cambio en Apellido.'
				WHEN i.Correo <> d.Correo THEN 'Cambio en Correo.'
				ELSE 'Cambio no especificado.'
			END
	FROM
		INSERTED AS i
	INNER JOIN
		DELETED AS d ON i.IdEstudiante = d.IdEstudiante;
END
GO

-- Actualizamos a un estudiante, para probar si se crea el nuevo log en la tabla correspondiente
UPDATE dbo.Estudiantes 
SET ApellidoEstudiante = 'Gomez'
WHERE IdEstudiante = 7
GO


/***** Trigger de eliminación con AFTER y DELETED *****/
CREATE TRIGGER dbo.DELETE_Estudiantes
	ON dbo.Estudiantes
AFTER DELETE		-- Indicamos que se ejecutara despues de un delete
AS 
BEGIN 
	SET NOCOUNT ON;

	INSERT INTO dbo.Log (LogName, LogValue)
		SELECT 
			'Trigger DELETE_Estudiantes',
			'Estudiante ' + CAST(IdEstudiante AS VARCHAR) + ' fue eliminado'
    FROM DELETED -- Tabla temporal que se crea al eliminar datos, por cada registro eliminado se hara una insercion en Log

END
GO

-- Eliminamos un estudiante, para probar si se crea el nuevo log en la tabla correspondiente
DELETE FROM dbo.Estudiantes 
WHERE NombreEstudiante = 'Pedrito'
GO




-- Observamos la tabla de logs
SELECT * FROM dbo.Log;
GO
SELECT * FROM dbo.Estudiantes
GO


-- Para eliminar un trigger
DROP TRIGGER IF EXISTS dbo.INSERT_Estudiantes;
DROP TRIGGER IF EXISTS dbo.UPDATE_Estudiantes;
DROP TRIGGER IF EXISTS dbo.DELETE_Estudiantes;
GO