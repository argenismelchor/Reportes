#TOTAL DE COMIDAS POR HORA
#VERSION 1.0
#USUARIO =*
#DESCRIPCION
#Descripción no disponible para este reporte.
#Favor de Actualizarla.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA', $salida)
NUEVO_PARAMETRO_FEC ( 'FECHA', '', _fecha )
NUEVO_PARAMETRO ( 'INICIO  (HORA.MIN)', '', _hora_ini )
NUEVO_PARAMETRO ( 'FIN     (HORA.MIN)', '', _hora_fin )
LEE_PARAMETROS
BORRA_PARAMETROS

FORMATO_FECHA := 2
FORMATO_HORA := 6
SALIDA := $salida
COLUMNAS := 90

_min_ini := FRAC( _hora_ini ) * 100
_min_fin := FRAC( _hora_fin ) * 100

_hora_ini := TRUNCAR( _hora_ini )
_hora_fin := TRUNCAR( _hora_fin )


ENCABEZADO   
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL ( 60 ), VERSION_GIRO ) IMPRIME
   IMP ( CENTRA ( 'EMPRESA':'NOMBRE' )) IMPRIME
   DECIMALES := 0
   IMP ( CENTRA ( 'TOTAL DE COMIDAS DEL DIA ' + FECHA( _fecha ) + ' DE LAS ' + .( _hora_ini ) +':'+ .( _min_ini ) + ' A LAS ' + .( _hora_fin )+':'+ .( _min_fin ) )) IMPRIME
   IMP ( REPITETXT( '=', COLUMNAS )) IMPRIME
   IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(50), 'HORA', COL(60), 'DEPARTAMENTO' ) IMPRIME
   IMP ( REPITETXT ('-', COLUMNAS )) IMPRIME
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

$depto := ''

SUB_RUTINA formato_trabajador
   IMP ( COL ( 1 ), 'EMPPRIN':'CLAVE', COL ( 10 ), 'EMPPRIN':'NOMBRE' )
   IMP ( COL(50), HORA( 'EMPPRIN':'HORA' ) )
   $depto := ''
   SI ( TRAE_REGISTRO( 'DEPTO', 'EMPPRIN':'DEP_CLAVE' ) )
     IMP ( COL(60), 'DEPTO':'CLAVE', '  ', 'DEPTO':'DESCRIPCION' )
     $depto := 'DEPTO':'CLAVE' + '  ' + 'DEPTO':'DESCRIPCION'
   FIN_SI
   IMPRIME
FIN_SUB_RUTINA

INCLUYE UTIL2.DAT

_incluir_dep := 1
lee_parametros_seleccion
lee_parametros_indices
$campos_extras := 'C.*'
$bases_extras := 'EMPCOME C'
$condiciones_extras := 'C. CLAVE = E. CLAVE AND C. FECHA = :FECHA'
base_trabajadores
PARAMETRO_SQL( 'EMPPRIN', 'FECHA', _fecha )

_hora := 0
PRIMER_REGISTRO ( 'EMPPRIN' )
MIENTRAS ( FIN_BASE ( 'EMPPRIN' ) = FALSO )
  SI ( ES_VIGENTE( _fecha ) )
    _hora := 'EMPPRIN':'HORA'
    DECIMALES := 8
    SI ( ( _hora >= CALCULA_HORA( _hora_ini, _min_ini, 0 ) ) AND ( _hora <= CALCULA_HORA( _hora_fin, _min_fin, 0 ) ) )
      datos_trabajador
    FIN_SI
  FIN_SI
  SIGUIENTE_REGISTRO ( 'EMPPRIN' )
FIN_MIENTRAS

termina_reporte
