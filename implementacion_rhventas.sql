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

/*CREACIÓN DE TABLAS*/
/*PATRON CORESPONDIENTE:
	PRIMARY KEY = Pk_Nombre del campo
	FOREIGN KEY = Fk_Tabla de origen_Nombre del campo
*/

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
	Fk_Empleado_Empleado_SupervisorId int not null
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
add constraint Ck_Nro_Doc_Identidad CHECK (Uk_Nro_Doc_Identidad not like '%[^0-9]%')
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
add constraint Ck_Telefono CHECK (Telefono not like '%[^0-9]%')
GO

/*INSERCION DE DATOS EN TABLAS*/



INSERT INTO PUESTO VALUES
('Ingeniero de Software',2800,2600),
('Gerente de Producto',1500,1400),
('Arquitecto Cloud',2000,1800.0),
('Desarrollador de Software',1500,1000),
('Cientifico de Data',2800,2400),
('Analista de Negocios',1600,980),
('Ingeniero DevOps',2500,2200),
('Soporte Tecnico',1200,920.0),
('Administrador de Red',1600,1200),
('Desarrollador de Apps Moviles',1900,1500)
go

INSERT INTO REGION VALUES
('Norteamerica'),
('Sudamerica'),
('Centroamerica'),
('Europa'),
('Asia'),
('Africa'),
('Oceania')
go

INSERT INTO PAIS VALUES
('Estado Unidos',1),
('Mexico',1),
('Peru',2),
('Argentina',2),
('Italia',4),
('España',4),
('China',5),
('India',5),
('Egipto',6),
('Australia',7)
go




/*
DATOS INSERTADOS EN LA TABLA PUESTO Y EN LA TABLA PAIS
*/



/*POSIBLE crud de Procedimientp Almacenado*/

CREATE PROCEDURE CRUD_RH_VENTAS
	/*VARIABLES O COLUMNAS DE UNA TABLA*/
	@MODO CHAR(1)
AS
	IF @MODO='I' 
	BEGIN
		INSERT INTO /*TABLA*/ VALUES(/*VARIABLES A INSERTAR*/)
	END

	IF @MODO='U'
	BEGIN
		UPDATE /*TABLA*/ SET(/*VARIABLES A ACTUALIZAR*/)
	END

	IF @MODO='D'
	BEGIN
		DELETE FROM /*TABLA*/ WHERE (/*VARIABLES A BORRAR*/)
	END

	EXECUTE CRUD_RH_VENTAS @MODO='MODO' 'VALORES A I, A, D'
