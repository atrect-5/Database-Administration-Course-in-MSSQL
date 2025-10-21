-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;
GO
/****** Funciones escalares personalizadas ******/
/* Sintaxis
CREATE FUNCTION nombre_funcion
( [ {@nombre_parametro [AS] tipo_dato_parametro
	[ = default ]}
	[,...n]
   ]
)
RETURNS tipo_dato_retorno
AS
BEGIN
	cuerpo_funcion
	RETURN expresion_escalar
END [;]
*/
-- Creamos una funcion que obtiene el dia de la semana
CREATE FUNCTION dbo.GetWeekDay
( @date DATETIME )
	RETURNS VARCHAR(10)
AS
BEGIN 	
	RETURN DATENAME(WEEKDAY, @date);
END;
GO

-- Probamos la funcion
SELECT dbo.GetWeekDay(GETDATE()) AS 'Dia de la semana';
GO

-- Para actualizar la funcion
ALTER FUNCTION dbo.GetWeekDay
( @date DATETIME )
	RETURNS VARCHAR(10)
AS
BEGIN 	
	RETURN DATEPART(WEEKDAY, @date);
END;
GO

-- Probamos la funcion actualizada
SELECT dbo.GetWeekDay(GETDATE()) AS 'Dia de la semana';
GO

-- Para eliminar la funcion
DROP FUNCTION dbo.GetWeekDay