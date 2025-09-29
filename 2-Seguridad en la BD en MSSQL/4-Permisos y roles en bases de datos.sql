
/********** Creacion de base de datos de prueba **********/
/*Base de datos para realizar ejercicios sobre roles y permisos en bases de datos*/

CREATE DATABASE PermisosRolesDB;
GO
USE PermisosRolesDB;
GO

-- Creamos las tablas de la base de datos
CREATE TABLE Cursos (
	curso_id INT IDENTITY,
	nombre_curso VARCHAR(50),
	nivel_clase VARCHAR(2),
	dia VARCHAR(10)
);
GO

CREATE TABLE Estudiantes (
	estudiante_id INT IDENTITY,
	nombre VARCHAR(25),
	apellido VARCHAR(25),
	curso VARCHAR(50)
);
GO

-- Insertamos los datos de las tablas
INSERT INTO [dbo].[Cursos] (
[nombre_curso], [nivel_clase], [dia] 
) VALUES ('MSSQL', 'A1', 'Lunes'),
('PHP', 'A1', 'Martes'),
('C++', 'A1', 'Miercoles'),
('JavaScript', 'A1', 'Jueves'),
('C#', 'A1', 'Viernes'),
('Python', 'A1', 'Sabado');
GO

INSERT INTO [dbo].[Estudiantes] (
 [curso], [nombre], [apellido]
) VALUES ('MSSQL', 'Alejandro', 'Gonzalez'),
('MSSQL', 'Miguel', 'Alatorre'),
('C++', 'Bruce', 'Calderon'),
('JavaScript', 'Salvador', 'Enriquez'),
('C#', 'Jessica', 'Alvelar'),
('Python', 'Cassandra', 'Avelar');
GO


-- Listamos los roles de la base de datos
SELECT *
FROM sys.fn_builtin_permissions('DATABASE') -- Nos muestra los permisos a nivel de base de datos

SELECT *
FROM sys.database_principals
WHERE type = 'R'; -- Nos muestra los roles de bases de datos predefinidos


-- ** Aqui podemos ver los roles en nuestra base de datos que han sido otorgados y a que usuario en esta base de datos furon otogados **
SELECT rdp.name AS role_name, rdm.name AS member_name
FROM sys.database_role_members AS rm
JOIN sys.database_principals AS rdp
ON rdp.principal_id = rm.role_principal_id
JOIN sys.database_principals AS rdm 
ON rdm.principal_id = rm.member_principal_id;

-- Creamos un login y usuario para poder asignar nuestro rol
CREATE LOGIN usuario_database WITH PASSWORD = 'password_muy_dificil';
CREATE USER ALEJANDRO_DB FOR LOGIN usuario_database;


-- Esto vincula un usuario con un rol, en este caso es un rol predefinido con permisos de seguridad
ALTER ROLE db_securityadmin ADD MEMBER ALEJANDRO_DB;

-- Nos lista los miembros que son parte de un determinado rol
EXEC sp_helprolemember db_securityadmin;

-- Esto desvincula un usuario con un rol, en este caso es un rol predefinido con permisos de seguridad
ALTER ROLE db_securityadmin DROP MEMBER ALEJANDRO_DB;


-- ** Creamos nuestro propio rol, agregamos el usurio que previamente creamos (se debe desvincular del rol anterior), listamos los miembros del nuevo rol y luego lo desevinculamos
CREATE ROLE nuevo_rol; -- Creamos nuestro propio rol
ALTER ROLE nuevo_rol ADD MEMBER ALEJANDRO_DB; -- Vinculamos el usurio al rol
EXEC sp_helprolemember nuevo_rol; -- Listamos miembros de 'nuevo_rol'
ALTER ROLE nuevo_rol DROP MEMBER ALEJANDRO_DB; -- Desvinculamos el usurio al rol

-- **Esto elimina un rol de base de datos que creamos (No debe incluir miembros) **
DROP ROLE nuevo_rol;