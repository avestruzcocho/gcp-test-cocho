CREATE OR REPLACE PROCEDURE `bnt-lakehouse-oro-des.ds_b_ant_oro.sp_bq_abandono_hipoteca_calc`(vfecha DATE)
OPTIONS (description="Ejecucion de las reglas de negocio")
BEGIN
 
  ------------------------------------------------------------------------------
  -- PARTE 1  SQL que genera la base mensual de la data para el modelo
  ------------------------------------------------------------------------------
  create or replace table bnt-lakehouse-oro-des.`ds_b_ant_oro.t_paso_reglas_neg_1` as 
  WITH
      t1 AS(
      SELECT
        *,
        CAST(FORMAT_DATE("%Y%m", mes_fecha) AS int64) AS obs,
        CAST(FORMAT_DATE("%Y%m%d", mes_fecha) AS int64) AS obs2
      FROM
        `bnt-lakehouse-plt-des.ds_b_ant_plt.t_b_ant_ins_abn_hip_hist_vxx`
      WHERE
        mes_fecha = vfecha ),
      t2 AS(
      SELECT
        *
      FROM
        `bnt-lakehouse-plt-des.ds_b_ant_plt.t_b_ant_modelin` ),
      t3 AS(
      SELECT
        *
      FROM
        `bnt-lakehouse-plt-des.ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos` ),
      t4 AS(
      SELECT
        *
      FROM
        `bnt-lakehouse-plt-des.ds_b_ant_plt.t_b_ant_codigos_postales` )
    SELECT
      t1.cliente_id,  -----------------------SIC
      t1.credito_numero,---------------------CREDITO
      t1.obs2,-------------------------------OBS
      tenencia_seguros_bandera,--------------FAM_SEGUROS
      tenencia_vista_bandera,----------------FAM_VISTA
      antig_emisora_meses_numero,------------MOBS_EMI
      depositos_nom_monto,-------------------MONTO_DEP
      retiros_nom_monto,---------------------MONTO_RET
      max_auto_offus_monto,------------------MAX_LIMAU_OFFUS
      max_hipo_offus_monto,------------------MAX_LIMHIPO_OFFUS
      total_credito_personal_offus_monto,----SDOPLN_OFFUS
      score_bc_monto,------------------------SCORE_VALUE
      tdc_offus_numero,----------------------NUM_TDC_OFFUS
      total_auto_offus_numero,---------------NUM_AU_OFFUS
      score_bc_bandera,----------------------TIENESCORE
      monto_max_tdc_offus_monto,-------------MAX_LIMTDC_OFFUS
      antig_cliente_meses_numero,------------MOBS
      saldo_total_auto_monto,----------------SDO_AUTO
      saldo_total_auto_offus_monto,----------SDOAU_OFFUS
      saldo_total_hipo_offus_monto,----------SDOHIPO_OFFUS
      case when aniosresdom_desc = '    ' then '2021'
      else aniosresdom_desc
      end aniosresdom_desc,---ANIOSRESDOM
      sexo_tipo,-----------------------------SEXO
      codpos_long_numero,--------------------CODPOS_LONG
      codpos_lat_numero,---------------------CODPOS_LAT
      txn_depositos_nom_numero,--------------TXN_DEP
      txn_retiros_nom_numero,----------------TXN_RET
      txn_retiros_nom_offus_numero,----------TXN_R3
      sdoprom_mens_vista_monto,--------------SP_VISTA
      fact_total_tdc_monto,------------------FACT
      uso_mensual_tdc_pct,-------------------UTIL_TDC
      meses_antig_tdc_numero,----------------MOBS_TDC
      saldo_total_cierre_tdc_monto,----------SDO_CIERRE_TDC
      linea_max_tdc_monto,-------------------AMBS_CRLIM
      contable_ultimo_balance_saldo,---------N_SALDOCONTABLE
      credito_monto,-------------------------IMPCRED
      plazo_total_credito_meses_numero,------PLAZO
      garantia_monto,------------------------IMPGARANTI
      tasa_cobrada_pct,----------------------TASACOBRAD
      broker_bandera,------------------------F_BROKER
      max_num_pagos_vencidos_numero,---------MAX_NPV
      pct_ltv_monto,-------------------------LTV
      pct_ltv_cierre_monto,------------------LTV_CIERRE
      plazo_remanente_credito_numero,--------N_PLAZO_REMANENTE
      aforo_monto,---------------------------N_LTV
      score_riesgo_numero,-------------------N_SCORE_RIESGO
      prom_voluntad_pago_7m_monto,-----------PROM_VPAGO
      antig_credito_meses_numero,------------MOB
      pago_exigible_monto,-------------------EXIGIBLE
      pago_monto,----------------------------PAGO
      consultas_buro_1m_numero,--------------CONSULTA_1M
      consultas_buro_3m_numero,--------------CONSULTA_3M
      consultas_buro_6m_numero,--------------CONSULTA_6M
      consultas_buro_12m_numero,-------------CONSULTA_12M
      case when ingreso_tipo in("Asalariado","No asalariado","No aplica","A") then ingreso_tipo else 'Otro'end as ingreso_tipo,----------TIPO_INGRESO,
      case when modalidad_credito_cve in (70078.0,70013.0,71000.0,70137.0,70081.0,70166.0,70139.0) then cast(modalidad_credito_cve as string) else 'Otro' end as modalidad_credito_cve,------MODALIDAD
      case when broker_nombre in("Sin Broker","SINERGIA SOC S.A. DE C.V.","FSG BROKER S.A. DE C.V.")then broker_nombre else 'Otro' end as broker_nombre,-------------------------BROKER
      case when nivel_riesgo_cliente_tipo in('Bajo','Muy bajo') then nivel_riesgo_cliente_tipo else 'Otro' end as nivel_riesgo_cliente_tipo,-------------NIVEL_RIESGO
      case when tipoperclav_id  in (251,252) then cast(tipoperclav_id as string) else 'Otro' end as tipoperclav_id,------------------------TIPOPERCLAV
      case when estadociv_tipo in ('C','S') then estadociv_tipo else 'Otro' end as estadociv_tipo,------------------------ESTADOCIV
      case when nivelestclav_numero in (4,5,6,8) then cast(nivelestclav_numero as string) else 'Otro' end as nivelestclav_numero --------------------NIVELESTCLAV
    FROM t1
    LEFT JOIN t2 
    ON (t1.cliente_id=t2.cliente_id
    AND t1.obs =t2.fecha_informacion)
    LEFT JOIN t3
    ON t1.cliente_id = t3.numerocif_id
    LEFT JOIN t4
    ON (cast(t3.codigopos_id as int64) = t4.d_codigo_id);

  ------------------------------------------------------------------------------
    -- PARTE 2  Reglas Python y liimpieza de datos.
  ------------------------------------------------------------------------------
  create or replace table  `bnt-lakehouse-oro-des.ds_b_ant_oro.t_paso_reglas_neg_2` as 
  SELECT
  ifnull(cliente_id,0)cliente_id,
  ifnull(credito_numero,0)credito_numero,
  ifnull(obs2,0 )obs,
  ifnull(tenencia_seguros_bandera,0)tenencia_seguros_bandera,
  ifnull(tenencia_vista_bandera,0)tenencia_vista_bandera,
  cast(ifnull(antig_emisora_meses_numero,0)as float64)antig_emisora_meses_numero,
  case when depositos_nom_monto is null then 16200 else depositos_nom_monto end depositos_nom_monto,                          
  case when retiros_nom_monto is null then -7384.78 else retiros_nom_monto end retiros_nom_monto,                                
  ifnull(max_auto_offus_monto,0)max_auto_offus_monto,
  ifnull(max_hipo_offus_monto,0)max_hipo_offus_monto,
  ifnull(total_credito_personal_offus_monto,0)total_credito_personal_offus_monto,
  case when score_bc_monto is null then 682 else score_bc_monto end score_bc_monto,                                           
  ifnull(tdc_offus_numero,0)tdc_offus_numero,
  ifnull(total_auto_offus_numero,0)total_auto_offus_numero,
  ifnull(score_bc_bandera,0)score_bc_bandera,
  ifnull(monto_max_tdc_offus_monto,0)monto_max_tdc_offus_monto,
  ifnull(antig_cliente_meses_numero,0)antig_cliente_meses_numero,
  ifnull(saldo_total_auto_monto,0)saldo_total_auto_monto,
  ifnull(saldo_total_auto_offus_monto,0)saldo_total_auto_offus_monto,
  ifnull(saldo_total_hipo_offus_monto,0)saldo_total_hipo_offus_monto,
  case when cast(aniosresdom_desc as int64) < 1900 then (2021 - cast(aniosresdom_desc as int64))
       when aniosresdom_desc is null then 0
  else cast(aniosresdom_desc as int64)
  end aniosresdom_desc,
  case when sexo_tipo = "F" then 1 else 0 end as sexo_tipo,
  ifnull(codpos_long_numero,0)codpos_long_numero,
  ifnull(codpos_lat_numero,0)codpos_lat_numero,
  case when txn_depositos_nom_numero is null then 2 else txn_depositos_nom_numero end as txn_depositos_nom_numero,            
  case when txn_retiros_nom_numero is null then 3 else txn_retiros_nom_numero end as txn_retiros_nom_numero,                  
  case when txn_retiros_nom_offus_numero is null then 3 else txn_retiros_nom_offus_numero end as txn_retiros_nom_offus_numero,
  case when sdoprom_mens_vista_monto is null then 4745.740967 else sdoprom_mens_vista_monto end as sdoprom_mens_vista_monto,         
  ifnull(fact_total_tdc_monto,0)fact_total_tdc_monto,
  ifnull(uso_mensual_tdc_pct,0)uso_mensual_tdc_pct,
  ifnull(meses_antig_tdc_numero,0)meses_antig_tdc_numero,
  ifnull(saldo_total_cierre_tdc_monto,0)saldo_total_cierre_tdc_monto,
  ifnull(linea_max_tdc_monto,0)linea_max_tdc_monto,
  ifnull(contable_ultimo_balance_saldo,0)contable_ultimo_balance_saldo,
  ifnull(credito_monto,0)credito_monto,
  ifnull(plazo_total_credito_meses_numero,0)plazo_total_credito_meses_numero,
  ifnull(garantia_monto,0)garantia_monto,
  ifnull(tasa_cobrada_pct,0)tasa_cobrada_pct,
  ifnull(broker_bandera,0)broker_bandera,
  ifnull(max_num_pagos_vencidos_numero,0)max_num_pagos_vencidos_numero,
  ifnull(pct_ltv_monto,0)pct_ltv_monto,
  ifnull(pct_ltv_cierre_monto,0)pct_ltv_cierre_monto,
  ifnull(plazo_remanente_credito_numero,0)plazo_remanente_credito_numero,
  ifnull(aforo_monto,0)aforo_monto,
  case when score_riesgo_numero is null then 733 else score_riesgo_numero end as score_riesgo_numero,                        
  ifnull(prom_voluntad_pago_7m_monto,0)prom_voluntad_pago_7m_monto,
  ifnull(antig_credito_meses_numero,0)antig_credito_meses_numero,
  ifnull(pago_exigible_monto,0)pago_exigible_monto,
  ifnull(pago_monto,0)pago_monto,
  ifnull(consultas_buro_1m_numero,0)consultas_buro_1m_numero,
  ifnull(consultas_buro_3m_numero,0)consultas_buro_3m_numero,
  ifnull(consultas_buro_6m_numero,0)consultas_buro_6m_numero,
  ifnull(consultas_buro_12m_numero,0)consultas_buro_12m_numero,
  --case when ingreso_tipo in("Asalariado","No asalariado","No aplica","A") then ingreso_tipo else 'Otro'end as ingreso_tipo,
  --case when cast(modalidad_credito_cve as string) in('70078.0','70013.0','71000.0','70137.0','70081.0','70166.0','70139.0') then cast(modalidad_credito_cve as string) else 'Otro' end as modalidad_credito_cve,
  --case when broker_nombre in("Sin Broker","SINERGIA SOC S.A. DE C.V.","PUNTACATOCHE IBÉRICA S. DE R.L.","EASY HOMEZS SERVICES S.A. DE C.V.","FSG BROKER S.A. DE C.V.")then broker_nombre else 'Otro' end as broker_nombre,
  --case when nivel_riesgo_cliente_tipo in('Bajo','Muy bajo') then nivel_riesgo_cliente_tipo else 'Otro' end as nivel_riesgo_cliente_tipo,
  --case when tipoperclav_id  in (251,252) then cast(tipoperclav_id as string) else 'Otro' end as tipoperclav_id,
  --case when estadociv_tipo in ('C','S') then estadociv_tipo else 'Otro' end as estadociv_tipo,
  --case when nivelestclav_numero in (6,8,4,5) then cast(nivelestclav_numero as string) else 'Otro' end as nivelestclav_numero,
    ----variables dummy
  case when ingreso_tipo = 'A' then 1 else 0 end as tipo_ingreso_a,
  case when ingreso_tipo = 'Asalariado' then 1 else 0 end as tipo_ingreso_asalariado,
  case when ingreso_tipo = 'No aplica' then 1 else 0 end as tipo_ingreso_noaplica,
  case when ingreso_tipo = 'No asalariado' then 1 else 0 end as tipo_ingreso_noasalariado,
  case when ingreso_tipo = 'Otro' then 1 else 0 end as tipo_ingreso_otro,
  case when modalidad_credito_cve = '70013' then 1 else 0 end as modalidad_70013,
  case when modalidad_credito_cve = '70078' then 1 else 0 end as modalidad_70078,
  case when modalidad_credito_cve = '70081' then 1 else 0 end as modalidad_70081,
  case when modalidad_credito_cve = '70137' then 1 else 0 end as modalidad_70137,
  case when modalidad_credito_cve = '70139' then 1 else 0 end as modalidad_70139,
  case when modalidad_credito_cve = '70166' then 1 else 0 end as modalidad_70166,
  case when modalidad_credito_cve = '71000' then 1 else 0 end as modalidad_71000,
  case when cast(modalidad_credito_cve as string) = 'Otro' then 1 else 0 end as modalidad_Otro,
  case when broker_nombre = 'FSG BROKER S.A. DE C.V.' then 1 else 0 end as broker_fsgbrokers_a_dec_v_, 
  case when broker_nombre = 'Otro' then 1 else 0 end as broker_otro,
  case when broker_nombre = 'Sin Broker' then 1 else 0 end as broker_sinbroker,
  case when broker_nombre = 'SINERGIA SOC S.A. DE C.V.' then 1 else 0 end as broker_sinergiasocs_a_dec_v_,
  case when broker_nombre = 'PUNTACATOCHE IBÉRICA S. DE R.L.' then 1 else 0 end as broker_puntacatocheiberiaderl,     
  case when broker_nombre = 'EASY HOMEZS SERVICES S.A. DE C.V.' then 1 else 0 end as broker_easyhomezsservicessadecv, 
  case when nivel_riesgo_cliente_tipo = 'Bajo' then 1 else 0 end as nivel_riesgo_bajo,
  case when nivel_riesgo_cliente_tipo = 'Muy bajo' then 1 else 0 end as nivel_riesgo_muybajo,
  case when nivel_riesgo_cliente_tipo = 'Otro' then 1 else 0 end as nivel_riesgo_otro,
  case when tipoperclav_id = '251' then 1 else 0 end as tipoperclav_251,
  case when tipoperclav_id = '252' then 1 else 0 end as tipoperclav_252,
  case when tipoperclav_id = 'Otro' then 1 else 0 end as tipoperclav_otro,
  case when estadociv_tipo = 'C' then 1 else 0 end as estadociv_c,
  case when estadociv_tipo = 'Otro' then 1 else 0 end as estadociv_otro,
  case when estadociv_tipo = 'S' then 1 else 0 end as estadociv_s,
  case when nivelestclav_numero = '4' then 1 else 0 end as nivelestclav_4,
  case when nivelestclav_numero = '5' then 1 else 0 end as nivelestclav_5,
  case when nivelestclav_numero = '6' then 1 else 0 end as nivelestclav_6,
  case when nivelestclav_numero = '8' then 1 else 0 end as nivelestclav_8,
  case when nivelestclav_numero = 'Otro' then 1 else 0 end as nivelestclav_otro
FROM
  `ds_b_ant_oro.t_paso_reglas_neg_1`
;

------------------------------------------------------------------------------
-- Se trunca la tabla de entrada del modelo.
------------------------------------------------------------------------------

TRUNCATE TABLE `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_ins_abn_hip_vxx`;

------------------------------------------------------------------------------
-- Se carga la data mensual a la tabla de entrada del modelo.
------------------------------------------------------------------------------
 
INSERT INTO `bnt-lakehouse-oro-des.ds_b_ant_oro.t_b_ant_ins_abn_hip_vxx`
SELECT
  cliente_id,
  credito_numero,
  obs,
  tenencia_seguros_bandera,
  tenencia_vista_bandera,
  antig_emisora_meses_numero,
  depositos_nom_monto,
  retiros_nom_monto,
  max_auto_offus_monto,
  max_hipo_offus_monto,
  total_credito_personal_offus_monto,
  score_bc_monto,
  tdc_offus_numero,
  total_auto_offus_numero,
  score_bc_bandera,
  monto_max_tdc_offus_monto,
  antig_cliente_meses_numero,
  saldo_total_auto_monto,
  saldo_total_auto_offus_monto,
  saldo_total_hipo_offus_monto,
  aniosresdom_desc,
  sexo_tipo,
  codpos_long_numero,
  codpos_lat_numero,
  txn_depositos_nom_numero,
  txn_retiros_nom_numero,
  txn_retiros_nom_offus_numero,
  sdoprom_mens_vista_monto,
  fact_total_tdc_monto,
  uso_mensual_tdc_pct,
  meses_antig_tdc_numero,
  saldo_total_cierre_tdc_monto,
  linea_max_tdc_monto,
  contable_ultimo_balance_saldo,
  credito_monto,
  plazo_total_credito_meses_numero,
  garantia_monto,
  tasa_cobrada_pct,
  broker_bandera,
  max_num_pagos_vencidos_numero,
  pct_ltv_monto,
  pct_ltv_cierre_monto,
  plazo_remanente_credito_numero,
  aforo_monto,
  score_riesgo_numero,
  prom_voluntad_pago_7m_monto,
  antig_credito_meses_numero,
  pago_exigible_monto,
  pago_monto,
  consultas_buro_1m_numero,
  consultas_buro_3m_numero,
  consultas_buro_6m_numero,
  consultas_buro_12m_numero,
  tipo_ingreso_a,
  tipo_ingreso_asalariado,
  tipo_ingreso_noaplica,
  tipo_ingreso_noasalariado,
  tipo_ingreso_otro,
  modalidad_70013,
  modalidad_70078,
  modalidad_70081,
  modalidad_70137,
  modalidad_70139,
  modalidad_70166,
  modalidad_71000,
  modalidad_otro,
  broker_fsgbrokers_a_dec_v_,
  broker_otro,
  broker_sinbroker,
  broker_sinergiasocs_a_dec_v_,
  nivel_riesgo_bajo,
  nivel_riesgo_muybajo,
  nivel_riesgo_otro,
  tipoperclav_251,
  tipoperclav_252,
  tipoperclav_otro,
  estadociv_c,
  estadociv_otro,
  estadociv_s,
  nivelestclav_4,
  nivelestclav_5,
  nivelestclav_6,
  nivelestclav_8,
  cast(nivelestclav_otro as float64)
FROM `ds_b_ant_oro.t_paso_reglas_neg_2`;
  
  
------------------------------------------------------------------------------
-- Se borran las tablas temporales.
------------------------------------------------------------------------------
  DROP TABLE `ds_b_ant_oro.t_paso_reglas_neg_1`;
  DROP TABLE `ds_b_ant_oro.t_paso_reglas_neg_2`;

------------------------------------------------------------------------------
-- Se aplica un Delete para evitar duplicados.
------------------------------------------------------------------------------
  DELETE FROM `ds_b_ant_oro.t_b_ant_ins_abn_hip_hist` 
  WHERE PARSE_DATE('%Y%m%d', CAST(obs AS STRING)) = vfecha;

------------------------------------------------------------------------------
-- Se carga datos de entrada mensual en una tabla historica.
------------------------------------------------------------------------------
  INSERT INTO `ds_b_ant_oro.t_b_ant_ins_abn_hip_hist`   
  SELECT * FROM `ds_b_ant_oro.t_b_ant_ins_abn_hip_vxx`; 

----------------------------------------------------------------------------------
-- Se aplica un Delete para evitar duplicados en la tabla de Salida Predccion ML.
----------------------------------------------------------------------------------
   ----Evita duplicados en tabla de calificar
  DELETE FROM `ds_b_ant_oro.t_b_ant_calif_abandono_hip_hist_vxx`
  WHERE obs = vfecha;


END;