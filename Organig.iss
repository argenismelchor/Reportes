/*tablas para Organigramas*/

CREATE TABLE Supervisor_giro.USUARIOO (
	USUARIO char (15) NOT NULL ,
	NOMBRE char (30) NULL ,
	PASSWORD char (10) NULL ,
        SUPERVISOR bit ,
        DERECHOS image NULL ,
        CONSTRAINT PK_USUARIOO PRIMARY KEY  CLUSTERED 
	(
		USUARIO
	)
)

CREATE TABLE Supervisor_giro.ASISTENTE (
	CLAVE_ASISTENTE char (10) NOT NULL,
	CLAVE_ASISTIDO  char (10) NOT NULL
)


CREATE TABLE Supervisor_giro.ORGPERF (
	CLAVE char (10) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	COLOR_FONDO int NULL ,
        COLOR_LETRA int NULL ,
        TAMANO_LETRA int NULL ,
	MARCO char (15) NULL ,
	SOMBRA bit,
	MOSTRAR bit,
	MOSTRAR_EMPLEADOS bit,
	MOSTRAR_DATOS_EXTRAS bit,
	MOSTRAR_FOTOGRAFIA bit,
	MOSTRAR_PLAZAS bit,
	MOSTRAR_POR_PLAZA bit,
        CONSTRAINT PK_ORGPERF PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

