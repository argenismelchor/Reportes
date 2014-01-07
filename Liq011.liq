#POLIZA DE SEGURO SOCIAL ESTANDAR ESTANDAR
#VERSION 2.500
#USUARIO =*
#NO EDITAR
#DESCRIPCION
#Este reporte genera una poliza estandar de Seguro Social de todos los trabajadores de la empresa aún cuando no esten vigentes.
#Este reporte imprime de los trabajadores la clave, nombre, departamento, puesto y sucursal.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA/DISCO', $salida )
NUEVO_PARAMETRO_FEC ('FECHA INICIAL','',_fi) 
NUEVO_PARAMETRO_FEC ('FECHA FINAL','',_ff)
LEE_PARAMETROS

BORRA_PARAMETROS

ENCABEZADO
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL (60), VERSION_GIRO );; IMPRIME
   IMP ( CENTRA ('EMPRESA':'NOMBRE' ));; IMPRIME
   IMP ( CENTRA ('POLIZA DE SEGURO SOCIAL ESTANDAR'));; IMPRIME
   IMP ( CENTRA ( 'DEL '+FECHA( _fi )+' AL '+FECHA( _ff ) ) );; IMPRIME
   IMP ( REPITETXT('=',80));; IMPRIME
   IMP ( COL(25), 'NOMBRE DE LA CUENTA', COL(50), DER('DEBE',10), COL(60), DER('HABER',10) );; IMPRIME
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

INCLUYE LIQ_INI.CIC

FORMATO_FECHA := 2
FORMATO_PESOS := 2

#Variables Globales
VAR_T ( &indices )
VAR_T( &totales )
$tipo      := ''
_aux       := 0
_tot_pat   := 0
_tot_obr   := 0
_cuota_imss:= 0
_nomina    := 0
_subtot    := 0
_mes       := 1
_cont      := 0
_num_ind   := 0

#Subrutina diversas

SUB_RUTINA parametros
  #
FIN_SUB_RUTINA

SUB_RUTINA sumatoria
   #Incremeto de valores para los indices seleccionados
   DECIMALES := 2
   _num_ind := 0
   REPITE
     INCREMENTA_TABLA( &totales, 'IMSS', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _cuota_imss )
     INCREMENTA_TABLA( &totales, 'SAR', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _retiro )
     INCREMENTA_TABLA( &totales, 'INFO', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), _info )
     _num_ind := _num_ind + 1
   HASTA ( TRAE_VALOR_TABLA( &indices, 0, _num_ind ) = '' )
FIN_SUB_RUTINA

SUB_RUTINA imprime_nombre
    SI ( _primera = 0 )
       IMP ( '*', COL(3), 'EMPPRIN':'AFILIACION', COL(15), 'EMPPRIN':'NOMBRE', COL(60), FORMATO( 'EMPPRIN':'RFC', 'XXXX-XXXXXX-XXX' ), COL(80), 'EMPPRIN':'CLAVE'  ) ;; IMPRIME
       _primera:=1
    FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
    calcula_periodo
    _cuota_imss := _fija + _ex_3m_p + _dinero_p + _especie_p + _iv_p + _rt + _guarderia + _cv_p
    sumatoria
FIN_SUB_RUTINA

SUB_RUTINA sub_totales
    DECIMALES:=2
    _subtot := VALOR_TABLA(&totales, 'INFO', $indice) + VALOR_TABLA(&totales, 'SAR', $indice) + VALOR_TABLA(&totales, 'NOMINA', $indice) + VALOR_TABLA(&totales, 'IMSS', $indice)
    IMP ( COL(25), '5% INFONAVIT', COL(50), DER($(VALOR_TABLA(&totales, 'INFO', $indice)),10) ) ;; IMPRIME
    IMP ( COL(25), '2% S.A.R.', COL(50), DER($(VALOR_TABLA(&totales, 'SAR', $indice)),10) ) ;; IMPRIME
    IMP ( COL(25), 'CUOTAS IMSS', COL(50), DER($(VALOR_TABLA(&totales, 'IMSS', $indice)),10) ) ;; IMPRIME
    IMP ( COL(25), 'Sub Total', COL(60), DER($(_subtot),10) ) ;; IMPRIME
    #Pone en cero los contadores
    ASIGNA_VALOR_TABLA( &totales, 'IMSS', $indice, 0)
    ASIGNA_VALOR_TABLA( &totales, 'SAR', $indice, 0)
    ASIGNA_VALOR_TABLA( &totales, 'INFO', $indice, 0)
FIN_SUB_RUTINA

INCLUYE LIQ_FIN.CIC

$indice := 'TOTAL'
IMP ( COL(25), 'IMPUESTOS POR PAGAR' ) ;; IMPRIME
sub_totales
TERMINA_REPORTE

IMPRIME
DECIMALES:=2
_subtot:=VALOR_TABLA(&totales, 'INFO', 'TOTAL') + VALOR_TABLA(&totales, 'SAR', 'TOTAL') + VALOR_TABLA(&totales, 'NOMINA', 'TOTAL') + VALOR_TABLA(&totales, 'IMSS', 'TOTAL')

IMP ( COL(25), 'CUOTAS IMSS', COL(50), DER($(VALOR_TABLA(&totales, 'IMSS', 'TOTAL')),10) ) ;; IMPRIME
IMP ( COL(25), '2% SAR', COL(50), DER($(VALOR_TABLA(&totales, 'SAR', 'TOTAL')),10) ) ;; IMPRIME
IMP ( COL(25), '5% INFONAVIT', COL(50), DER($(VALOR_TABLA(&totales, 'INFO', 'TOTAL')),10) ) ;; IMPRIME
IMP ( COL(25), 'Total', COL(70), DER($(_subtot),10) ) ;; IMPRIME

