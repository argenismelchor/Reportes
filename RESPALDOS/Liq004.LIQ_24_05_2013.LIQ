#DISTRIBUCION DE CUOTAS INFONAVIT
#VERSION 2.500
#DESCRIPCION
#Este Reporte cálcula la distribución de cuotas de infonavit para la nueva ley del seguro social vigente del 1 julio del 97.
#Este reporte muestra todos los trabajadores de la empresa que hayan cotizado para el mes a calcular.
#Este reporte imprime de los trabajadores la Afiliacion, Nombre, RFC, Clave. De la liquidación imprime las cuotas correspondientes al infonavit.
#Este reporte pide el mes y el año a calcular, pide ademas los parametros estandares pero es necesario que especifique un registro patronal a calcular.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL  ( 'SALIDA' , 'PANTALLA/IMPRESORA/DISCO' , $salida )
NUEVO_PARAMETRO_FEC  ( 'FECHA INICIAL' , '' , _fi ) 
NUEVO_PARAMETRO_FEC  ( 'FECHA FINAL' , '' , _ff )
NUEVO_PARAMETRO_CHEQ ( 'SOLO TOTALES' , '' , _solo_tot )
LEE_PARAMETROS
BORRA_PARAMETROS

_lv := 0

ENCABEZADO
   FORMATO_FECHA := 3
   LETRA ( 'LETRA CONDENSADA' )
   IMPRIME
   _lv := LONGITUD ( VERSION_GIRO )
   IMP ( COL (1) , NOMBRE_REPORTE , COL (COLUMNAS - _lv) , VERSION_GIRO ) ;; IMPRIME
   IMP ( COL (1) , CLAVE_REPORTE , CENTRA ('EMPRESA':'NOMBRE' ) ) ;; IMPRIME
   IMP ( CENTRA ( 'Del ' + FECHA ( _fi ) + ' al ' + FECHA ( _ff ) ) ) ;; IMPRIME
   IMP ( REPITETXT ( '=' , 90 ) ) ;; IMPRIME
   IMP ( COL (3) , 'No. IMSS' , COL (25) , 'Nombre' , COL (70) , 'RFC' ) ;; IMPRIME
   IMP ( COL (3) , 'MOV' , COL (8) , 'Fecha' , COL (20) , 'Dias' , COL (30) , DER ( 'S.D.I.' , 10 ) , COL (45), 'Falt' , COL (55) , 'Incap' ) ;; IMPRIME
   IMP ( COL (1) , DER ( 'RETIRO' , 15 ) , COL (16) , DER ( 'Ces/V P.' , 15 ) , COL (31) , DER ( 'Ces/V O.' , 15 ) , COL (46) , DER ( 'INFONAVIT' , 15 ) , COL (65) , DER ( 'TOTAL' , 15 ) ) ;; IMPRIME
   IMP ( REPITETXT ( '-' , 90 ) ) ;; IMPRIME
   IMPRIME
FIN_ENCABEZADO

PIE
   FORMATO_FECHA := 3
   IMPRIME
   DECIMALES := 0
   IMP ( COL (1) , 'Fecha : ' , FECHA (FECHA_HOY) , '    ' , 'Hora : ', HORA (HORA_ACTUAL) , COL (75) , 'PAGINA : ' , PAGINA ) ;; IMPRIME
   IMPRIME
   DECIMALES := 2
FIN_PIE 

VAR_T ( &indices )

_omitir_total_general := 1

INCLUYE LIQ_INI.CIC

FORMATO_FECHA := 3
FORMATO_PESOS := 2
RENGLONES     := 65
COLUMNAS      := 90

SI ( IMPRESION_DIRECTA = FALSO )
  TAMAÑO_HOJA ( 2700, 2300 )
SI_NO
  COLUMNAS := 90
FIN_SI

#Variables Globales
VAR_T ( &totales )
$tipo    := ''
$indice  := ''
_cont    := 0
_tot_pat := 0
_tot_obr := 0
_fbaja   := 0
_num_ind := 0

#Subrutina diversas

SUB_RUTINA parametros
  #
FIN_SUB_RUTINA

SUB_RUTINA sumatoria
   #Incremeto de valores para los indices seleccionados
   DECIMALES := 2
   _num_ind := 0
   REPITE
     INCREMENTA_TABLA( &totales, 'RETIRO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _retiro )
     INCREMENTA_TABLA( &totales, 'CESANTIA_P', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _cv_p )
     INCREMENTA_TABLA( &totales, 'CESANTIA_O', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _cv_e )
     INCREMENTA_TABLA( &totales, 'INFONAVIT', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _info )
     INCREMENTA_TABLA( &totales, 'TOTAL_INFO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _tot_infonavit )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
    SI ( _primera=0 )
      SI ( _solo_tot = 0 )
         IMP ( '*' , COL (3) , FORMATO ( 'EMPPRIN':'AFILIACION' , 'XX XX XX XXXX X' ) , COL (25) , SUBSTR ( 'EMPPRIN':'NOMBRE' , 1 , 33 ) , COL (60) , FORMATO ( 'EMPPRIN':'RFC', 'XXXX-XXXXXX-XXX' ) , COL (80) , 'EMPPRIN':'CLAVE' ) ;; IMPRIME
      FIN_SI
      _primera:=1
    FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
    calcula_periodo
    imprime_nombre
    FORMATO_FECHA := 3
    SI (( 'EMPSDO':'FECHA' >= _fi ) AND ( 'EMPSDO':'FECHA'<=_ff ))
        DECIMALES:=0
        IMP ( COL (3) , 'EMPSDO':'TIPO' , COL (8) , FECHA ('EMPSDO':'FECHA') )
    FIN_SI
    DECIMALES:=0
    IMP ( COL(20), _dias_ta ) 
    DECIMALES:=2
    IMP ( COL(30), DER($(_sueldo_mj_15),10)  )
    DECIMALES:=0 
    IMP ( COL(45), _no_faltas, COL(55), _no_incap ) 
    IMPRIME
    DECIMALES:=2
    IMP ( COL(1), DER($(_retiro),15)  ) 
    IMP ( COL(16), DER($(_cv_p), 15)  )
    IMP ( COL(31), DER($(_cv_e), 15)  )
    IMP ( COL(46), DER($(_info), 15)  )
    IMP ( COL(65), DER($(_tot_infonavit),15)  ) 
    IMPRIME
    sumatoria
    SIGUIENTE_REGISTRO('EMPSDO')
    SI (('EMPSDO':'FECHA'=_ffinal) and ('EMPSDO':'TIPO'='B'))
      SI (TRAE_REGISTRO('BAJA','EMPSDO':'CAUSA BAJA'))
        DECIMALES:=0
        IMP ( COL(3), 'EMPSDO':'TIPO', COL(8), FECHA( 'EMPSDO':'FECHA' ) , '  ( ' , 'BAJA':'DESCRIPCION' , ' ) ' ) ;; IMPRIME
      FIN_SI
    FIN_SI
    SI ( _no_incap>0 )
      PRIMER_REGISTRO('EMPINC')
      MIENTRAS(FIN_BASE('EMPINC')=FALSO)
        SI (('EMPINC':'FECHA'>=_fi) AND ('EMPINC':'FECHA'<=_ff))
          DECIMALES:=0
          IMP ( COL(10), 'Incapacidad', COL(25), 'EMPINC':'NUMERO', COL(40), 'EMPINC':'DURACION' ) ;; IMPRIME
        FIN_SI
        SIGUIENTE_REGISTRO('EMPINC') 
      FIN_MIENTRAS
    FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA sub_totales
  IMPRIME
  IMP ( '*****  SUBTOTALES ', $indice ) ;; IMPRIME
  $tipo := $indice
  DECIMALES:=2
  IMP ( COL(1), DER($(VALOR_TABLA(&totales, 'RETIRO', $tipo)),15) ) 
  IMP ( COL(16), DER($(VALOR_TABLA(&totales, 'CESANTIA_P', $tipo)),15) )
  IMP ( COL(31), DER($(VALOR_TABLA(&totales, 'CESANTIA_O', $tipo)),15) )
  IMP ( COL(46), DER($(VALOR_TABLA(&totales, 'INFONAVIT', $tipo)),15) )
  IMP ( COL(65), DER($(VALOR_TABLA(&totales, 'TOTAL_INFO', $tipo)),15) )
  IMPRIME
  #_tot_pat := VALOR_TABLA(&totales, 'CESANTIA_P', $tipo)
  #_tot_obr := VALOR_TABLA(&totales, 'RETIRO', $tipo) + VALOR_TABLA(&totales, 'CESANTIA_O', $tipo) + VALOR_TABLA(&totales, 'INFONAVIT', $tipo)
  #IMP ( COL(112), DER($(_tot_pat + _tot_obr),8) )
  #IMPRIME
  #Pone en cero los contadores
  ASIGNA_VALOR_TABLA( &totales, 'RETIRO', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'CESANTIA_P', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'CESANTIA_O', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'INFONAVIT', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'TOTAL_INFO', $tipo, 0 )
FIN_SUB_RUTINA

INCLUYE LIQ_FIN.CIC

$indice := 'TOTAL'
sub_totales

DECIMALES:=0
IMPRIME ;; IMPRIME
IMP ( '*****  TOTALES GENERALES' ) ;; IMPRIME
IMPRIME
IMP ( ' * Trabajadores       : ', COL(30), DER( _trab, 15) ) ;; IMPRIME
IMP ( ' * Faltas             : ', COL(30), DER( _total_faltas, 15) ) ;; IMPRIME
IMP ( ' * Incap              : ', COL(30),  DER(  _total_incap, 15) ) ;; IMPRIME
IMP ( ' * Dias E.G.          : ', COL(30),  DER( _total_dias_ti, 15) ) ;; IMPRIME
IMP ( ' * Dias IVCM          : ', COL(30), DER( _total_dias_ta, 15) ) ;; IMPRIME
DECIMALES:=2
IMP ( ' * Base Retiro        : ', COL(30),  DER( $( _total_base_sar), 15) ) ;; IMPRIME
IMP ( ' * Base Cesantia y V. : ', COL(30),  DER( $( _total_base_iv), 15) ) ;; IMPRIME
IMP ( ' * Base Infonavit     : ', COL(30),  DER( $( _total_base_info1), 15) ) ;; IMPRIME
IMP ( COL(30), REPITETXT ( '-' , 16 ) ) ;; IMPRIME
IMP ( '<<< TOTAL A PAGAR INFONAVIT>>> :',  COL(30), DER($(_total_infonavit),15) ) ;; IMPRIME
TERMINA_REPORTE
