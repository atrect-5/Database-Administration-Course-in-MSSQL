
-- Utilizaremos la base de datos que creamos anteriormente, en la seccion 4-Permisos y roles en la base de datos
USE PermisosRolesDB;
GO
-- Creamos un login y un nuevo usuario
CREATE LOGIN login_acceso WITH PASSWORD = 'password_muy_dificil';
CREATE USER ALEJANDRO_ACCESO FOR LOGIN login_acceso;

-- Denegamos el acceso a SELECT para el usuario que creamos
DENY SELECT ON [dbo].[Cursos] TO ALEJANDRO_ACCESO;

EXECUTE ('SELECT * FROM [dbo].[Cursos]') AS USER = 'ALEJANDRO_ACCESO'; -- Ejecutamos un SELECT desde la cuenta denegada
/* 
Mens. 229, Nivel 14, Estado 5, Línea 12
The SELECT permission was denied on the object 'Cursos', database 'PermisosRolesDB', schema 'dbo'.
*/ -- Este es el mensaje que dara si no se tiene permiso
REVERT

-- Otorgamos el acceso a SELECT para el usuario que creamos
GRANT SELECT ON [dbo].[Cursos] TO ALEJANDRO_ACCESO;

EXECUTE ('SELECT * FROM [dbo].[Cursos]') AS USER = 'ALEJANDRO_ACCESO'; -- Ejecutamos un SELECT desde la misma cuenta, ahora con acceso
/*Ahora si lo permite*/
REVERT


-- Revoca permisos otorgados o denegados previamente
REVOKE SELECT ON [dbo].[Cursos] TO ALEJANDRO_ACCESO;


-- Creamos un procedure para probar los permisos en el
CREATE PROC sp_cursos 
AS SELECT * FROM Cursos;

-- Denegammos EXECUTE al usuario
DENY EXECUTE ON sp_cursos TO ALEJANDRO_ACCESO;
EXECUTE ('EXECUTE sp_cursos') AS USER = 'ALEJANDRO_ACCESO'; -- Ejecutamos un EXECUTE desde la cuenta denegada
/* 
Mensaje 229, nivel 14, estado 5, procedimiento sp_cursos, línea 1 [línea de inicio de lote 35]
The EXECUTE permission was denied on the object 'sp_cursos', database 'PermisosRolesDB', schema 'dbo'.
*/ -- Este es el mensaje que dara si no se tiene permiso
REVERT

-- Otorgamos permiso de EXECUTE al usuario
GRANT EXECUTE ON sp_cursos TO ALEJANDRO_ACCESO;
EXECUTE ('EXECUTE sp_cursos') AS USER = 'ALEJANDRO_ACCESO'; -- Ejecutamos un EXECUTE desde la misma cuenta, ahora con acceso
/*Ahora si lo permite*/
REVERT

