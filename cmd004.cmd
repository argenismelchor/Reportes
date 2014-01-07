#TOTAL DE COMIDAS POR PERIODO
#EXCEL
#USUARIO =*
#VERSION 1.0
#NO EDITAR
#DESCRIPCION
#Descripción no disponible para este reporte.
#Favor de Actualizarla.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA/EXCEL', $salida)
LEE_PARAMETROS
BORRA_PARAMETROS

FORMATO_FECHA := 3
SALIDA := $salida

#VARIABLES
_periodo := 0
_num_ind := 0
VAR_T ( &indices )
VAR_T ( &subtotales )
_num_com := 0
_tot_com := 0
$indice  := ''

ENCABEZADO   
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL ( 60 ), VERSION_GIRO ) IMPRIME
   IMP ( CENTRA ( 'EMPRESA':'NOMBRE' )) IMPRIME
   DECIMALES := 0
   IMP ( CENTRA ( 'TOTAL DE COMIDAS PERIODO ' + 'TIPONOM':'CLAVE' + ' ' + .( _periodo ) + ' DEL '+ FECHA ('PERIODO':'FECHA INICIAL')+ ' AL ' + FECHA ('PERIODO':'FECHA FINAL') )) IMPRIME
   IMP ( REPITETXT( '=',80 )) IMPRIME
   IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(60), 'NUMERO', COL(70), DER( 'TOTAL', 8 )  ) IMPRIME
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

SUB_RUTINA sub_totales
   IMP ( 'SUBTOTAL ' + $indice ) IMPRIME
   DECIMALES := 0
   IMP ( '  TOTAL DE COMIDAS : ', VALOR_TABLA( &subtotales, 'NUMERO', $indice ) ) IMPRIME
   DECIMALES := 2
   IMP ( '  TOTAL DESCUENTOS : ', VALOR_TABLA( &subtotales, 'TOTAL', $indice ) ) IMPRIME
   ASIGNA_VALOR_TABLA ( &subtotales, 'TOTAL', $indice, 0 )
   ASIGNA_VALOR_TABLA ( &subtotales, 'NUMERO', $indice, 0 )
FIN_SUB_RUTINA

_renglon := 1

SUB_RUTINA formato_trabajador
   IMP ( COL ( 1 ), 'EMPPRIN':'CLAVE', COL ( 10 ), 'EMPPRIN':'NOMBRE' )
   DECIMALES := 0
   _num_com := NUMERO_COMIDAS( 'PERIODO':'FECHA INICIAL', 'PERIODO':'FECHA FINAL', '*' )
   IMP ( COL(60), DER( _num_com, 3 ) )
   DECIMALES := 2
   _tot_com := TOTAL_COMIDAS( 'PERIODO':'FECHA INICIAL', 'PERIODO':'FECHA FINAL', '*' )
   IMP ( COL(70), DER( _tot_com, 8 ) )
   IMPRIME

   SI ( $salida = 'EXCEL' )
     _renglon := _renglon + 1
     EXCEL( 'PON_VALOR', 1, _renglon, 'EMPPRIN':'CLAVE' )
     EXCEL( 'PON_VALOR', 2, _renglon, 'EMPPRIN':'NOMBRE' )
     DECIMALES := 0
     EXCEL( 'PON_VALOR', 3, _renglon, .( _num_com ) )
     DECIMALES := 2
     EXCEL( 'PON_VALOR', 4, _renglon, .( _tot_com ) )
   FIN_SI

   #Incremeto de valores para los indices seleccionados
   _num_ind := 0
   REPITE
     INCREMENTA_TABLA( &subtotales, 'NUMERO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _num_com )
     INCREMENTA_TABLA( &subtotales, 'TOTAL', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _tot_com )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

INCLUYE UTIL2.DAT

lee_parametros_seleccion
lee_parametros_indices

$ind_act := ''
$nom_ind := ''

#Definicion de la tabla de indices utilizados
REPITE
  $nom_ind := TRAE_VALOR_TABLA( &in, 2, _num_ind )
  $ind_act := TRAE_VALOR_TABLA( &in, 0, _num_ind )
  SI (( $nom_ind <> '' ) AND ( $ind_act = '1' ))
    AGREGA_VALOR_COL( &indices, 0, $nom_ind )
  FIN_SI
  _num_ind := _num_ind + 1
HASTA(  $nom_ind = '' )
AGREGA_VALOR_COL( &indices, 0, 'TOTAL' )

$tiponom := TRAE_VALOR_TABLA( &in, 11, 6 )
ABRE_BASE( 'TIPONOM' )
SI ( $tiponom = '' )
  SI ( TOTAL_REGISTROS( 'TIPONOM' ) = 1 )
    PRIMER_REGISTRO('TIPONOM' )
    $tiponom := '"' + 'TIPONOM':'CLAVE' + '"'
  FIN_SI
FIN_SI
SI (( $tiponom = '' ) OR ( POS( ',', $tiponom ) > 0 ) )
  MENSAJE( 'SOLO PUEDE SELECCIONAR 1 TIPO DE NOMINA' )
  TERMINA_REPORTE
FIN_SI
$tiponom := ELIMINA( $tiponom, 1, 1 )
$tiponom := ELIMINA( $tiponom, LONGITUD( $tiponom ), 1 )
SI ( TRAE_REGISTRO( 'TIPONOM', $tiponom ) )
  DECIMALES := 0
  NUEVO_PARAMETRO  ( 'PERIODO', .('TIPONOM':'ACTUAL'), _periodo )
  LEE_PARAMETROS
  SI ( TRAE_REGISTRO( 'PERIODO', $tiponom, _periodo ) = FALSO )
    MENSAJE ( 'PERIODO DE NOMINA INEXISTENTE...' )
    TERMINA_REPORTE
  FIN_SI
FIN_SI

base_trabajadores
USA_ARCHIVO( 'EMPPRIN', 'EMPCOME', 'CLAVE' )

SI ( $salida = 'EXCEL' )
  EXCEL( 'PON_VALOR', 1, 1, 'CLAVE' )
  EXCEL( 'PON_VALOR', 1, 2, 'NOMBRE' )
  EXCEL( 'PON_VALOR', 1, 3, 'NUMERO' )
  EXCEL( 'PON_VALOR', 1, 4, 'TOTAL' )
FIN_SI

PRIMER_REGISTRO ( 'EMPPRIN' )
MIENTRAS ( FIN_BASE ( 'EMPPRIN' ) = FALSO )
   SI ( FUE_VIGENTE('PERIODO':'FECHA INICIAL', 'PERIODO':'FECHA FINAL') )
     datos_trabajador
   FIN_SI
   SIGUIENTE_REGISTRO ( 'EMPPRIN' )
FIN_MIENTRAS

termina_reporte
$indice := 'TOTAL'
sub_totales
