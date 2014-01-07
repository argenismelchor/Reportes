#CREDENCIALES GENERADAS
#VERSION 2.500
#DESCRIPCION
#Reporte de credenciales generado por el modulo de credenciales.
#imprime el formato definido en el generador de credenciales.
#FIN_DESCRIPCION
#

NUEVO_PARAMETRO_SAL ('SALIDA','PANTALLA/IMPRESORA',$salida)
NUEVO_PARAMETRO_TAB ('CREDENCIAL', DIRECTORIO_PROGRAMAS + '\USUEXT/CLAVE/CREDENCIALES EXTRAS', &cred )
LEE_PARAMETROS

BORRA_PARAMETROS

MODO_IMPRESION ( 'GRAFICO')
_ff := FECHA_HOY
FORMATO_FECHA := 2
SALIDA  := $salida
_hlargo := 2794
_hancho := 2159

### VARIABLES GLOBALES DEL REPORTE
_x := 0
_y := 0
_sep_x := 100
_sep_y := 100
_ini_x := 100
_ini_y := 100
_no_cred := 2
_largo := 500
_ancho := 800
_cred  := 0

SUB_RUTINA formato_credencial
  IMPRIME_REC( _x, _y, 800, 500 )
  CAMBIA_LETRA( 'Courier New', 14, '\N' )
  VE_XY( _x + 32, _y + 38 ) ;;  IMP ( SUBSTR( 'EMPRESA':'NOMBRE', 1, 30) ) ;; IMPRIME
  CAMBIA_LETRA( 'Courier New', 10, '' )
  VE_XY( _x + 52, _y + 195 ) ;;  IMP ( SUBSTR( 'USUEXT':'CLAVE', 1, 10) ) ;; IMPRIME
  VE_XY( _x + 52, _y + 251 ) ;;  IMP ( SUBSTR( 'USUEXT':'DESCRIPCION', 1, 30) ) ;; IMPRIME
  CODIGO_BARRAS( 'USUEXT':'CLAVE', _x + 204, _y + 347, 378, 76 )
  _cred:=_cred + 1
  SI ( _cred >= _no_cred )
    _cred:=0
    _y:=_y + _largo + _sep_y
        SI ( _y + _largo >= _hlargo )
          _y:=_sep_y + _ini_y
          AVANZA_HOJA
          IMPRIME
        FIN_SI
  FIN_SI
FIN_SUB_RUTINA

_y := _sep_y + _ini_y
_x := _sep_x

#Definicion de variables en base a los parametros
SALIDA := $salida

VAR_T( &tabla )
$creds := TRAE_SELECCION( &cred )
AGREGA_VALOR_COL( &tabla, 0, 'SELECT *')
AGREGA_VALOR_COL( &tabla, 0, 'FROM "' + DIRECTORIO_PROGRAMAS + '\USUEXT"')
SI ( $creds <> '' )
  AGREGA_VALOR_COL( &tabla, 0, 'WHERE CLAVE IN ( '+ $creds + ' )')
FIN_SI
CREA_CONSULTA( 'USUEXT', &tabla )

PRIMER_REGISTRO( 'USUEXT' )
MIENTRAS ( FIN_BASE ( 'USUEXT' ) = FALSO )
    _x:=(_cred * (_ancho + _ini_x + _sep_x )) + _sep_x
   formato_credencial
   SIGUIENTE_REGISTRO ( 'USUEXT' )
FIN_MIENTRAS
