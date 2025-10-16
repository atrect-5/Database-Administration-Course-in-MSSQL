
USE AzulSchoolMSSQLAdministration;

-- Creamos una tabla de ejemplo
CREATE TABLE DatosAlumnos(
	AlumnoID int IDENTITY PRIMARY KEY,
	Nombre varchar(100) MASKED WITH (FUNCTION = 'partial(1, "XXXXXX", 0)') NULL, -- Usamos MASKED WITH (FUNCTION = ) para cubrir la informacion
	Info varchar(12) MASKED WITH (FUNCTION = 'default()') NULL,
	Email varchar(50) MASKED WITH (FUNCTION = 'email()') NULL
)

-- Agregamos valores de prueba
INSERT INTO DatosAlumnos (Nombre, Info, Email) VALUES 
	('Alejandro Gonzalez', '123.456.789', 'alex1123.nel@gmail.com'),
	('Bruce Calderon', '987.654.321', 'bruce@email.com'),
	('Miguel Alatorre', '456.123.789', 'correo@miguel.com')


SELECT * FROM DatosAlumnos;

-- Creamos un nuevo user para probar las mask
CREATE USER nuevo_Mask WITHOUT LOGIN
GRANT SELECT ON DatosAlumnos TO nuevo_Mask -- Le asignamos permisos de lectura

-- Ejecutamos un select como el usuario nuevo_Mask y veremos que nos bloque cierta info
EXEC AS USER = 'nuevo_Mask';
SELECT * FROM DatosAlumnos;
REVERT


-- Observamos los elementos enmascarados de una tabla
SELECT c.name, tbl.name AS Nombre_Tabla, c.is_masked, c.masking_function
FROM sys.masked_columns AS c
JOIN sys.tables AS tbl
	ON c.[object_id] = tbl.[object_id]
WHERE is_masked = 1

-- Eliminamos el enmascaramiento de una columna
ALTER TABLE DatosAlumnos 
ALTER COLUMN nombre DROP MASKED