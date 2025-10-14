
-- Usamos la base de datos master
USE master;

-- Eliminamos la base de datos de la que realizamos el backup
DROP DATABASE AzulSchoolMSSQLAdministration;

-- Verificamos el archivo que contiene el respaldo de la base de datos 
RESTORE VERIFYONLY 
FROM DISK = N'D:\Database Backups\ASMSSQLABackup.bak'; -- Se debe colocar la ruta donde se guardo la copia de seguridad
/* Deberia retornar algo asi:
The backup set on file 1 is valid. */

-- Ya verificado, procedemos a reestaurar la base de datos
RESTORE DATABASE AzulSchoolMSSQLAdministration
FROM DISK = N'D:\Database Backups\ASMSSQLABackup.bak';
/* Deberia retornar algo asi:
RESTORE DATABASE successfully processed 546 pages in 0.010 seconds (426.171 MB/sec). */

-- Verificamos la integridad logica y fisica de la base de datos que restauramos
DBCC CHECKDB('AzulSchoolMSSQLAdministration') WITH no_infomsgs; -- Excluimos los mensajes de consola de lo que esta checando el comando
/* Deberia retornar algo asi:
Los comandos se han completado correctamente. */


-- Ya podremos usar nuestra base de datos
USE AzulSchoolMSSQLAdministration;