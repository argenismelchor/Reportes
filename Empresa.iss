CREATE TABLE Supervisor_giro.BAJA (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	ORIGEN char (1) NULL ,
        CONSTRAINT PK_BAJA PRIMARY KEY  CLUSTERED
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.CALENDAR (
	CLAVE char (2) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        CONSTRAINT PK_CALENDAR PRIMARY KEY  CLUSTERED
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.CURSO (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	TIPO char (20) NULL ,
        COSTO smallmoney NULL ,
	COMENTARIO char (30) NULL ,
        CONSTRAINT PK_CURSO PRIMARY KEY  CLUSTERED
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.CURSOPRO (
	CLAVE_CURSO char (5) NOT NULL ,
	ID int IDENTITY (1, 1) NOT NULL ,
	FECHA_INICIO datetime NULL ,
	FECHA_TERMINO datetime NULL ,
	HORARIO_ENTRADA datetime NULL ,
	HORARIO_SALIDA datetime NULL ,
	INSTRUCTOR char (5) NULL ,
	LUGAR char (30) NULL ,
	COMENTARIO char (30) NULL ,
        CONSTRAINT PK_CURSOPRO PRIMARY KEY  CLUSTERED 
	(
		CLAVE_CURSO,
		ID
	)
)

CREATE TABLE Supervisor_giro.CURSOPUE (
	CLAVE_CURSO char (5) NOT NULL ,
	CLAVE_PUESTO char (5) NOT NULL ,
        OBLIGATORIO Bit ,
        CONSTRAINT PK_CURSOPUE PRIMARY KEY  CLUSTERED 
	(
		CLAVE_CURSO,
		CLAVE_PUESTO
	)
)

CREATE TABLE Supervisor_giro.DIASINHA (
	CLAVE char (2) NOT NULL ,
	TIPO char (1) NOT NULL ,
        ANO smallint NOT NULL ,
	MES smallint NOT NULL ,
	DIA smallint NOT NULL ,
        CONSTRAINT PK_DIASINHA PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		TIPO,
                ANO,
		MES,
		DIA
	)
)

CREATE TABLE Supervisor_giro.EMPABO (
	PRESTAMO int NOT NULL ,
	FECHA datetime NOT NULL ,
        MONTO money NULL ,
	COMENTARIO char (25) NULL ,
        CONSTRAINT PK_EMPABO PRIMARY KEY  CLUSTERED 
	(
		PRESTAMO,
		FECHA
	)
)

CREATE TABLE Supervisor_giro.EMPACUM (
	CLAVE char (10) NOT NULL ,
	CONCEPTO char (6) NOT NULL ,
        ENE money NULL ,
        FEB money NULL ,
        MAR money NULL ,
        ABR money NULL ,
        MAY money NULL ,
        JUN money NULL ,
        JUL money NULL ,
        AGO money NULL ,
        SEP money NULL ,
        OCT money NULL ,
        NOV money NULL ,
        DIC money NULL ,
        AGUINALDO money NULL ,
        FINIQUITO money NULL ,
        ESPECIAL money NULL ,
        CONSTRAINT PK_EMPACUM PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		CONCEPTO
	)
)

CREATE TABLE Supervisor_giro.EMPAUS (
	CLAVE char (10) NOT NULL ,
	FECHAI datetime NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
	FECHAF datetime NULL ,
	TIPO char (1) NULL ,
        CONSTRAINT PK_EMPAUS PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHAI,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPCAPAC (
	CLAVE char (10) NOT NULL ,
        CURSO char (5) NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
        PROGRAMADO int NULL ,
        OBLIGATORIO bit ,
        CONSTRAINT PK_EMPCAPAC PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
                CURSO       
	)
)

CREATE TABLE Supervisor_giro.EMPCONT (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
	FORMULARIO char (8) NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
	TIPO char (1) NULL ,
	DURACION int NULL ,
	COMENTARIO char (255) NULL ,
        CONSTRAINT PK_EMPCONT PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA,
		FORMULARIO,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPCURSO (
	CLAVE char (10) NOT NULL ,
	CURSO_PROGRAMADO int NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
	FECHA_INICIAL datetime NULL ,
	FECHA_FINAL datetime NULL ,
	HORAS int NULL ,
        EVALUACION numeric(5,2) NULL ,
	DOCUMENTO char (30) NULL ,
	COMENTARIO char (40) NULL ,
	INSTRUCTOR char (5) NULL ,
        CONSTRAINT PK_EMPCURSO PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		CURSO_PROGRAMADO,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPDEP (
	CLAVE char (10) NOT NULL ,
	FECHA_ENTRADA datetime NOT NULL ,
	FECHA_SALIDA datetime NULL ,
	CATALOGO char (10) NULL ,
        CONSTRAINT PK_EMPDEP PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA_ENTRADA
	)
)

CREATE TABLE Supervisor_giro.EMPEXT (
	CLAVE char (10) NOT NULL ,
        CONSTRAINT PK_EMPEXT PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.EMPFAM (
	CLAVE char (10) NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
	NOMBRE char (40) NULL ,
	PARENTESCO char (30) NULL ,
	SEXO char (1) NULL ,
	NACIMIENTO datetime NULL ,
        CONSTRAINT PK_EMPFAM PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPIDIOM (
	CLAVE char (10) NOT NULL ,
	IDIOMA char (5) NOT NULL ,
	ESCRITO smallint NULL ,
	LEIDO smallint NULL ,
	HABLADO smallint NULL ,
        CONSTRAINT PK_EMPIDIOM PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		IDIOMA
	)
)

CREATE TABLE Supervisor_giro.EMPINC (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
        ID int IDENTITY (1, 1)  NOT NULL ,
	DURACION int NULL ,
	NUMERO char (8) NULL ,
	TIPO char (2) NULL ,
	CASO char (1) NULL ,
        CONSTRAINT PK_EMPINC PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPNOM (
	CLAVE char (10) NOT NULL ,
        NOMINA image NULL ,
        CONSTRAINT PK_EMPNOM PRIMARY KEY  CLUSTERED 
	(
                CLAVE
	)
)

CREATE TABLE Supervisor_giro.EMPNOTA (
	CLAVE char (10) NOT NULL ,
	TIPO char (5) NOT NULL ,
	FECHA datetime NOT NULL ,
        NOTA image NULL ,
        CONSTRAINT PK_EMPNOTA PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		TIPO,
		FECHA
	)
)

CREATE TABLE Supervisor_giro.EMPPRES (
	CLAVE char (10) NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
	CLAVE_CONCEPTO char (6) NULL ,
	FECHA datetime NULL ,
        MONTO money NULL ,
        DESCUENTO money NULL ,
        SALDO money NULL ,
	ESTADO char (1) NULL ,
	COMENTARIO char (1) NULL ,
        CONSTRAINT PK_EMPPRES PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPPRIN (
	CLAVE char (10) NOT NULL ,
	NOMBREP char (30) NULL ,
	NOMBREM char (30) NULL ,
	NOMBREN char (30) NULL ,
	INGRESO datetime NULL ,
	PLANTA datetime NULL ,
	FOTO char (12) NULL ,
	PE char (1) NULL ,
	RFC char (13) NULL ,
	TIPO_NOM char (4) NULL ,
	TIPO_PAGO char (3) NULL ,
	TURNO char (5) NULL ,
	CTA_TARJETA char (20) NULL ,
        PTU bit ,
        CUOTA_SINDICAL bit ,
        VALOR_MINUTO smallmoney NULL ,
	AFILIACION char (11) NULL ,
	BANCO_SAR char (3) NULL ,
	SUCURSAL char (6) NULL ,
	CTA_CHEQUES char (10) NULL ,
	CONTROL_INTERNO char (16) NULL ,
        APORTACION_SAR smallmoney NULL ,
        APORTACION_INFONAVIT smallmoney NULL ,
	CREDITO_INFONAVIT char (10) NULL ,
	INICIO_DESCUENTO_INF datetime NULL ,
	TIPO_DESCUENTO char (1) NULL ,
        VALOR_DESCUENTO smallmoney NULL ,
	CURP char (20) NULL ,
	JORNADA_REDUCIDA smallint NULL ,
	SEMANA_REDUCIDA smallint NULL ,
	CALENDARIO char (2) NULL ,
	CONSTRAINT PK_EMPPRIN PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.EMPPUES (
	CLAVE char (10) NOT NULL ,
	FECHA_ENTRADA datetime NOT NULL ,
	FECHA_SALIDA datetime NULL ,
	CATALOGO char (10) NULL ,
        CONSTRAINT PK_EMPPUES PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA_ENTRADA
	)
)

CREATE TABLE Supervisor_giro.EMPRET (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
        ID int IDENTITY (1, 1) NOT NULL ,
        RETARDO numeric(6,2) NULL ,
	DESCONTAR char (1) NULL ,
	CONSTRAINT PK_EMPRET_1__10 PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA,
		ID
	)
)

CREATE TABLE Supervisor_giro.EMPRH (
	CLAVE char (10) NOT NULL ,
	CALLE char (30) NULL ,
	NUMERO char (7) NULL ,
	INTERIOR char (7) NULL ,
	COLONIA char (30) NULL ,
	SECTOR char (30) NULL ,
	CP int NULL ,
	MUNICIPIO char (25) NULL ,
	ESTADO char (5) NULL ,
	TELEFONO_1 char (10) NULL ,
	TELEFONO_2 char (10) NULL ,
	FECHA_NACIMIENTO datetime NULL ,
	LUGAR_NACIMIENTO char (20) NULL ,
	ESTADO_CIVIL char (5) NULL ,
	ESCOLARIDAD char (5) NULL ,
	SEXO char (1) NULL ,
        CONSTRAINT PK_EMPRH PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.EMPSDO (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
	TIPO char (1) NOT NULL ,
        SDO1 smallmoney NULL ,
        SDO2 smallmoney NULL ,
        SDO3 smallmoney NULL ,
        SDO4 smallmoney NULL ,
        SDO5 smallmoney NULL ,
	BAJA_IMSS datetime NULL ,
	CAUSA_BAJA char (5) NULL ,
	FECHA_SALIDA datetime NULL ,
        CONSTRAINT PK_EMPSDO PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA,
		TIPO
	)
)

CREATE TABLE Supervisor_giro.EMPSUC (
	CLAVE char (10) NOT NULL ,
	FECHA_ENTRADA datetime NOT NULL ,
	FECHA_SALIDA datetime NULL ,
	CATALOGO char (10) NULL ,
        CONSTRAINT PK_EMPSUC PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA_ENTRADA
	)
)

CREATE TABLE Supervisor_giro.EMPVACA (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
	DURACION int NULL ,
        PRIMA_VACACIONAL numeric(6,2) NULL ,
        DESCANSO_1 smallint NULL ,
        DESCANSO_2 smallint NULL ,
        FECHA_FINAL datetime NULL ,
        CONSTRAINT PK_EMPVACA PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA
	)
)

CREATE TABLE Supervisor_giro.ESCOLAR (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        CONSTRAINT PK_ESCOLAR PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.FACTOR (
        CLAVE char (2) NOT NULL ,
	ANT_INICIAL int NOT NULL ,
	ANT_FINAL int NULL ,
        FACTOR numeric(7,5) NULL ,
        CUOTA_FIJA smallmoney NULL ,
        DIAS_DE_VACACIONES smallmoney NULL ,
        PRIMA_VACACIONAL numeric(6,2) NULL ,
        DIAS_DE_AGUINALDO smallmoney NULL ,
        CONSTRAINT PK_FACTOR PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		ANT_INICIAL
	)
)

CREATE TABLE Supervisor_giro.FALTA (
	CLAVE char (1) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	GOCE smallint NULL ,
        CONSTRAINT PK_FALTA PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.IDIOMA (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        CONSTRAINT PK_IDIOMA PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.IMSS (
        ANO smallint NOT NULL ,
	MES smallint NOT NULL ,
	REGISTRO char (11) NOT NULL ,
	DIAS_EG int NULL ,
	DIAS_IV int NULL ,
	FALTAS int NULL ,
	INCAPACIDADES int NULL ,
        BASE_EG1 money NULL ,
        BASE_EG2 money NULL ,
        BASE_EG3 money NULL ,
        BASE_IV money NULL ,
        BASE_RT money NULL ,
        BASE_RETIRO money NULL ,
        BASE_CV money NULL ,
        BASE_INFONAVIT money NULL ,
        TOTAL_IMSS money NULL ,
        TOTAL_INFONAVIT money NULL ,
        CONSTRAINT PK_IMSS PRIMARY KEY  CLUSTERED 
	(
                ANO,
		MES,
		REGISTRO
	)
)

CREATE TABLE Supervisor_giro.INSTRUCT (
	CLAVE char (5) NOT NULL ,
	NOMBRE char (40) NULL ,
	TEL char (15) NULL ,
        CONSTRAINT PK_INSTRUC PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.MINIMO (
	FECHA datetime NOT NULL ,
        MINIMO_A smallmoney NULL ,
        MINIMO_B smallmoney NULL ,
        MINIMO_C smallmoney NULL ,
        TOPE_EG smallmoney NULL ,
        TOPE_IVCM smallmoney NULL ,
        TOPE_RT smallmoney NULL ,
        TOPE_INFONAVIT smallmoney NULL ,
        CONSTRAINT PK_MINIMO PRIMARY KEY  CLUSTERED 
	(
		FECHA
	)
)

CREATE TABLE Supervisor_giro.NOTA (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        CONSTRAINT PK_NOTA PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.PAGOIMSS (
	FECHA datetime NOT NULL ,
        EG_FIJO smallmoney NULL ,
        EG_ESPECIE_PATRON numeric(6,4) NULL ,
        EG_ESPECIE_EMPLEADO numeric(6,4) NULL ,
        EG_3SMGDF_PATRON numeric(6,4) NULL ,
        EG_3SMGDF_EMPLEADO numeric(6,4) NULL ,
        EG_DINERO_PATRON numeric(6,4) NULL ,
        EG_DINERO_EMPLEADO numeric(6,6) NULL ,
        RT numeric(6,4) NULL ,
        INVALIDEZ_Y_VIDA_PATRON numeric(6,4) NULL ,
        INVALIDEZ_Y_VIDA_EMPLEADO numeric(6,4) NULL ,
        GUARDERIA numeric(6,4) NULL ,
        RETIRO numeric(6,4) NULL ,
        CESANTIA_Y_VEJEZ_PATRON numeric(6,4) NULL ,
        CESANTIA_Y_VEJEZ_EMPLEADO numeric(6,4) NULL ,
        CONSTRAINT PK_PAGOIMSS PRIMARY KEY  CLUSTERED 
	(
		FECHA
	)
)

CREATE TABLE Supervisor_giro.PATRONAL (
	CLAVE char (10) NOT NULL ,
	NOMBRE char (50) NULL ,
	REGISTRO_PATRONAL char (11) NULL ,
	GUIA_MAGNETICA int NULL ,
	ZONA_ECONOMICA char (1) NULL ,
	CALLE char (30) NULL ,
	NUMERO char (8) NULL ,
	COLONIA char (20) NULL ,
	C_P char (5) NULL ,
	MUNICIPIO char (20) NULL ,
	ESTADO char (20) NULL ,
	TELEFONO char (12) NULL ,
	FAX char (12) NULL ,
	REPRESENTANTE char (30) NULL ,
        RT numeric(7,5) NULL ,
        CONSTRAINT PK_PATRONAL PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.PERIODO (
	TIPONOM char (4) NOT NULL ,
	NUMERO int NOT NULL ,
	FECHA_INICIAL datetime NULL ,
	FECHA_FINAL datetime NULL ,
	DIAS_DE_PAGO smallint NULL ,
        ESPECIAL bit ,
        INICIO_DE_ANO bit ,
        FIN_DE_ANO bit ,
        INICIO_DE_BIMESTRE bit ,
        FIN_DE_BIMESTRE bit ,
        INICIO_DE_MES bit ,
        FIN_DE_MES bit ,
        EXTRA_1 bit ,
        EXTRA_2 bit ,
	DIA_DESCUENTO_1 smallint NULL ,
	DIA_DESCUENTO_2 smallint NULL ,
	MES_DE_ACUMULACION char (10) NULL ,
        CONSTRAINT PK_PERIODO PRIMARY KEY  CLUSTERED 
	(
                TIPONOM,
                NUMERO
	)
)

CREATE TABLE Supervisor_giro.PRIMASRT (
	CLASE int NOT NULL ,
        GRADO numeric(6,2) NULL ,
        INDICE numeric(6,2) NULL ,
        PRIMA numeric(6,2) NULL ,
        CONSTRAINT PK_PRIMASRT PRIMARY KEY  CLUSTERED 
	(
		CLASE
	)
)

CREATE TABLE Supervisor_giro.PUESTO (
	CLAVE char (10) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	TIPO_EMPLEADO char (2) NULL ,
	CALENDARIO char (2) NULL ,
        CONSTRAINT PK_PUESTO PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.SUCURSAL (
	CLAVE char (10) NOT NULL ,
	NOMBRE char (50) NULL ,
	REGISTRO_PATRONAL char (10) NULL ,
	CALLE char (30) NULL ,
	NUMERO char (8) NULL ,
	COLONIA char (20) NULL ,
	C_P char (5) NULL ,
	MUNICIPIO char (20) NULL ,
	ESTADO char (20) NULL ,
	TELEFONO char (12) NULL ,
	FAX char (12) NULL ,
        ENCARGADO char (30) NULL ,
        CONSTRAINT PK_SUCURSAL PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.TABISPT (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        TABLA image NULL ,
        SUBSIDIO numeric(6,4) NULL ,
        CONSTRAINT PK_TABISPT PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.TIPOEMP (
	CLAVE char (2) NOT NULL ,
	DESCRIPCION char (30) NULL ,
        CONSTRAINT PK_TIPOEMP PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.TIPONOM (
	CLAVE char (4) NOT NULL ,
	DESCRIPCION char (25) NULL ,
	ACTUAL int NULL ,
        CONSTRAINT PK_TIPONOM PRIMARY KEY  CLUSTERED 
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.TURNO1 (
	CLAVE char (5) NOT NULL ,
	DESCRIPCION char (30) NULL ,
	ENTRADA_LUN smalldatetime NULL ,
	SALIDA_LUN smalldatetime NULL ,
	SALIDA_COM_LUN smalldatetime NULL ,
	REGRESO_COM_LUN smalldatetime NULL ,
	VARIABLE_PRINCIPAL_LUN bit ,
	VARIABLE_COMIDA_LUN bit ,
	ENTRADA_MAR smalldatetime NULL ,
	SALIDA_MAR smalldatetime NULL ,
	SALIDA_COM_MAR smalldatetime NULL ,
	REGRESO_COM_MAR smalldatetime NULL ,
	VARIABLE_PRINCIPAL_MAR bit ,
	VARIABLE_COMIDA_MAR bit ,
	ENTRADA_MIE smalldatetime NULL ,
	SALIDA_MIE smalldatetime NULL ,
	SALIDA_COM_MIE smalldatetime NULL ,
	REGRESO_COM_MIE smalldatetime NULL ,
	VARIABLE_PRINCIPAL_MIE bit ,
	VARIABLE_COMIDA_MIE bit ,
	ENTRADA_JUE smalldatetime NULL ,
	SALIDA_JUE smalldatetime NULL ,
	SALIDA_COM_JUE smalldatetime NULL ,
	REGRESO_COM_JUE smalldatetime NULL ,
	VARIABLE_PRINCIPAL_JUE bit ,
	VARIABLE_COMIDA_JUE bit ,
	ENTRADA_VIE smalldatetime NULL ,
	SALIDA_VIE smalldatetime NULL ,
	SALIDA_COM_VIE smalldatetime NULL ,
	REGRESO_COM_VIE smalldatetime NULL ,
	VARIABLE_PRINCIPAL_VIE bit ,
	VARIABLE_COMIDA_VIE bit ,
	ENTRADA_SAB smalldatetime NULL ,
	SALIDA_SAB smalldatetime NULL ,
	SALIDA_COM_SAB smalldatetime NULL ,
	REGRESO_COM_SAB smalldatetime NULL ,
	VARIABLE_PRINCIPAL_SAB bit ,
	VARIABLE_COMIDA_SAB bit ,
	ENTRADA_DOM smalldatetime NULL ,
	SALIDA_DOM smalldatetime NULL ,
	SALIDA_COM_DOM smalldatetime NULL ,
	REGRESO_COM_DOM smalldatetime NULL ,
	VARIABLE_PRINCIPAL_DOM bit ,
	VARIABLE_COMIDA_DOM bit ,
        CONSTRAINT PK_TURNO1 PRIMARY KEY  CLUSTERED
	(
		CLAVE
	)
)

CREATE TABLE Supervisor_giro.USUARIO (
	USUARIO char (15) NOT NULL ,
	NOMBRE char (30) NULL ,
	PASSWORD char (10) NULL ,
        SUPERVISOR bit ,
        DERECHOS image NULL ,
        CONSTRAINT PK_USUARIO PRIMARY KEY  CLUSTERED 
	(
		USUARIO
	)
)

/*tablas para el reloj checador*/

CREATE TABLE Supervisor_giro.USUARIOR (
	USUARIO char (15) NOT NULL ,
	NOMBRE char (30) NULL ,
	PASSWORD char (10) NULL ,
        SUPERVISOR bit ,
        DERECHOS image NULL ,
        CONSTRAINT PK_USUARIOR PRIMARY KEY  CLUSTERED 
	(
		USUARIO
	)
)

CREATE TABLE Supervisor_giro.EMPMEN (
        CLAVE char (10) NOT NULL ,
        FECHA datetime NOT NULL ,
        MENSAJE char (240) NULL ,
        AUDIBLE image NULL ,
        PERMITE_CHECAR bit ,
        EN_ENTRADA_1 bit ,
        EN_ENTRADA_2 bit ,
        EN_SALIDA_1 bit ,
        EN_SALIDA_2 bit ,
        CONSTRAINT PK_EMPMEN PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
                FECHA
	)
)

CREATE TABLE Supervisor_giro.EMPRELOJ (
        CLAVE char (10) NOT NULL ,
        FECHA datetime NOT NULL ,
        ENTRADA_P datetime NULL ,
        ENTRADA_S datetime NULL ,
        SALIDA_S datetime NULL ,
        SALIDA_P datetime NULL ,
        ENTRADA_REAL_P datetime NULL ,
        ENTRADA_REAL_S datetime NULL ,
        SALIDA_REAL_S datetime NULL ,
        SALIDA_REAL_P datetime NULL ,
        CONSTRAINT PK_EMPRELOJ PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
                FECHA
	)
)

CREATE TABLE Supervisor_giro.LINEAUS (
        CLAVE char (5) NOT NULL ,
        DESCRIPCION char(30) NULL ,
        CALENDAR char(2) NULL ,
        CHECAR bit ,
        CONSTRAINT PK_LINEAUS PRIMARY KEY  CLUSTERED 
	(
                CLAVE
	)
)

CREATE TABLE Supervisor_giro.BITAREL (
        CLAVE char (10) NOT NULL ,
        DIA datetime NOT NULL ,
        HORA datetime NOT NULL ,
        CONSTRAINT PK_BITAREL PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
                DIA,
                HORA
	)
)

CREATE TABLE Supervisor_giro.EMPHE (
	CLAVE char (10) NOT NULL ,
	FECHA datetime NOT NULL ,
	TIPO char (1) NOT NULL ,
        MONTO numeric(6,2) NULL ,
        CONSTRAINT PK_EMPHE PRIMARY KEY  CLUSTERED 
	(
		CLAVE,
		FECHA,
		TIPO
	)
)

CREATE TABLE Supervisor_giro.MENSAJE (
        CLAVE char (5) NOT NULL ,
        MENSAJE char(240) NULL ,
        AUDIBLE image NULL ,
        PERMITE_CHECAR bit ,
        CONSTRAINT PK_MENSAJE PRIMARY KEY  CLUSTERED 
	(
                CLAVE
	)
)

