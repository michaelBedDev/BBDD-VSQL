CREATE DATABASE LIGA_MiguelCM
GO
USE LIGA_MiguelCM
GO

CREATE TABLE EQUIPO(
	identificador int NOT NULL,
	nombre varchar(30) NOT NULL,
	CIF char(9) NOT NULL,
	prespuesto numeric(14,2) NOT NULL,
	cod_division int NOT NULL,
	num_campo int NOT NULL
CONSTRAINT PK_EQUIPO_identificador PRIMARY KEY (identificador),
CONSTRAINT UQ_EQUIPO_nombre UNIQUE (nombre),
CONSTRAINT UQ_EQUIPO_CIF UNIQUE (CIF),
);
CREATE TABLE DIVISION(
	codigo int NOT NULL,
	nombre varchar(70) NOT NULL,
	categoria char(4) NULL
CONSTRAINT PK_DIVISION_codigo PRIMARY KEY (codigo),
CONSTRAINT UQ_DIVISION_nombre UNIQUE (nombre),
);
--tipo entero mas pequeño posible tinyint (0-255)
CREATE TABLE CAMPO(
	numero int NOT NULL,
	nombre varchar(100) NOT NULL,
	capacidad int NOT NULL
CONSTRAINT PK_CAMPO_numero PRIMARY KEY (numero),
CONSTRAINT UQ_CAMPO_nombre UNIQUE (nombre),
);
CREATE TABLE PARTIDO(
	fechaHora datetime NOT NULL,
	observaciones varchar(150) NULL,
	equipo_local int NOT NULL,
	equipo_visitante int NOT NULL
CONSTRAINT PK_PARTIDO_fechaHora_equipo_local_visitante PRIMARY KEY (fechaHora, equipo_local, equipo_visitante)
);
--default
ALTER TABLE DIVISION
ADD CONSTRAINT DF_DIVISION_categoria DEFAULT ('1DIV') for categoria;

--verificaciones
ALTER TABLE CAMPO
ADD CONSTRAINT CHK_CAMPO_capacidad CHECK (capacidad >= 500);

--claves foraneas
ALTER TABLE  EQUIPO
ADD CONSTRAINT FK_cod_division
	FOREIGN KEY (cod_division)
	REFERENCES DIVISION (codigo)
	ON UPDATE CASCADE,
CONSTRAINT FK_num_campo
	FOREIGN KEY (num_campo)
	REFERENCES CAMPO (numero)
	ON UPDATE NO ACTION;

ALTER TABLE PARTIDO
ADD CONSTRAINT FK_equipo_local
	FOREIGN KEY (equipo_local)
	REFERENCES EQUIPO (identificador),

CONSTRAINT FK_equipo_visitante
	FOREIGN KEY (equipo_visitante)
	REFERENCES EQUIPO (identificador);

--on update
--on delete

--cascade
--no action
--set null
--default