----------------------------------------------------------------------------------------------------------------------------------------------
-- PROCESAR EL DATASET ENTRENAMIENTO
-----------------------------------------------------------------------

-- DATASET COMPARTIDO POR BANORTE, con el nombre de bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_prop_prod

-- Se agrego un campo para particionar llamada `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_limpieza1_prop_prod`
-- ALTER TABLE `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_prop_prod_hist`
-- ADD COLUMN fecha_obs date;
--select * from `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_prop_prod_hist` limit 1;

---------------------------------------------------------------------------- 
-- PARTE 2 - PYTHON - Limpieza de datos del Insumo para el modelo
------------------------------------------------------------------------------

-- Creación de la tabla con reglas de negocio para meter al código que correspondia a las reglas de python
CREATE OR REPLACE TABLE `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_limpieza1_prop_prod` AS 
SELECT cliente_id, CAST(fecha_informacion as DATE) as fecha_obs,*
EXCEPT(cliente_id,fecha_informacion,fecha_obs)
FROM `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_prop_prod`
WHERE tenencia_tdc_bandera IS NOT NULL  --REGLA DE NEGOCIO PARA EL DATASET DE ENTRENAMIENTO
; -- SIN FILTRO : 4,130,998    ----- CON FILTRO : 4,128,390

--SELECT fecha_solicitud_auto FROM `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_limpieza1_prop_prod`;

-- Reglas de negocio
CREATE OR REPLACE TABLE bnt-lakehouse-oro-des.ds_paso.t_paso1_entreno_ins_prop_prod_vxx 
AS
SELECT
  *,
  --REGLAS DE NEGOCIO QUE SOLO APLICAN EN EL DATASET DE ENTRENAMIENTO
  IF( IFNULL(fecha_solicitud_auto,"9999-12-31") = "9999-12-31",0,1 ) AS target_auto,
  IF( IFNULL(fecha_solicitud_cn,"9999-12-31") = "9999-12-31",0,1 ) AS target_cn,
  IF( IFNULL(fecha_solicitud_hipo,"9999-12-31") = "9999-12-31",0,1 ) AS target_hipo,
  IF( IFNULL(fecha_solicitud_tdc,"9999-12-31") = "9999-12-31",0,1 ) AS target_tdc,
  IF (IFNULL(depvar_fondos_new,0) =0, 0, 1) AS target_fondos,

  IF (LENGTH(CAST(EXTRACT(MONTH FROM fecha_obs) AS STRING)) = 1, 
     CONCAT("0", CAST(EXTRACT(MONTH FROM fecha_obs) AS STRING)),
     CAST(EXTRACT(MONTH FROM fecha_obs) AS STRING)) AS mes_temp
    ,
  IF (  edad_cliente_anios_numero < 0,            ABS(edad_cliente_anios_numero),
    IF (edad_cliente_anios_numero >100, edad_cliente_anios_numero-100, edad_cliente_anios_numero)
     ) AS edad_temp ,
  IF ( IFNULL(CAST (aniosresdom_desc AS BIGNUMERIC), 0) > 1800,
       2022-IFNULL(CAST (aniosresdom_desc AS BIGNUMERIC), 0), 
       IFNULL(CAST (aniosresdom_desc AS BIGNUMERIC), 0)
     ) AS aniosresdom_temp , 
  IF (IFNULL(reus_bandera,'0') = '0','0','1' ) AS reus_temp , --STRING
  
 
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)) , 
     (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     ) 
    --6
    ) 
   AS prom_sp6  ,
 
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) 
              + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) ) , 
       (
    IF (sdoprom_mens_vista_monto IS NOT NULL,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) 
       ) 
  --5
  ) 
  AS prom_sp5  ,
  
    SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) 
              + IFNULL(sdoprom_mens_vista_monto_3,0) )  , 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0)
     ) 
  --4
  ) 
 AS prom_sp4  ,
  
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) ) , 
           (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0)
     ) 
  --3
  ) 
   AS prom_sp3,


  SAFE_DIVIDE( 
    IFNULL(sdoprom_mens_vista_monto,0)+IFNULL(sdoprom_mens_vista_monto_1,0),    
             (
               IF (sdoprom_mens_vista_monto   IS NOT NULL ,1.0,0.0) +
               IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0)
    --IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    --IF (sdoprom_mens_vista_monto_1 IS NOT NULL,1.0,0.0) 
     ) 
    --2
  ) 
  AS prom_sp2,
  
  SAFE_DIVIDE((IFNULL(fact_total_tdc_monto,0) + IFNULL(fact_total_tdc_monto_1,0) + IFNULL(fact_total_tdc_monto_2 ,0)
  + IFNULL(fact_total_tdc_monto_3,0) + IFNULL(fact_total_tdc_monto_4,0) + IFNULL(fact_total_tdc_monto_5,0) ) , 
       (
    IF (fact_total_tdc_monto IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (fact_total_tdc_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_5 IS NOT NULL ,1.0,0.0)
     ) 
  --6
  ) 
   AS prom_fact6,
  SAFE_DIVIDE((IFNULL(fact_total_tdc_monto,0) + IFNULL(fact_total_tdc_monto_1,0) + IFNULL(fact_total_tdc_monto_2 ,0)
  + IFNULL(fact_total_tdc_monto_3,0) + IFNULL(fact_total_tdc_monto_4,0) ) , 
         (
    IF (fact_total_tdc_monto IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (fact_total_tdc_monto_4 IS NOT NULL ,1.0,0.0) 
     ) 
  --5
  ) AS prom_fact5,
  SAFE_DIVIDE((IFNULL(fact_total_tdc_monto,0) + IFNULL(fact_total_tdc_monto_1,0) + IFNULL(fact_total_tdc_monto_2 ,0)
  + IFNULL(fact_total_tdc_monto_3,0) ) , 
         (
    IF (fact_total_tdc_monto IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_3 IS NOT NULL ,1.0,0.0) 
     ) 
  --4
  ) AS prom_fact4 ,
  SAFE_DIVIDE((IFNULL(fact_total_tdc_monto,0) + IFNULL(fact_total_tdc_monto_1,0) + IFNULL(fact_total_tdc_monto_2 ,0)
   ) , 
         (
    IF (fact_total_tdc_monto IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_2 IS NOT NULL ,1.0,0.0) 
     ) 
  --3
  )AS prom_fact3,
  SAFE_DIVIDE((IFNULL(fact_total_tdc_monto,0) + IFNULL(fact_total_tdc_monto_1,0)),
         (
    IF (fact_total_tdc_monto IS NOT NULL ,1.0,0.0) + 
    IF (fact_total_tdc_monto_1 IS NOT NULL ,1.0,0.0) 
         )
  --2
  ) AS prom_fact2,
  SAFE_DIVIDE((IFNULL(depositos_nom_monto,0) + IFNULL(depositos_nom_monto_1,0) + IFNULL(depositos_nom_monto_2,0) + IFNULL(depositos_nom_monto_3,0) + IFNULL(depositos_nom_monto_4,0) + IFNULL(depositos_nom_monto_5,0) ) ,
         (
    IF (depositos_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (depositos_nom_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_5 IS NOT NULL ,1.0,0.0)
     ) 
  
  --6
  ) AS prom_md6,
  SAFE_DIVIDE((IFNULL(depositos_nom_monto,0) + IFNULL(depositos_nom_monto_1,0) + IFNULL(depositos_nom_monto_2,0) + IFNULL(depositos_nom_monto_3,0) + IFNULL(depositos_nom_monto_4,0)  ) ,
  (
    IF (depositos_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (depositos_nom_monto_4 IS NOT NULL ,1.0,0.0) 
     ) 
  
  --5
  ) AS prom_md5,
  SAFE_DIVIDE((IFNULL(depositos_nom_monto,0) + IFNULL(depositos_nom_monto_1,0) + IFNULL(depositos_nom_monto_2,0) + IFNULL(depositos_nom_monto_3,0) ) ,
   (
    IF (depositos_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_3 IS NOT NULL ,1.0,0.0) 
     ) 
  
   --4
   ) AS prom_md4,
  SAFE_DIVIDE((IFNULL(depositos_nom_monto,0) + IFNULL(depositos_nom_monto_1,0) + IFNULL(depositos_nom_monto_2,0) ) ,
  (
    IF (depositos_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_2 IS NOT NULL ,1.0,0.0) 
  ) 
  --3
  ) AS prom_md3,
  SAFE_DIVIDE((IFNULL(depositos_nom_monto,0) + IFNULL(depositos_nom_monto_1,0) ) ,
  (
    IF (depositos_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (depositos_nom_monto_1 IS NOT NULL ,1.0,0.0) 
     ) 
  
  --2
  ) AS prom_md2,
  SAFE_DIVIDE((IFNULL(retiros_nom_monto,0) + IFNULL(retiros_nom_monto_1,0) + IFNULL(retiros_nom_monto_2,0) + IFNULL(retiros_nom_monto_3,0) + IFNULL(retiros_nom_monto_4,0) + IFNULL(retiros_nom_monto_5,0)) , 
  (
    IF (retiros_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (retiros_nom_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_5 IS NOT NULL ,1.0,0.0)
     ) 
  
  --6
  ) AS prom_mr6,
  SAFE_DIVIDE((IFNULL(retiros_nom_monto,0) + IFNULL(retiros_nom_monto_1,0) + IFNULL(retiros_nom_monto_2,0) + IFNULL(retiros_nom_monto_3,0) + IFNULL(retiros_nom_monto_4,0) ) , 
    (
    IF (retiros_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (retiros_nom_monto_4 IS NOT NULL ,1.0,0.0) 
     ) 
  --5
  ) AS prom_mr5,
  SAFE_DIVIDE((IFNULL(retiros_nom_monto,0) + IFNULL(retiros_nom_monto_1,0) + IFNULL(retiros_nom_monto_2,0) + IFNULL(retiros_nom_monto_3,0) ) , 
     (
    IF (retiros_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_3 IS NOT NULL ,1.0,0.0)
     ) 
   --4
   ) AS prom_mr4,
  SAFE_DIVIDE((IFNULL(retiros_nom_monto,0) + IFNULL(retiros_nom_monto_1,0) + IFNULL(retiros_nom_monto_2,0) ) , 
    (
    IF (retiros_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_2 IS NOT NULL ,1.0,0.0)
     ) 
  --3
  ) AS prom_mr3,
  SAFE_DIVIDE((IFNULL(retiros_nom_monto,0) + IFNULL(retiros_nom_monto_1,0)) , 
    (
    IF (retiros_nom_monto IS NOT NULL ,1.0,0.0) + 
    IF (retiros_nom_monto_1 IS NOT NULL ,1.0,0.0) 
     ) 
  --2
  ) AS prom_mr2,
  
  SAFE_DIVIDE(IFNULL(sdoprom_mens_vista_monto,0) , 
    SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)), 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     )
    --6
    ) ) AS porc_sp1 ,
  
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) +IFNULL(sdoprom_mens_vista_monto_1,0)) , 
    SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)), 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     )
    --6 
    ) ) AS porc_sp2,
  
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0)) , 
    SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)) , 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     )
    --6 
    ) ) AS porc_sp3,
  
  SAFE_DIVIDE( (IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0)) , 
    SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)) , 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     )
    --6
     ) ) AS porc_sp4,
  
  SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0)) , 
    SAFE_DIVIDE((IFNULL(sdoprom_mens_vista_monto,0) + IFNULL(sdoprom_mens_vista_monto_1,0) + IFNULL(sdoprom_mens_vista_monto_2,0) + IFNULL(sdoprom_mens_vista_monto_3,0) + IFNULL(sdoprom_mens_vista_monto_4,0) + IFNULL(sdoprom_mens_vista_monto_5,0)) , 
         (
    IF (sdoprom_mens_vista_monto IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_1 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_2 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_3 IS NOT NULL ,1.0,0.0) +
    IF (sdoprom_mens_vista_monto_4 IS NOT NULL ,1.0,0.0) + 
    IF (sdoprom_mens_vista_monto_5 IS NOT NULL ,1.0,0.0)
     )
    --6 
    ) ) AS porc_sp5  ,
  CASE estadoclav_id
    WHEN 1 THEN  'CDMX'
    WHEN 2 THEN  'AGS'
    WHEN 3 THEN  'BC'
    WHEN 4 THEN  'BCS'
    WHEN 5 THEN  'CAM'
    WHEN 6 THEN  'COAH'
    WHEN 7 THEN  'COL'
    WHEN 8 THEN  'CHIS'
    WHEN 9 THEN  'CHIH'
    WHEN 10 THEN 'DGO'
    WHEN 11 THEN 'GTO'
    WHEN 12 THEN 'GRO'
    WHEN 13 THEN 'HGO'
    WHEN 14 THEN 'JAL'
    WHEN 15 THEN 'MEX'
    WHEN 16 THEN 'MICH'
    WHEN 17 THEN 'MOR'
    WHEN 18 THEN 'NAY'
    WHEN 19 THEN 'NL'
    WHEN 20 THEN 'OAX'
    WHEN 21 THEN 'PUE'
    WHEN 22 THEN 'QRO'
    WHEN 23 THEN 'Q ROO'
    WHEN 24 THEN 'SLP'
    WHEN 25 THEN 'SIN'
    WHEN 26 THEN 'SON'
    WHEN 27 THEN 'TAB'
    WHEN 28 THEN 'TAMPS'
    WHEN 29 THEN 'TLAX'
    WHEN 30 THEN 'VER'
    WHEN 31 THEN 'YUC'
    WHEN 32 THEN 'ZAC'
    ELSE 'OTRO'
  END AS estadoclav_id_temp,
  IF (estadociv_tipo IN UNNEST(["S", "C", "U"]), estadociv_tipo, "OTRO") AS estadociv_tipo_temp, 
  IF (metodo_desc IN UNNEST(['Nomina','Depositos','Modelo Saldos','Nomina y depositos','Buro HRC','Afore']), metodo_desc, "OTRO") AS metodo_desc_temp, 
  IF (estudios_desc IN UNNEST( ['CARRERA TECNICA','LICENCIATURA (PROFESIONAL)','POSTGRADO (MAESTRIA,DOCTORADO)', 'PREPARATORIA', 'PRIMARIA','SECUNDARIA','SIN ESCOLARIDAD']), estudios_desc,
  IF (estudios_desc = 'DIPLOMADO-ESPECIALIDAD', 'LICENCIATURA (PROFESIONAL)', "OTRO")) AS estudios_desc2 ,
  IF (segmento_nombre IN UNNEST( ['I','H','IA','GB','G','C','FB','D','F','EB','J','E', 'B','A','IB','GA','FC','FA','EC','DC','GC','EA',  'AA']), segmento_nombre, "OTRO") AS segmento_nombre2,
    CASE segmentogrupclav_numero
      WHEN 201 THEN 'PREFERENTE'
      WHEN 203 THEN 'PERSONAL'
      WHEN 89 THEN 'PYMES'
      ELSE 'OTRO'
    END AS segmentogrupclav_numero2

from bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entreno_sin_procesar_limpieza1_prop_prod;
  
-- Segunda parte Reglas de negocio  
CREATE OR REPLACE TABLE bnt-lakehouse-oro-des.ds_paso.t_paso2_entreno_ins_prop_prod_vxx AS
SELECT * EXCEPT(reus_bandera),
  CASE WHEN segmento_nombre2 = 'A'    THEN 1 ELSE 0 END as segmento_nombre_a,
  CASE WHEN segmento_nombre2 = 'AA'   THEN 1 ELSE 0 END as segmento_nombre_aa,
  CASE WHEN segmento_nombre2 = 'B'    THEN 1 ELSE 0 END as segmento_nombre_b,
  CASE WHEN segmento_nombre2 = 'C'    THEN 1 ELSE 0 END as segmento_nombre_c,
  CASE WHEN segmento_nombre2 = 'D'    THEN 1 ELSE 0 END as segmento_nombre_d,
  CASE WHEN segmento_nombre2 = 'DC'   THEN 1 ELSE 0 END as segmento_nombre_dc,
  CASE WHEN segmento_nombre2 = 'E'    THEN 1 ELSE 0 END as segmento_nombre_e,
  CASE WHEN segmento_nombre2 = 'EA'   THEN 1 ELSE 0 END as segmento_nombre_ea,
  CASE WHEN segmento_nombre2 = 'EB'   THEN 1 ELSE 0 END as segmento_nombre_eb,
  CASE WHEN segmento_nombre2 = 'EC'   THEN 1 ELSE 0 END as segmento_nombre_ec,
  CASE WHEN segmento_nombre2 = 'F'    THEN 1 ELSE 0 END as segmento_nombre_f,
  CASE WHEN segmento_nombre2 = 'FA'   THEN 1 ELSE 0 END as segmento_nombre_fa,
  CASE WHEN segmento_nombre2 = 'FB'   THEN 1 ELSE 0 END as segmento_nombre_fb,
  CASE WHEN segmento_nombre2 = 'FC'   THEN 1 ELSE 0 END as segmento_nombre_fc,
  CASE WHEN segmento_nombre2 = 'G'    THEN 1 ELSE 0 END as segmento_nombre_g,
  CASE WHEN segmento_nombre2 = 'GA'   THEN 1 ELSE 0 END as segmento_nombre_ga,
  CASE WHEN segmento_nombre2 = 'GB'   THEN 1 ELSE 0 END as segmento_nombre_gb,
  CASE WHEN segmento_nombre2 = 'GC'   THEN 1 ELSE 0 END as segmento_nombre_gc,
  CASE WHEN segmento_nombre2 = 'H'    THEN 1 ELSE 0 END as segmento_nombre_h,
  CASE WHEN segmento_nombre2 = 'I'    THEN 1 ELSE 0 END as segmento_nombre_i,
  CASE WHEN segmento_nombre2 = 'IA'   THEN 1 ELSE 0 END as segmento_nombre_ia,
  CASE WHEN segmento_nombre2 = 'IB'   THEN 1 ELSE 0 END as segmento_nombre_ib,
  CASE WHEN segmento_nombre2 = 'J'    THEN 1 ELSE 0 END as segmento_nombre_j,
  CASE WHEN segmento_nombre2 = 'OTRO' THEN 1 ELSE 0 END as segmento_nombre_otro,  

  CASE WHEN estudios_desc2 = 'CARRERA TECNICA' THEN 1 ELSE 0 END as estudios_desc_carrera_tecnica,
  CASE WHEN estudios_desc2 = 'DIPLOMADO-ESPECIALIDAD' THEN 1 ELSE 0 END as estudios_desc_diplomado_especialidad,
  CASE WHEN estudios_desc2 = 'LICENCIATURA (PROFESIONAL)' THEN 1 ELSE 0 END as estudios_desc_licenciatura_profesional,
  CASE WHEN estudios_desc2 = 'OTRO' THEN 1 ELSE 0 END as estudios_desc_otro,
  CASE WHEN estudios_desc2 = 'POSTGRADO (MAESTRIA,DOCTORADO)' THEN 1 ELSE 0 END as estudios_desc_postgrado_maestria_doctorado,
  CASE WHEN estudios_desc2 = 'PREPARATORIA' THEN 1 ELSE 0 END as estudios_desc_preparatoria,
  CASE WHEN estudios_desc2 = 'PRIMARIA' THEN 1 ELSE 0 END as estudios_desc_primaria,
  CASE WHEN estudios_desc2 = 'SECUNDARIA' THEN 1 ELSE 0 END as estudios_desc_secundaria,
  CASE WHEN estudios_desc2 = 'SIN ESCOLARIDAD' THEN 1 ELSE 0 END as estudios_desc_sin_escolaridad,
  
  CASE WHEN metodo_desc_temp = 'Afore' THEN 1 ELSE 0 END as metodo_afore,
  CASE WHEN metodo_desc_temp = 'OTRO' THEN 1 ELSE 0 END as metodo_otro,
  CASE WHEN metodo_desc_temp = 'Buro HRC' THEN 1 ELSE 0 END as metodo_buro_hrc,
  CASE WHEN metodo_desc_temp = 'Depositos' THEN 1 ELSE 0 END as metodo_depositos,
  CASE WHEN metodo_desc_temp = 'Modelo Saldos' THEN 1 ELSE 0 END as metodo_modelo_saldos,
  CASE WHEN metodo_desc_temp = 'Nomina' THEN 1 ELSE 0 END as metodo_nomina,
  CASE WHEN metodo_desc_temp = 'Nomina y depositos' THEN 1 ELSE 0 END as metodo_nomina_y_depositos,

  CASE WHEN estadociv_tipo_temp = 'C' THEN 1 ELSE 0 END as estadociv_tipo_c,
  CASE WHEN estadociv_tipo_temp = 'OTRO' THEN 1 ELSE 0 END as estadociv_tipo_otro,
  CASE WHEN estadociv_tipo_temp = 'S' THEN 1 ELSE 0 END as estadociv_tipo_s,
  CASE WHEN estadociv_tipo_temp = 'U' THEN 1 ELSE 0 END as estadociv_tipo_u,

  CASE WHEN CAST(segmentogrupclav_numero2 AS STRING) = 'OTRO' THEN 1 ELSE 0 END as segmentogrupclav_numero_otro,
  CASE WHEN CAST(segmentogrupclav_numero2 AS STRING) = 'PERSONAL' THEN 1 ELSE 0 END as segmentogrupclav_numero_personal,
  CASE WHEN CAST(segmentogrupclav_numero2 AS STRING) = 'PREFERENTE' THEN 1 ELSE 0 END as segmentogrupclav_numero_preferente,
  CASE WHEN CAST(segmentogrupclav_numero2 AS STRING) = 'PYMES' THEN 1 ELSE 0 END as segmentogrupclav_numero_pymes,

    CASE WHEN persona_tipo = 'PF' THEN 1 ELSE 0 END as persona_tipo_pf,
  CASE WHEN persona_tipo = 'PFAE' THEN 1 ELSE 0 END as persona_tipo_pfae,

  CASE WHEN CAST(mes_temp AS INT64) = 1 THEN 1 ELSE 0 END as mes_fecha_01,
  CASE WHEN CAST(mes_temp AS INT64) = 2 THEN 1 ELSE 0 END as mes_fecha_02,
  CASE WHEN CAST(mes_temp AS INT64) = 3 THEN 1 ELSE 0 END as mes_fecha_03,
  CASE WHEN CAST(mes_temp AS INT64) = 4 THEN 1 ELSE 0 END as mes_fecha_04,
  CASE WHEN CAST(mes_temp AS INT64) = 5 THEN 1 ELSE 0 END as mes_fecha_05,
  CASE WHEN CAST(mes_temp AS INT64) = 6 THEN 1 ELSE 0 END as mes_fecha_06,
  CASE WHEN CAST(mes_temp AS INT64) = 7 THEN 1 ELSE 0 END as mes_fecha_07,
  CASE WHEN CAST(mes_temp AS INT64) = 8 THEN 1 ELSE 0 END as mes_fecha_08,
  CASE WHEN CAST(mes_temp AS INT64) = 9 THEN 1 ELSE 0 END as mes_fecha_09,
  CASE WHEN CAST(mes_temp AS INT64) = 10 THEN 1 ELSE 0 END as mes_fecha_10,
  CASE WHEN CAST(mes_temp AS INT64) = 11 THEN 1 ELSE 0 END as mes_fecha_11,
  CASE WHEN CAST(mes_temp AS INT64) = 12 THEN 1 ELSE 0 END as mes_fecha_12,

  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'CDMX' THEN 1 ELSE 0 END as estadoclav_id_cdmx,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'AGS'       THEN 1 ELSE 0 END as estadoclav_id_ags,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'BC'       THEN 1 ELSE 0 END as estadoclav_id_bc,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'BCS'       THEN 1 ELSE 0 END as estadoclav_id_bcs,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'CAM'       THEN 1 ELSE 0 END as estadoclav_id_cam,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'COAH'       THEN 1 ELSE 0 END as estadoclav_id_coah,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'COL'       THEN 1 ELSE 0 END as estadoclav_id_col,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'CHIS'       THEN 1 ELSE 0 END as estadoclav_id_chis,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'CHIH'       THEN 1 ELSE 0 END as estadoclav_id_chin,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'DGO'       THEN 1 ELSE 0 END as estadoclav_id_dgo,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'GTO'       THEN 1 ELSE 0 END as estadoclav_id_gto,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'GRO'       THEN 1 ELSE 0 END as estadoclav_id_gro,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'HGO'       THEN 1 ELSE 0 END as estadoclav_id_hgo,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'JAL'       THEN 1 ELSE 0 END as estadoclav_id_jal,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'MEX'       THEN 1 ELSE 0 END as estadoclav_id_mex,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'MICH'       THEN 1 ELSE 0 END as estadoclav_id_mich,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'MOR'       THEN 1 ELSE 0 END as estadoclav_id_mor,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'NAY'      THEN 1 ELSE 0 END as estadoclav_id_nay,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'NL'       THEN 1 ELSE 0 END as estadoclav_id_nl,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'OAX'       THEN 1 ELSE 0 END as estadoclav_id_oax,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'PUE'       THEN 1 ELSE 0 END as estadoclav_id_pue,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'QRO'       THEN 1 ELSE 0 END as estadoclav_id_qro,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'Q ROO'       THEN 1 ELSE 0 END as estadoclav_id_q_roo,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'SLP'       THEN 1 ELSE 0 END as estadoclav_id_slp,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'SIN'       THEN 1 ELSE 0 END as estadoclav_id_sin,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'SON'       THEN 1 ELSE 0 END as estadoclav_id_son,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'TAB'       THEN 1 ELSE 0 END as estadoclav_id_tab,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'TAMPS'       THEN 1 ELSE 0 END as estadoclav_id_tamps,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'TLAX'       THEN 1 ELSE 0 END as estadoclav_id_tlax,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'VER'       THEN 1 ELSE 0 END as estadoclav_id_ver,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'YUC'      THEN 1 ELSE 0 END as estadoclav_id_yuc,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'ZAC'      THEN 1 ELSE 0 END as estadoclav_id_zac,
  CASE WHEN CAST(estadoclav_id_temp AS STRING) = 'OTRO'       THEN 1 ELSE 0 END as estadoclav_id_otro,



FROM bnt-lakehouse-oro-des.ds_paso.t_paso1_entreno_ins_prop_prod_vxx;

-- TRUNCAR SIEMPRE Y CUANDO YA NO SE VUELVA A EJECUTAR ESTE CÓDIGO, OSEA ANTES DEL 2022-07
TRUNCATE TABLE bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entrenado_prop_prod_hist ;

-- Insertar en tabla historica de entrenamiento
INSERT INTO bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_entrenado_prop_prod_hist 
SELECT 
 CAST(cliente_id as INT64) AS cliente_id, --fecha_obs as fecha_informacion, 
 CAST(FORMAT_DATE('%Y%m%d', fecha_obs) AS int64) AS fecha_informacion, --ESTO SOLO ES PARA EL MODELO
 genero_femenino_bandera, 
 edad_temp AS edad_cliente_anios_numero,
 antig_cliente_meses_numero,tenencia_auto_bandera,tenencia_bxi_bandera,
 tenencia_casa_bolsa_bandera,tenencia_credito_nomina_bandera,tenencia_hipo_bandera,tenencia_mesa_dinero_bandera,
 tenencia_credito_personal_bandera,tenencia_pagare_plazo_bandera,tenencia_seguros_bandera,tenencia_fondos_inversion_bandera,
 tenencia_tdc_bandera,tenencia_vista_bandera,total_tenencia_productos_numero,nom_3m_bandera,
 inicio_sesion_app_movil_numero,sdoprom_mens_fondos_inversion_monto,sdoprom_trim_casa_bolsa_monto,sdoprom_mens_mesa_dinero_monto,
 sdoprom_mens_pagare_plazo_monto,sdoprom_mens_vista_monto,txn_depositos_nom_numero,txn_retiros_nom_numero,
 depositos_nom_monto,
 retiros_nom_monto,fact_total_tdc_monto,gastos_lujos_monto,fact_luxury_monto,
 gastos_transporte_monto,fact_transporte_monto,txn_servicios_infantiles_numero,fact_servicios_monto,
 gastos_personales_monto,fact_gastos_personales_monto,gastos_entretenimiento_monto,fact_entretenimiento_monto,
 gastos_otros_monto,fact_otros_monto,gastos_despensa_monto,fact_despensa_monto,
 score_bc_bandera,score_bc_monto,saldo_total_hipo_offus_monto,saldo_total_auto_offus_monto,
 total_hipo_offus_numero,saldo_total_tdc_offus_monto,credito_personal_offus_numero,max_credito_personal_offus_monto,
 total_auto_offus_numero,total_credito_personal_offus_monto,uso_credito_personal_offus_monto,max_auto_offus_monto,
 monto_max_tdc_offus_monto,uso_tdc_offus_monto,tdc_offus_numero,max_hipo_offus_monto,
 nom_monto,--depositos_nom_monto,
 codpos_long_numero,codpos_lat_numero,CAST(medio_contacto AS INT64) medio_contacto,ing_mensual_monto,
 retrospectivo_bandera,
 aniosresdom_temp as aniosresdom_desc,
 CAST(reus_temp AS INT64) as reus_bandera ,
 prom_sp6,prom_sp5,prom_sp4,prom_sp3,prom_sp2,
 prom_fact6,prom_fact5,prom_fact4,prom_fact3,prom_fact2,
 prom_md6,prom_md5,prom_md4,prom_md3,prom_md2,
 prom_mr6,prom_mr5,
 prom_mr4,prom_mr3,prom_mr2,
 porc_sp1,porc_sp2,porc_sp3,porc_sp4,porc_sp5,
 segmento_nombre_a,segmento_nombre_aa,segmento_nombre_b,segmento_nombre_c,segmento_nombre_d,segmento_nombre_dc,segmento_nombre_e,
 segmento_nombre_ea,segmento_nombre_eb,segmento_nombre_ec,segmento_nombre_f,segmento_nombre_fa,segmento_nombre_fb,segmento_nombre_fc,
 segmento_nombre_g,segmento_nombre_ga,segmento_nombre_gb,segmento_nombre_gc,segmento_nombre_h,segmento_nombre_i,
 segmento_nombre_ia,segmento_nombre_ib,segmento_nombre_j,segmento_nombre_otro,
 segmentogrupclav_numero_otro,segmentogrupclav_numero_personal,segmentogrupclav_numero_preferente,segmentogrupclav_numero_pymes,    
 persona_tipo_pf,persona_tipo_pfae,
 estudios_desc_carrera_tecnica,estudios_desc_licenciatura_profesional,estudios_desc_otro,
 estudios_desc_postgrado_maestria_doctorado,estudios_desc_preparatoria,estudios_desc_primaria,
 estudios_desc_secundaria,
 --estudios_desc_diplomado_especialidad,
 estudios_desc_sin_escolaridad,
 metodo_afore,metodo_buro_hrc,metodo_depositos,metodo_modelo_saldos,metodo_nomina,metodo_nomina_y_depositos,metodo_otro,
 estadociv_tipo_c,estadociv_tipo_otro,estadociv_tipo_s,estadociv_tipo_u,
 estadoclav_id_ags,estadoclav_id_bc,estadoclav_id_bcs,estadoclav_id_cam,estadoclav_id_cdmx,
 estadoclav_id_chin,estadoclav_id_chis,estadoclav_id_coah,estadoclav_id_col,estadoclav_id_dgo,
 estadoclav_id_gro,estadoclav_id_gto,estadoclav_id_hgo,estadoclav_id_jal,estadoclav_id_mex,
 estadoclav_id_mich,estadoclav_id_mor,estadoclav_id_nay,estadoclav_id_nl,estadoclav_id_oax,
 estadoclav_id_otro,estadoclav_id_pue,estadoclav_id_q_roo,estadoclav_id_qro,estadoclav_id_sin,
 estadoclav_id_slp,estadoclav_id_son,estadoclav_id_tab,estadoclav_id_tamps,estadoclav_id_tlax,
 estadoclav_id_ver,estadoclav_id_yuc,estadoclav_id_zac,
 mes_fecha_01,mes_fecha_02,mes_fecha_03,mes_fecha_04,mes_fecha_05,mes_fecha_06,
 mes_fecha_07,mes_fecha_08,mes_fecha_09,mes_fecha_10,mes_fecha_11,mes_fecha_12,
 target_auto, target_cn, target_hipo, target_tdc, target_fondos

FROM bnt-lakehouse-oro-des.ds_paso.t_paso2_entreno_ins_prop_prod_vxx;