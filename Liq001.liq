#CALCULO LIQUIDACION IMSS
#VERSION 2.500
#USUARIO =*
#NO EDITAR
#DESCRIPCION
#Este Reporte cálcula la liquidación de imss para la nueva ley del seguro social vigente del 1 julio del 97.
#Este reporte muestra todos los trabajadores de la empresa que hayan cotizado para el mes a calcular.
#Este reporte imprime de los trabajadores la Afiliacion, Nombre, RFC, Clave. De la liquidación imprime las cuotas correspondientes al IMSS.
#Este reporte pide el mes y el año a calcular, pide ademas los parametros estandares pero es necesario que especifique un registro patronal a calcular.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION

FORMATO_FECHA := 6
$fech_act := FECHA (FECHA_HOY)
$mes_act  := SUBSTR ( $fech_act , 3 , 2 )
$ano_act  := SUBSTR ( $fech_act , 5 , 4 )
NUEVO_PARAMETRO_SAL ( 'SALIDA' , 'PANTALLA/IMPRESORA/DISCO' , $salida )
NUEVO_PARAMETRO ( 'AÑO' , $ano_act , _ano ) 
NUEVO_PARAMETRO ( 'MES' , $mes_act , _mes ) 
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
   IMP ( COL (1) , CLAVE_REPORTE , CENTRA ('EMPRESA':'NOMBRE' ) ) ;; IMPRIME
   IMP ( CENTRA ('LIQUIDACION MENSUAL IMSS'));; IMPRIME
   IMP ( CENTRA ( 'DEL ' + FECHA ( _fi ) + ' AL ' + FECHA ( _ff ) ) ) ;; IMPRIME
   IMP ( REPITETXT ( '=' , 110 ) ) ;; IMPRIME
   IMP ( COL (3)  , 'No. IMSS' , COL (25) , 'Nombre' , COL (80) , 'RFC' , COL (100) , 'Clave' ) ;; IMPRIME
   IMP ( COL (3)  , 'MOV' , COL (8) , 'Fecha' , COL (20) , 'Dias' , COL (30) , DER ( 'S.D.I.' , 10 ) , COL (45) , 'Falt' , COL (55) , 'Incap' ) ;; IMPRIME
   IMP ( COL (5)  , DER ( 'FIJA' , 13 ) , COL (18) , DER ( 'Ex.3SDF' , 13 ) , COL (31) , DER ( 'DINERO' , 13 ) , COL (44) , DER ( 'ESPECIE' , 13 ) )
   IMP ( COL (57) , DER ( 'RT' , 13 ) , COL (70) , DER ( 'Inv Vida' , 13 ) , COL (83) , DER ( 'GUARD' , 13 ) , COL (96) , DER ( 'TOTAL' , 13 ) ) ;; IMPRIME
   IMP ( REPITETXT( '-' , 110 ) ) ;; IMPRIME
   IMPRIME
FIN_ENCABEZADO

PIE
   FORMATO_FECHA := 3
   IMPRIME
   DECIMALES := 0
   IMP ( COL (1) , 'Fecha : ' , FECHA (FECHA_HOY) , '    ' , 'Hora : ' , HORA (HORA_ACTUAL) , COL (95) , 'PAGINA : ' , PAGINA ) ;; IMPRIME
   IMPRIME
   DECIMALES := 2
FIN_PIE 

VAR_T ( &indices )

INCLUYE LIQ_INI.CIC

FORMATO_FECHA := 3
FORMATO_PESOS := 2
RENGLONES     := 65
COLUMNAS      := 110

#Variables Globales
VAR_T ( &totales )
$tipo:=''
_cont:=0
$indice := ''
_mensual := 1
$indice_valor := ''
_fbaja := 0
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
     INCREMENTA_TABLA( &totales, 'FIJA', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _fija )
     INCREMENTA_TABLA( &totales, 'EX_3S', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _ex_3m )
     INCREMENTA_TABLA( &totales, 'DINERO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _dinero )
     INCREMENTA_TABLA( &totales, 'ESPECIE', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _especie )
     INCREMENTA_TABLA( &totales, 'RT', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _rt )
     INCREMENTA_TABLA( &totales, 'IV', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _iv )
     INCREMENTA_TABLA( &totales, 'GUARDERIA', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _guarderia )
     INCREMENTA_TABLA( &totales, 'TOTAL_IMSS', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _tot_imss )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
    SI ( _primera = 0 )
       IMP ( '*' , COL (3) , FORMATO ( 'EMPPRIN':'AFILIACION' , 'XX XX XX XXXX X' ) , COL (25) , SUBSTR ( 'EMPPRIN':'NOMBRE' , 1 , 50 ) , COL (80) , FORMATO ( 'EMPPRIN':'RFC' , 'XXXX-XXXXXX-XXX' ) , COL (100) , 'EMPPRIN':'CLAVE' ) ;; IMPRIME
       _primera := 1
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
    LETRA ( 'LETRA CONDENSADA' )
    IMP ( COL(5), DER($(_fija),13) ) 
    IMP ( COL(18), DER($(_ex_3m),13) )
    IMP ( COL(31), DER($(_dinero),13) )
    IMP ( COL(44), DER($(_especie),13) )
    IMP ( COL(57), DER($(_rt),13) )
    IMP ( COL(70), DER($(_iv),13) ) 
    IMP ( COL(83), DER($(_guarderia),13) )
    IMP ( COL(96), DER($(_tot_imss),13) ) 
    IMPRIME
    sumatoria
    SIGUIENTE_REGISTRO('EMPSDO')
    SI ('EMPSDO':'TIPO' = 'B')
      SI (TRAE_REGISTRO('BAJA','EMPSDO':'CAUSA BAJA'))
        DECIMALES:=0
        SI ( 'EMPSDO':'BAJA IMSS' >= 'EMPSDO':'FECHA' + 7 )
          _fbaja := 'EMPSDO':'BAJA IMSS'
        SI_NO
          _fbaja := 'EMPSDO':'FECHA'
        FIN_SI 
        IMP ( COL(3), 'EMPSDO':'TIPO', COL(8) , FECHA ( _fbaja ) , '  ( ' , 'BAJA':'DESCRIPCION' , ' )' ) ;; IMPRIME
      FIN_SI
    FIN_SI
    SI ( _no_incap > 0 )
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
  IMP ( COL(5), DER($(VALOR_TABLA(&totales, 'FIJA', $tipo)),13) ) 
  IMP ( COL(18), DER($(VALOR_TABLA(&totales, 'EX_3S', $tipo)),13) )
  IMP ( COL(31), DER($(VALOR_TABLA(&totales, 'DINERO', $tipo)),13) )
  IMP ( COL(44), DER($(VALOR_TABLA(&totales, 'ESPECIE', $tipo)),13) )
  IMP ( COL(57), DER($(VALOR_TABLA(&totales, 'RT', $tipo)),13) )
  IMP ( COL(70), DER($(VALOR_TABLA(&totales, 'IV', $tipo)),13) ) 
  IMP ( COL(83), DER($(VALOR_TABLA(&totales, 'GUARDERIA', $tipo)),13) )
  IMP ( COL(96), DER($(VALOR_TABLA(&totales, 'TOTAL_IMSS', $tipo)),13) ) 
  IMPRIME
  ASIGNA_VALOR_TABLA( &totales, 'FIJA', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'EX_3S', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'DINERO', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'ESPECIE', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'RT', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'IV', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'GUARDERIA', $tipo, 0 )
  ASIGNA_VALOR_TABLA( &totales, 'TOTAL_IMSS', $tipo, 0 )

  SI ( $indice = 'REGISTRO PATRONAL' )
    SI ( _acum_tot = 1 )
      ABRE_BASE( 'IMSS' )
      SI (TRAE_REGISTRO('IMSS', $ano_act, $mes_act, $indice_valor ))
        'IMSS':'FALTAS' := _total_faltas
        'IMSS':'INCAPACIDADES' := _total_incap
        'IMSS':'DIAS EG' := _total_dias_ti
        'IMSS':'DIAS IV' := _total_dias_ta
        'IMSS':'BASE EG1' := _total_base_eym1
        'IMSS':'BASE EG2' := _total_base_eym2
        'IMSS':'BASE EG3' := _total_base_eym3
        'IMSS':'BASE RT' := _total_base_rt
        'IMSS':'BASE IV' := _total_base_iv
        'IMSS':'TOTAL IMSS' := _total_imss
        GRABA_BASE( 'IMSS' )
      SI_NO
        AGREGA_REGISTRO( 'IMSS' )
        'IMSS':'AÑO' := _ano
        'IMSS':'MES' := _mes
        'IMSS':'REGISTRO' := $indice_valor
        'IMSS':'FALTAS' := _total_faltas
        'IMSS':'INCAPACIDADES' := _total_incap
        'IMSS':'DIAS EG' := _total_dias_ti
        'IMSS':'DIAS IV' := _total_dias_ta
        'IMSS':'BASE EG1' := _total_base_eym1
        'IMSS':'BASE EG2' := _total_base_eym2
        'IMSS':'BASE EG3' := _total_base_eym3
        'IMSS':'BASE RT' := _total_base_rt
        'IMSS':'BASE IV' := _total_base_iv
        'IMSS':'TOTAL IMSS' := _total_imss
        GRABA_BASE( 'IMSS' )
      FIN_SI
      CIERRA_BASE( 'IMSS' )
    FIN_SI
  FIN_SI  
FIN_SUB_RUTINA

_omitir_total_general := 1
INCLUYE LIQ_FIN.CIC

$indice := 'TOTAL'
sub_totales

DECIMALES:=0
IMPRIME ;; IMPRIME
IMP ( '*****  TOTALES GENERALES' ) ;; IMPRIME
IMP ( ' * Trabajadores       : ', COL(30), DER( _trab, 15) ) ;; IMPRIME
IMP ( ' * Faltas             : ', COL(30), DER( _total_faltas, 15) ) ;; IMPRIME
IMP ( ' * Incap              : ', COL(30),  DER(  _total_incap, 15) ) ;; IMPRIME
IMP ( ' * Dias E.G.          : ', COL(30),  DER( _total_dias_ti, 15) ) ;; IMPRIME
IMP ( ' * Dias IV            : ', COL(30), DER( _total_dias_ta, 15) ) ;; IMPRIME
DECIMALES:=2
IMP ( ' * Base E.G. FRACC. I : ', COL(30),  DER( $( _total_base_eym1), 15) ) ;; IMPRIME
IMP ( ' * Base E.G. FRACC. II: ', COL(30),  DER( $( _total_base_eym2), 15) ) ;; IMPRIME
IMP ( ' * Base E.G. ART. 107 : ', COL(30),  DER( $( _total_base_eym3), 15) ) ;; IMPRIME
IMP ( ' * Base RT y Guarderia: ', COL(30),  DER( $( _total_base_rt), 15) ) ;; IMPRIME
IMP ( ' * Base IV            : ', COL(30),  DER( $( _total_base_iv), 15) ) ;; IMPRIME
IMP ( COL(30), REPITETXT ( '-' , 16 ) ) ;; IMPRIME
IMP ( '<<< TOTAL A PAGAR IMSS >>> :',  COL(30), DER($(_total_imss),15) ) ;; IMPRIME
TERMINA_REPORTE
