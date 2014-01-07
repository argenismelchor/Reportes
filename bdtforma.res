#REPORTE DE CANDIDATOS
#VERSION 1.0
#USUARIO =*
#DESCRIPCION
#Muestra el curriculum de los candidatos en la base de datos
#FIN_DESCRIPCION
$folio := '1'

FORMATO_FECHA := 3
FORMATO_PESOS := 2
SALIDA := 'P'

ENCABEZADO   
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL ( 60 ), VERSION_GIRO ) IMPRIME
   IMP ( CENTRA ( 'EMPRESA':'NOMBRE' )) IMPRIME
   IMP ( CENTRA ( 'REPORTE DE CANDIDATOS' )) IMPRIME
   IMP ( REPITETXT( '=',80 )) IMPRIME
   LETRA ( 'LETRA NORMAL' )
   IMPRIME
FIN_ENCABEZADO

PIE
   IMPRIME ;; IMPRIME
   DECIMALES := 0
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( COL ( 2 ), 'Fecha : ', FECHA (FECHA_HOY), ' ', 'Hora : ', HORA ( HORA_ACTUAL ), COL ( 65 ), 'PAGINA -', PAGINA, '-' ) IMPRIME
   LETRA ( 'LETRA NORMAL' ) IMPRIME
   DECIMALES := 2
FIN_PIE 

#VARIABLES
$tabla := 'PROSPECTOS'
_col   := 12
$estado_civil := ''
$sexo         := ''
$disp         := ''
$nivel        := ''
$experiencia  := ''
VAR_T ( &nota  )
VAR_T ( &datos )

MODO_IMPRESION( 'DIRECTO' )

SUB_RUTINA formato_trabajador
   SI ( PAGINA > 1 )
     AVANZA_HOJA
   FIN_SI
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'FOLIO' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $tabla:'CLAVE' )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'FECHA SOLICITUD' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(67), FECHA( $tabla:'FECHA' ) )
   IMPRIME ;; IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'NOMBRE' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $tabla:'NOMBREP' + ' ' + $tabla:'NOMBREM' + ' ' + $tabla:'NOMBREN' )
   IMPRIME ;; IMPRIME

   IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'DIRECCION' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $tabla:'CALLE' + ' ' + $tabla:'NUMERO' + ' ' + $tabla:'INTERIOR' )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'CIUDAD' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(56), $tabla:'CIUDAD' )
   IMPRIME ;; IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'TELEFONO' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $tabla:'TELEFONO' )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'FAX' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(67), $tabla:'FAX' )
   IMPRIME ;; IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'EMAIL' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $tabla:'EMAIL' )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'WEB' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(67), $tabla:'WEB' )
   IMPRIME ;; IMPRIME

   IMPRIME

   _col := 18
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'FECHA NACIMIENTO' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), FECHA( $tabla:'FECHA_NACIMIENTO' ) )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(35), 'EDAD' )
   LETRA( 'LETRA NORMAL' )
   DECIMALES := 0
   IMP ( COL(40), .(TRUNCAR( ( FECHA_HOY - $tabla:'FECHA_NACIMIENTO' ) / 365 ) ) )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'NACIONALIDAD' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(62), $tabla:'NACIONALIDAD' )
   IMPRIME ;; IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'ESTADO CIVIL' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'ESTADO_CIVIL' = 0 ) $estado_civil := 'SOLTERO' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 1 ) $estado_civil := 'CASADO' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 2 ) $estado_civil := 'DIVORCIADO' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 3 ) $estado_civil := 'VIUDO' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 4 ) $estado_civil := 'SEPARADO' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 5 ) $estado_civil := 'UNION LIBRE' FIN_SI
   SI ( $tabla:'ESTADO_CIVIL' = 6 ) $estado_civil := 'OTRO' FIN_SI
   IMP ( COL(_col), $estado_civil )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(32), 'SEXO' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'SEXO' = 0 ) $sexo := 'MASCULINO' FIN_SI
   SI ( $tabla:'SEXO' = 1 ) $sexo := 'FEMENINO' FIN_SI
   IMP ( COL(37), $sexo )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'DISPONIBILIDAD' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'DISPONIBILIDAD' = 0 ) $disp := 'TIEMPO COMPLETO' FIN_SI
   SI ( $tabla:'DISPONIBILIDAD' = 1 ) $disp := 'MEDIO TIEMPO' FIN_SI
   SI ( $tabla:'DISPONIBILIDAD' = 1 ) $disp := 'TIEMPO PARCIAL' FIN_SI
   IMP ( COL(65), $disp )
   IMPRIME ;; IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'TIENE LICENCIA' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'TIENE_LICENCIA' = VERDADERO )
      IMP ( COL(_col), 'SI' )
   SI_NO
      IMP ( COL(_col), 'NO' )
   FIN_SI
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(48), 'TIENE AUTO' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'TIENE_AUTO' = VERDADERO )
      IMP ( COL(62), 'SI' )
   SI_NO
      IMP ( COL(62), 'NO' )
   FIN_SI
   IMPRIME ;; IMPRIME

   IMPRIME

   _col := 20
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'NIVEL DE ESTUDIOS' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'NIVEL_ESTUDIOS' = 0 ) $nivel := 'PRIMARIA' FIN_SI
   SI ( $tabla:'NIVEL_ESTUDIOS' = 1 ) $nivel := 'SECUNDARIA' FIN_SI
   SI ( $tabla:'NIVEL_ESTUDIOS' = 2 ) $nivel := 'PREPARATORIA' FIN_SI
   SI ( $tabla:'NIVEL_ESTUDIOS' = 3 ) $nivel := 'LICENCIATURA' FIN_SI
   SI ( $tabla:'NIVEL_ESTUDIOS' = 4 ) $nivel := 'DIPLOMADO' FIN_SI
   SI ( $tabla:'NIVEL_ESTUDIOS' = 5 ) $nivel := 'DOCTORADO' FIN_SI
   IMP ( COL(_col), $nivel )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(40), 'PROFESION' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(51), $tabla:'PROFESION' )
   SI ( TRAE_REGISTRO ( 'B_PROF', $tabla:'PROFESION' ) )
     IMP ( COL(58), 'B_PROF':'PROFESION' )
   FIN_SI
   IMPRIME ;; IMPRIME
   
   DECIMALES := 2
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'SUELDO DESEADO' )
   LETRA( 'LETRA NORMAL' )
   IMP ( COL(_col), $( $tabla:'SUELDO_MEN_DESEADO' ) )
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(40), 'EXPERIENCIA LABORAL' )
   LETRA( 'LETRA NORMAL' )
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 0 ) $experiencia := 'NINGUNA' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 1 ) $experiencia := 'PRACTICA PROFESIONAL' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 2 ) $experiencia := 'MENOS DE 1 A�O' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 3 ) $experiencia := '1 A 2 A�OS' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 4 ) $experiencia := '2 A 3 A�OS' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 5 ) $experiencia := '3 A 5 A�OS' FIN_SI
   SI ( $tabla:'EXPERIENCIA_LABORAL' = 6 ) $experiencia := 'MAS DE 5 A�OS' FIN_SI
   IMP ( COL(60), $experiencia )
   IMPRIME ;; IMPRIME

   IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'I D I O M A S' )
   IMPRIME

   DECIMALES := 0
   LETRA( 'LETRA NORMAL' )
   PRIMER_REGISTRO( 'B_CIDIOM' )
   MIENTRAS( FIN_BASE( 'B_CIDIOM' ) = FALSO )
     IMP ( COL(5), 'B_CIDIOM':'IDIOMA' )
     SI ( TRAE_REGISTRO( 'B_IDIOMA', 'B_CIDIOM':'IDIOMA' ) )
       IMP ( COL(10), 'B_IDIOMA':'IDIOMA' )
     FIN_SI
     IMP ( COL(40), .('B_CIDIOM':'PORCENTAJE') + '%' )
     IMPRIME
     SIGUIENTE_REGISTRO( 'B_CIDIOM' )
   FIN_MIENTRAS

   IMPRIME

   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'H A B I L I D A D E S' )
   IMPRIME

   DECIMALES := 0
   LETRA( 'LETRA NORMAL' )
   PRIMER_REGISTRO( 'B_CCONOC' )
   MIENTRAS( FIN_BASE( 'B_CCONOC' ) = FALSO )
     IMP ( COL(5), 'B_CCONOC':'CONOCIMIENTO' )
     SI ( TRAE_REGISTRO( 'B_CONOCI', 'B_CCONOC':'CONOCIMIENTO' ) )
       IMP ( COL(10), 'B_CONOCI':'DESCRIPCION' )
     FIN_SI
     IMP ( COL(40), .('B_CCONOC':'PORCENTAJE') + '%' )
     IMPRIME
     SIGUIENTE_REGISTRO( 'B_CCONOC' )
   FIN_MIENTRAS

   IMPRIME
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'D A T O S    A C A D E M I C O S' )
   IMPRIME
   LETRA( 'LETRA NORMAL' )
   CARGA_MEMO ( &datos , $tabla , 'DATOS_ACADEMICOS' )
   IMPRIME_TABLA ( &datos , 5 )

   IMPRIME
   LETRA( 'LETRA ENFATISADA' )
   IMP ( COL(1), 'N O T A' )
   IMPRIME
   LETRA( 'LETRA NORMAL' )
   CARGA_MEMO ( &nota , $tabla , 'NOTAS' )
   IMPRIME_TABLA ( &nota , 5 )

FIN_SUB_RUTINA

VAR_T ( &sql )
AGREGA_VALOR_COL( &sql, 0, 'SELECT *' )
AGREGA_VALOR_COL( &sql, 0, 'FROM B_CANDI' )
SI ( $folio <> '' )
  AGREGA_VALOR_COL( &sql, 0, 'WHERE CLAVE IN ( ' + $folio + ')' )
FIN_SI
CREA_CONSULTA( $tabla, &sql )
USA_ARCHIVO ( $tabla, 'B_CIDIOM', 'CLAVE' )
USA_ARCHIVO ( $tabla, 'B_CCONOC', 'CLAVE' )

PRIMER_REGISTRO ( $tabla )
MIENTRAS ( FIN_BASE ( $tabla ) = FALSO )
   formato_trabajador
   SIGUIENTE_REGISTRO ( $tabla )
FIN_MIENTRAS
