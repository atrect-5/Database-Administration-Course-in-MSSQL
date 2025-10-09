
-- Se realiza un 'Full backup' de la base de datos elegida
BACKUP DATABASE AzulSchoolMSSQLAdministration TO DISK = N'D:\Database Backups\ASMSSQLABackup.bak'; -- Para probarlo, debes colocar tu propia ruta, pero el archivo debe tener la extencion '.bak'
GO

-- Se realiza un 'Backup diferencial' de la base de datos elegida
BACKUP DATABASE AzulSchoolMSSQLAdministration TO DISK = N'D:\Database Backups\ASMSSQLABackupDiff.dif' WITH DIFFERENTIAL; -- El archivo debe tener la extencion '.dif'
GO

-- Se realiza un 'Backup de los logs de las transacciones' de la base de datos elegida
BACKUP DATABASE AzulSchoolMSSQLAdministration TO DISK = N'D:\Database Backups\ASMSSQLABackupTrans.trn' WITH DIFFERENTIAL; -- El archivo debe tener la extencion '.trn'
GO


-- ** Nos muestra cual es la ultima vez que se realizo un backup de cada base de datos **
SELECT sdb.name AS DataBaseName, 
COALESCE(CONVERT(VARCHAR(12), MAX(bus.backup_finish_date), 101), '-') AS UltimoBackup
	FROM sys.sysdatabases AS sdb
	LEFT OUTER JOIN msdb.dbo.backupset AS bus ON bus.database_name = sdb.name
	GROUP BY sdb.name

-- ** Nos muestra los backups realizados en los ultimos 30 dias (se puede cambiar el numero de dias) **
SELECT
	CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Servidor,
	msdb.dbo.backupset.database_name BBDD, 
	CASE msdb..backupset.type
		WHEN 'D' THEN 'Database'
		WHEN 'L' THEN 'Log'
	END AS Tipo,
	msdb.dbo.backupset.backup_start_date Inicio_BK,
	msdb.dbo.backupset.backup_finish_date Fin_BK,
	msdb.dbo.backupmediafamily.physical_device_name Donde_Esta,
	msdb.dbo.backupset.backup_size Tamano,
	msdb.dbo.backupset.description Motivo
FROM msdb.dbo.backupmediafamily
	INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id
/* Cambiar "GETDATE() - 30" Por el numero de dias que queramos */
WHERE (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 30)
ORDER BY 
	msdb.dbo.backupset.database_name,
	msdb.dbo.backupset.backup_finish_date;