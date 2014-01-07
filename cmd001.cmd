#LISTA DE MENUS
#VERSION 1.0
#USUARIO =*
#NO EDITAR
#DESCRIPCION
#Lista los menus de toda la semana
#FIN_DESCRIPCION

$salida := 'PANTALLA'
NUEVO_PARAMETRO_TAB ( 'TURNO', 'TURNOC/CLAVE/TURNOS COMEDOR', &turnos )
NUEVO_PARAMETRO_CHEQ( 'MENUS ESPECIALES', '', _menus )
LEE_PARAMETROS
BORRA_PARAMETROS

FORMATO_FECHA := 2
FORMATO_HORA  := 4
SALIDA := $salida

ENCABEZADO   
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL ( 60 ), VERSION_GIRO ) IMPRIME
   IMP ( CENTRA ( 'EMPRESA':'NOMBRE' )) IMPRIME
   IMP ( CENTRA ( 'LISTA DE MENUS' )) IMPRIME
   IMP ( REPITETXT( '=',80 )) IMPRIME
   IMP ( COL(1), 'CLAVE', COL(1), 'DESCRIPCION', COL(60), DER('COSTO TRA', 10), COL(70), DER('COSTO EMP', 10) ) IMPRIME
   IMP ( REPITETXT ('-', 80 )) IMPRIME
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

#VARIABLES GLOBALES
$turno := TRAE_SELECCION( &turnos )
VAR_T ( &tabla )
VAR_T ( &menu )
$campo_inicio  := ''
$campo_termino := ''
$campo_menu    := ''
$dia           := ''

#SUBRUTINAS
SUB_RUTINA imprime_dia
  DECIMALES := 12
  $campo_inicio  := 'INICIO_' + SUBSTR( $dia, 1, 3 )
  $campo_termino := 'TERMINO_' + SUBSTR( $dia, 1, 3 )
  $campo_menu    := 'MENU_' + SUBSTR( $dia, 1, 3 )
  IMPRIME
  LETRA ( 'LETRA ENFATISADA' )
  IMP ( COL(5), $dia, COL(25), 'HORA INICIO : ', HORA( 'TURNOC':$campo_inicio ), COL(55), 'HORA TERMINO : ', HORA( 'TURNOC':$campo_termino ) ) ;; IMPRIME
  LETRA ( 'LETRA NORMAL' )
  CARGA_MEMO( &menu, 'TURNOC', $campo_menu )
  IMPRIME_TABLA( &menu, 10 )
FIN_SUB_RUTINA

SUB_RUTINA imprime_turno
  IMP ( COL(1), 'TURNOC':'CLAVE', COL(10), 'TURNOC':'DESCRIPCION', COL(60), DER( $('TURNOC':'COSTO_EMPLEADO'), 10), COL(70), DER( $('TURNOC':'COSTO_EMPRESA'), 10) )
  IMPRIME
  $dia := 'LUNES'
  imprime_dia
  $dia := 'MARTES'
  imprime_dia
  $dia := 'MIERCOLES'
  imprime_dia
  $dia := 'JUEVES'
  imprime_dia
  $dia := 'VIERNES'
  imprime_dia
  $dia := 'SABADO'
  imprime_dia
  $dia := 'DOMINGO'
  imprime_dia
  AVANZA_HOJA
FIN_SUB_RUTINA

AGREGA_VALOR_COL( &tabla, 0, 'SELECT *' )
AGREGA_VALOR_COL( &tabla, 0, 'FROM "' + LEE_INI( 'CONFIGURACIONES', 'NETFILEDIR', 'C:\GIRO' ) + '\TURNOC"' )
SI ( $turno <> '' )
  AGREGA_VALOR_COL( &tabla, 0, 'WHERE CLAVE IN ( ' + $turno +' )' )
FIN_SI 
CREA_CONSULTA( 'TURNOC', &tabla )

PRIMER_REGISTRO ( 'TURNOC' )
MUESTRA_AVANCE( 'TURNOC', 'PROGRESO...' )
MIENTRAS ( FIN_BASE ( 'TURNOC' ) = FALSO )
   imprime_turno
   SIGUIENTE_REGISTRO ( 'TURNOC' )
FIN_MIENTRAS

$tabla := 'C:\GIRO\TABMENU'
SI ( _menus = 1 )
  ABRE_BASE( $tabla )
  PRIMER_REGISTRO( $tabla )
  MIENTRAS( FIN_BASE( $tabla ) = FALSO )
    LETRA ( 'LETRA ENFATISADA' )
    IMP ( COL(1), $tabla:'CLAVE', COL(10), $tabla:'DESCRIPCION', COL(60), DER( $($tabla:'COSTO_EMPLEADO'), 10), COL(70), DER( $($tabla:'COSTO_EMPRESA'), 10) )
    IMPRIME
    LETRA ( 'LETRA NORMAL' )
    CARGA_MEMO( &menu, $tabla, 'MENU' )
    IMPRIME_TABLA( &menu, 10 )
    IMPRIME
    SIGUIENTE_REGISTRO( $tabla )
  FIN_MIENTRAS
FIN_SI
