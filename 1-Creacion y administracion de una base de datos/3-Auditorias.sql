
USE master; -- Para crear una auditoria, debe usarse la base de datos 'master'

-- Primero se crea la auditoria
CREATE SERVER AUDIT AzulSchoolAudit
	TO FILE (FILEPATH = 'C:\Audit'); 
GO

-- Luego se crean las especificaciones de la auditoria
CREATE SERVER AUDIT SPECIFICATION AzulSchoolAuditSpecification
FOR SERVER AUDIT AzulSchoolAudit
	ADD (FAILED_LOGIN_GROUP);
GO



-- ** Ver informacion sobre las auditorias **
-- Mostrar las auditorias creadas
SELECT * FROM sys.server_audits;

-- Especificaciones de auditoría
SELECT * FROM sys.server_audit_specifications;

-- Devuelve todas las entradas de auditoría encontradas en los archivos .sqlaudit de esa carpeta
SELECT * FROM sys.fn_get_audit_file('C:\Audit\*.sqlaudit', DEFAULT, DEFAULT);




-- Por ultimo, habilitamos la auditoria
ALTER SERVER AUDIT AzulSchoolAudit
WITH (STATE = ON)
GO

-- Si queremos desabilitarla
ALTER SERVER AUDIT AzulSchoolAudit
WITH (STATE = OFF)
GO

-- Para eliminar una auditoria, usamos DROP
DROP SERVER AUDIT SPECIFICATION AzulSchoolAuditSpecification;
GO

DROP SERVER AUDIT AzulSchoolAudit;
GO