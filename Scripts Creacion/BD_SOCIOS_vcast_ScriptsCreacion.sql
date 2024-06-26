USE master;
GO
/****** CREACION DE LA BD SOCIOS ******/
CREATE DATABASE SOCIOS_vcast;
GO
ALTER DATABASE SOCIOS_vcast SET COMPATIBILITY_LEVEL = 110;
GO

USE SOCIOS_vcast;
GO
/****** CREACION DE TABLAS ******/
CREATE TABLE CUOTA(
	codigo tinyint NOT NULL,
	nombre varchar(20) NOT NULL,
	importe decimal(18, 2) NOT NULL,
 CONSTRAINT PK_CUOTA PRIMARY KEY (codigo)
);
GO

INSERT CUOTA (codigo, nombre, importe) VALUES (11, N'DE HONOR', CAST(100.00 AS Decimal(18, 2)))
INSERT CUOTA (codigo, nombre, importe) VALUES (12, N'FAMILIAR', CAST(30.00 AS Decimal(18, 2)))
INSERT CUOTA (codigo, nombre, importe) VALUES (13, N'HABITUAL', CAST(50.00 AS Decimal(18, 2)))
INSERT CUOTA (codigo, nombre, importe) VALUES (99, N'GRATUITA', CAST(0.00 AS Decimal(18, 2)))

GO


CREATE TABLE AULA(
	numero int NOT NULL,
	descripcion varchar(30) NOT NULL,
	superficie int NOT NULL,
	estado char(1) NOT NULL,
 CONSTRAINT PK_AULA PRIMARY KEY (numero)
);
GO

INSERT AULA (numero, descripcion, superficie, estado) VALUES (1, N'PISTA DE TENIS', 270, N'B')
INSERT AULA (numero, descripcion, superficie, estado) VALUES (2, N'COCINA', 100, N'R')
INSERT AULA (numero, descripcion, superficie, estado) VALUES (3, N'AULA TALLER', 150, N'B')
INSERT AULA (numero, descripcion, superficie, estado) VALUES (4, N'AULA SUR', 80, N'M')
INSERT AULA (numero, descripcion, superficie, estado) VALUES (5, N'AULA NORTE', 50, N'B')

GO
CREATE TABLE PROVINCIA(
	codigo varchar(2) NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT PK_PROVINCIA PRIMARY KEY (codigo)
);
GO

INSERT PROVINCIA (codigo, nombre) VALUES (N'01', N'Álava')
INSERT PROVINCIA (codigo, nombre) VALUES (N'02', N'Albacete')
INSERT PROVINCIA (codigo, nombre) VALUES (N'03', N'Alacante')
INSERT PROVINCIA (codigo, nombre) VALUES (N'04', N'Almería')
INSERT PROVINCIA (codigo, nombre) VALUES (N'05', N'Ávila')
INSERT PROVINCIA (codigo, nombre) VALUES (N'06', N'Badajoz')
INSERT PROVINCIA (codigo, nombre) VALUES (N'07', N'Illes Balears')
INSERT PROVINCIA (codigo, nombre) VALUES (N'08', N'Barcelona')
INSERT PROVINCIA (codigo, nombre) VALUES (N'09', N'Burgos')
INSERT PROVINCIA (codigo, nombre) VALUES (N'10', N'Cáceres')
INSERT PROVINCIA (codigo, nombre) VALUES (N'11', N'Cádiz')
INSERT PROVINCIA (codigo, nombre) VALUES (N'12', N'Castellón')
INSERT PROVINCIA (codigo, nombre) VALUES (N'13', N'Ciudad Real')
INSERT PROVINCIA (codigo, nombre) VALUES (N'14', N'Córdoba')
INSERT PROVINCIA (codigo, nombre) VALUES (N'15', N'A Coruña')
INSERT PROVINCIA (codigo, nombre) VALUES (N'16', N'Cuenca')
INSERT PROVINCIA (codigo, nombre) VALUES (N'17', N'Girona')
INSERT PROVINCIA (codigo, nombre) VALUES (N'18', N'Granada')
INSERT PROVINCIA (codigo, nombre) VALUES (N'19', N'Guadalajara')
INSERT PROVINCIA (codigo, nombre) VALUES (N'20', N'Guipúzcoa')
INSERT PROVINCIA (codigo, nombre) VALUES (N'21', N'Huelva')
INSERT PROVINCIA (codigo, nombre) VALUES (N'22', N'Huesca')
INSERT PROVINCIA (codigo, nombre) VALUES (N'23', N'Jaén')
INSERT PROVINCIA (codigo, nombre) VALUES (N'24', N'León')
INSERT PROVINCIA (codigo, nombre) VALUES (N'25', N'Lleida')
INSERT PROVINCIA (codigo, nombre) VALUES (N'26', N'La Rioja')
INSERT PROVINCIA (codigo, nombre) VALUES (N'27', N'Lugo')
INSERT PROVINCIA (codigo, nombre) VALUES (N'28', N'Madrid')
INSERT PROVINCIA (codigo, nombre) VALUES (N'29', N'Málaga')
INSERT PROVINCIA (codigo, nombre) VALUES (N'30', N'Murcia')
INSERT PROVINCIA (codigo, nombre) VALUES (N'31', N'Navarra')
INSERT PROVINCIA (codigo, nombre) VALUES (N'32', N'Ourense')
INSERT PROVINCIA (codigo, nombre) VALUES (N'33', N'Asturias')
INSERT PROVINCIA (codigo, nombre) VALUES (N'34', N'Palencia')
INSERT PROVINCIA (codigo, nombre) VALUES (N'35', N'Las Palmas')
INSERT PROVINCIA (codigo, nombre) VALUES (N'36', N'Pontevedra')
INSERT PROVINCIA (codigo, nombre) VALUES (N'37', N'Salamanca')
INSERT PROVINCIA (codigo, nombre) VALUES (N'38', N'Santa Cruz de Tenerife')
INSERT PROVINCIA (codigo, nombre) VALUES (N'39', N'Cantabria')
INSERT PROVINCIA (codigo, nombre) VALUES (N'40', N'Segovia')
INSERT PROVINCIA (codigo, nombre) VALUES (N'41', N'Sevilla')
INSERT PROVINCIA (codigo, nombre) VALUES (N'42', N'Soria')
INSERT PROVINCIA (codigo, nombre) VALUES (N'43', N'Tarragona')
INSERT PROVINCIA (codigo, nombre) VALUES (N'44', N'Teruel')
INSERT PROVINCIA (codigo, nombre) VALUES (N'45', N'Toledo')
INSERT PROVINCIA (codigo, nombre) VALUES (N'46', N'Valencia')
INSERT PROVINCIA (codigo, nombre) VALUES (N'47', N'Valladolid')
INSERT PROVINCIA (codigo, nombre) VALUES (N'48', N'Vizcaya')
INSERT PROVINCIA (codigo, nombre) VALUES (N'49', N'Zamora')
INSERT PROVINCIA (codigo, nombre) VALUES (N'50', N'Zaragoza')
INSERT PROVINCIA (codigo, nombre) VALUES (N'51', N'Ceuta')
INSERT PROVINCIA (codigo, nombre) VALUES (N'52', N'Melilla')
INSERT PROVINCIA (codigo, nombre) VALUES (N'99', N'No española')

GO
CREATE TABLE TIPO_SOCIO(
	codigo int NOT NULL,
	nombre varchar(30) NOT NULL,
 CONSTRAINT PK_TIPO_SOCIO PRIMARY KEY (codigo)
);
GO
SET ANSI_PADDING OFF
GO
INSERT TIPO_SOCIO (codigo, nombre) VALUES (99, N'TIPO DESCONOCIDO')

GO
CREATE TABLE SOCIO(
	numero numeric(18, 0) NOT NULL,
	nif char(9) NULL,
	nss char(12) NULL,
	nombre varchar(30) NOT NULL,
	ape1 varchar(30) NOT NULL,
	ape2 varchar(30) NULL,
	telefono1 char(9) NULL,
	telefono2 char(9) NULL,
	fecha_nac datetime NOT NULL,
	calle varchar(30) NULL,
	num_casa varchar(30) NOT NULL,
	piso varchar(5) NULL,
	localidad varchar(40) NULL,
	codpostal char(5) NULL,
	cod_provincia varchar(2) NULL,
	tipo varchar(30) NOT NULL,
	profesion varchar(30) NULL,
	abonada char(1) NOT NULL,
	cod_cuota tinyint NOT NULL,
	cod_tipo_socio int NOT NULL,
 CONSTRAINT PK_SOCIO PRIMARY KEY (numero)
);
GO

INSERT SOCIO (numero, nif, nss, nombre, ape1, ape2, telefono1, telefono2, fecha_nac, calle, num_casa, piso, localidad, codpostal, cod_provincia, tipo, profesion, abonada, cod_cuota, cod_tipo_socio) VALUES (CAST(1000 AS Numeric(18, 0)), N'11111112A', N'111111111112', N'MARIA', N'GRAÑA', N'UMIA', N'981111112', NULL, CAST(0x00006B7D00000000 AS DateTime), N'C/DEL OLVIDO', N'3', N'2ºA', N'FERROL', N'15011', N'15', N'HONORÍFICO', NULL, N'S', 11, 99)
INSERT SOCIO (numero, nif, nss, nombre, ape1, ape2, telefono1, telefono2, fecha_nac, calle, num_casa, piso, localidad, codpostal, cod_provincia, tipo, profesion, abonada, cod_cuota, cod_tipo_socio) VALUES (CAST(1001 AS Numeric(18, 0)), N'22222223B', N'222222222223', N'MANUEL', N'SIEIRO', N'CAMPOS', N'981222223', N'639222223', CAST(0x0000487000000000 AS DateTime), N'C/ SAN ROQUE', N'15', N'', N'A CORUÑA', N'15025', N'15', N'FAMILIAR', N'CARTERO', N'N', 12, 99)
INSERT SOCIO (numero, nif, nss, nombre, ape1, ape2, telefono1, telefono2, fecha_nac, calle, num_casa, piso, localidad, codpostal, cod_provincia, tipo, profesion, abonada, cod_cuota, cod_tipo_socio) VALUES (CAST(1002 AS Numeric(18, 0)), N'33333334C', N'333333333334', N'JORGE', N'DEL CARMEN', N'LÉREZ', N'         ', N'639333334', CAST(0x0000810900000000 AS DateTime), N'PLZ. DE ESPAÑA', N'25-26', N'11ºB', N'FERROL', N'15006', N'15', N'COMÚN', N'ABOGADO', N'S', 99, 99)
INSERT SOCIO (numero, nif, nss, nombre, ape1, ape2, telefono1, telefono2, fecha_nac, calle, num_casa, piso, localidad, codpostal, cod_provincia, tipo, profesion, abonada, cod_cuota, cod_tipo_socio) VALUES (CAST(1003 AS Numeric(18, 0)), N'44444445D', N'444444444445', N'CARLA', N'VIEITO', N'GIL', NULL, NULL, CAST(0x00007A0600000000 AS DateTime), N'C/ SAN ROQUE', N'30', N'BAJO', N'A CORUÑA', N'15006', N'15', N'HONORÍFICO', N'ESTUDIANTE', N'S', 11, 99)

GO
CREATE TABLE EMPLEADO(
	numero int NOT NULL,
	nif char(9) NOT NULL,
	nss char(12) NOT NULL,
	nombre varchar(30) NOT NULL,
	ape1 varchar(30) NOT NULL,
	ape2 varchar(30) NULL,
	calle varchar(30) NOT NULL,
	num_casa varchar(8) NULL,
	piso varchar(5) NULL,
	localidad varchar(40) NULL,
	codpostal char(5) NULL,
	cod_provincia varchar(2) NULL,
	tel_fijo char(9) NULL,
	tel_movil char(9) NULL,
	salario decimal(18, 2) NULL,
	cargo char(10) NOT NULL,
 CONSTRAINT PK_EMPLEADO PRIMARY KEY (numero)
);
GO

INSERT EMPLEADO (numero, nif, nss, nombre, ape1, ape2, calle, num_casa, piso, localidad, codpostal, cod_provincia, tel_fijo, tel_movil, salario, cargo) VALUES (100, N'11111111A', N'121212121212', N'MARIA', N'GARCÍA', N'PÉREZ', N'C/NUEVA', N'10', N'3º', N'SANTIAGO', N'15125', N'15', N'981111111', N'639111111', CAST(900.00 AS Decimal(18, 2)), N'PRF       ')
INSERT EMPLEADO (numero, nif, nss, nombre, ape1, ape2, calle, num_casa, piso, localidad, codpostal, cod_provincia, tel_fijo, tel_movil, salario, cargo) VALUES (200, N'22222222B', N'131313131313', N'CARLOS', N'REGO', N'PENA', N'PLZ. DE LA CONSTITUCIÓN', N'30', N'4º', N'A CORUÑA', N'15002', N'15', N'981222222', N'639222222', CAST(800.00 AS Decimal(18, 2)), N'PRF       ')
INSERT EMPLEADO (numero, nif, nss, nombre, ape1, ape2, calle, num_casa, piso, localidad, codpostal, cod_provincia, tel_fijo, tel_movil, salario, cargo) VALUES (300, N'33333333C', N'141414141414', N'JUANA', N'POSE', N'VARELA', N'AV. DE CASTILLA', N'100', N'5ºD', N'FERROL', N'15104', N'15', N'981333333', N'639333333', CAST(1500.90 AS Decimal(18, 2)), N'PRF       ')
INSERT EMPLEADO (numero, nif, nss, nombre, ape1, ape2, calle, num_casa, piso, localidad, codpostal, cod_provincia, tel_fijo, tel_movil, salario, cargo) VALUES (400, N'44444444D', N'151515151515', N'JOSÉ', N'GONZÁLEZ', N'ÍNSUA', N'C/MAYOR', N'25', N'1ºIZQ', N'SANTIAGO', N'15145', N'15', N'981444444', N'639444444', CAST(600.00 AS Decimal(18, 2)), N'ADM       ')

GO
CREATE TABLE PROFESOR(
	num_prof int NOT NULL,
	especialidad varchar(50) NOT NULL,
 CONSTRAINT PK_PROFESOR PRIMARY KEY (num_prof)
);
GO

INSERT PROFESOR (num_prof, especialidad) VALUES (100, N'DEPORTES')
INSERT PROFESOR (num_prof, especialidad) VALUES (200, N'COCINA')
INSERT PROFESOR (num_prof, especialidad) VALUES (300, N'INFORMÁTICA')

GO
CREATE TABLE ADMINISTRATIVO(
	num_adm int NOT NULL,
	horas_extras tinyint NOT NULL,
 CONSTRAINT PK_ADMINISTRATIVO PRIMARY KEY (num_adm)
);
GO
INSERT ADMINISTRATIVO (num_adm, horas_extras) VALUES (400, 50)

GO
CREATE TABLE ACTIVIDAD(
	identificador int NOT NULL,
	nombre varchar(50) NOT NULL,
	fecha_ini datetime NOT NULL,
	fecha_fin datetime NOT NULL,
	plazas tinyint NOT NULL,
	precio decimal(18, 2) NOT NULL,
	observaciones varchar(100) NULL,
	num_profesor int NOT NULL,
	num_aula int NOT NULL,
 CONSTRAINT PK_ACTIVIDAD PRIMARY KEY (identificador),
 CONSTRAINT IX_NUM_AULA UNIQUE (num_aula)
);

GO

INSERT ACTIVIDAD (identificador, nombre, fecha_ini, fecha_fin, plazas, precio, observaciones, num_profesor, num_aula) VALUES (10, N'TENIS PARA PRINCIPIANTES', CAST(0x000095F700000000 AS DateTime), CAST(0x000096E900000000 AS DateTime), 15, CAST(301.55 AS Decimal(18, 2)), N'Se exige raqueta y 1 bote de pelotas. ', 100, 1)
INSERT ACTIVIDAD (identificador, nombre, fecha_ini, fecha_fin, plazas, precio, observaciones, num_profesor, num_aula) VALUES (20, N'REPOSTERIA', CAST(0x000095FC00000000 AS DateTime), CAST(0x0000961800000000 AS DateTime), 20, CAST(50.00 AS Decimal(18, 2)), NULL, 200, 2)
INSERT ACTIVIDAD (identificador, nombre, fecha_ini, fecha_fin, plazas, precio, observaciones, num_profesor, num_aula) VALUES (30, N'AJEDREZ', CAST(0x0000961D00000000 AS DateTime), CAST(0x0000967900000000 AS DateTime), 10, CAST(80.00 AS Decimal(18, 2)), NULL, 100, 4)
INSERT ACTIVIDAD (identificador, nombre, fecha_ini, fecha_fin, plazas, precio, observaciones, num_profesor, num_aula) VALUES (40, N'INICIACIÓN A LA INFORMÁTICA', CAST(0x0000960A00000000 AS DateTime), CAST(0x0000964700000000 AS DateTime), 20, CAST(0.00 AS Decimal(18, 2)), N'', 300, 3)

GO
CREATE TABLE REALIZA(
	num_socio numeric(18, 0) NOT NULL,
	id_actividad int NOT NULL,
	pagada char(1) NOT NULL,
 CONSTRAINT PK_REALIZA PRIMARY KEY (num_socio, id_actividad)
);
GO

INSERT REALIZA (num_socio, id_actividad, pagada) VALUES (CAST(1000 AS Numeric(18, 0)), 10, N'S')
INSERT REALIZA (num_socio, id_actividad, pagada) VALUES (CAST(1001 AS Numeric(18, 0)), 10, N'N')
INSERT REALIZA (num_socio, id_actividad, pagada) VALUES (CAST(1001 AS Numeric(18, 0)), 30, N'S')
INSERT REALIZA (num_socio, id_actividad, pagada) VALUES (CAST(1002 AS Numeric(18, 0)), 40, N'N')
INSERT REALIZA (num_socio, id_actividad, pagada) VALUES (CAST(1003 AS Numeric(18, 0)), 30, N'S')
GO

CREATE TABLE CURSA(
	num_profesor int NOT NULL,
	id_actividad int NOT NULL,
 CONSTRAINT PK_CURSA PRIMARY KEY (num_profesor, id_actividad)
);
GO
INSERT CURSA (num_profesor, id_actividad) VALUES (100, 40)
INSERT CURSA (num_profesor, id_actividad) VALUES (200, 30)

/**** VALORES POR DEFECTO ****************/
ALTER TABLE SOCIO ADD  CONSTRAINT DF_SOCIO_abonada  DEFAULT ('N') FOR abonada
GO

ALTER TABLE SOCIO ADD  DEFAULT (99) FOR cod_tipo_socio
GO

ALTER TABLE ADMINISTRATIVO ADD  CONSTRAINT DF_ADMINISTRATIVO_horas_extras  DEFAULT (0) FOR horas_extras
GO

ALTER TABLE REALIZA ADD  CONSTRAINT DF_REALIZA_pagada  DEFAULT ('N') FOR pagada
GO


/**** CHECKS - VERIFICACIONES ***************/
ALTER TABLE ACTIVIDAD 
ADD  CONSTRAINT CHK_control_fechas CHECK  ((fecha_fin >= fecha_ini))
GO

/***CLAVES FORANEAS****************/
ALTER TABLE SOCIO   
ADD  CONSTRAINT FK_SOCIO_CUOTA 
    FOREIGN KEY(cod_cuota)
	REFERENCES CUOTA (codigo)
	ON UPDATE CASCADE
GO

ALTER TABLE SOCIO  
ADD  CONSTRAINT FK_SOCIO_PROVINCIA 
	FOREIGN KEY(cod_provincia)
	REFERENCES PROVINCIA (codigo)
	ON UPDATE CASCADE
GO

ALTER TABLE SOCIO  
ADD  CONSTRAINT FK_TIPO_SOCIO_SOCIO 
	FOREIGN KEY(cod_tipo_socio)
	REFERENCES TIPO_SOCIO (codigo)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

ALTER TABLE EMPLEADO  
ADD  CONSTRAINT FK_EMPLEADO_PROVINCIA 
	FOREIGN KEY(cod_provincia)
	REFERENCES PROVINCIA (codigo)
	ON UPDATE CASCADE
GO


ALTER TABLE PROFESOR  
ADD  CONSTRAINT FK_PROFESOR_EMPLEADO 
	FOREIGN KEY(num_prof)
	REFERENCES EMPLEADO (numero)
GO

ALTER TABLE ADMINISTRATIVO 
ADD  CONSTRAINT FK_ADMINISTRATIVO_EMPLEADO 
	FOREIGN KEY(num_adm)
	REFERENCES EMPLEADO (numero)
GO

ALTER TABLE ACTIVIDAD  
ADD  CONSTRAINT FK_ACTIVIDAD_AULA 
	FOREIGN KEY(num_aula)
	REFERENCES AULA (numero)
GO

ALTER TABLE ACTIVIDAD  
ADD  CONSTRAINT FK_ACTIVIDAD_PROFESOR 
	FOREIGN KEY(num_profesor)
	REFERENCES PROFESOR (num_prof)
	ON UPDATE CASCADE
GO

ALTER TABLE REALIZA 
ADD  CONSTRAINT FK_REALIZA_ACTIVIDAD 
	FOREIGN KEY(id_actividad)
	REFERENCES ACTIVIDAD (identificador)
	ON UPDATE CASCADE
GO

ALTER TABLE REALIZA  
ADD  CONSTRAINT FK_REALIZA_SOCIO 
	FOREIGN KEY(num_socio)
	REFERENCES SOCIO (numero)
	ON UPDATE CASCADE
GO

ALTER TABLE CURSA 
ADD  CONSTRAINT FK_CURSA_ACTIVIDAD 
	FOREIGN KEY(id_actividad)
	REFERENCES ACTIVIDAD (identificador)
GO

ALTER TABLE CURSA  
ADD  CONSTRAINT FK_CURSA_PROFESOR 
	FOREIGN KEY(num_profesor)
	REFERENCES PROFESOR (num_prof)
GO
