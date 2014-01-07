#EMPLEADOS SIN CHECAR COMEDOR
#EXCEL
#USUARIO =*
#VERSION 1.0
#DESCRIPCION
#Descripción no disponible para este reporte.
#Favor de Actualizarla.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA/EXCEL', $salida)
NUEVO_PARAMETRO_FEC ( 'FECHA', '', _fecha )
LEE_PARAMETROS
BORRA_PARAMETROS

COLUMNAS := 90
FORMATO_FECHA := 2
SALIDA := $salida

ENCABEZADO   
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL ( 60 ), VERSION_GIRO ) IMPRIME
   IMP ( CENTRA ( 'EMPRESA':'NOMBRE' )) IMPRIME
   IMP ( CENTRA ( 'EMPLEADOS SIN CHECAR COMEDOR AL ' + FECHA( _fecha ) )) IMPRIME
   IMP ( REPITETXT( '=', COLUMNAS )) IMPRIME
   SI ( CD_DC = 0 )
     IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(60), 'DEPARTAMENTO' ) IMPRIME
   SI_NO
     IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(60), 'CENTRO DE COSTO' ) IMPRIME
   FIN_SI
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

_ren_excel := 1
$depto := ''

SUB_RUTINA formato_trabajador
   IMP ( COL ( 1 ), 'EMPPRIN':'CLAVE', COL ( 10 ), 'EMPPRIN':'NOMBRE' )
   $depto := ''
   SI ( CD_DC = 0 )
     SI ( TRAE_REGISTRO( 'DEPTO', 'EMPPRIN':'DEP_CLAVE' ) )
       IMP ( COL(60), 'DEPTO':'CLAVE', '  ', 'DEPTO':'DESCRIPCION' )
       $depto := 'DEPTO':'CLAVE' + '  ' + 'DEPTO':'DESCRIPCION'
     FIN_SI
   SI_NO
     SI ( TRAE_REGISTRO( 'CENTROC', 'EMPPRIN':'DEP_CLAVE' ) )
       IMP ( COL(60), 'CENTROC':'CLAVE', '  ', 'CENTROC':'DESCRIPCION' )
       $depto := 'CENTROC':'CLAVE' + '  ' + 'CENTROC':'DESCRIPCION'
     FIN_SI
   FIN_SI
   IMPRIME
   SI ( $salida = 'EXCEL' )
     EXCEL( 'PON_VALOR', 1, _ren_excel, 'EMPPRIN':'CLAVE' )
     EXCEL( 'PON_VALOR', 2, _ren_excel, 'EMPPRIN':'NOMBRE' )
     EXCEL( 'PON_VALOR', 3, _ren_excel, $depto )
     _ren_excel := _ren_excel + 1
   FIN_SI
FIN_SUB_RUTINA

INCLUYE UTIL2.DAT

_incluir_dep := 1
lee_parametros_seleccion
lee_parametros_indices

SI ( $salida = 'EXCEL' )
  EXCEL( 'PON_VALOR', 1, _ren_excel, 'CLAVE' )
  EXCEL( 'PON_VALOR', 2, _ren_excel, 'NOMBRE' )
  EXCEL( 'PON_VALOR', 3, _ren_excel, 'DEPARTAMENTO' )
  _ren_excel := _ren_excel + 1
FIN_SI

base_trabajadores
USA_ARCHIVO( 'EMPPRIN', 'EMPCOME', 'CLAVE' )

PRIMER_REGISTRO ( 'EMPPRIN' )
MIENTRAS ( FIN_BASE ( 'EMPPRIN' ) = FALSO )
  SI ( ES_VIGENTE( _fecha) )
    SI ( TRAE_REGISTRO( 'EMPCOME', 'EMPPRIN':'CLAVE', _fecha ) = FALSO )
      datos_trabajador
    FIN_SI
  FIN_SI
  SIGUIENTE_REGISTRO ( 'EMPPRIN' )
FIN_MIENTRAS

termina_reporte
