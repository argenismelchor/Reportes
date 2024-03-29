#CORTES PARCIALES COMEDOR
#VERSION 2.500
#USUARIO =*
#NO EDITAR
#DESCRIPCION
#Este reporte muestra el corte parcial del comedor.
#Este reporte imprime de los trabajadores la clave, nombre, departamento, puesto y sucursal, de los sueldos permite imprimir los 5 sueldos.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de N�mina.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA/DISCO', $salida )
NUEVO_PARAMETRO_FEC ( 'FECHA INICIAL', '', _fi) 
NUEVO_PARAMETRO_FEC ( 'FECHA FINAL', '', _ff)
NUEVO_PARAMETRO_SEL ( 'LISTADO X', 'EMPLEADO/FECHA', _tipo_listado  )
NUEVO_PARAMETRO_CHEQ( 'DETALLADO', '', _imp_tot )
#NUEVO_PARAMETRO_CHEQ( 'CONSOLIDAR EMPRESAS', '', _consolidar )
LEE_PARAMETROS

_consolidar := 0

SI ( _imp_tot = 0 )
  _imp_tot := 1
SI_NO
  _imp_tot := 0
FIN_SI

BORRA_PARAMETROS

SI ( _imp_tot = 0 )
  ENCABEZADO   
     IMPRIME 
     LETRA ( 'LETRA ENFATISADA' )
     IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL (60), VERSION_GIRO );; IMPRIME
     IMP ( CENTRA ('EMPRESA':'NOMBRE' ));; IMPRIME
     IMP ( CENTRA ('CORTE PARCIAL DEL '+ FECHA (_fi)+ ' AL ' + FECHA (_ff) ) ) ;; IMPRIME
     IMP ( REPITETXT('=',80));; IMPRIME
     IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(50), 'FECHA', COL(65), DER( 'COSTO', 8) );; IMPRIME
     IMP ( REPITETXT('-',80) );; IMPRIME
     LETRA ( 'LETRA NORMAL' )
     IMPRIME 
  FIN_ENCABEZADO
  PIE
     IMPRIME
     DECIMALES := 0
     LETRA ( 'LETRA ENFATISADA' )
     IMP ( COL(2), 'Fecha : ', FECHA (FECHA_HOY), ' ', 'Hora : ', HORA (HORA_ACTUAL), COL(65), 'PAGINA -', PAGINA, '-' );; IMPRIME
     LETRA ( 'LETRA NORMAL' );; IMPRIME
     DECIMALES := 2
  FIN_PIE 
FIN_SI

FORMATO_FECHA := 2
FORMATO_PESOS := 2
SI ( _imp_tot = 1 )
  MODO_IMPRESION( 'DIRECTO' )
  COLUMNAS := 40
  LETRA ( 'LETRA ENFATISADA' )
  IMP ( REPITETXT('=',COLUMNAS));; IMPRIME  
  IMP ( CENTRA ('EMPRESA':'NOMBRE' ));; IMPRIME
  IMP ( CENTRA ('CORTE DE CAJA' ));; IMPRIME
  IMP ( CENTRA ('DEL ' + FECHA( _fi ) + ' AL ' + FECHA ( _ff ) ));; IMPRIME
  IMP ( REPITETXT('-',COLUMNAS));; IMPRIME  
  LETRA ( 'LETRA NORMAL' )
FIN_SI

#Variables Globales
VAR_T( &sql )
_aux1 := 0
$aux1 := ''
$ant_emp := ''
_ant_fec := 0
_tot_com := 0
_num_com := 0
_total_comedor   := 0
_comidas_comedor := 0
_comidas_extras  := 0
_tot_extras := 0
_tot_menus  := 0
_tot_esp    := 0
_fci        := 0
_fcf        := 0
$empresa    := ''
_primero    := 0

#Subrutina diversas

SUB_RUTINA tabla_extras
  LIMPIA_TABLA( &sql )
  AGREGA_VALOR_COL( &sql, 0, 'SELECT *' )
  AGREGA_VALOR_COL( &sql, 0, 'FROM "' + DIRECTORIO_PROGRAMAS + '\USUEXT" U, EMPCOME C' )
  AGREGA_VALOR_COL( &sql, 0, 'WHERE C. CLAVE = U. CLAVE AND C. FECHA >= :FI AND C. FECHA <= :FF' )
  CREA_CONSULTA( 'USUEXT', &sql )
  PARAMETRO_SQL( 'USUEXT', 'FI', _fci )
  PARAMETRO_SQL( 'USUEXT', 'FF', _fcf )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
  SI ( _imp_tot = 0 )
    IMPRIME
    IMP ( COL(1), 'EMPPRIN':'CLAVE', COL(10), 'EMPPRIN':'NOMBRE' )  
  FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA imprime_fecha
  SI ( _imp_tot = 0 )
    IMPRIME
    FORMATO_FECHA := 5
    IMP ( COL(1), '* FECHA : ', FECHA( 'EMPPRIN':'FECHA' ) )  
  FIN_SI
  $ant_emp := ''
FIN_SUB_RUTINA

SUB_RUTINA subtotales_comida
  SI ( _primero = 0 )
    SI ((( _tipo_listado = 0 ) AND ( $ant_emp <> '' )) OR (( _tipo_listado = 1 ) AND ( _ant_fec <> 0 )))
      SI ( _imp_tot = 0 )
        IMP ( COL(65), '________'  )
        IMPRIME
        DECIMALES := 0
        IMP ( COL(30), 'TOTAL COMIDAS : ', DER( $( _num_com ), 3) )
        DECIMALES := 2
        IMP ( COL(55), 'TOTAL : ', DER( $( _tot_com ), 10)  )
        IMPRIME
      FIN_SI
      _num_com := 0
      _tot_com := 0
    FIN_SI
  FIN_SI
    _primero := 0
FIN_SUB_RUTINA

SUB_RUTINA checa_extras
  SI (( _ant_fec <> 0 ) AND ( _primero = 0 ))
    SI ( _imp_tot = 0 )
      IMPRIME
      IMP ( 'CREDENCIALES EXTRAS' ) ;; IMPRIME
    FIN_SI
    tabla_extras
    
    PRIMER_REGISTRO( 'USUEXT' )
    MIENTRAS ( FIN_BASE( 'USUEXT' ) = FALSO )
      SI ( _imp_tot = 0 )
        IMP ( 'USUEXT':'CLAVE', COL(10), 'USUEXT':'DESCRIPCION', COL(50), FECHA('USUEXT':'FECHA'), COL(65), DER( $('USUEXT':'COSTO'), 8) ) ;; IMPRIME
      FIN_SI
      _tot_com := _tot_com + 'USUEXT':'COSTO'
      _num_com := _num_com + 1
      _total_comedor := _total_comedor + 'USUEXT':'COSTO'
      _comidas_comedor := _comidas_comedor + 1
      _tot_extras := _tot_extras + 'USUEXT':'COSTO'
      _comidas_extras := _comidas_extras + 1
      SIGUIENTE_REGISTRO( 'USUEXT' )
    FIN_MIENTRAS
  FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
  SI (( _tipo_listado = 1 ) AND ( _ant_fec <> 'EMPPRIN':'FECHA' ) )
    _fci := _ant_fec
    _fcf := _ant_fec
    subtotales_comida
    checa_extras
    subtotales_comida
    imprime_fecha
    _ant_fec := 'EMPPRIN':'FECHA'
  FIN_SI
  SI ( $ant_emp <> 'EMPPRIN':'CLAVE' )
    SI ( _tipo_listado = 0 )
      subtotales_comida
    FIN_SI
    imprime_nombre
    $ant_emp := 'EMPPRIN':'CLAVE'
  FIN_SI
  FORMATO_FECHA := 3
  SI ( _imp_tot = 0 )
    DECIMALES := 2
    IMP ( COL(50), FECHA('EMPPRIN':'FECHA'), COL(65), DER( $('EMPPRIN':'COSTO'), 8 ) )
    IMPRIME
  FIN_SI
  _tot_com := _tot_com + 'EMPPRIN':'COSTO'
  _num_com := _num_com + 1
  _total_comedor := _total_comedor + 'EMPPRIN':'COSTO'
  _comidas_comedor := _comidas_comedor + 1
  SI ( 'EMPPRIN':'TIPO' = 0 )
    _tot_menus := _tot_menus + 'EMPPRIN':'COSTO'
  SI_NO
    _tot_esp := _tot_esp + 'EMPPRIN':'COSTO'
  FIN_SI
FIN_SUB_RUTINA

INCLUYE UTIL2.DAT

SI ( _imp_tot = 1 )
  _omitir_total_general := 1
FIN_SI
_incluir_suc := 1
_incluir_dep := 1
_incluir_pue := 1
lee_parametros_seleccion
lee_parametros_indices

#Definicion de variables en base a los parametros
SALIDA := $salida

_num_emp := 0
SI ( _consolidar = 0 )
  $empresa := 'EMPRESA':'CLAVE'
SI_NO
  DECIMALES := 0
  _num_emp := 1
  $empresa := LEE_INI( 'EMPRESAS_COMEDOR', 'EMPRESA_' + .( _num_emp ), '' )
FIN_SI

REPITE
  SI ( _consolidar = 1 )
    SI ( TRAE_REGISTRO( 'EMPRESA', $empresa ) = FALSO )
      MENSAJE( 'LA EMPRESA ' + $empresa + ' NO EXISTE..' )
      TERMINA_REPORTE
    FIN_SI
  FIN_SI
  CAMBIA_BASE( 'EMPRESA':'PATH TRABAJO' )
  SI ( _imp_tot = 0 )
    IMP ( 'EMPRESA : ' + 'EMPRESA':'NOMBRE' ) ;; IMPRIME
  FIN_SI
  $campos_extras := 'C. CLAVE, C. FECHA, C. HORA, C. COSTO, C. TIPO'
  $bases_extras  := 'EMPCOME C'
  $condiciones_extras := 'C. CLAVE = E. CLAVE AND C. FECHA >= :FI AND C. FECHA <= :FF'
  SI ( _tipo_listado = 1 )
    $ordenes_extras := 'C. FECHA'
  FIN_SI
  base_trabajadores
  PARAMETRO_SQL( 'EMPPRIN', 'FI', _fi )
  PARAMETRO_SQL( 'EMPPRIN', 'FF', _ff )
  _primero := 1
  SI ( _tipo_listado = 1 )
    _ant_fec := 0
  FIN_SI
  
  MIENTRAS ( FIN_BASE ( 'EMPPRIN' ) = FALSO )
     datos_trabajador
     SIGUIENTE_REGISTRO ( 'EMPPRIN' )
  FIN_MIENTRAS
  subtotales_comida
  SI ( 0 = 0 )
    _fci := _fi
    _fcf := _ff
    _ant_fec := FECHA_HOY  
    checa_extras 
    SI ( _imp_tot = 0 )
      IMP ( COL(65), '________'  )
      IMPRIME
      DECIMALES := 0
      IMP ( COL(30), 'TOTAL COMIDAS : ', DER( $( _comidas_extras ), 3) )
      DECIMALES := 2
      IMP ( COL(55), 'TOTAL : ', DER( $( _tot_extras ), 10)  )
      IMPRIME
    FIN_SI
  FIN_SI
  DECIMALES := 0
  _num_emp := _num_emp + 1
  $empresa := LEE_INI( 'EMPRESAS_COMEDOR', 'EMPRESA_' + .( _num_emp ), '' )  
  SI (( _consolidar = 1 ) AND ( _imp_tot = 0 ))
    AVANZA_HOJA
  FIN_SI
HASTA(( $empresa = '' ) OR ( _consolidar = 0 ))
termina_reporte

IMPRIME ;; IMPRIME
IMP ( 'FECHA HOY     : ', FECHA( FECHA_HOY ) ) ;; IMPRIME
IMP ( 'HORA ACTUAL   : ', HORA( HORA_ACTUAL ) ) ;; IMPRIME
IMPRIME ;; IMPRIME
LETRA ( 'LETRA ENFATISADA' )
IMP ( 'TOTALES GENERALES ' ) ;; IMPRIME
LETRA ( 'LETRA NORMAL' )
DECIMALES := 0
IMP ( 'COMIDAS NORMALES     : ', DER( $( _comidas_comedor - _comidas_extras ), 12 ) ) ;; IMPRIME
IMP ( 'COMIDAS EXTRAS       : ', DER( $( _comidas_extras ), 12 ) ) ;; IMPRIME
IMP ( COL(26), '__________' ) ;; IMPRIME
IMP ( 'NUMERO DE COMIDAS    : ', DER( $( _comidas_comedor ), 12 ) ) ;; IMPRIME
IMPRIME
DECIMALES := 2
IMP ( 'TOTAL DE MENUS       : ', DER( $( _tot_menus ), 12 ) ) ;; IMPRIME
IMP ( 'TOTAL DE ESPECIALES  : ', DER( $( _tot_esp ), 12 ) ) ;; IMPRIME
IMP ( 'TOTAL DE EXTRAS      : ', DER( $( _tot_extras ), 12 ) ) ;; IMPRIME
IMP ( COL(26), '__________' ) ;; IMPRIME
IMP ( 'TOTAL DE COMIDAS     : ', DER( $( _total_comedor ), 12 ) ) ;; IMPRIME
SI ( _imp_tot = 1 )
  IMPRIME ;; IMPRIME ;; IMPRIME ;; IMPRIME
  IMP ( CENTRA( '_______________________' ) ) ;; IMPRIME
  IMP ( CENTRA( 'FIRMA SUPERVISOR' ) ) ;; IMPRIME
FIN_SI
TERMINA_REPORTE

