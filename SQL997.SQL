#CAMBIO DE TIPO DE NOMINA
#SELECT * FROM SUPERVISOR_GIRO.EMPPRIN

UPDATE SUPERVISOR_GIRO.EMPPRIN
SET TIPO_NOM = 'SINQ'
WHERE TIPO_NOM = 'MAZ'