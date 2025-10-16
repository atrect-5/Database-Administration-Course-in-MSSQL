
-- Se crea la clave maestra que servira para firmar el certificado y encriptar los datos de la base de datos
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'UNa_Contrasenna_muy_muy_larga_y_segura'
GO

-- Se crea el certificado y se firma con la maseter key
CREATE CERTIFICATE TDE_Certificado WITH SUBJECT = 'TDE_Base_De_Datos'
GO

-- Esta consulta nos permite ver los certificados existentes
SELECT * FROM sys.certificates;

-- Realizamos un backup del certificado y su llave privada para poder restaurarlo en caso de ser necesario
USE master; -- Cambiamos a la base de datos maestra
BACKUP CERTIFICATE TDE_Certificado TO FILE = 'D:\Database Backups\Certificados\TDE_Certificado'
	WITH PRIVATE KEY (FILE = 'D:\Database Backups\Certificados\TDE_Certificado.pri',
	ENCRYPTION BY PASSWORD = 'TDE_Certificado')


-- Se crea la llave de encriptacion para la base de datos
USE AzulSchoolMSSQLAdministration -- Cambiamos a la base de datos que queremo encriptar
CREATE DATABASE ENCRYPTION KEY 
WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE TDE_Certificado -- Solo funciona con determinadas versiones de SQL Server


-- Encriptamos la base de datos usando el certificado
-- Se activa la encriptacion
ALTER DATABASE AzulSchoolMSSQLAdministration SET ENCRYPTION ON 


-- Para saber si la base de datos esta encriptada, se obtienen las llaves de encriptacion
SELECT * FROM sys.dm_database_encryption_keys;
-- Dependiendo el codigo de encryption_state, es si esta cifrada o no la base de datos
/*
0 -> No existe una clave de cifrado en la base de datos, no esta cifrado
1 -> No cifrado
2 -> Se esta cifrando la base de datos
3 -> Cifrado
4 -> Se esta cambiando la clave de cifrado
5 -> Se esta descifrando
6 -> Se esta cambiando la proteccion
*/