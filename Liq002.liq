#CALCULO LIQUIDACION INFONAVIT
#NO EDITAR
#USUARIO =*
#VERSION 2.500
#DESCRIPCION
#Este Reporte cálcula la liquidación de infonavit para la nueva ley del seguro social vigente del 1 julio del 97.
#Este reporte muestra todos los trabajadores de la empresa que hayan cotizado para el bimestre a calcular.
#Este reporte imprime de los trabajadores la Afiliacion, Nombre, RFC, Clave. De la liquidación imprime las cuotas correspondientes al infonavit.
#Este reporte pide el mes y el año a calcular, pide ademas los parametros estandares pero es necesario que especifique un registro patronal a calcular.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION

FORMATO_FECHA := 6
$fech_act := FECHA (FECHA_HOY)
$mes_act  := SUBSTR ( $fech_act , 3 , 2 )
$ano_act  := SUBSTR ( $fech_act , 5 , 4 )
_mes      := VALOR ( $mes_act )
_mes      := TRUNCAR ( ( _mes - 1 ) / 2 ) + 1
$mes_act  := .( _mes )
$mes_act  := SUBSTR ( $mes_act , 1 , 1 )
NUEVO_PARAMETRO_SAL ( 'SALIDA' , 'PANTALLA/IMPRESORA/DISCO' , $salida )
NUEVO_PARAMETRO ( 'AÑO' , $ano_act , _ano )
NUEVO_PARAMETRO ( 'BIMESTRE' , $mes_act , _mes ) 
NUEVO_PARAMETRO_CHEQ ( 'ALMACENAR TOTALES' , '' , _acum_tot )
LEE_PARAMETROS
BORRA_PARAMETROS

_fi := 0
_ff := 0
_lv := 0

ENCABEZADO
   FORMATO_FECHA := 3
   LETRA ( 'LETRA CONDENSADA' )
   IMPRIME
   _lv := LONGITUD ( VERSION_GIRO )
   IMP ( COL (1) , NOMBRE_REPORTE , COL (COLUMNAS - _lv) , VERSION_GIRO ) ;; IMPRIME
   IMP ( COL (1) , CLAVE_REPORTE , CENTRA ('EMPRESA':'NOMBRE') ) ;; IMPRIME
   IMP ( CENTRA ('LIQUIDACION BIMESTRAL INFONAVIT') ) ;; IMPRIME
   IMP ( CENTRA ( 'DEL ' + FECHA ( _fi ) + ' AL ' + FECHA ( _ff ) ) ) ;; IMPRIME
   IMP ( REPITETXT ( '=' , 90 ) ) ;; IMPRIME
   IMP ( COL (3) , 'No. IMSS' , COL (25) , 'Nombre' , COL (60) , 'RFC' , COL (80) , 'Clave' ) ;; IMPRIME
   IMP ( COL (3) , 'MOV' , COL (8) , 'Fecha' , COL (20) , 'Dias' , COL (30) , DER ( 'S.D.I.' , 10 ) , COL (45) , 'Falt' , COL (55) , 'Incap' ) ;; IMPRIME
   IMP ( COL (5) , DER ( 'RETIRO' , 15 ) , COL (20) , DER ( 'Ces/Vej' , 15 ) , COL (35) , DER ( 'INFO' , 15 ) , COL (50) , DER ( 'CREDITO INF' , 15 ) , COL (75),  DER ( 'TOTAL' , 15 ) ) ;; IMPRIME
   IMP ( REPITETXT ( '-' , 90 ) ) ;; IMPRIME
   IMPRIME
FIN_ENCABEZADO

PIE
   FORMATO_FECHA := 3
   IMPRIME
   DECIMALES := 0
   IMP ( COL (1) , 'Fecha : ' , FECHA (FECHA_HOY) , '    ' , 'Hora : ' , HORA (HORA_ACTUAL) , COL (75) , 'PAGINA : ' , PAGINA ) ;; IMPRIME
   IMPRIME
   DECIMALES := 2
FIN_PIE 

VAR_T ( &indices )

INCLUYE LIQ_INI.CIC

FORMATO_FECHA := 3
FORMATO_PESOS := 2
RENGLONES     := 65
COLUMNAS      := 90

_omitir_total_general := 1

#Variables Globales
VAR_T ( &totales )
$tipo         := ''
$indice       := ''
$indice_valor := ''
_cont         := 0
_bimestral    := 1
_fbaja        := 0
_num_ind      := 0

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
     INCREMENTA_TABLA( &totales, 'CESANTIA', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _cv )
     INCREMENTA_TABLA( &totales, 'INFONAVIT', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _info )
     INCREMENTA_TABLA( &totales, 'TOTAL_INFO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _tot_infonavit )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
    SI ( _primera=0 )
       IMP ( '*' , COL (3) , FORMATO ( 'EMPPRIN':'AFILIACION' , 'XX XX XX XXXX X' ) , COL (25) , SUBSTR ( 'EMPPRIN':'NOMBRE' , 1 , 33 ) , COL (60) , FORMATO ( 'EMPPRIN':'RFC' , 'XXXX-XXXXXX-XXX' ) , COL (80) , 'EMPPRIN':'CLAVE' ) ;; IMPRIME
       _primera:=1
    FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
    calcula_periodo
    imprime_nombre
    FORMATO_FECHA := 3
    SI (( 'EMPSDO':'TIPO' <> 'B' ) AND ( 'EMPSDO':'FECHA' >= _fi ) AND ( 'EMPSDO':'FECHA' <= _ff ))
        DECIMALES := 0
        IMP ( COL (3) , 'EMPSDO':'TIPO' , COL (8) ,  FECHA ('EMPSDO':'FECHA') )
    FIN_SI
    DECIMALES:=0
    IMP ( COL(20), _dias_ta ) 
    DECIMALES:=2
    IMP ( COL(30), DER($(_sueldo_mj_25),10)  )
    DECIMALES:=0 
    IMP ( COL(45), _no_faltas, COL(55), _no_incap ) 
    IMPRIME
    DECIMALES:=2
    IMP ( COL(5) , DER($(_retiro),15) )
    IMP ( COL(20), DER($(_cv),15) )
    IMP ( COL(35), DER($(_info),15) )
    SI ( _credito > 0 )
       IMP ( COL(50), DER($(_credito), 15 ))
    FIN_SI
    IMP ( COL(75), DER($(_tot_infonavit),15)  )
    IMPRIME
    sumatoria
    SIGUIENTE_REGISTRO('EMPSDO')
    SI ('EMPSDO':'TIPO'='B')
      SI (TRAE_REGISTRO('BAJA','EMPSDO':'CAUSA BAJA'))
        DECIMALES:=0
        SI ( 'EMPSDO':'BAJA IMSS' >= 'EMPSDO':'FECHA' + 7 )
          _fbaja := 'EMPSDO':'BAJA IMSS'
        SI_NO
          _fbaja := 'EMPSDO':'FECHA'
        FIN_SI 
        IMP ( COL (3) , 'EMPSDO':'TIPO' , COL (8) , FECHA ( _fbaja ) , '  ( ' , 'BAJA':'DESCRIPCION' , ' )' ) ;; IMPRIME
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
  IMP ( '*****  SubTotales ' , $indice ) ;; IMPRIME
  $tipo := $indice
  DECIMALES:=2
  IMP ( COL(5), DER($(VALOR_TABLA(&totales, 'RETIRO', $tipo)),15) ) 
  IMP ( COL(20), DER($(VALOR_TABLA(&totales, 'CESANTIA', $tipo)),15) )
  IMP ( COL(35), DER($(VALOR_TABLA(&totales, 'INFONAVIT', $tipo)),15) )
  IMP ( COL(75), DER($(VALOR_TABLA(&totales, 'TOTAL_INFO', $tipo)),15) )
  IMPRIME
  ASIGNA_VALOR_TABLA( &totales, 'RETIRO', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'CESANTIA', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'INFONAVIT', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'TOTAL_INFO', $tipo, 0 )

  SI ( $indice = 'REGISTRO PATRONAL' )
    SI ( _acum_tot = 1)
      ABRE_BASE( 'IMSS' )
      SI (TRAE_REGISTRO('IMSS', $ano_act, $mes_act, $indice_valor ))
        'IMSS':'BASE RETIRO' := _total_base_sar
        'IMSS':'BASE CV' := _total_base_iv
        'IMSS':'BASE INFONAVIT' := _total_base_info1
        'IMSS':'TOTAL INFONAVIT' := _total_infonavit
        GRABA_BASE( 'IMSS' )
      SI_NO
        AGREGA_REGISTRO( 'IMSS' )
        'IMSS':'AÑO' := _ano
        'IMSS':'MES' := _mes
        'IMSS':'REGISTRO' := $indice_valor
        'IMSS':'BASE RETIRO' := _total_base_sar
        'IMSS':'BASE CV' := _total_base_iv
        'IMSS':'BASE INFONAVIT' := _total_base_info1
        'IMSS':'TOTAL INFONAVIT' := _total_infonavit
        GRABA_BASE( 'IMSS' )
      FIN_SI
      CIERRA_BASE( 'IMSS' )
    FIN_SI
  FIN_SI
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
