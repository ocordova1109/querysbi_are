USE [WMS_BI]
GO
/****** Object:  StoredProcedure [dbo].[RPT_TRANSACCION_MINERIA]    Script Date: 07/05/2021 06:06:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************
* CREADO POR: SAVAR AGENTES DE ADUANA
 *             Oscar Cordova
 * FECHA CREA: 08/05/2021
 * DESCRIPCION: Detalle de bitacora de transacciones
 * EXECUCION : 
    	EXEC DBO.RPT_BITACORA_TRANSACCION_ARE  
*****************************************************************/

--exec RPT_BITACORA_TRANSACCION_ARE 17787,''
ALTER PROCEDURE [dbo].[RPT_BITACORA_TRANSACCION_ARE] 
(
	@trans_no integer,
	@sku varchar(40)
)
AS
BEGIN

	IF @trans_no			IS NULL OR @trans_no = ''		SET @trans_no = NULL
	IF @sku		IS NULL OR @sku = ''		SET @sku = NULL
	

SET NOCOUNT ON;
	DECLARE @tipope varchar(2);

	select @tipope=TRANS_TYPE from INVENTARIO_ARE where TRANS_NO=@trans_no

	if @tipope='I'
	begin
		
		select 
		inv.REF_NO2 as nropedido,
        dsp.ORD_NO as nrodespacho,
		inv.SKU,
        inv.SKU_DESC,
        detp.CANTIDAD as CANT_SOLI,
        detp.CANT_ENTREGADA,
        detp.CANT_CONFIRMA,
        detp.US_CONFIRMA,
        usconf.nombreuser as nomuserconf,
        detp.FEC_CONFIRMA,
        detp.US_CREAR as uscrearpedido,
        usped.nombreuser as nomuserped,
        detp.FEC_CREAR as feccrearpedido,
        ord.US_CREAR as uscreareq,
        usreq.nombreuser as nomusereq,
        ord.FEC_CREAR as feccrearreq       
		from INVENTARIO_ARE inv
		left join DESPACHO_HDR dsp on inv.REF_NO=dsp.ORD_NO
		left join PEDIDOS_ARE ped on dsp.EXT_ORD_NO=ped.NRO_PEDIDO
		left join PEDIDOS_DTL_ARE detp on ped.IDPEDIDO=detp.IDPEDIDO and inv.SKU=detp.SKU
		left join ORDENES_ARE ord on ped.ID_ORDEN=ord.IDORDEN
        left join (SELECT * FROM OPENQUERY(NEOSAV,'select "idUser" as idusuario,"desUser" as nombreuser 
        from "maeUsuarios" where "edoUser"=''A'' and "codTipRel"=''PE''')) as usreq on ord.US_CREAR=usreq.idusuario
        left join (SELECT * FROM OPENQUERY(NEOSAV,'select "idUser" as idusuario,"desUser" as nombreuser 
        from "maeUsuarios" where "edoUser"=''A'' and "codTipRel"=''PE''')) as usped on detp.US_CREAR=usped.idusuario 
        left join (SELECT * FROM OPENQUERY(NEOSAV,'select "idUser" as idusuario,"desUser" as nombreuser 
        from "maeUsuarios" where "edoUser"=''A'' and "codTipRel"=''PE''')) as usconf on detp.US_CONFIRMA=usconf.idusuario 
		where inv.TRANS_NO=@trans_no 
		--select * from PEDIDOS_ARE where NRO_PEDIDO=4755  4861	
	end		

  
END



