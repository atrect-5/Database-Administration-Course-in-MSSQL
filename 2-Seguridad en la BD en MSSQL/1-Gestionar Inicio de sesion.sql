
-- Crear un inicio de sesion con autenticacion de SQL Server
CREATE LOGIN Alejandro
WITH PASSWORD = 'contraseña_segura'
MUST_CHANGE, -- Indica que la siguiente vez que inicie sesion, debera cambiar la contraseña
CHECK_EXPIRATION = ON, -- Indica que la contraseña expira y debe ser cambiada despues de un tiempo (debe incluirse si se usa MUST_CHANGE)
CHECK_POLICY = ON; -- Indica que se aplican las politicas de contraseñas del sistema operativo (longitud minima, complejidad, etc.)

-- Crear un inicio de sesion con autenticacion de Windows
CREATE LOGIN [DOMINIO\nombre_usuario]
FROM WINDOWS;

-- Modificar un inicio de sesion
ALTER LOGIN Alejandro
WITH PASSWORD = 'nueva_contraseña_segura';

ALTER LOGIN Alejandro 
DISABLE; -- Deshabilita el inicio de sesion

-- Ver los inicios de sesion existentes
SELECT * FROM sys.sql_logins;


-- ** Eliminar un inicio de sesion **
DROP LOGIN Alejandro;
