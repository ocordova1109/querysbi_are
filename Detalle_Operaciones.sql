USE [WMS_BI]
GO
/****** Object:  StoredProcedure [dbo].[RPT_TRANSACCION_MINERIA]    Script Date: 07/05/2021 06:06:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************
* CREADO POR: SAVAR AGENTES DE ADUANA
 *             Jesús A. Anton Pachas
 * FECHA CREA: 24/11/2020
 * DESCRIPCION: LISTA LAS TRANSACCION DE MINERIA
 * EXECUCION : 
    	EXEC DBO.RPT_TRANSACCION_MINERIA  
*****************************************************************/

--exec RPT_TRANSACCION_MINERIA_TEST 'SVCL','WH1','01','','','','','',1,100,'','','ASL727'
ALTER PROCEDURE [dbo].[RPT_TRANSACCION_MINERIA] 
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

	select @tipope=TRANS_TYPE from INVENTARIO_ARE where TRANS_NO=17852

	if @tipope='I'
	begin
		
		select 
		inv.REF_NO2 as nropedido,
		ord.*
		from INVENTARIO_ARE inv
		left join DESPACHO_HDR dsp on inv.REF_NO=dsp.ORD_NO
		left join PEDIDOS_ARE ped on dsp.EXT_ORD_NO=ped.NRO_PEDIDO
		left join PEDIDOS_DTL_ARE detp on ped.IDPEDIDO=detp.IDPEDIDO and inv.SKU=detp.SKU
		left join ORDENES_ARE ord on ped.ID_ORDEN=ord.IDORDEN
		where inv.TRANS_NO=17747 
		--select * from PEDIDOS_ARE where NRO_PEDIDO=4755  4861	
	end		

  
END


