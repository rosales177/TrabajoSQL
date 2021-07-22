USE master
go

DROP DATABASE if exists RH_VENTAS
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

DROP TABLE if exists PUESTO
go
CREATE TABLE PUESTO
(
	Pk_PuestoId int not null,
	Nombre nvarchar(40) not null,
	Salario_Maximo decimal(6,2) not null,
	Salario_Minimo decimal(4,2) not null
)
go

DROP TABLE if exists REGION
go
CREATE TABLE REGION
(
	Pk_Region_Id int not null,
	Nombre nvarchar(40) not null	
)
go

DROP TABLE if exists PAIS
go

CREATE TABLE PAIS
(
	Pk_Pais_Id int not null,
	Nombre nvarchar(40) not null,
	Fk_Region_RegionId int not null
)
go

DROP TABLE if exists SUCURSAL
go

CREATE TABLE SUCURSAL 
(
	Pk_SucursalId int not null,
	Direccion nvarchar(60) not null,
	Distrito nvarchar(20) not null,
	Provincia nvarchar(40) not null,
	Fk_Pais_PaisId int not null
)
go

DROP TABLE IF EXISTS USUARIO
go

CREATE TABLE USUARIO
(
	Pk_Nombre nvarchar(50) not null,
	Pass varBinary(8000) not null,
	Estado char(1) not null,
	Fk_Empleado_EmpleadoId int not null
)
go

DROP TABLE IF EXISTS EMPLEADO
go

CREATE TABLE EMPLEADO
(
	Pk_Empleado_Id int not null,
	Tipo_Doc_Identidad nvarchar(20) not null,
	Nro_Doc_Identidad nvarchar(20) not null,
	Nombre nvarchar(40) not null,
	Apellido nvarchar(40) not null,
	Email nvarchar(50) not null,
	Nacionalidad nvarchar(40) not null,
	telefono nvarchar(20) not null,
	FSupervisor_Id int not null
)
go