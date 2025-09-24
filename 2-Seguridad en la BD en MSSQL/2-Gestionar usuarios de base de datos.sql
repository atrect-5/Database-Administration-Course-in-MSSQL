
-- Crear un usuario de base de datos 
CREATE USER AlejandroG 
FOR LOGIN Alejandro; -- Se especifica el inicio de sesion que usara el usuario

-- Modificar un usuario
CREATE LOGIN otro_login
WITH PASSWORD = 'contraseña_segura'; -- Creamos otro login

ALTER USER AlejandroG
WITH LOGIN = otro_login; -- Cambia el login del usuario

-- Ver los usuarios de base de datos existentes
SELECT * 
FROM sys.database_principals
WHERE type = 'S'; -- Filtrar solo los usuarios de base de datos (tambien funciona type_desc = 'SQL_USER')

-- ** Eliminar un usuario de base de datos **
DROP USER AlejandroG;