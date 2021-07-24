USE master
go

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


USE RH_VENTAS
GO

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

DROP TABLE IF EXISTS REGION
go
CREATE TABLE REGION
(
	Pk_Region_Id int not null identity(1,1),
	Nombre nvarchar(40) not null	
)
go

DROP TABLE IF EXISTS PAIS
go

CREATE TABLE PAIS
(
	Pk_Pais_Id int not null identity(1,1),
	Uk_Nombre nvarchar(40) not null,
	Fk_Region_Pais_RegionId int not null
)                        
go

DROP TABLE IF EXISTS EMPLEADO
go

CREATE TABLE EMPLEADO
(
	Pk_Empleado_Id int not null identity(1,1),
	Tipo_Doc_Identidad nvarchar(20) not null,
	Uk_Nro_Doc_Identidad nvarchar(20) not null,
	Nombre nvarchar(40) not null,
	Apellido nvarchar(40) not null,
	Email nvarchar(50) not null,
	Nacionalidad nvarchar(40) not null,
	telefono nvarchar(20) not null,
	--Fk_Empleado_Empleado_SupervisorId int not null
)
go

DROP TABLE IF EXISTS DEPARTAMENTO
GO
CREATE TABLE DEPARTAMENTO
(
	Pk_Departamento_ID int not null identity(1,1),
	Uk_Nombre nvarchar(40) not null,
	Fk_Sucursal_Departamento_SucursalId int not null
)
GO

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

DROP TABLE IF EXISTS EMPLEADO_CONTRATO_HISTORIAL
GO
CREATE TABLE EMPLEADO_CONTRATO_HISTORIAL
(
	Pk_Empleado_Id int not null,
	Pk_Contrato_Id int not null,
	Fecha_Inicio date not null,
	Fecha_Termino date not null,
	Sueldo_Basico decimal (6,2) not null,
	Comision_Vta decimal(5,2)not null,
	Puesto_Id int not null,
	Departamento_Id int not null,
	Años_Servicio int not null,
	Meses_Servicio int not null,
	Dias_Servicio int not null
)
GO



/*---PRIMARY KEY---*/

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



/*---FOREIGN KEYS---*/

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


--=========FK_Empleado_Empleado_SupervisorId da Falla=======


/*
ALTER TABLE EMPLEADO
DROP CONSTRAINT IF EXISTS Fk_Empleado_Empleado_SupervisorId
go
ALTER TABLE EMPLEADO
ADD CONSTRAINT Fk_Empleado_Empleado_SupervisorId FOREIGN KEY(Fk_Empleado_Empleado_SupervisorId)
REFERENCES EMPLEADO(Pk_Empleado_Id)
go*/

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
DROP CONSTRAINT if  exists Fk_Departamento_EmpleadoContratos_DepartamentoId
go
ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Departamento_EmpleadoContratos_DepartamentoId FOREIGN KEY(Fk_Departamento_EmpleadoContratos_DepartamentoId)
REFERENCES DEPARTAMENTO(Pk_Departamento_Id)
go

/*---UNIQUE KEY---*/

ALTER TABLE PAIS
drop constraint IF EXISTS Uk_NombreP
GO
ALTER TABLE PAIS
add constraint Uk_NombreP Unique (Uk_Nombre)
GO

ALTER TABLE DEPARTAMENTO
drop constraint IF EXISTS Uk_Nombre
GO
ALTER TABLE DEPARTAMENTO
add constraint Uk_Nombre Unique (Uk_Nombre)
GO

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Uk_Nro_Doc_Identidad
GO
ALTER TABLE EMPLEADO
add constraint Uk_Nro_Doc_Identidad Unique (Uk_Nro_Doc_Identidad)
GO



/*---ALTER CHECK---*/

ALTER TABLE EMPLEADO
drop constraint IF EXISTS Ck_Nro_Doc_Identidad
GO

ALTER TABLE EMPLEADO
add constraint Ck_Nro_Doc_Identidad CHECK (Uk_Nro_Doc_Identidad not like  '%[^0-9]%')
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
CREATE PROCEDURE sp_insert_Usuario
@Nombre nvarchar(50),
@Passwor nvarchar(12),
@Estado char(1),
@EmpleadoId int 
as	
	Declare @frase nvarchar(20);
	Set @frase = 'EstaEsMiFrace'
	INSERT INTO USUARIO VALUES (@Nombre,ENCRYPTBYPASSPHRASE(@frase,@Passwor),@Estado,@EmpleadoId)
Go
 ----------SELECT WHERE----------------
 
DROP PROC IF EXISTS sp_Select_Usuario
go
CREATE PROCEDURE sp_Select_Usuario
@EmpleadoID int
as
	SELECT * FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = 'EmpleadoID' 
go

-------------UPDATE-------------------
DROP PROC IF EXISTS sp_Update_Usuario
go
CREATE PROC sp_Update_Usuario
@Nombre nvarchar,
@Password nvarchar(12),
@Estado char(1),
@EmpleadorID int
as
	Declare @frase nvarchar(20);
	Set @frase = 'EstaEsMiFrace'
	UPDATE USUARIO 
	SET Pk_Nombre = @Nombre, Pass = ENCRYPTBYPASSPHRASE(@frase,@Password),Estado=@Estado 
	WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadorID

GO

-------------DELETE--------------------
DROP PROC IF EXISTS sp_Delete_Usuario
go
CREATE PROC sp_Delete_Usuario
@EmpleadoID int 
as
	DELETE FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoID
go


--======================================
----------- INSERT PROCEDURE
--======================================

--=========PUESTO========
drop procedure if exists sp_InsertarPuesto
go
create proc sp_InsertarPuesto
	@nom nvarchar(40), @smax decimal(6,2), @smin decimal(6,2),
	@resultado nvarchar(50) output
as
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	if @smax is null or len(@smax)=0 or len(@smax)=0
		begin
		set @resultado = 'El monto es invalido'
		return 
	end
	if @smin is null or len(@smin)=0 or len(@smin)=0
		begin
		set @resultado = 'El monto es invalido'
		return 
	end
	insert PUESTO(Nombre, Salario_Maximo, Salario_Minimo)
	values(@nom, @smax, @smin)
	set @resultado='Registro Insertado'
end
go

--=========DEPARTAMENTO========
drop proc if exists sp_insertardepartamento
go
create proc sp_insertardepartamento
	@depa nvarchar(50), @nom nvarchar(50), 
	@S_D_SuId int, @resultado nvarchar(80)
as
begin
if @depa is null or len(@depa)< 10 or len(@depa)>10
	begin
	set @resultado ='¡Id Departamento invalido! Id 10 digitos'
	return
end
if @nom is null or len(@nom)=0
	begin
	set @resultado='El nombre ingresado no es valido'
	return
end
if @depa is null or len(@S_D_Suid)< 10 or len(@S_D_Suid)>10
	begin
	set @resultado ='¡Id Departamento invalido! Id 10 digitos'
	return
end

insert into DEPARTAMENTO (Pk_Departamento_Id, Uk_Nombre, Fk_Sucursal_Departamento_SucursalId)
values (@depa, @nom, @S_D_SuId)
set @resultado = 'Registro Insertado'
end
go


--=========REGION========
drop procedure if exists sp_InsertarRegion
go
create proc sp_InsertarRegion
	@nom nvarchar(40),
	@resultado nvarchar(50) output
as
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	insert REGION(Nombre)
	values(@nom)
	set @resultado='Registro Insertado'
end
go

--=========PAIS========
drop procedure if exists sp_InsertarPais
go
create proc sp_InsertarPais
	@nom nvarchar(40), @reg int,
	@resultado nvarchar(50) output
as
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	if @reg is null or LEN(@reg)=0
	begin
		set @resultado='El codigo de region ingresado no es valido'
		return
	end
	insert PAIS(Uk_Nombre,Fk_Region_Pais_RegionId)
	values(@nom,@reg)
	set @resultado='Registro Insertado'
end
go


--======================================
--======== SELECT PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_SeleccionaPuesto
go
CREATE PROCEDURE sp_SeleccionaPuesto
@id INT, @resultado nvarchar(50) output
AS 
SELECT * FROM PUESTO WHERE Pk_Puesto_Id = @id
SET @resultado='Seleccion Exitosa'
GO

--=======DEPARTAMENTO=========

DROP PROCEDURE if exists sp_SelecionaDepartamento
go
CREATE PROCEDURE sp_SeleccionaDepartamento
@id int, @resultado nvarchar(50) output
AS
BEGIN
SELECT * FROM DEPARTAMENTO WHERE Pk_Departamento_ID = @id
SET @resultado='Seleccion Exitosa'
END
GO


--=========REGION========

DROP PROCEDURE if exists sp_SeleccionaRegion
GO
CREATE PROCEDURE sp_SeleccionaRegion
@id INT, @resultado nvarchar(50) output
AS 
SELECT * FROM REGION WHERE Pk_Region_Id = @id
SET @resultado='Seleccion Exitosa'
GO

--======================================
--======== UPDATE PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_UpdatePuesto
go
CREATE PROCEDURE sp_UpdatePuesto  
@id INT, 
@nom nvarchar(40), @smax decimal(6,2), @smin decimal(6,2),
@resultado nvarchar(50) output
AS
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	if @smax is null or len(@smax)=0 or len(@smax)=0
		begin
		set @resultado = 'El monto es invalido'
		return 
	end
	if @smin is null or len(@smin)=0 or len(@smin)=0
		begin
		set @resultado = 'El monto es invalido'
		return 
	end
	UPDATE PUESTO SET  
       [Nombre] = @nom,
       [Salario_Maximo] = @smax,
	   [Salario_Minimo] = @smin
       WHERE Pk_Puesto_Id= @id
	   SET @resultado='Actualizacion Exitosa'
end
GO

--=======DEPARTAMENTO========

DROP PROCEDURE IF exists sp_UpdateDepartamento
go
CREATE PROCEDURE sp_UpdateDepartamento
@id int, 
@nom nvarchar(50), 
@S_D_SUID int,
@resultado nvarchar(50) output
AS
BEGIN
if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	UPDATE DEPARTAMENTO SET  
       [Uk_Nombre] = @nom,
	   [Fk_Sucursal_Departamento_SucursalId] = @S_D_SUID
       WHERE Pk_Departamento_ID= @id
	   SET @resultado='Actualizacion Exitosa'
end
GO


--=========REGION========
DROP PROCEDURE if exists sp_UpdateRegion
go
CREATE PROCEDURE sp_UpdateRegion  
@id INT, 
@nom VARCHAR(40),
@resultado nvarchar(50) output
AS
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	UPDATE REGION SET  
       [Nombre] = @nom
       WHERE Pk_Region_Id= @id
	   SET @resultado='Actualizacion Exitosa'
end
GO
--=========PAIS========
DROP PROCEDURE if exists sp_UpdatePais
go
CREATE PROCEDURE sp_UpdatePais  
@id INT, 
@nom VARCHAR(40), @reg int,
@resultado nvarchar(50) output
AS
begin
	if @nom is null or LEN(@nom)=0
	begin
		set @resultado='El nombre ingresado no es valido'
		return
	end
	if @reg is null or LEN(@reg)=0
	begin
		set @resultado='El codigo de region ingresado no es valido'
		return
	end
	UPDATE PAIS SET  
       [Uk_Nombre] = @nom,
	   [Fk_Region_Pais_RegionId]= @reg
       WHERE Pk_Pais_Id= @id
	   SET @resultado='Actualizacion Exitosa'
end
GO

--======================================
--------- DELETE PROCEDURE
--======================================

--=========PUESTO========
DROP PROCEDURE if exists sp_DeletePuesto
go
CREATE PROCEDURE sp_DeletePuesto
@id INT,
@resultado nvarchar(50) output
AS 
DELETE FROM PUESTO WHERE Pk_Puesto_Id = @id
SET @resultado='Eliminacion Exitosa'
GO

--=====DEPARTAMENTO========

DROP PROCEDURE IF EXISTS sp_deleteDepartamento
go
 CREATE PROCEDURE sp_deleteDepartamento
@id INT,
@resultado nvarchar(50) output
AS 
DELETE FROM DEPARTAMENTO WHERE Pk_Departamento_ID = @id
SET @resultado='Eliminacion Exitosa'
GO


--=========REGION========
DROP PROCEDURE if exists sp_DeleteRegion
go
CREATE PROCEDURE sp_DeleteRegion
@id INT,
@resultado nvarchar(50) output
AS 
DELETE FROM REGION WHERE Pk_Region_Id = @id
SET @resultado='Eliminacion Exitosa'
GO
--=========PAIS========
DROP PROCEDURE if exists sp_DeletePais
go
CREATE PROCEDURE sp_DeletePais
@id INT,
@resultado nvarchar(50) output
AS 
DELETE FROM PAIS WHERE Pk_Pais_Id = @id
SET @resultado='Eliminacion Exitosa'
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
	DECLARE @Años int
	DECLARE @Meses int
	DECLARE @Dias int

	SET @ContratoID  = (SELECT Pk_Contrato_Id FROM Inserted)
	SET @EmpleadoID = (SELECT Fk_Empleado_EmpleadoContratos_EmpleadoId FROM Inserted)
	SET @fechaI = (SELECT Fecha_Inicio FROM Inserted)
	SET @fechaF = (SELECT Fecha_Termino FROM Inserted)
	SET @SueldoB = (SELECT Sueldo_Basico FROM Inserted)
	SET @Comisionvta = (SELECT Comision_vta FROM Inserted)
	SET @PuestoID = (SELECT Fk_Puesto_EmpleadoContratos_PuestoId FROM Inserted)
	SET @DepartamentoID = (SELECT Fk_Departamento_EmpleadoContratos_DepartamentoId FROM Inserted)
	
	SET @Años = (SELECT DATEDIFF(YEAR,@fechaI,@fechaF))
	SET @Meses = (SELECT DATEDIFF(MONTH,@fechaI,@fechaF))
	SET @Dias = (SELECT DATEDIFF(DAY,@fechaI,@fechaF))


	INSERT INTO EMPLEADO_CONTRATO_HISTORIAL 
	VALUES(@EmpleadoID,@ContratoID,@fechaI,@fechaF,@SueldoB,@Comisionvta,@PuestoID,@DepartamentoID,@Años,@Meses,@Dias)

Go

--------------push prueba------------------------

--================================================
--			Inserción de Datos(Para Prueba)
--=================================================

INSERT 
INTO PUESTO 
VALUES
('Administrador',1500,930)
GO

INSERT
INTO REGION
VALUES
('Sur America')
GO


INSERT 
INTO PAIS
VALUES
('PERU',1)
GO

INSERT 
INTO SUCURSAL
VALUES
('Av.Tomas Marzano #2156','Lima','Lima',1)
GO

INSERT 
INTO DEPARTAMENTO
VALUES 
('Administración',1)
GO

INSERT 
INTO EMPLEADO
VALUES
('DNI','74889652','Jose Antonio','Robles Bermejo','bermejontio@gmail.com','Peruana','985642138')
GO

insert into EMPLEADO_CONTRATOS
values(1,'22-07-2021', '22-08-2022', 950, 500, 1, 1)
go

