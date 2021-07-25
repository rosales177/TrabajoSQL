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

/*CREACIÓN DE TABLAS*/

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
	Fk_Empleado_Empleado_SupervisorId int -- Ahora se permiten ingresar valores nulos porque no puede supervisarse uno mismo
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

ALTER TABLE EMPLEADO
DROP CONSTRAINT IF EXISTS Fk_Empleado_Empleado_SupervisorId
go
ALTER TABLE EMPLEADO
ADD CONSTRAINT Fk_Empleado_Empleado_SupervisorId FOREIGN KEY(Fk_Empleado_Empleado_SupervisorId)
REFERENCES EMPLEADO(Pk_Empleado_Id)
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


ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Puesto_EmpleadoContratos_PuestoId FOREIGN KEY(Fk_Puesto_EmpleadoContratos_PuestoId)
REFERENCES PUESTO(Pk_Puesto_Id)

ALTER TABLE EMPLEADO_CONTRATOS
DROP CONSTRAINT if  exists Fk_Departamento_EmpleadoContratos_DepartamentoId
go
ALTER TABLE EMPLEADO_CONTRATOS
ADD CONSTRAINT Fk_Departamento_EmpleadoContratos_DepartamentoId FOREIGN KEY(Fk_Departamento_EmpleadoContratos_DepartamentoId)
REFERENCES DEPARTAMENTO(Pk_Departamento_Id)
go

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
	INSERT INTO USUARIO VALUES (@Nombre,ENCRYPTBYPASSPHRASE(@frase,@Password),@Estado,@EmpleadoId)
	Print @Mensaje
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
	SELECT * FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoID 
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
	UPDATE USUARIO 
	SET Pk_Nombre = @Nombre, Pass = ENCRYPTBYPASSPHRASE(@frase,@Password),Estado=@Estado 
	WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoId
	PRINT(@Mensaje)
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
		SET @EmpleadoId = 'Error en la variable @EmpleadoId, valor fuera de rango o nulo'
		PRINT @EmpleadoId
		RETURN
	END
	SET @EmpleadoId = 'Datos eliminados correctamente'
	DELETE FROM USUARIO WHERE Fk_Empleado_Usuario_EmpleadoId = @EmpleadoID
	PRINT @EmpleadoId
go


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
	insert PUESTO(Nombre, Salario_Maximo, Salario_Minimo)
	values(@nom, @smax, @smin)
	set @resultado='Registro Insertado'
	print @resultado
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
		set @resultado ='¡Id Sucursal invalido! Id 10 digitos'
		PRINT @resultado
		return
	end

	insert into DEPARTAMENTO (Uk_Departamento_Nombre, Fk_Sucursal_Departamento_SucursalId)
	values (@nom, @S_D_SuId)
	set @resultado = 'Registro Insertado'
	PRINT @resultado
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
	insert REGION(Uk_Region_Nombre)
	values(@nom)
	set @resultado='Registro Insertado'
	PRINT @resultado
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
	insert PAIS(Uk_Pais_Nombre,Fk_Region_Pais_RegionId)
	values(@nom,@reg)
	set @resultado='Registro Insertado'
	PRINT @resultado
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
SELECT * FROM PUESTO WHERE Pk_Puesto_Id = @id
SET @resultado='Seleccion Exitosa'
PRINT @resultado
GO

--=======DEPARTAMENTO=========

DROP PROCEDURE if exists sp_SeleccionaDepartamento
go
CREATE PROCEDURE sp_SeleccionaDepartamento
@id int
AS
DECLARE @resultado nvarchar(100)
SELECT * FROM DEPARTAMENTO WHERE Pk_Departamento_ID = @id
SET @resultado='Seleccion Exitosa'
PRINT @resultado
GO


--=========REGION========

DROP PROCEDURE if exists sp_SeleccionaRegion
GO
CREATE PROCEDURE sp_SeleccionaRegion
@id INT
AS 
DECLARE @resultado nvarchar(100)
SELECT * FROM REGION WHERE Pk_Region_Id = @id
SET @resultado='Seleccion Exitosa'
PRINT @resultado
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
	UPDATE PUESTO SET  
       [Nombre] = @nom,
       [Salario_Maximo] = @smax,
	   [Salario_Minimo] = @smin
       WHERE Pk_Puesto_Id= @id
	   SET @resultado='Actualizacion Exitosa'
	PRINT @resultado
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
	UPDATE DEPARTAMENTO SET  
       [Uk_Departamento_Nombre] = @nom,
	   [Fk_Sucursal_Departamento_SucursalId] = @S_D_SUID
       WHERE Pk_Departamento_ID= @id
	   SET @resultado='Actualizacion Exitosa'
	   PRINT @resultado
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
	UPDATE REGION SET  
       [Uk_Region_Nombre] = @nom
       WHERE Pk_Region_Id= @id
	   SET @resultado='Actualizacion Exitosa'
	PRINT @resultado
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
	UPDATE PAIS SET  
       [Uk_Pais_Nombre] = @nom,
	   [Fk_Region_Pais_RegionId]= @reg
       WHERE Pk_Pais_Id= @id
	   SET @resultado='Actualizacion Exitosa'
	PRINT @resultado
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
DELETE FROM PUESTO WHERE Pk_Puesto_Id = @id
SET @resultado='Eliminacion Exitosa'
PRINT @resultado
GO

--=====DEPARTAMENTO========

DROP PROCEDURE IF EXISTS sp_deleteDepartamento
go
 CREATE PROCEDURE sp_deleteDepartamento
@id INT
AS 
DECLARE @resultado nvarchar(100)
DELETE FROM DEPARTAMENTO WHERE Pk_Departamento_ID = @id
SET @resultado='Eliminacion Exitosa'
PRINT @resultado
GO


--=========REGION========
DROP PROCEDURE if exists sp_DeleteRegion
go
CREATE PROCEDURE sp_DeleteRegion
@id INT
AS 
DECLARE @resultado nvarchar(100)
DELETE FROM REGION WHERE Pk_Region_Id = @id
SET @resultado='Eliminacion Exitosa'
PRINT @resultado
GO
--=========PAIS========
DROP PROCEDURE if exists sp_DeletePais
go
CREATE PROCEDURE sp_DeletePais
@id INT
AS 
DECLARE @resultado nvarchar(100)
DELETE FROM PAIS WHERE Pk_Pais_Id = @id
SET @resultado='Eliminacion Exitosa'
PRINT @resultado
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

	INSERT INTO EMPLEADO 
	(Tipo_Doc_Identidad,Uk_Empleado_Nro_Doc_Identidad,Nombre,Apellido,Email,Nacionalidad,telefono)
	VALUES
	(@type_document,@N_document,@Nombre,@Apellido,@Email,@Nacionalidad,@telefono)

	SET @Mensaje = 'Datos Insertados Correctamente'

	Print @Mensaje

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
		SET @Mensaje = 'Error en el parámetro @EmpleadoId el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END

	SELECT * FROM EMPLEADO WHERE Pk_Empleado_Id = @EmpleadoId
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

AS
	DECLARE @Mensaje nvarchar(200) 
	IF (@EmpleadoId is null or len(@EmpleadoId)= 0)
	BEGIN
		SET @Mensaje = 'Error en el parámetro @EmpleadoId el dato ingresado es nulo o fuera de rango'
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

	UPDATE EMPLEADO 
	SET Tipo_Doc_Identidad = @Type_document, Uk_Empleado_Nro_Doc_Identidad = @N_document,Nombre = @Nombre,Apellido = @Apellido,Email = @Email,Nacionalidad = @Nacionalidad, telefono = @telefono
	WHERE Pk_Empleado_Id = @EmpleadoId
	SET @Mensaje = 'Datos Actualizados Correctamente'

	Print @Mensaje

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
		SET @Mensaje = 'Error en el parámetro @EmpleadoId el dato ingresado es nulo o fuera de rango'
		print @Mensaje
		RETURN
	END

	DELETE FROM EMPLEADO WHERE Pk_Empleado_Id = @EmpleadoId

	SET @Mensaje = 'Datos Eliminados Correctamente'
	Print @Mensaje
Go



/*---TRIGGER DE INSERCION EMPLEADO_HISTORIAL AL ELIMINAR (MATOS)---*/

DROP TRIGGER IF EXISTS INSERTAR_EMPLEADO_HISTORIAL
go
CREATE TRIGGER INSERTAR_EMPLEADO_HISTORIAL
ON EMPLEADO
FOR DELETE
as
	INSERT INTO EMPLEADO_HISTORIAL(Empleado_Id, Tipo_Doc_Identidad, Nro_Doc_Identidad, Nombre, Apellido, Email, Nacionalidad, telefono)
	SELECT 
	Pk_Empleado_Id, Tipo_Doc_Identidad, Uk_Empleado_Nro_Doc_Identidad, Nombre, Apellido, Email, Nacionalidad, telefono
	FROM DELETED
Go

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

('DNI','74889652','Jose Antonio','Robles Bermejo','bermejontio@gmail.com','Peruana','985642138',1)
GO

insert into EMPLEADO_CONTRATOS
values(1,'2021-07-22', '2022-08-22', 950, 500, 1, 1)
go

select * from EMPLEADO_CONTRATOS



--(Rosales)Modificaciones Realizadas(Borrar este comentario)

/*
	-Se creo el Foreign Key de Puesto a Empleados_Contratos ya que no existia

	-Se modifico la nomenclatura de los Unique Key

			de Uk_NombreCampo a Uk_Tabla_NombreCampo

	--Se Agregaron los comentarios correspondiente

	-Los Procedimientos almacenados que contenian variables de salida fueron modificadas para que el mensaje
	fuera mostrado al ejecutar el Sp

	Remplazando el output por variables locales

	Ejemplo 

	Ejecutar.....

	exec sp_insertardepartamento 'Almacen', 1


*/