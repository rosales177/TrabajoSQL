USE master
go

/*CREACION ARCHIVOS MDF Y LDF*/

DROP DATABASE IF EXISTS RH_VENTAS
go

CREATE DATABASE RH_VENTAS
ON PRIMARY    
(
	NAME= RHVentas_dat,
	FILENAME = 'C:\human_resource\rhventasdat.mdf',
	SIZE = 20MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB 
)
LOG ON    
(
	NAME = RHVentas_log,
	FILENAME = 'C:\human_resource\rhventaslog.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB
)
go

/*USO DE LA BASE DE DATOS RH_VENTAS*/

USE RH_VENTAS
GO

/*CREACI�N DE TABLAS*/

---TABLAS PUESTO
DROP TABLE IF EXISTS PUESTO
go
CREATE TABLE PUESTO
(
	Pk_Puesto_Id int not null identity(1,1),
	Nombre nvarchar(40) not null,
	Salario_Maximo decimal(6,2) not null,
	Salario_Minimo decimal(6,2) not null
)
go

---TABLAS REGION
DROP TABLE IF EXISTS REGION
go
CREATE TABLE REGION
(
	Pk_Region_Id int not null identity(1,1),
	Uk_Region_Nombre nvarchar(40) not null	
)
go

---TABLAS PAIS
DROP TABLE IF EXISTS PAIS
go

CREATE TABLE PAIS
(
	Pk_Pais_Id int not null identity(1,1),
	Uk_Pais_Nombre nvarchar(40) not null,
	Fk_Region_Pais_RegionId int not null
)                        
go


---TABLA EMPLEADO
DROP TABLE IF EXISTS EMPLEADO
go

CREATE TABLE EMPLEADO
(
	Pk_Empleado_Id int not null identity(1,1),
	Tipo_Doc_Identidad nvarchar(20) not null,
	Uk_Empleado_Nro_Doc_Identidad nvarchar(20) not null,
	Nombre nvarchar(40) not null,
	Apellido nvarchar(40) not null,
	Email nvarchar(50) not null,
	Nacionalidad nvarchar(40) not null,
	telefono nvarchar(20) not null,
--	Fk_Empleado_Empleado_SupervisorId int -- Ahora se permiten ingresar valores nulos porque no puede supervisarse uno mismo
)
go

---TABLA DEPARTAMENTO
DROP TABLE IF EXISTS DEPARTAMENTO
GO
CREATE TABLE DEPARTAMENTO
(
	Pk_Departamento_ID int not null identity(1,1),
	Uk_Departamento_Nombre nvarchar(40) not null,
	Fk_Sucursal_Departamento_SucursalId int not null
)
GO

---TABLA SUCURSAL
DROP TABLE IF EXISTS SUCURSAL
go


CREATE TABLE SUCURSAL
(
Pk_Sucursal_Id int not null identity(1,1),
Direccion nvarchar(60) not null,
Distrito nvarchar(20) not null,
Provincia nvarchar(40) not null,
Fk_Pais_Sucursal_PaisId int not null
)
go


---TABLA USUARIO
DROP TABLE IF EXISTS USUARIO
go


CREATE TABLE USUARIO
(
Pk_Nombre nvarchar(50) not null,
Pass varBinary(8000) not null,
Estado char(1) not null,
Fk_Empleado_Usuario_EmpleadoId int not null
)
go

---TABLA EMPLEADO_HISTORIAL

DROP TABLE IF EXISTS EMPLEADO_HISTORIAL
go
CREATE TABLE EMPLEADO_HISTORIAL
(
	Pk_Historial_Id int not null identity(1,1),
	Empleado_Id int not null,
	Tipo_Doc_Identidad nvarchar(20) not null,
	Nro_Doc_Identidad nvarchar(20) not null,
	Nombre nvarchar(40) not null,
	Apellido nvarchar(40) not null,
	Email nvarchar(50) not null,
	Nacionalidad nvarchar(40) not null,
	telefono nvarchar(20) not null,
	Fecha_Registro_Despido date default getdate() not null,
)
go

---TABLA EMPLEADO_CONTRATOS
DROP TABLE IF EXISTS EMPLEADO_CONTRATOS
GO
CREATE TABLE EMPLEADO_CONTRATOS
(
	Pk_Contrato_Id int not null identity(1,1),
	Fk_Empleado_EmpleadoContratos_EmpleadoId int not null,
	Fecha_Inicio date not null,
	Fecha_Termino date not null,
	Sueldo_Basico decimal(8,2) not null,
	Comision_vta decimal(8,2) not null,
	Fk_Puesto_EmpleadoContratos_PuestoId int not null,
	Fk_Departamento_EmpleadoContratos_DepartamentoId int not null

)
GO

---TABLA EMPLEADO_CONTRATO_HISTORIAL
DROP TABLE IF EXISTS EMPLEADO_CONTRATO_HISTORIAL
GO

CREATE TABLE EMPLEADO_CONTRATO_HISTORIAL
(
	Pk_Empleado_Id int not null,
	Pk_Contrato_Id int not null,
	Fecha_Inicio date not null,
	Fecha_Termino date not null,
	Sueldo_Basico decimal (8,2) not null,
	Comision_Vta decimal(8,2)not null,
	Puesto_Id int not null,
	Departamento_Id int not null,
	A�os_Servicio int not null,
	Meses_Servicio int not null,
	Dias_Servicio int not null
)
GO


--=======CREACION DE TABLA SUPERVISOR=========

DROP TABLE IF EXISTS SUPERVISOR
GO
CREATE TABLE SUPERVISOR
(
PK_supervisorId int not null identity(1,1),
FK_Empleado_Supervisor_EmpleadoId int not null,
FK_Departamento_Supervisor_DepartarmentoId int not null
)

GO
/*---PRIMARY KEY---*/

--NOMENCLATURA: Pk_NombreTabla_NombreCampo

ALTER TABLE PUESTO
DROP CONSTRAINT IF EXISTS Pk_Puesto_Id
go
ALTER TABLE PUESTO
ADD PRIMARY KEY (Pk_Puesto_Id)
go

ALTER TABLE REGION
DROP CONSTRAINT IF EXISTS Pk_Region_Id
go
ALTER TABLE REGION
ADD PRIMARY KEY (Pk_Region_Id)
go

ALTER TABLE PAIS
DROP CONSTRAINT IF EXISTS Pk_Pais_Id
go
ALTER TABLE PAIS
ADD PRIMARY KEY (Pk_Pais_Id)
go

ALTER TABLE SUCURSAL
DROP CONSTRAINT IF EXISTS Pk_Sucursal_Id
go
ALTER TABLE SUCURSAL
ADD PRIMARY KEY (Pk_Sucursal_Id)
go

ALTER TABLE DEPARTAMENTO
DROP CONSTRAINT IF EXISTS Pk_Departamento_Id
go
ALTER TABLE DEPARTAMENTO
ADD PRIMARY KEY (Pk_Departamento_Id)
go

ALTER TABLE USUARIO
DROP CONSTRAINT IF EXISTS Pk_Nombre
go
ALTER TABLE USUARIO
ADD PRIMARY KEY (Pk_Nombre)
go

ALTER TABLE EMPLEADO
DROP CONSTRAINT IF EXISTS Pk_Empleado_Id
go
ALTER TABLE EMPLEADO
ADD PRIMARY KEY (Pk_Empleado_Id)
go

ALTER TABLE EMPLEADO_CONTRATOS
DROP CONSTRAINT if exists Pk_Contrato_Id
go
ALTER TABLE EMPLEADO_CONTRATOS
ADD PRIMARY KEY (Pk_Contrato_Id)
go

ALTER TABLE EMPLEADO_CONTRATO_HISTORIAL
DROP CONSTRAINT if exists Pk_EmpleadoId_ContratoId
go
ALTER TABLE EMPLEADO_CONTRATO_HISTORIAL
ADD CONSTRAINT Pk_EmpleadoId_ContratoId PRIMARY KEY (Pk_Empleado_Id, Pk_Contrato_Id)
go

ALTER TABLE SUPERVISOR
DROP CONSTRAINT IF EXISTS PK_supervisorId
GO
ALTER TABLE SUPERVISOR
ADD PRIMARY KEY (PK_supervisorId)
GO


/*---FOREIGN KEYS---*/

--NOMENCLATURA : Fk_TablaOrigen_TablaDestino_NombreCampo

ALTER TABLE PAIS
DROP CONSTRAINT IF EXISTS Fk_Region_Pais_RegionId
go
ALTER TABLE PAIS
ADD CONSTRAINT Fk_Region_Pais_RegionId FOREIGN KEY(Fk_Region_Pais_RegionId)
REFERENCES REGION(Pk_Region_Id)
go

ALTER TABLE SUCURSAL
DROP CONSTRAINT IF EXISTS Fk_Pais_Sucursal_PaisId
go
ALTER TABLE SUCURSAL
ADD CONSTRAINT Fk_Pais_Sucursal_PaisId FOREIGN KEY(Fk_Pais_Sucursal_PaisId)
REFERENCES PAIS(Pk_Pais_Id)
go

ALTER TABLE DEPARTAMENTO
DROP CONSTRAINT IF EXISTS Fk_Sucursal_Departamento_SucursalId
go
ALTER TABLE DEPARTAMENTO
ADD CONSTRAINT Fk_Sucursal_Deparatamento_SucursalId FOREIGN KEY(Fk_Sucursal_Departamento_SucursalId)
REFERENCES SUCURSAL(Pk_Sucursal_Id)
go

ALTER TABLE USUARIO
DROP CONSTRAINT IF EXISTS Fk_Empleado_Usuario_EmpleadoId
go
ALTER TABLE USUARIO
ADD CONSTRAINT Fk_Empleado_Usuario_EmpleadoId FOREIGN KEY(Fk_Empleado_Usuario_EmpleadoId)
REFERENCES EMPLEADO(Pk_Empleado_Id)
ON DELETE CASCADE	------->  RESTRICCION ELIMINACION EN CASCADA
go

ALTER TABLE EMPLEADO_CONTRATOS
DROP CONSTRAINT if  exists Fk_Empleado_EmpleadoContratos_EmpleadoId
go
ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Empleado_EmpleadoContratos_EmpleadoId FOREIGN KEY(Fk_Empleado_EmpleadoContratos_EmpleadoId)
REFERENCES EMPLEADO(Pk_Empleado_Id)
go

ALTER TABLE EMPLEADO_CONTRATOS
DROP CONSTRAINT IF EXISTS Fk_Puesto_EmpleadoContratos_PuestoId
Go

ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Puesto_EmpleadoContratos_PuestoId FOREIGN KEY(Fk_Puesto_EmpleadoContratos_PuestoId)
REFERENCES PUESTO(Pk_Puesto_Id)
Go

ALTER TABLE EMPLEADO_CONTRATOS
DROP CONSTRAINT if  exists Fk_Departamento_EmpleadoContratos_DepartamentoId
go
ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Departamento_EmpleadoContratos_DepartamentoId FOREIGN KEY(Fk_Departamento_EmpleadoContratos_DepartamentoId)
REFERENCES DEPARTAMENTO(Pk_Departamento_Id)
go

ALTER TABLE SUPERVISOR
DROP CONSTRAINT if  exists FK_Empleado_Supervisor_EmpleadoId
GO
ALTER TABLE SUPERVISOR
ADD CONSTRAINT FK_Empleado_Supervisor_EmpleadoId FOREIGN KEY(FK_Empleado_Supervisor_EmpleadoId)
REFERENCES EMPLEADO(Pk_Empleado_Id)
GO

ALTER TABLE SUPERVISOR
DROP CONSTRAINT IF EXISTS FK_Departamento_Supervisor_DepartarmentoId
GO
ALTER TABLE SUPERVISOR
ADD CONSTRAINT FK_Departamento_Supervisor_DepartarmentoId FOREIGN KEY(FK_Departamento_Supervisor_DepartarmentoId)
REFERENCES DEPARTAMENTO(Pk_Departamento_ID)
GO

/*---UNIQUE KEY---*/

--NOMENCLATURA : Uk_NombreTabla_NombreCampo

ALTER TABLE PAIS
drop constraint IF EXISTS Uk_Pais_NombreP
GO
ALTER TABLE PAIS
add constraint Uk_Pais_NombreP Unique (Uk_Pais_Nombre)
GO

ALTER TABLE DEPARTAMENTO
drop constraint IF EXISTS Uk_Departamento_Nombre
GO
ALTER TABLE DEPARTAMENTO
add constraint Uk_Departamento_Nombre Unique (Uk_Departamento_Nombre)
GO

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Uk_Empleado_Nro_Doc_Identidad
GO
ALTER TABLE EMPLEADO
add constraint Uk_Empleado_Nro_Doc_Identidad Unique (Uk_Empleado_Nro_Doc_Identidad)
GO

ALTER TABLE REGION
DROP CONSTRAINT IF EXISTS Uk_Region_Nombre
Go
ALTER TABLE REGION 
ADD CONSTRAINT Uk_Region_Nombre UNIQUE(Uk_Region_Nombre)
GO
/*---ALTER CHECK---*/

--NOMENCLATURA : Ck_NombreCampo

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Ck_Nro_Doc_Identidad
GO

ALTER TABLE EMPLEADO
add constraint Ck_Nro_Doc_Identidad CHECK (Uk_Empleado_Nro_Doc_Identidad not like  '%[^0-9]%')
GO

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Ck_Email
GO

ALTER TABLE EMPLEADO
add constraint Ck_Email CHECK (Email like '%[^@]@%[^.].[a-z][a-z][a-z]')
GO

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Ck_Telefono
GO

ALTER TABLE EMPLEADO
add constraint Ck_Telefono CHECK (telefono like '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%')
GO

/*Creacion de CRUD tabla USUARIO*/

----------INSERT------------------
DROP PROCEDURE if exists sp_insert_Usuario
go
CREATE PROCEDURE sp_insert_Usuario
@Nombre nvarchar(50),
@Password nvarchar(12),
@Estado char(1),
@EmpleadoId int 
as	
	DECLARE @Mensaje nvarchar(200);
	DEClARE @frase nvarchar(20);
	IF(@Nombre is null or LEN(@Nombre)=0 or LEN(@Nombre) >50 )
	BEGIN
		SET @Mensaje = 'Error en la variable @Nombre, valor fuera de rango o nulo'
		Print @Mensaje
		return 
	END
	IF(@Password is Null or LEN(@Password)= 0 or LEN(@Password)> 12)
	BEGIN
		SET @Mensaje = 'Error en la variable @Password, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Estado is null or LEN(@Estado)=0 or LEN(@Estado)>1)
	BEGIN
		SET @Mensaje = 'Error en la variable @Estado, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@EmpleadoId is null or LEN(@EmpleadoId)= 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END 
	SET @Mensaje = 'Datos Insertados Correctamente'
	Set @frase = 'TOPSECRET'
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO USUARIO VALUES (@Nombre,ENCRYPTBYPASSPHRASE(@frase,@Password),@Estado,@EmpleadoId)
			COMMIT TRAN
			Print @Mensaje
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n : '
			Print @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
Go

 ----------SELECT WHERE----------------
 
DROP PROC IF EXISTS sp_Select_Usuario
go
CREATE PROCEDURE sp_Select_Usuario
@EmpleadoID int
as
	DECLARE @Mensaje nvarchar(200);
	IF(@EmpleadoID is null or LEN(@EmpleadoID) =0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Nombre, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT * FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoID 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
go

-------------UPDATE-------------------
DROP PROC IF EXISTS sp_Update_Usuario
go
CREATE PROC sp_Update_Usuario
@Nombre nvarchar,
@Password nvarchar(12),
@Estado char(1),
@EmpleadoId int
as
	DECLARE @Mensaje nvarchar(200);
	DEClARE @frase nvarchar(20);
	IF(@Nombre is null or LEN(@Nombre)=0 or LEN(@Nombre) >50 )
	BEGIN
		SET @Mensaje = 'Error en la variable @Nombre, valor fuera de rango o nulo'
		Print @Mensaje
		return 
	END
	IF(@Password is Null or LEN(@Password)= 0 or LEN(@Password)> 12)
	BEGIN
		SET @Mensaje = 'Error en la variable @Password, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Estado is null or LEN(@Estado)=0 or LEN(@Estado)>1)
	BEGIN
		SET @Mensaje = 'Error en la variable @Estado, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@EmpleadoId is null or LEN(@EmpleadoId)= 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END 
	SET @Mensaje = 'Datos Actualizados Correctamente'
	Set @frase = 'TOPSECRET'
	BEGIN TRAN
		BEGIN TRY
			UPDATE USUARIO 
			SET Pk_Nombre = @Nombre, Pass = ENCRYPTBYPASSPHRASE(@frase,@Password),Estado=@Estado 
			WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoId
			PRINT(@Mensaje)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO

-------------DELETE--------------------
DROP PROC IF EXISTS sp_Delete_Usuario
go
CREATE PROC sp_Delete_Usuario
@EmpleadoId int 
as
	DECLARE @Mensaje nvarchar(200);
	IF(@EmpleadoId is null or LEN(@EmpleadoId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, valor fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	SET @Mensaje = 'Datos eliminados correctamente'
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
go

-------------------FUNCTION SHOWPASS------------------------------
DROP FUNCTION IF EXISTS dbo.ShowPass
GO
CREATE FUNCTION ShowPass (@Pass varbinary(8000),@Frase nvarchar(20))
RETURNS nvarchar(20)
AS BEGIN
	DECLARE @Password nvarchar(20);
	SET @Password = CONVERT(nvarchar(20),DECRYPTBYPASSPHRASE(@Frase,@Pass))
	RETURN @Password
END
GO


--======================================
----------- INSERT PROCEDURE
--======================================

--=========PUESTO========
drop procedure if exists sp_InsertarPuesto
go
create proc sp_InsertarPuesto
	@nom nvarchar(40), @smax decimal(6,2), @smin decimal(6,2)
as
begin
	DECLARE @resultado nvarchar(100);
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		print @resultado
		return
	end
	if @smax is null or len(@smax)=0 or len(@smax)=0
		begin
		set @resultado = 'El monto es invalido'
		print @resultado
		return 
	end
	if @smin is null or len(@smin)=0 or len(@smin)=0
		begin
		set @resultado = 'El monto es invalido'
		print @resultado
		return 
	end
	BEGIN TRAN
		BEGIN TRY
			insert PUESTO(Nombre, Salario_Maximo, Salario_Minimo)
			values(@nom, @smax, @smin)
			set @resultado='Registro Insertado'
			print @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
go

--=========DEPARTAMENTO========
drop proc if exists sp_insertardepartamento
go
create proc sp_insertardepartamento
	@nom nvarchar(50), 
	@S_D_SuId int
as
begin
	DECLARE @resultado nvarchar(80);
	if @nom is null or len(@nom)=0
		begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	
	if exists (select Uk_Departamento_Nombre from DEPARTAMENTO where Uk_Departamento_Nombre = ltrim(rtrim(@nom)))
		begin 
			set @resultado=('Error -998: El registro ya existe.')
			PRINT @resultado
			return
		end
	if @S_D_SuId is null or @S_D_SuId=0/*(@S_D_Suid)< 10 or len(@S_D_Suid)>10*/
		begin
		set @resultado ='�Id Sucursal invalido! Id 10 digitos'
		PRINT @resultado
		return
	end
	BEGIN TRAN
		BEGIN TRY
			insert into DEPARTAMENTO (Uk_Departamento_Nombre, Fk_Sucursal_Departamento_SucursalId)
			values (@nom, @S_D_SuId)
			set @resultado = 'Registro Insertado'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end

go


--=========REGION========
drop procedure if exists sp_InsertarRegion
go
create proc sp_InsertarRegion
	@nom nvarchar(40)
as
begin
	DECLARE @resultado nvarchar(50)
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	BEGIN TRAN
		BEGIN TRY
			insert REGION(Uk_Region_Nombre)
			values(@nom)
			set @resultado='Registro Insertado'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
go

--=========PAIS========
drop procedure if exists sp_InsertarPais
go
create proc sp_InsertarPais
	@nom nvarchar(40), @reg int
as
begin
	DECLARE @resultado nvarchar(100)
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	if @reg is null or LEN(@reg)=0
	begin
		set @resultado='El codigo de region ingresado no es valido'
		PRINT @resultado
		return
	end
	BEGIN TRAN
		BEGIN TRY
			insert PAIS(Uk_Pais_Nombre,Fk_Region_Pais_RegionId)
			values(@nom,@reg)
			set @resultado='Registro Insertado'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
go


--======================================
--======== SELECT PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_SeleccionaPuesto
go
CREATE PROCEDURE sp_SeleccionaPuesto
@id INT
AS 
DEClARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY
			SELECT * FROM PUESTO WHERE Pk_Puesto_Id = @id
			SET @resultado='Seleccion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO

--=======DEPARTAMENTO=========

DROP PROCEDURE if exists sp_SeleccionaDepartamento
go
CREATE PROCEDURE sp_SeleccionaDepartamento
@id int
AS
DECLARE @resultado nvarchar(100)

	BEGIN TRAN
		BEGIN TRY
			SELECT Pk_Departamento_ID, Uk_Departamento_Nombre 'Nombre', tb2.Distrito 'Sucursal'
			FROM DEPARTAMENTO AS tb1 
			JOIN SUCURSAL AS tb2 
			ON(tb1.Fk_Sucursal_Departamento_SucursalId = tb2.Pk_Sucursal_Id) 
			WHERE Pk_Departamento_ID = @id
			SET @resultado='Seleccion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO



--=========REGION========

DROP PROCEDURE if exists sp_SeleccionaRegion
GO
CREATE PROCEDURE sp_SeleccionaRegion
@id INT
AS 
DECLARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY
			SELECT * FROM REGION WHERE Pk_Region_Id = @id
			SET @resultado='Seleccion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO

----------PAIS-----------------
DROP PROC IF EXISTS sp_Select_Pais
GO
CREATE PROC sp_Select_Pais
@PaisId int
AS
	DECLARE @Mensaje nvarchar(100)
	IF(@PaisId is null or LEN(@PaisId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @PaisId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT Pk_Pais_Id,Uk_Pais_Nombre 'Nombre', Uk_Region_Nombre 'Regi�n' FROM 
			PAIS AS tb1 
			JOIN REGION AS tb2 
			ON(tb1.Fk_Region_Pais_RegionId=tb2.Pk_Region_Id)
			WHERE Pk_Pais_Id = @PaisId
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO
--======================================
--======== UPDATE PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_UpdatePuesto
go
CREATE PROCEDURE sp_UpdatePuesto  
@id INT, 
@nom nvarchar(40), @smax decimal(6,2), @smin decimal(6,2)
AS
	DECLARE @resultado nvarchar(100)
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	if @smax is null or len(@smax)=0 or len(@smax)=0
		begin
		set @resultado = 'El monto es invalido'
		PRINT @resultado
		return 
	end
	if @smin is null or len(@smin)=0 or len(@smin)=0
		begin
		set @resultado = 'El monto es invalido'
		PRINT @resultado
		return 
	end
	BEGIN TRAN
		BEGIN TRY
			UPDATE PUESTO SET  
			[Nombre] = @nom,  
			[Salario_Maximo] = @smax,
			[Salario_Minimo] = @smin
			WHERE Pk_Puesto_Id= @id
			SET @resultado='Actualizacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
GO

--=======DEPARTAMENTO========

DROP PROCEDURE IF exists sp_UpdateDepartamento
go
CREATE PROCEDURE sp_UpdateDepartamento
@id int, 
@nom nvarchar(50), 
@S_D_SUID int
AS
DECLARE @resultado nvarchar(100)
BEGIN
if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	BEGIN TRAN
		BEGIN TRY
			UPDATE DEPARTAMENTO SET  
		   [Uk_Departamento_Nombre] = @nom,
		   [Fk_Sucursal_Departamento_SucursalId] = @S_D_SUID
		   WHERE Pk_Departamento_ID= @id
		   SET @resultado='Actualizacion Exitosa'
		   PRINT @resultado
		   COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
GO

--=========REGION========
DROP PROCEDURE if exists sp_UpdateRegion
go
CREATE PROCEDURE sp_UpdateRegion  
@id INT, 
@nom VARCHAR(40)
AS
DECLARE @resultado nvarchar(100)
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
BEGIN TRAN
		BEGIN TRY
			UPDATE REGION SET  
			   [Uk_Region_Nombre] = @nom
			   WHERE Pk_Region_Id= @id
			   SET @resultado='Actualizacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
GO
--=========PAIS========
DROP PROCEDURE if exists sp_UpdatePais
go
CREATE PROCEDURE sp_UpdatePais  
@id INT, 
@nom VARCHAR(40), @reg int
AS
DECLARE @resultado nvarchar(100)
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		PRINT @resultado
		return
	end
	if @reg is null or LEN(@reg)=0
	begin
		set @resultado='El codigo de region ingresado no es valido'
		PRINT @resultado
		return
	end
	BEGIN TRAN
		BEGIN TRY
			UPDATE PAIS SET  
			[Uk_Pais_Nombre] = @nom,
			[Fk_Region_Pais_RegionId]= @reg
			WHERE Pk_Pais_Id= @id
			SET @resultado='Actualizacion Exitosa'
			PRINT @resultado
			COMMIT TRAN		
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
end
GO

--======================================
--------- DELETE PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_DeletePuesto
go
CREATE PROCEDURE sp_DeletePuesto
@id INT
AS 
DECLARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY
			DELETE FROM PUESTO WHERE Pk_Puesto_Id = @id
			SET @resultado='Eliminacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO

--=====DEPARTAMENTO========

DROP PROCEDURE IF EXISTS sp_deleteDepartamento
go
 CREATE PROCEDURE sp_deleteDepartamento
@id INT
AS 
DECLARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY
			DELETE FROM DEPARTAMENTO WHERE Pk_Departamento_ID = @id
			SET @resultado='Eliminacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO

--=========REGION========
DROP PROCEDURE if exists sp_DeleteRegion
go
CREATE PROCEDURE sp_DeleteRegion
@id INT
AS 
DECLARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY
			DELETE FROM REGION WHERE Pk_Region_Id = @id
			SET @resultado='Eliminacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO
--=========PAIS========
DROP PROCEDURE if exists sp_DeletePais
go
CREATE PROCEDURE sp_DeletePais
@id INT
AS 
DECLARE @resultado nvarchar(100)
BEGIN TRAN
		BEGIN TRY			
			DELETE FROM PAIS WHERE Pk_Pais_Id = @id
			SET @resultado='Eliminacion Exitosa'
			PRINT @resultado
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @resultado = 'Error en la transacci�n: '
			PRINT @resultado
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH

GO
-----------VIEW PAIS-------------

CREATE VIEW vp_Select_Pais

AS

	SELECT Pk_Pais_Id,Uk_Pais_Nombre 'Nombre', Uk_Region_Nombre 'Regi�n' FROM 
	PAIS AS tb1 
	JOIN REGION AS tb2 
	ON(tb1.Fk_Region_Pais_RegionId=tb2.Pk_Region_Id)
GO

----------VIEW DEPARTAMENTO---------------

CREATE VIEW vp_Select_Departamento
AS
	SELECT Pk_Departamento_ID, Uk_Departamento_Nombre 'Nombre', tb2.Distrito 'Sucursal'
	FROM DEPARTAMENTO AS tb1 
	JOIN SUCURSAL AS tb2 
	ON(tb1.Fk_Sucursal_Departamento_SucursalId = tb2.Pk_Sucursal_Id)	
GO
--=========================================================
--				  CRUD EMPLEADO_CONTRATOS
--=========================================================

------------------INSERT EMPLEADO_CONTRATOS----------------
DROP PROC IF EXISTS sp_Insert_EmpleadoContratos
GO
CREATE PROC sp_Insert_EmpleadoContratos
@EmpleadoId int,
@FechaI date,
@FechaF date,
@Sueldo_Basico decimal(8,2),
@Comision_vta decimal(8,2),
@PuestoId int,
@Departamento int
AS
	DECLARE @Mensaje nvarchar(100)

	IF(@EmpleadoId is null or LEN(@EmpleadoId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END

	IF(@FechaI is null or LEN(@FechaI) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @FechaI, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@FechaF is null or LEN(@FechaF) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @FechaF, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Sueldo_Basico is null or LEN(@Sueldo_Basico) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Sueldo_Basico, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Comision_vta is null or LEN(@Comision_vta) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Comision_vta, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@PuestoId is null or LEN(@PuestoId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @PuestoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Departamento is null or LEN(@Departamento) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Departamento, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			INSERT INTO EMPLEADO_CONTRATOS VALUES (@EmpleadoId,@FechaI,@FechaF,@Sueldo_Basico,@Comision_vta,@PuestoId,@Departamento)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO 
---------------SELECTE WHERE EMPLEADO_CONTRATOS------------
DROP PROC IF EXISTS sp_SelectWhere_EmpleadoContratos
GO
CREATE PROC sp_SelectWhere_EmpleadoContratos
@ContratoId int 
AS
	DECLARE @Mensaje nvarchar(100)
	IF(@ContratoId is null or LEN(@ContratoId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @ContratoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SET @Mensaje = 'Datos Insertados Correctamente'
			SELECT * FROM EMPLEADO_CONTRATOS WHERE Pk_Contrato_Id = @ContratoId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO
-------------------UPDATE EMPLEADO_CONTRATOS---------------
DROP PROC IF EXISTS sp_Update_EmpleadoContratos
GO
CREATE PROC sp_Update_EmpleadoContratos
@ContratoId int,
@EmpleadoId int,
@FechaI date,
@FechaF date,
@Sueldo_Basico decimal(8,2),
@Comision_vta decimal(8,2),
@PuestoId int,
@Departamento int
AS
	DECLARE @Mensaje nvarchar(100)
	IF(@ContratoId is null or LEN(@ContratoId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @ContratoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@EmpleadoId is null or LEN(@EmpleadoId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END

	IF(@FechaI is null or LEN(@FechaI) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @FechaI, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@FechaF is null or LEN(@FechaF) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @FechaF, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Sueldo_Basico is null or LEN(@Sueldo_Basico) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Sueldo_Basico, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Comision_vta is null or LEN(@Comision_vta) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Comision_vta, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@PuestoId is null or LEN(@PuestoId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @PuestoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Departamento is null or LEN(@Departamento) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Departamento, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END

	SET @Mensaje = 'Datos Actualizados Correctamente'
	
	BEGIN TRAN
		BEGIN TRY
			UPDATE EMPLEADO_CONTRATOS SET Fk_Empleado_EmpleadoContratos_EmpleadoId= @EmpleadoId,Fecha_Inicio= @FechaI,Fecha_Termino=@FechaF,Sueldo_Basico = @Sueldo_Basico, Comision_vta=@Comision_vta,Fk_Puesto_EmpleadoContratos_PuestoId = @PuestoId , Fk_Departamento_EmpleadoContratos_DepartamentoId = @Departamento 
			WHERE Pk_Contrato_Id = @ContratoId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
GO
-------------------DELETE EMPLEADO_CONTRATOS--------------
DROP PROc IF EXISTS sp_Delete_EmpleadoContratos
GO
CREATE PROC sp_Delete_EmpleadoContratos
@ContratoId int 
AS
	DECLARE @Mensaje nvarchar(100)
	IF(@ContratoId is null or LEN(@ContratoId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @ContratoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	SET @Mensaje = 'Datos Insertados Correctamente'
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM EMPLEADO_CONTRATOS WHERE Pk_Contrato_Id = @ContratoId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
GO

-----------------VIEW EMPLEADO_CONTRATOS--------------
CREATE VIEW vp_Select_EmpleadoContratos
AS	
			SELECT Pk_Contrato_Id, CONCAT(tb2.Nombre,' ',tb2.Apellido) 'Nombre y Apellido',Fecha_Inicio,Fecha_Termino,Sueldo_Basico,Comision_vta,tb3.Nombre,tb4.Uk_Departamento_Nombre 'Departamento' 
			FROM EMPLEADO_CONTRATOS AS tb1 
			JOIN EMPLEADO AS tb2 
			ON(tb1.Fk_Empleado_EmpleadoContratos_EmpleadoId = tb2.Pk_Empleado_Id)
			JOIN PUESTO AS tb3
			ON(tb1.Fk_Puesto_EmpleadoContratos_PuestoId = tb3.Pk_Puesto_Id)
			JOIN DEPARTAMENTO AS tb4
			ON(tb1.Fk_Departamento_EmpleadoContratos_DepartamentoId = tb4.Pk_Departamento_ID)
GO

--==============================================
--				CRUD SUCURSAL
--==============================================

------------INSERTAR SUCURSAL--------------------

DROP PROC IF EXISTS sp_Insertar_Sucursal
GO
CREATE PROC sp_Insertar_Sucursal
@Direccion nvarchar(50),
@Distrito nvarchar(30),
@Provincia nvarchar(50),
@PaisId int
AS
	DECLARE @Mensaje nvarchar(100);
	IF(@Direccion is null or LEN(@Direccion) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Direccion, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Distrito is null or LEN(@Distrito) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Distrito, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Provincia is null or LEN(@Provincia) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Provincia, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@PaisId is null or LEN(@PaisId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @PaisId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO SUCURSAL (Direccion,Distrito,Provincia,Fk_Pais_Sucursal_PaisId)
			VALUES (@Direccion,@Distrito,@Provincia,@PaisId)
			SET @Mensaje = 'Datos Insertados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	

GO

------------SELECT WHERE SUCURSAL----------------

DROP PROC IF EXISTS sp_ListarWhere_Sucursal
GO
CREATE PROC sp_ListarWhere_Sucursal
@SucursalId int
AS
	DECLARE @Mensaje nvarchar(100);

	IF(@SucursalId is null or LEN(@SucursalId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SucursalId, fuera de rango o nulo '
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT Pk_Sucursal_Id,Direccion,Distrito,Provincia,tb2.Uk_Pais_Nombre 'Pa�s' 
			FROM SUCURSAL AS tb1 
			JOIN PAIS AS tb2 
			ON(tb1.Fk_Pais_Sucursal_PaisId = tb2.Pk_Pais_Id) 
			WHERE Pk_Sucursal_Id = @SucursalId
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
GO

------------UPDATE SUCURSAL---------------

DROP PROC IF EXISTS sp_Update_Sucursal
GO
CREATE PROC sp_Update_Sucursal
@SucursalId int,
@Direccion nvarchar(50),
@Distrito nvarchar(30),
@Provincia nvarchar(50),
@PaisId int
AS
	DECLARE @Mensaje nvarchar(100);
	IF(@SucursalId is null or LEN(@SucursalId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SucursalId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Direccion is null or LEN(@Direccion) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Direccion, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Distrito is null or LEN(@Distrito) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Distrito, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Provincia is null or LEN(@Provincia) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Provincia, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@PaisId is null or LEN(@PaisId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @PaisId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END

	BEGIN TRAN
		BEGIN TRY
			UPDATE SUCURSAL SET Direccion = @Direccion, Distrito = @Distrito, Provincia = @Provincia,Fk_Pais_Sucursal_PaisId = @PaisId
			WHERE Pk_Sucursal_Id = @SucursalId
	
			SET @Mensaje = 'Datos Actualizados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	

GO
------------DELETE SUCURSAL----------------
DROP PROC IF EXISTS sp_Delete_Sucursal
GO
CREATE PROC sp_Delete_Sucursal
@SucursalId int
AS
	DECLARE @Mensaje nvarchar(100);

	IF(@SucursalId is null or LEN(@SucursalId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SucursalId, fuera de rango o nulo '
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			DELETE SUCURSAL WHERE Pk_Sucursal_Id = @SucursalId
			SET @Mensaje = 'Datos Eliminados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
GO

------------------VIEW SUCURSAL------------------
CREATE VIEW vp_Select_Sucursal
AS
	SELECT Pk_Sucursal_Id,Direccion,Distrito,Provincia,tb2.Uk_Pais_Nombre 'Pa�s' 
	FROM SUCURSAL AS tb1 
	JOIN PAIS AS tb2 
	ON(tb1.Fk_Pais_Sucursal_PaisId = tb2.Pk_Pais_Id)
GO

--=================================================
--				  CRUD SUPERVISOR
--=================================================

----------------INSERT SUPERVISOR------------------

DROP PROC IF EXISTS sp_Insert_Supervisor
GO
CREATE PROC sp_Insert_Supervisor
@EmpleadoId int,
@Departamento int

AS
	DECLARE @Mensaje nvarchar(100);

	IF(@EmpleadoId is null or LEN(@EmpleadoId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Departamento is null or LEN(@Departamento)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Departamento, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	SET @Mensaje = 'Datos Insertados Correctamente'
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO SUPERVISOR (FK_Empleado_Supervisor_EmpleadoId,FK_Departamento_Supervisor_DepartarmentoId)
			VALUES (@EmpleadoId,@Departamento)
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	

GO

-------------SELECT WHERE SUPERVISOR---------------

DROP PROC IF EXISTS sp_SelectWhere_Supervisor
GO
CREATE PROC sp_SelectWhere_Supervisor
@SupervisorId int
AS 
	DECLARE @Mensaje nvarchar(100)

	IF(@SupervisorId is null or LEN(@SupervisorId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupervisorId'
		PRINT @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT PK_supervisorId 'Supervisor ID', CONCAT(tb2.Nombre,' ',tb2.Apellido) 'Nombre y Apellido', tb3.Uk_Departamento_Nombre 'Supervisor'
			FROM SUPERVISOR AS tb1 
			JOIN EMPLEADO AS tb2 on
			(tb1.FK_Empleado_Supervisor_EmpleadoId = tb2.Pk_Empleado_Id)
			JOIN DEPARTAMENTO AS tb3 on
			(tb1.FK_Departamento_Supervisor_DepartarmentoId = tb3.Pk_Departamento_ID) WHERE PK_supervisorId = @SupervisorId
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
GO

----------------UPDATE SUPERVISOR-----------------

DROP PROC IF EXISTS sp_Update_Supervisor
GO
CREATE PROC sp_Update_Supervisor
@SupervisorId int,
@EmpleadoId int,
@Departamento int

AS
	DECLARE @Mensaje nvarchar(100);
	IF(@SupervisorId is null or LEN(@SupervisorId)= 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupervisorId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@EmpleadoId is null or LEN(@EmpleadoId)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @EmpleadoId, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	IF(@Departamento is null or LEN(@Departamento)=0)
	BEGIN
		SET @Mensaje = 'Error en la variable @Departamento, fuera de rango o nulo'
		PRINT @Mensaje
		RETURN
	END
	SET @Mensaje = 'Datos Insertados Correctamente'
	BEGIN TRAN
		BEGIN TRY
			UPDATE SUPERVISOR SET FK_Empleado_Supervisor_EmpleadoId = @EmpleadoId , FK_Departamento_Supervisor_DepartarmentoId = @Departamento
			WHERE PK_supervisorId = @SupervisorId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
GO

---------------DELETE SUPERVISOR-----------------

DROP PROC IF EXISTS sp_Delete_Supervisor
GO
CREATE PROC sp_Delete_Supervisor
@SupervisorId int
AS
	DECLARE @Mensaje nvarchar(100)

	IF(@SupervisorId is null or LEN(@SupervisorId) = 0)
	BEGIN
		SET @Mensaje = 'Error en la variable @SupervisorId, fuera de rango o nulo'
		PRINT @Mensaje 
		RETURN
	END

	SET @Mensaje = 'Datos Eliminados Correctamente'
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM SUPERVISOR WHERE Pk_supervisorId  = @SupervisorId
			PRINT @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	

	
GO
-------------View Supervisor--------------------
CREATE VIEW vp_Select_Supervisor
AS
			SELECT PK_supervisorId 'Supervisor ID', CONCAT(tb2.Nombre,' ',tb2.Apellido) 'Nombre y Apellido', tb3.Uk_Departamento_Nombre 'Supervisor'
			FROM SUPERVISOR AS tb1 
			JOIN EMPLEADO AS tb2 on
			(tb1.FK_Empleado_Supervisor_EmpleadoId = tb2.Pk_Empleado_Id)
			JOIN DEPARTAMENTO AS tb3 on
			(tb1.FK_Departamento_Supervisor_DepartarmentoId = tb3.Pk_Departamento_ID)
GO

--===========================================
--           CRUD Tabla EMPLEADO
--==========================================

---------------INSERTAR--------------------
DROP PROCEDURE if exists sp_Insertar_Empleado
go
CREATE PROC sp_Insertar_Empleado
@Type_document nvarchar(20),
@N_document nvarchar(20),
@Nombre nvarchar(40),
@Apellido nvarchar(40),
@Email nvarchar(50),
@Nacionalidad nvarchar(40),
@telefono nvarchar(20)

AS
	DECLARE @Mensaje nvarchar(200) 
	IF(@Type_document is null or len(@Type_document)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Tipo_Doc_Indetidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@N_document is null or len(@N_document)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Uk_Nro_Doc_Identidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Nombre is null or len(@Nombre)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Nombre el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Apellido is null or len(@Apellido)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Apellido el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Email is null or len(@Email)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Email el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Nacionalidad is null or len(@Nacionalidad)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Nacionalidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@telefono is null or len(@telefono)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo telefono el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO EMPLEADO 
			(Tipo_Doc_Identidad,Uk_Empleado_Nro_Doc_Identidad,Nombre,Apellido,Email,Nacionalidad,telefono)
			VALUES
			(@type_document,@N_document,@Nombre,@Apellido,@Email,@Nacionalidad,@telefono)
			SET @Mensaje = 'Datos Insertados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
Go

--------------READ-----------------------
DROP PROCEDURE IF EXISTS sp_ListarWhere_Empleado
go
CREATE PROC sp_ListarWhere_Empleado
@EmpleadoId int 
As
	Declare @Mensaje nvarchar(200);
	IF (@EmpleadoId is null or len(@EmpleadoId)= 0)
	BEGIN
		SET @Mensaje = 'Error en el par�metro @EmpleadoId el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			SELECT * FROM EMPLEADO WHERE Pk_Empleado_Id = @EmpleadoId
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
Go

-------------UPDATE-----------------------
DROP PROCEDURE IF EXISTS sp_Update_Empleado
go

CREATE PROC sp_Update_Empleado
@EmpleadoId int,
@Type_document nvarchar(20),
@N_document nvarchar(20),
@Nombre nvarchar(40),
@Apellido nvarchar(40),
@Email nvarchar(50),
@Nacionalidad nvarchar(40),
@telefono nvarchar(20)
--@SupervisorId 

AS
	DECLARE @Mensaje nvarchar(200) 
	IF (@EmpleadoId is null or len(@EmpleadoId)= 0)
	BEGIN
		SET @Mensaje = 'Error en el par�metro @EmpleadoId el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Type_document is null or len(@Type_document)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Tipo_Doc_Indetidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@N_document is null or len(@N_document)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Uk_Nro_Doc_Identidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Nombre is null or len(@Nombre)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Nombre el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Apellido is null or len(@Apellido)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Apellido el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Email is null or len(@Email)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Email el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@Nacionalidad is null or len(@Nacionalidad)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo Nacionalidad el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	IF(@telefono is null or len(@telefono)=0)
	BEGIN
		SET @Mensaje = 'Error en el campo telefono el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END
	BEGIN TRAN
		BEGIN TRY
			UPDATE EMPLEADO 
			SET Tipo_Doc_Identidad = @Type_document, Uk_Empleado_Nro_Doc_Identidad = @N_document,Nombre = @Nombre,Apellido = @Apellido,Email = @Email,Nacionalidad = @Nacionalidad, telefono = @telefono /* Fk_Empleado_Empleado_SupervisorId=@SupervisorId*/
			WHERE Pk_Empleado_Id = @EmpleadoId
			SET @Mensaje = 'Datos Actualizados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
Go

--------------DELETE-----------------
DROP PROCEDURE IF EXISTS sp_Delete_Empleado
go

CREATE PROC sp_Delete_Empleado
@EmpleadoId int
AS	
	DECLARE @Mensaje nvarchar(200)
	IF(@EmpleadoId is null or len(@EmpleadoId) = 0 )
	BEGIN
		SET @Mensaje = 'Error en el par�metro @EmpleadoId el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END

	BEGIN TRAN
		BEGIN TRY
			DELETE FROM EMPLEADO WHERE Pk_Empleado_Id = @EmpleadoId
			SET @Mensaje = 'Datos Eliminados Correctamente'
			Print @Mensaje
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
Go



/*---TRIGGER DE INSERCION EMPLEADO_HISTORIAL AL ELIMINAR (MATOS)---*/

DROP TRIGGER IF EXISTS INSERTAR_EMPLEADO_HISTORIAL
go
CREATE TRIGGER INSERTAR_EMPLEADO_HISTORIAL
ON EMPLEADO
FOR DELETE
as
	DECLARE @Mensaje nvarchar(200)
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO EMPLEADO_HISTORIAL(Empleado_Id, Tipo_Doc_Identidad, Nro_Doc_Identidad, Nombre, Apellido, Email, Nacionalidad, telefono)
			SELECT 
			Pk_Empleado_Id, Tipo_Doc_Identidad, Uk_Empleado_Nro_Doc_Identidad, Nombre, Apellido, Email, Nacionalidad, telefono
			FROM DELETED
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
Go

/*---TRIGGER DE ACTUALIZACION EMPLEADO_HISTORIAL---*/

DROP TRIGGER IF EXISTS UPDATE_EMPLEADO_HISTORIAL
go
CREATE TRIGGER UPDATE_EMPLEADO_HISTORIAL
ON EMPLEADO
FOR UPDATE
AS
	DECLARE @Mensaje nvarchar(200)
	BEGIN TRAN
		BEGIN TRY
			UPDATE EMPLEADO_HISTORIAL 
			SET 
			Tipo_Doc_Identidad = EMPLEADO.Tipo_Doc_Identidad,
			Nro_Doc_Identidad=EMPLEADO.Uk_Empleado_Nro_Doc_Identidad,
			Nombre=EMPLEADO.Nombre,
			Apellido=EMPLEADO.Apellido,
			Email=EMPLEADO.Email,
			Nacionalidad=EMPLEADO.Nacionalidad,
			telefono=EMPLEADO.telefono
			FROM EMPLEADO_HISTORIAL 
			INNER JOIN EMPLEADO on EMPLEADO_HISTORIAL.Empleado_Id = EMPLEADO.Pk_Empleado_Id; 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
GO

/*TRIGGER DE INSERCION HISTORIAL_EMPLEADO_CONTRATOS*/

DROP TRIGGER IF EXISTS INSERT_HISTORIAL_EMPLEADO_CONTRATOS_V2
go
CREATE TRIGGER INSERT_HISTORIAL_EMPLEADO_CONTRATOS_V2
ON EMPLEADO_CONTRATOS
FOR INSERT
as
	DECLARE @ContratoID int
	DECLARE @EmpleadoID int
	DECLARE @fechaI date
	DECLARE @fechaF date
	DECLARE @SueldoB decimal(8,2)
	DECLARE @Comisionvta decimal(8,2)
	DECLARE @PuestoID int
	DECLARE @DepartamentoID int
	DECLARE @A�os int
	DECLARE @Meses int
	DECLARE @Dias int
	DECLARE @Mensaje nvarchar(200)

	SET @ContratoID  = (SELECT Pk_Contrato_Id FROM Inserted)
	SET @EmpleadoID = (SELECT Fk_Empleado_EmpleadoContratos_EmpleadoId FROM Inserted)
	SET @fechaI = (SELECT Fecha_Inicio FROM Inserted)
	SET @fechaF = (SELECT Fecha_Termino FROM Inserted)
	SET @SueldoB = (SELECT Sueldo_Basico FROM Inserted)
	SET @Comisionvta = (SELECT Comision_vta FROM Inserted)
	SET @PuestoID = (SELECT Fk_Puesto_EmpleadoContratos_PuestoId FROM Inserted)
	SET @DepartamentoID = (SELECT Fk_Departamento_EmpleadoContratos_DepartamentoId FROM Inserted)
	
	SET @A�os = (SELECT DATEDIFF(YEAR,@fechaI,@fechaF))
	SET @Meses = (SELECT DATEDIFF(MONTH,@fechaI,@fechaF))
	SET @Dias = (SELECT DATEDIFF(DAY,@fechaI,@fechaF))

	BEGIN TRAN
		BEGIN TRY
			INSERT INTO EMPLEADO_CONTRATO_HISTORIAL 
			VALUES(@EmpleadoID,@ContratoID,@fechaI,@fechaF,@SueldoB,@Comisionvta,@PuestoID,@DepartamentoID,@A�os,@Meses,@Dias)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	
	
Go

/*TRIGGER DE UPDATE HISTORIAL_EMPLEADO_CONTRATOS*/
DROP TRIGGER IF EXISTS UPDATE_EMPLEADO_CONTRATO_HISTORIAL_V1
GO
CREATE TRIGGER UPDATE_EMPLEADO_CONTRATO_HISTORIAL_V1
ON EMPLEADO_CONTRATOS
FOR UPDATE
AS
	DECLARE 
	@IdContrato int,
	@IdEmpleado int,
	@FechaI date,
	@FechaF date,
	@SueldoB decimal(6,2),
	@ComisionVTA decimal(5,2),
	@PuestoId int,
	@DepartamentoId int,
	@A�os int,
	@Meses int,
	@Dias int,
	@Mensaje nvarchar(100)
	
	SET NOCOUNT ON;
	SELECT @IdContrato= Pk_Contrato_Id FROM deleted;
	SELECT @IdEmpleado= Fk_Empleado_EmpleadoContratos_EmpleadoId FROM deleted;
	SELECT @FechaI=Fecha_Inicio FROM inserted;
	SELECT @FechaF=Fecha_Termino FROM inserted;
	SELECT @SueldoB = Sueldo_Basico FROM inserted;
	SELECT @ComisionVTA = Comision_vta FROM inserted;
	SELECT @PuestoId = Fk_Puesto_EmpleadoContratos_PuestoId FROM inserted;
	SELECT @DepartamentoId = Fk_Departamento_EmpleadoContratos_DepartamentoId FROM inserted;
	
	SET @A�os = (SELECT DATEDIFF(YEAR,@FechaI,@FechaF))
	SET @Meses = (SELECT DATEDIFF(MONTH,@FechaI,@FechaF))
	SET @Dias = (SELECT DATEDIFF(DAY,@FechaI,@FechaF))

	BEGIN TRAN
		BEGIN TRY
			UPDATE EMPLEADO_CONTRATO_HISTORIAL 
			SET [Fecha_Inicio]=@FechaI,
			[Fecha_Termino]=@FechaF,
			[Sueldo_Basico]=@SueldoB,
			[Comision_Vta]=@ComisionVTA,
			[Puesto_Id]=@PuestoId,
			[Departamento_Id]=@DepartamentoId,
			[A�os_Servicio]=@A�os,
			[Meses_Servicio]=@Meses,
			[Dias_Servicio]=@Dias 
			Where Pk_Contrato_Id = @IdContrato
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			SET @Mensaje = 'Error en la transacci�n: '
			PRINT @Mensaje
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
GO

--================================================
--			Inserci�n de Datos(Para Prueba)
--================================================

EXEC sp_InsertarPuesto 'Contaduria',4500.50,930.90
GO

EXEC sp_InsertarRegion 'Asia'
GO

EXEC sp_InsertarPais 'Per�',1 
GO

EXEC sp_Insertar_Sucursal 'Av.La Perla  #258','Callao','Lima',1
GO

EXEC sp_insertardepartamento 'Contaduria',1
GO

EXEC sp_Insertar_Empleado 'DNI','98653214','Jose Andres','Lopez Martines','lopes@gmail.com','Peruana','986532145'
GO

EXEC sp_Insert_EmpleadoContratos 1,'2021-07-22', '2022-08-22', 1800, 930, 1, 1
GO

Exec sp_insert_Usuario 'Juancho177','admin1234','T',1
GO

EXEC sp_Insert_Supervisor 1, 1
GO

/*
	Select * from vp_Select_EmpleadoContratos
	GO
	SELECT * FROM vp_Select_Supervisor
	GO
	SELECT * FROM vp_Select_Pais
	GO
	SELECT * FROM vp_Select_Sucursal
	GO
	SELECT * FROM vp_Select_Departamento
	GO
	SELECT * FROM EMPLEADO
	GO
	SELECT * FROM PUESTO
	GO
	SELECT * FROM USUARIO
	GO
*/
