
-- Ver los permisos del servidor 
SELECT * 
FROM sys.fn_builtin_permissions('SERVER')
ORDER BY permission_name;

-- Ver los roles del servidor, junto al usuario que tiene ese rol
SELECT spr.name AS ROLE_NAME, spm.name AS MEMBER_NAME
FROM sys.server_role_members AS rm
	JOIN sys.server_principals AS spr
		ON spr.principal_id = rm.role_principal_id
	JOIN sys.server_principals AS spm 
		ON spm.principal_id = rm.member_principal_id
ORDER BY ROLE_NAME, MEMBER_NAME;

-- Ver los roles excistentes
SELECT *
FROM sys.server_principals
WHERE type = 'R'; -- Filtrar solo los roles de servidor


-- Creamos un login que tendra el rol que hemos creado
CREATE LOGIN nuevo_login_nuevo_rol
WITH PASSWORD = 'nueva_contraseña_segura';

-- Creamos un rol de servidor con el login que hemos creado
CREATE SERVER ROLE nuevo_rol
AUTHORIZATION nuevo_login_nuevo_rol;


-- Modificar un rol
ALTER SERVER ROLE nuevo_rol
DROP MEMBER nuevo_login_nuevo_rol; -- Para eliminar un inicio de sesion del rol

ALTER SERVER ROLE nuevo_rol
ADD MEMBER nuevo_login_nuevo_rol; -- Para agregar un inicio de sesion al rol


-- ** Elimina un rol **
DROP SERVER ROLE nuevo_rol;