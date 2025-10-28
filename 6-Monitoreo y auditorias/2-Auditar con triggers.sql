-- Utilizamos nuestra base de datos
USE AzulSchoolMSSQLAdministration;
GO

-- Creamos una tabla que nos permita monitorear cambios en los estudiantes
CREATE TABLE EstudiantesLog (
	Fecha_Registro	DATETIME,
	Usuario			VARCHAR(30),
	Maquina			VARCHAR(50),
	Num_Conexion	INT,
	Programa		VARCHAR(100),
	Base_de_Datos	VARCHAR(50),
	Tabla			VARCHAR(50),
	Operacion		VARCHAR(10),
	TR_Util			VARCHAR(20)
);
GO

-- Creamos un trigger para llevar a cabo un registro de los movimientos realizados en la tabla estudiantes
-- Esto nos permite saber cuales fueron los cabios realizados en la tabla estudiantes, quien realizo los cambios y en que condiciones (maquina, programa, etc.)
CREATE TRIGGER TR_EstudiantesLog ON dbo.Estudiantes
	AFTER INSERT, UPDATE, DELETE
AS 
	-- Variables que recogen datos 
	DECLARE	@Fecha_Registro		DATETIME	/*Fecha registro*/
	DECLARE	@Usuario			VARCHAR(30)	/*Usuario actual*/
	DECLARE	@Maquina			VARCHAR(50)	/*PC*/
	DECLARE	@Num_Conexion		INT			/*Spid*/
	DECLARE	@Programa			VARCHAR(100)	/*Que programa se utilizo*/
	DECLARE	@Base_de_Datos		VARCHAR(50)	/*Sobre que base de datos se realizo la operacion*/
	DECLARE	@Tabla				VARCHAR(50)	/*Sobre que tabla se realizo la operacion*/
	DECLARE	@Operacion			VARCHAR(10)	/*Operacion realizada*/ 
	DECLARE	@TR_Util			VARCHAR(20)	/*Trigger utilizado*/
	-- Obtencion de datos
	SET	@Fecha_Registro = GETDATE()
	SET	@Usuario		= SYSTEM_USER
	SET	@Maquina		= HOST_NAME()
	SET	@Num_Conexion 	= @@SPID
	SET	@Programa		= PROGRAM_NAME()
	SET	@Base_de_Datos	= DB_NAME()
	SET	@Tabla			= 'Estudiantes'
	SET	@TR_Util		= 'TR_EstudiantesLog'

	-- Tipo de operacion
	IF EXISTS (SELECT * FROM inserted)
		IF EXISTS (SELECT * FROM deleted)
			SELECT @Operacion = 'Cambio'
		ELSE
			SELECT @Operacion = 'Alta'
	ELSE
		SELECT @Operacion = 'Baja'
	
	-- Operacion SQL del trigger para guardar la informacion en la tabla se logs
	INSERT INTO EstudiantesLog (Fecha_Registro, Usuario, Maquina, Num_Conexion, Programa, Base_de_Datos, Tabla, Operacion, TR_Util)
	VALUES (@Fecha_Registro, @Usuario, @Maquina, @Num_Conexion, @Programa, @Base_de_Datos, @Tabla, @Operacion, @TR_Util)
GO

-- Insertamos datos
INSERT INTO dbo.Estudiantes (NombreEstudiante, ApellidoEstudiante, Correo)
VALUES ('Pedro', 'Gomez', 'peddro@correo.com')
GO

-- Actualizamos datos
UPDATE dbo.Estudiantes 
SET NombreEstudiante = 'Actualizado'
WHERE NombreEstudiante = 'Pedro'
GO

-- Eliminamos datos
DELETE FROM dbo.Estudiantes 
WHERE NombreEstudiante = 'Actualizado'
GO

-- Mostramos nuestra tabla de estudiantes y los logs
SELECT * FROM dbo.Estudiantes
SELECT * FROM dbo.EstudiantesLog