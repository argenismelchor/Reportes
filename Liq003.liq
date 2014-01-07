#DISTRIBUCION DE CUOTAS IMSS
#NO EDITAR
#USUARIO =*
#VERSION 2.500
#DESCRIPCION
#Este Reporte cálcula la distribución de cuotas de imss para la nueva ley del seguro social vigente del 1 julio del 97.
#Este reporte muestra todos los trabajadores de la empresa que hayan cotizado para el mes a calcular.
#Este reporte imprime de los trabajadores la Afiliacion, Nombre, RFC, Clave. De la liquidación imprime las cuotas correspondientes al IMSS.
#Este reporte pide el mes y el año a calcular, pide ademas los parametros estandares pero es necesario que especifique un registro patronal a calcular.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION
NUEVO_PARAMETRO_SAL ( 'SALIDA' , 'PANTALLA/IMPRESORA/DISCO' , $salida )
NUEVO_PARAMETRO_FEC ( 'FECHA INICIAL' , '' , _fi )  
NUEVO_PARAMETRO_FEC ( 'FECHA FINAL' , '' , _ff )
NUEVO_PARAMETRO_CHEQ( 'SOLO TOTALES' , '' , _solo_tot )
LEE_PARAMETROS
BORRA_PARAMETROS

_lv := 0

ENCABEZADO
   LETRA ( 'LETRA CONDENSADA' )
   IMPRIME
   _lv := LONGITUD ( VERSION_GIRO )
   IMP ( COL (1) , NOMBRE_REPORTE , COL (COLUMNAS - _lv) , VERSION_GIRO ) ;; IMPRIME
   IMP ( COL (1) , CLAVE_REPORTE , CENTRA ('EMPRESA':'NOMBRE' ) ) ;; IMPRIME
   IMP ( CENTRA ( 'Del ' + FECHA ( _fi ) + ' al ' + FECHA ( _ff ) ) ) ;; IMPRIME
   IMP ( REPITETXT ( '=' , 130 ) ) ;; IMPRIME
   IMP ( COL (3)   , 'No. IMSS' , COL (25) , 'Nombre' , COL (90) , 'RFC' , COL (120) , 'Clave' ) ;; IMPRIME
   IMP ( COL (3)   , 'MOV' , COL (8) , 'Fecha' , COL (20) , 'Dias' , COL (30) , DER ( 'S.D.I.' , 10 ) , COL (45) , 'Falt' , COL (55) , 'Incap' ) ;; IMPRIME
   IMP ( COL (1)   , DER ( 'FIJA' , 10 ) , COL (11) , DER ( 'Ex3S P' , 10 ) , COL (21) , DER ( 'Ex3S O' , 10 ) , COL (31) , DER ( 'DINERO P' , 10 ) , COL (41) , DER ( 'DINERO O' , 10 ) )
   IMP ( COL (51)  , DER ( 'ESP P' , 10 ) , COL (61)  , DER ( 'ESP O' , 10 ) , COL (71) , DER ( 'RT' , 10 ) , COL (81) , DER ( 'I/V Pat' , 10 ) , COL (91) , DER ( 'I/V Obr' , 10 ) )
   IMP ( COL (101) , DER ( 'GUARD' , 10 ) , COL (111) , DER ( 'TOTAL' , 15 ) ) ;; IMPRIME
   IMP ( REPITETXT ( '-' , 130 ) ) ;; IMPRIME
   IMPRIME
FIN_ENCABEZADO
PIE
   LETRA ( 'LETRA CONDENSADA' )
   IMPRIME
   DECIMALES := 0
   IMP ( COL (1) , 'Fecha : ' , FECHA (FECHA_HOY) , '    ' , 'Hora : ' , HORA (HORA_ACTUAL) , COL (110) , 'PAGINA : ' , PAGINA ) ;; IMPRIME
   IMPRIME
   DECIMALES := 2
FIN_PIE 

VAR_T ( &indices )

INCLUYE LIQ_INI.CIC

FORMATO_FECHA := 3
FORMATO_PESOS := 1
COLUMNAS      := 130
RENGLONES     := 65

SI ( IMPRESION_DIRECTA = FALSO )
  TAMAÑO_HOJA ( 2700 , 2300 )
SI_NO
  COLUMNAS := 130
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

_omitir_total_general := 1

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
     INCREMENTA_TABLA( &totales, 'EX_3S_P', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _ex_3m_p )
     INCREMENTA_TABLA( &totales, 'EX_3S_O', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _ex_3m_e )
     INCREMENTA_TABLA( &totales, 'DINERO_P', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _dinero_p )
     INCREMENTA_TABLA( &totales, 'DINERO_O', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _dinero_e )
     INCREMENTA_TABLA( &totales, 'ESPECIE_P', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _especie_p )
     INCREMENTA_TABLA( &totales, 'ESPECIE_O', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _especie_e )
     INCREMENTA_TABLA( &totales, 'RT', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _rt )
     INCREMENTA_TABLA( &totales, 'IV_P', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _iv_p )
     INCREMENTA_TABLA( &totales, 'IV_O', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _iv_e )
     INCREMENTA_TABLA( &totales, 'GUARDERIA', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _guarderia )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
    SI ( _primera=0 )
      SI ( _solo_tot = 0 )
         IMP ( '*' , COL (3) , FORMATO ( 'EMPPRIN':'AFILIACION' , 'XX XX XX XXXX X' ) , COL (25) , 'EMPPRIN':'NOMBRE' , COL (90) , FORMATO ( 'EMPPRIN':'RFC' , 'XXXX-XXXXXX-XXX' ) , COL (120) , 'EMPPRIN':'CLAVE' ) ;; IMPRIME
      FIN_SI
      _primera:=1
    FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
    calcula_periodo
    imprime_nombre
    FORMATO_FECHA := 3
    LETRA('LETRA CONDENSADA')
    SI (( 'EMPSDO':'TIPO' <> 'B' ) AND ( 'EMPSDO':'FECHA' >= _fi ) AND ( 'EMPSDO':'FECHA' <= _ff ))
        DECIMALES := 0
        SI ( _solo_tot = 0 )
          IMP ( COL (3) , 'EMPSDO':'TIPO' , COL (8) , FECHA ('EMPSDO':'FECHA') )
        FIN_SI
    FIN_SI
    SI ( _solo_tot = 0 )
      DECIMALES:=0
      IMP ( COL(20), _dias_ta ) 
      DECIMALES:=2
      IMP ( COL(30), DER($(_sueldo_mj_25),10)  )
      DECIMALES:=0 
      IMP ( COL(45), _no_faltas, COL(55), _no_incap ) 
      IMPRIME
      DECIMALES := 2
      LETRA('LETRA CONDENSADA')
      IMP ( COL(1), DER($(_fija),10)  ) 
      IMP ( COL(11), DER($(_ex_3m_p),10)  )
      IMP ( COL(21), DER($(_ex_3m_e),10)  )
      IMP ( COL(31), DER($(_dinero_p),10)  )
      IMP ( COL(41), DER($(_dinero_e),10)  )
      IMP ( COL(51), DER($(_especie_p),10)  )
      IMP ( COL(61), DER($(_especie_e),10)  )
      IMP ( COL(71), DER($(_rt),10)  )
      IMP ( COL(81), DER($(_iv_p),10)  ) 
      IMP ( COL(91), DER($(_iv_e),10)  ) 
      IMP ( COL(101), DER($(_guarderia),10)  )
      IMP ( COL(111), DER($(_tot_imss), 15)  ) 
      IMPRIME
    FIN_SI
    sumatoria
    SIGUIENTE_REGISTRO('EMPSDO')
    SI (( 'EMPSDO':'FECHA' = _ffinal ) AND ( 'EMPSDO':'TIPO'='B' ))
      SI (TRAE_REGISTRO('BAJA','EMPSDO':'CAUSA BAJA'))
        DECIMALES:=0
        SI ( 'EMPSDO':'BAJA IMSS' >= 'EMPSDO':'FECHA' + 7 )
          _fbaja := 'EMPSDO':'BAJA IMSS'
        SI_NO
          _fbaja := 'EMPSDO':'FECHA'
        FIN_SI 
        SI ( _solo_tot = 0 )
          IMP ( COL (3) , 'EMPSDO':'TIPO' , COL (8) ,  FECHA ( _fbaja ) , '  ( ' , 'BAJA':'DESCRIPCION' , ' )' ) ;; IMPRIME
        FIN_SI
      FIN_SI
    FIN_SI
    SI ( _no_incap>0 )
      PRIMER_REGISTRO('EMPINC')
      MIENTRAS(FIN_BASE('EMPINC')=FALSO)
        SI (('EMPINC':'FECHA'>=_fi) AND ('EMPINC':'FECHA'<=_ff))
          SI ( _solo_tot = 0 )
            DECIMALES:=0
            IMP ( COL(10), 'Incapacidad', COL(25), 'EMPINC':'NUMERO', COL(40), 'EMPINC':'DURACION' ) ;; IMPRIME
         FIN_SI
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
    LETRA('LETRA CONDENSADA')
    IMP ( COL(1), DER($(VALOR_TABLA(&totales, 'FIJA', $tipo)),10) )
    IMP ( COL(11), DER($(VALOR_TABLA(&totales, 'EX_3S_P', $tipo)),10) )
    IMP ( COL(21), DER($(VALOR_TABLA(&totales, 'EX_3S_O', $tipo)),10) )
    IMP ( COL(31), DER($(VALOR_TABLA(&totales, 'DINERO_P', $tipo)),10) )
    IMP ( COL(41), DER($(VALOR_TABLA(&totales, 'DINERO_O', $tipo)),10) )
    IMP ( COL(51), DER($(VALOR_TABLA(&totales, 'ESPECIE_P', $tipo)),10) )
    IMP ( COL(61), DER($(VALOR_TABLA(&totales, 'ESPECIE_O', $tipo)),10) )
    IMP ( COL(71), DER($(VALOR_TABLA(&totales, 'RT', $tipo)),10) )
    IMP ( COL(81), DER($(VALOR_TABLA(&totales, 'IV_P', $tipo)),10) )
    IMP ( COL(91), DER($(VALOR_TABLA(&totales, 'IV_O', $tipo)),10) )
    IMP ( COL(101), DER($(VALOR_TABLA(&totales, 'GUARDERIA', $tipo)),10) )
    _tot_pat:=VALOR_TABLA(&totales, 'FIJA', $tipo) + VALOR_TABLA(&totales, 'EX_3S_P', $tipo) + VALOR_TABLA(&totales, 'DINERO_P', $tipo) + VALOR_TABLA(&totales, 'ESPECIE_P', $tipo) + VALOR_TABLA(&totales, 'RT', $tipo)
    _tot_pat:=_tot_pat + VALOR_TABLA(&totales, 'IV_P', $tipo) + VALOR_TABLA(&totales, 'GUARDERIA', $tipo)
    _tot_obr:=VALOR_TABLA(&totales, 'EX_3S_O', $tipo) + VALOR_TABLA(&totales, 'DINERO_O', $tipo) + VALOR_TABLA(&totales, 'ESPECIE_O', $tipo) + VALOR_TABLA(&totales, 'IV_O', $tipo)
    IMP ( COL(111), DER($(_tot_pat + _tot_obr),15) )
    IMPRIME
    #Pone en cero los contadores
    ASIGNA_VALOR_TABLA( &totales, 'FIJA', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'EX_3S_P', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'EX_3S_O', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'DINERO_P', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'DINERO_O', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'ESPECIE_P', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'ESPECIE_O', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'RT', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'IV_P', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'IV_O', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'GUARDERIA', $tipo, 0)
    ASIGNA_VALOR_TABLA( &totales, 'TOT_IMSS', $tipo, 0)
    IMPRIME
FIN_SUB_RUTINA

INCLUYE LIQ_FIN.CIC

$indice := 'TOTAL'
sub_totales

DECIMALES:=0
IMPRIME ;; IMPRIME
IMP ( '*****  TOTALES GENERALES' ) ;; IMPRIME
IMPRIME
FORMATO_PESOS := 2
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
IMP ( COL (30), REPITETXT ( '-' , 16 ) ) ;; IMPRIME
IMP ( '<<< TOTAL A PAGAR IMSS >>> :',  COL(30), DER($(_total_imss),15) ) ;; IMPRIME
TERMINA_REPORTE

