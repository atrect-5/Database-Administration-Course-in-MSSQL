-- Usamos la base de datos que creamos
USE AzulSchoolMSSQLAdministration;

/****** Funciones integradas ******/

-- Une dos o más cadenas en una sola.
SELECT CONCAT(NombreEstudiante, ' ', ApellidoEstudiante) AS Nombre_Estuduante, Correo
FROM dbo.Estudiantes

SELECT NombreEstudiante + ' ' + ApellidoEstudiante AS Nombre_Estudiante, Correo
FROM dbo.Estudiantes
-- Los dos hacen lo mismo (concatenar elementos), pero operador '+' devuelve NULL si alguno de los valores es NULL y 'CONCAT' convierte los valores nulos en cadenas vacías

-- Devuelve toda la cadena en minuscula
SELECT LOWER(NombreEstudiante + ' ' + ApellidoEstudiante) AS Nombre_Estudiante, Correo
FROM dbo.Estudiantes
-- Devuelve toda la cadena en mayuscula
SELECT UPPER(NombreEstudiante + ' ' + ApellidoEstudiante) AS Nombre_Estudiante, Correo
FROM dbo.Estudiantes

-- Obtiene la fecha actual
SELECT GETDATE() AS Fecha;

-- Genera un numero aleatorio entre 0 y 1
SELECT RAND() AS Random;

-- Devuelve la cantidad de elementos que coinciden en la consulta
SELECT COUNT(*) AS Cantidad_Alumnos 
FROM Estudiantes

-- Devuelve la longitud de una cadena
SELECT LEN(Correo) AS Longitud_Correo 
FROM Estudiantes

-- Calcula el promedio de una columna numerica
SELECT AVG(LEN(Correo)) AS Promedio_Longitud_Correo  -- Calcula el promedio de longitud de los correos de los alumnos
FROM Estudiantes

