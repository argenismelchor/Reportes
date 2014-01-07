/**  SUELDOS   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpSdo') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpSdo
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpSdo
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpSdo
  Where Clave = @Empleado
GO

/**  RH   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpRh') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpRh
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpRh
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpRh
  Where Clave = @Empleado
GO

/**  EmpDep   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpDep') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpDep
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpDep
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpDep
  Where Clave = @Empleado
GO

/**  EmpPues   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpPues') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpPues
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpPues
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpPues
  Where Clave = @Empleado
GO

/**  EmpSuc   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpSuc') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpSuc
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpSuc
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpSuc
  Where Clave = @Empleado
GO

/**  EmpAus   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpAus') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpAus
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpAus
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpAus
  Where Clave = @Empleado
GO

/**  EmpInc   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpInc') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpInc
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpInc
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpInc
  Where Clave = @Empleado
GO

/**  EmpVaca   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpVaca') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpVaca
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpVaca
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpVaca
  Where Clave = @Empleado
GO

/**  EmpRet   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpRet') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpRet
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpRet
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpRet
  Where Clave = @Empleado
GO

/**  EmpAcum   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpAcum') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpAcum
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpAcum
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpAcum
  Where Clave = @Empleado
GO

/**  EmpCurso   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpCurso') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpCurso
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpCurso
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpCurso
  Where Clave = @Empleado
GO

/**  EmpCont   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpCont') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpCont
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpCont
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpCont
  Where Clave = @Empleado
GO

/**  EmpCapac   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpCapac') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpCapac
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpCapac
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpCapac
  Where Clave = @Empleado
GO

/**  EmpExt   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpExt') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpExt
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpExt
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpExt
  Where Clave = @Empleado
GO

/**  EmpFam   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpFam') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpFam
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpFam
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpFam
  Where Clave = @Empleado
GO

/**  EmpIdiom   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpIdiom') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpIdiom
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpIdiom
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpIdiom
  Where Clave = @Empleado
GO

/**  EmpNota   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpNota') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpNota
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpNota
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpNota
  Where Clave = @Empleado
GO

/**  EmpPres   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpPres') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpPres
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpPres
  @Empleado char(10) = ""
AS
  Select *
  From Supervisor_giro. EmpPres
  Where Clave = @Empleado
GO

/**  EmpAbo   **/
if exists (select * from sysobjects where id = object_id('Supervisor_giro.SP_EmpAbo') and sysstat & 0xf = 4)
	drop procedure Supervisor_giro.SP_EmpAbo
GO

CREATE PROCEDURE Supervisor_giro. SP_EmpAbo
  @Prestamo Int
AS
  Select *
  From Supervisor_giro. EmpAbo
  Where Prestamo = @Prestamo
GO

