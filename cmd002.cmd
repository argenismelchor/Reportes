#LISTA DE ASISTENCIA A COMEDOR
#VERSION 2.500
#USUARIO =*
#NO EDITAR
#DESCRIPCION
#Este reporte muestra todos los trabajadores de la empresa aún cuando no esten vigentes.
#Este reporte imprime de los trabajadores la clave, nombre, departamento, puesto y sucursal.
#Este reporte tiene los filtros estandares los cuales pueden filtrar cualquiera de los indices de Registro patronal, Sucursal
#Centro de Costo, Departamento, Puesto, Tipo Empleado y Tipo de Nómina.
#FIN_DESCRIPCION

NUEVO_PARAMETRO_SAL ( 'SALIDA', 'PANTALLA/IMPRESORA/DISCO', $salida )
NUEVO_PARAMETRO_FEC ( 'FECHA INICIAL', '', _fi )
NUEVO_PARAMETRO_FEC ( 'FECHA FINAL', '', _ff )
NUEVO_PARAMETRO_CHEQ( 'TOTALES X EMPLEADO', '', _totalizar )
LEE_PARAMETROS

BORRA_PARAMETROS

ENCABEZADO
   IMPRIME
   LETRA ( 'LETRA ENFATISADA' )
   IMP ( 'Rep. ', CLAVE_REPORTE, ' ', NOMBRE_REPORTE, COL (60), VERSION_GIRO );; IMPRIME
   IMP ( CENTRA ('EMPRESA':'NOMBRE')) ;; IMPRIME
   IMP ( CENTRA ('LISTA DE ASISTENCIA A COMEDOR') ) ;; IMPRIME
   IMP ( REPITETXT('=',80)) ;; IMPRIME
   SI ( CD_DC = 0 )
     IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(50), DER('SUCURSAL', 10), COL(60), DER('DEPTO', 10), COL(70), DER('PUESTO', 10) );; IMPRIME
   SI_NO
     IMP ( COL(1), 'CLAVE', COL(10), 'NOMBRE', COL(50), DER('SUCURSAL', 10), COL(60), DER('C.C.', 10), COL(70), DER('PUESTO',10) );; IMPRIME
   FIN_SI
   IMP ( COL(10), 'FECHA', COL(30), 'HORA', COL(50), DER( 'COSTO', 8 ) ) ;; IMPRIME
   IMP ( REPITETXT('-',80) );; IMPRIME;; IMPRIME 
   LETRA ( 'LETRA NORMAL' );; IMPRIME
FIN_ENCABEZADO

PIE
   IMPRIME
   DECIMALES := 0
   LETRA ( 'LETRA ENFATISADA' )
   IMPRIME
   IMP ( COL(2), 'Fecha : ', FECHA (FECHA_HOY), ' ', 'Hora : ', HORA(HORA_ACTUAL), COL(65), 'PAGINA -', PAGINA, '-' );; IMPRIME
   LETRA ( 'LETRA NORMAL' );; IMPRIME
   DECIMALES := 2
FIN_PIE

FORMATO_FECHA := 3
FORMATO_PESOS := 2
FORMATO_HORA  := 4

#Variables Globales
VAR_T ( &indices )
VAR_T ( &subtotales )
_num_ind := 0
$indice  := ''
$antes   := ''
_total   := 0


#Subrutina diversas

SUB_RUTINA imprime_nombre
  IMP ( COL(1), 'EMPPRIN':'CLAVE', COL(10), SUBSTR('EMPPRIN':'NOMBRE', 1, 30) )
  IMP ( COL(50), DER('EMPPRIN':'SUC_CLAVE', 10), COL(60), DER('EMPPRIN':'DEP_CLAVE', 10), COL(70), DER('EMPPRIN':'PUE_CLAVE', 10) )
  IMPRIME
FIN_SUB_RUTINA

SUB_RUTINA imprime_tot_emp
  DECIMALES := 2
  SI (( _totalizar = 1 ) AND ( $antes <> '' ))
    IMP ( COL(40), 'TOTAL : ', COL(50), DER( $( _total ), 8 ) ) ;; IMPRIME
    $antes := ''
  FIN_SI
FIN_SUB_RUTINA

SUB_RUTINA sub_totales
   imprime_tot_emp

   IMP ( 'TOTAL ', $indice, ' : ', DER( .(VALOR_TABLA ( &subtotales, 'SUBTOTAL', $indice) ), 12 ) )
   IMPRIME

   #INICIALIZA EL TOTAL EN 0
   ASIGNA_VALOR_TABLA ( &subtotales, 'SUBTOTAL', $indice, 0 )
FIN_SUB_RUTINA

SUB_RUTINA formato_trabajador
  DECIMALES := 2
  SI ( $antes <> 'EMPPRIN':'CLAVE' )
    imprime_tot_emp
    imprime_nombre
    $antes := 'EMPPRIN':'CLAVE'
    _total := 0
  FIN_SI
  IMP ( COL(10), FECHA( 'EMPPRIN':'FECHA' ), COL(30), HORA( 'EMPPRIN':'HORA' ), COL(50), DER( $( 'EMPPRIN':'COSTO'  ), 8 ) )
  IMPRIME
  _total := _total + 'EMPPRIN':'COSTO'

  #Incremeto de valores para los indices seleccionados
  _num_ind := 0
  REPITE
    INCREMENTA_TABLA( &subtotales, 'SUBTOTAL', TRAE_VALOR_TABLA( &indices, 0, _num_ind ), 'EMPPRIN':'COSTO' )
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

#Definicion de variables en base a los parametros
SALIDA := $salida

_incluir_suc := 1
_incluir_dep := 1
_incluir_pue := 1
$campos_extras := 'C. CLAVE, C. FECHA, C. HORA, C. COSTO'
$bases_extras := 'EMPCOME C'
$condiciones_extras := 'C. CLAVE = E. CLAVE AND C. FECHA >= :FI AND C. FECHA <= :FF'
base_trabajadores
PARAMETRO_SQL( 'EMPPRIN', 'FI', _fi )
PARAMETRO_SQL( 'EMPPRIN', 'FF', _ff )

MIENTRAS ( FIN_BASE ( 'EMPPRIN' ) = FALSO )
   SI ( FUE_VIGENTE( _fi, _ff ) )
     datos_trabajador
   FIN_SI
   SIGUIENTE_REGISTRO ( 'EMPPRIN' )
FIN_MIENTRAS

termina_reporte

$indice := 'TOTAL'
sub_totales
