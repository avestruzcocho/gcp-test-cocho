#bnt-lakehouse-core-prod

CREATE PROCEDURE ds_b_sp_core.adquisiciones_productos_observadas_calificacion(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-oro-prod.ds_oro_generico.t_b_ant_adquisiciones_productos_observadas` (
cliente_id,
target_tdc_umbral,
target_hipo_umbral,
target_auto_umbral,
target_cn_umbral,
target_fondos_umbral,
producto_tipo,
prediccion_tdc_umbral,
prediccion_hipo_umbral,
prediccion_auto_umbral,
prediccion_cn_umbral,
prediccion_fondos_umbral
)
SELECT
a.cliente_id,
CASE WHEN a.producto_tipo = "TDC" THEN 1 ELSE 0 END,
CASE WHEN a.producto_tipo = "HIPO" THEN 1 ELSE 0 END,
CASE WHEN a.producto_tipo = "AUTO" THEN 1 ELSE 0 END,
CASE WHEN a.producto_tipo = "CN" THEN 1 ELSE 0 END,
CASE WHEN a.producto_tipo = "FONDOS" THEN 1 ELSE 0 END,
a.producto_tipo,
b.prediccion_tdc_umbral,
b.prediccion_hipo_umbral,
b.prediccion_auto_umbral,
b.prediccion_cn_umbral,
b.prediccion_fondos_umbral

FROM ((
SELECT
*
FROM
`bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_adquisiciones_productos_observadas`
WHERE
fecha_informacion BETWEEN val_first_day
AND DATE_ADD(val_last_day, INTERVAL -1 MONTH)) a
RIGHT JOIN (
SELECT
*
FROM
`bnt-lakehouse-oro-prod.ds_b_ant_oro.t_b_ant_calif_prop_prod_hist_vxx`
WHERE
fecha_informacion BETWEEN val_first_day
AND LAST_DAY(val_first_day))b
ON
a.cliente_id=b.cliente_id);
END;

CREATE PROCEDURE ds_b_sp_core.adquisiciones_productos_observadas_plata(val_first_day DATE, val_last_day DATE)
BEGIN 
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_adquisiciones_productos_observadas` (
cliente_id ,
producto_tipo ,
num_caso ,
fecha_informacion ,
primer_valor_decreto ,
decreto_desc,
max_nun_credito,
num_credito,
grupo_tipo
)
SELECT  
CAST(sic AS INT64) ,
producto ,
num_caso ,
fecha_captura ,
first_value_decreto,
decreto,
max_nun_credito,
num_credito,
grupo
FROM  `bnt-lakehouse-brc-prod.ds_b_ant_brc.adquisiciones_productos_observadas`
WHERE fecha_captura BETWEEN val_first_day AND val_last_day ;
END;


CREATE PROCEDURE ds_b_sp_core.altamira_fusiones_fin_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN 
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_fusiones` (
clie_fusio_id,
clie_perm_numero,
fecha_informacion
)
SELECT  
CAST(clie_fusio AS INT64),
clie_perm,
fecha_informacion
FROM  `bnt-lakehouse-brc-prod.ds_b_cli_brc.altamira_fusiones_fin_opt`
WHERE fecha_informacion BETWEEN val_first_day AND val_last_day ;
END;

CREATE PROCEDURE ds_b_sp_core.altchequesfact_opt_oro(val_first_day DATE, val_last_day DATE)
BEGIN

INSERT INTO
`bnt-lakehouse-oro-prod.ds_b_dwh_cap_oro.t_b_dwh_cap_saldo_vista` (cuenta_id,
fechaultmov_date,
cliente_dwh_id,
pdimproducto_id,
pdimtiempo_fecha,
saldodisval_monto
)
SELECT
cuenta_id,
fechaultmov_date,
cliente_dwh_id,
pdimproducto_id,
pdimtiempo_fecha,
saldodisval_monto
FROM
`bnt-lakehouse-plt-prod.ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista` WHERE pdimtiempo_fecha BETWEEN val_first_day AND val_last_day ;
END;

CREATE PROCEDURE ds_b_sp_core.altchequesfact_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN

INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista` (cuenta_id,
fechaultmov_date,
cliente_dwh_id,
pdimproducto_id,
pdimtiempo_fecha,
saldodisval_monto
)
SELECT
cuenta,
fechaultmov,
CAST(pdimcliente AS INT64),
pdimproducto,
pdimtiempo,
saldodisval
FROM
`bnt-lakehouse-brc-prod.ds_b_dwh_cap_brc.altchequesfact_opt` WHERE pdimtiempo BETWEEN val_first_day AND val_last_day ;
END;

CREATE PROCEDURE ds_b_sp_core.altclientedim_opt_oro()
BEGIN
TRUNCATE TABLE `bnt-lakehouse-oro-prod.ds_b_dwh_cli_oro.t_b_dwh_cli_datos_basicos`;
INSERT INTO  `bnt-lakehouse-oro-prod.ds_b_dwh_cli_oro.t_b_dwh_cli_datos_basicos` (
numerocif_id,
pdimcliente_id,
tipoperclav_id,
aniosresdom_desc,
sexo_tipo,
estadociv_tipo,
nivelestclav_numero,
estadoclav_id,
ocupacionpmclav_id,
ocupacionpfclav_id,
codigopos_id
)
SELECT  
numerocif_id,
pdimcliente_id,
tipoperclav_id,
aniosresdom_desc,
sexo_tipo,
estadociv_tipo,
nivelestclav_numero,
estadoclav_id,
ocupacionpmclav_id,
ocupacionpfclav_id,
codigopos_id
FROM  `bnt-lakehouse-plt-prod.ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos`;
END;

CREATE PROCEDURE ds_b_sp_core.altclientedim_opt_plata()
BEGIN
TRUNCATE TABLE `bnt-lakehouse-plt-prod.ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos`;
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos` (
numerocif_id,
pdimcliente_id,
tipoperclav_id,
aniosresdom_desc,
sexo_tipo,
estadociv_tipo,
nivelestclav_numero,
estadoclav_id,
ocupacionpmclav_id,
ocupacionpfclav_id,
codigopos_id
)
SELECT  
CAST(numerocif AS INT64),
pdimcliente,
tipoperclav,
aniosresdom,
sexo,
estadociv,
nivelestclav,
estadoclav,
ocupacionpmclav,
ocupacionpfclav,
codigopos
FROM  `bnt-lakehouse-brc-pro.ds_b_dwh_cli_brc.altclientedim_opt`;
END;


CREATE PROCEDURE ds_b_sp_core.altclientedim_sas_opt_plata(val_first_day DATE, val_last_day DATE)
OPTIONS(
description="pase a plata")
BEGIN
INSERT INTO `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_datos_complementarios`
SELECT
cast(num_clie as int64)num_clie,
fecha_alta,
tipo_persona,
fecha_nac,
estudios,
cp,
tel1,
e_mail,
reus,
fecha_informacion
FROM `bnt-lakehouse-brc-prod.ds_b_cli_brc.altclientedim_sas_opt`
WHERE fecha_informacion BETWEEN val_first_day AND val_last_day;
END;

CREATE PROCEDURE ds_b_sp_core.altclienterelcuen_sas_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_productos` (cliente_id,
cuenta_id,
producto_tipo,
estatus_tipo,
nom_subp_nombre,
fecha_informacion
)
SELECT
CAST(num_clie as int64)num_clie,
cuenta,
tipo,
estatus,
nom_subp,
fecha_informacion
FROM
`bnt-lakehouse-brc-prod.ds_b_cli_brc.altclienterelcuen_sas_opt`
WHERE fecha_informacion BETWEEN val_first_day AND val_last_day ;
END;

CREATE PROCEDURE ds_b_sp_core.codigos_postales_mexico_ii_plata()
BEGIN
TRUNCATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_codigos_postales`;
INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_codigos_postales` (d_codigo_id,
codpos_long_numero,
codpos_lat_numero)
SELECT
d_codigo,
codpos_long,
codpos_lat
FROM
`bnt-lakehouse-brc-prod.ds_b_ant_brc.codigos_postales_mexico_ii`;
END;


CREATE PROCEDURE ds_b_sp_core.crm_base_ingresos_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_rie_plt.t_b_rie_ingreso_cliente` (ing_mensual_monto,
cliente_id,
metodo_desc,
retrospectivo_bandera,
fecha_informacion
)
SELECT
ing_mensual,
cast(sic as int64)sic,
metodo,
retrospectivo,
fecha_informacion
FROM
`bnt-lakehouse-brc-prod.ds_b_rie_brc.crm_base_ingresos_opt` WHERE fecha_informacion BETWEEN val_first_day AND val_last_day ;
END;


CREATE PROCEDURE ds_b_sp_core.ctasactnom_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN 
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_cap_plt.t_b_cap_dispersion_nomina_m` (
cliente_id,
mes_fecha,
importe_acum_monto,
fecha_informacion   
)
SELECT  
CAST(num_clie AS INT64),
mth,
importe_acum,
fecha_informacion
FROM  `bnt-lakehouse-brc-prod.ds_b_cap_brc.ctasactnom_opt`
WHERE mth BETWEEN val_first_day AND val_last_day ;
END;

#Fugas
CREATE PROCEDURE ds_b_sp_core.fugas_hipotecario_observadas_calificacion(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-oro-prod.ds_oro_generico.t_b_ant_fugas_hipotecario_observadas` ( cliente_id,
credito,
fuga_bandera,
fecha_informacion,
credito_numero,
calificacion_cliente_id,
obs,
prediccion_umbral)
SELECT
a.cliente_id,
a.credito,
a.fuga_bandera,
a.fecha_informacion,
b.credito_numero,
b.cliente_id AS calificacion_cliente_id,
b.obs,
b.prediccion_umbral,
FROM (
SELECT
*
FROM
`bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_hipotecario_observadas`
WHERE
fecha_informacion BETWEEN val_first_day
AND val_last_day) a
RIGHT JOIN (
SELECT
*
FROM
`bnt-lakehouse-oro-prod.ds_b_ant_oro.t_b_ant_calif_abandono_hip_hist_vxx`
WHERE
obs BETWEEN val_first_day
AND LAST_DAY(val_last_day)) b
ON
a.credito=b.credito_numero and a.cliente_id=b.cliente_id;
END;

CREATE PROCEDURE ds_b_sp_core.fugas_hipotecario_observadas_plata(val_first_day DATE, val_last_day DATE)
BEGIN 
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_hipotecario_observadas` (
cliente_id,
credito,
fuga_bandera,
fecha_informacion
)
SELECT  
CAST(num_clie AS INT64),
CAST (credito AS INT64),--cast (credito as int64), -- CASTEAR
CAST(flag_fuga AS INT64),
fecha_informacion
FROM  `bnt-lakehouse-brc-prod.ds_b_ant_brc.fugas_hipotecario_observadas`
WHERE fecha_informacion BETWEEN val_first_day AND val_last_day ;
END;


CREATE PROCEDURE ds_b_sp_core.fugas_total_personal_observadas_calificacion(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-oro-prod.ds_oro_generico.t_b_ant_fugas_total_personal_observadas` ( cliente_id,
objetivo,
fecha_abandono,
prediccion_umbral,
fecha_informacion)
SELECT
a.cliente_id,
a.objetivo,
a.fecha_abandono,
b.prediccion_umbral,
b.fecha_informacion
FROM ((
SELECT
*
FROM
`bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_total_personal_observadas`
WHERE
fecha_abandono BETWEEN val_first_day
AND val_last_day) a
RIGHT JOIN (
SELECT
*
FROM
`bnt-lakehouse-oro-prod.ds_b_ant_oro.t_b_ant_calif_abandono_total_hist_vxx`
WHERE
fecha_informacion BETWEEN val_first_day
AND LAST_DAY(val_first_day)) b
ON
a.cliente_id=b.cliente_id and a.fecha_informacion=b.fecha_informacion);
END;


CREATE PROCEDURE ds_b_sp_core.fugas_total_personal_observadas_plata(val_first_day DATE, val_last_day DATE)
BEGIN 
INSERT INTO  `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_total_personal_observadas` (
cliente_id,
fecha_informacion,
objetivo,
fecha_abandono
)
SELECT  
CAST(clie_final AS INT64) ,
fecha_obs ,
CAST(target AS INT64) ,
fecha_abandono
FROM  `bnt-lakehouse-brc-prod.ds_b_ant_brc.fugas_total_personal_observadas`
WHERE fecha_abandono BETWEEN val_first_day AND val_last_day ;
END;


CREATE PROCEDURE ds_b_sp_core.insumos_abandono_hipoteca_hist_plata(val_first_day DATE, val_last_day DATE)
OPTIONS(
description="pase a plata")
BEGIN
INSERT INTO `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_ins_abn_hip_hist_vxx`
SELECT
CAST(credito as INT64)credito,
mth,
plazo,
impcred,
impgaranti,
tasacobrad,
n_saldocontable,
modalidad,
tipo_ingreso,
broker,
f_broker,
mob,
exigible,
pago,
n_plazo_remanente,
n_ltv,
nivel_riesgo,
prom_vpago,
CAST(sic as INT64)sic,
consulta_1m,
consulta_3m,
consulta_6m,
consulta_12m,
max_npv,
ltv,
ltv_cierre,
n_score_riesgo
FROM
`bnt-lakehouse-brc-prod.ds_b_ant_brc.insumos_abandono_hipoteca_hist`
WHERE
mth BETWEEN val_first_day AND val_last_day;
END;


CREATE PROCEDURE ds_b_sp_core.modelin_plata(val_first_day INT64, val_last_day INT64)
BEGIN
INSERT INTO bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_modelin (
cliente_id,
fecha_informacion,
txn_depositos_nom_numero,
txn_retiros_nom_numero,
txn_retiros_nom_offus_numero,
sdoprom_mens_fondos_inversion_monto,
sdoprom_trim_casa_bolsa_monto,
sdoprom_mens_pagare_plazo_monto,
sdoprom_mens_vista_monto,
sdoprom_mens_mesa_dinero_monto,
fact_total_tdc_monto,
uso_mensual_tdc_pct,
meses_antig_tdc_numero,
saldo_total_cierre_tdc_monto,
linea_max_tdc_monto,
tenencia_auto_bandera,
tenencia_bxi_bandera,
tenencia_casa_bolsa_bandera,
tenencia_credito_nomina_bandera,
tenencia_hipo_bandera,
tenencia_mesa_dinero_bandera,
tenencia_credito_personal_bandera,
tenencia_pagare_plazo_bandera,
tenencia_seguros_bandera,
tenencia_fondos_inversion_bandera,
tenencia_tdc_bandera,
tenencia_vista_bandera,
antig_emisora_meses_numero,
depositos_nom_monto,
retiros_nom_monto,
max_auto_offus_monto,
max_hipo_offus_monto,
max_credito_personal_offus_monto,
monto_max_tdc_offus_monto,
antig_cliente_meses_numero,
saldo_total_auto_monto,
saldo_total_auto_offus_monto,
saldo_total_hipo_offus_monto,
saldo_total_tdc_offus_monto,
total_credito_personal_offus_monto,
score_bc_monto,
tdc_offus_numero,
total_auto_offus_numero,
total_hipo_offus_numero,
credito_personal_offus_numero,
genero_femenino_bandera,
score_bc_bandera,
edad_cliente_anios_numero,
nom_3m_bandera,
uso_tdc_offus_monto,
uso_credito_personal_offus_monto,
txn_ropa_numero,
fact_ropa_numero,
txn_teletrabajo_material_numero,
fact_teletrabajo_material_monto,
txn_teletrabajo_servicios_numero,
fact_teletrabajo_servicios_monto,
txn_hoteles_moteles_numero,
fact_hoteles_moteles_monto,
txn_transporte_publico_numero,
fact_transporte_publico_monto,
txn_asociaciones_numero,
fact_asociaciones_monto,
txn_aerolineas_numero,
fact_aerolineas_monto,
txn_renta_auto_numero,
fact_renta_auto_monto,
txn_transporte_priv_numero,
fact_transporte_priv_monto,
txn_cuidado_personal_numero,
fact_cuidado_personal_monto,
txn_transporte_botes_numero,
fact_transporte_botes_monto,
txn_bienes_energeticos_numero,
fact_bienes_energeticos_monto,
txn_gasolineria_numero,
fact_gasolineria_monto,
txn_farmacias_numero,
fact_farmacias_monto,
txn_entretenimiento_numero,
fact_entretenimiento_monto,
txn_servicios_legales_numero,
fact_servicios_legales_monto,
txn_electronicos_digital_numero,
fact_electronicos_digital_monto,
txn_financiera_numero,
fact_financiera_monto,
txn_gastos_medicos_numero,
fact_gastos_medicos_monto,
txn_alimentos_numero,
fact_alimentos_monto,
txn_servicios_personales_numero,
fact_servicios_personales_monto,
txn_educacion_numero,
fact_educacion_monto,
txn_tiendas_gral_numero,
fact_tiendas_gral_monto,
txn_transporte_otros_numero,
fact_transporte_otros_monto,
txn_mudanza_numero,
fact_mudanza_monto,
txn_servicios_transporte_numero,
fact_servicios_transporte_monto,
txn_ropa_accesorios_numero,
fact_ropa_accesorios_monto,
txn_imprenta_numero,
fact_imprenta_monto,
txn_veterinario_numero,
fact_veterinario_monto,
txn_restaurantes_numero,
fact_restaurantes_monto,
txn_servicios_infantiles_numero,
fact_servicios_infantiles_monto,
txn_comunicacion_numero,
fact_comunicacion_monto,
txn_apuestas_numero,
fact_apuestas_monto,
txn_servicios_funerarios_numero,
fact_servicios_funerarios_monto,
inicio_sesion_app_movil_numero
)
SELECT
CAST(num_clie AS INT64),
obs,
txn_dep,
txn_ret,
txn_r3,
sp_socinv,
sp_cb,
sp_plazo,
sp_vista,
sp_mesa,
fact,
util_tdc,
mobs_tdc,
sdo_cierre_tdc,
ambs_crlim,
fam_auto,
fam_bxi,
fam_casabolsa,
fam_crednomina,
fam_hipo,
fam_mesadinero,
fam_personal,
fam_plazo,
fam_seguros,
fam_sociedades,
fam_tdc,
fam_vista,
mobs_emi,
monto_dep,
monto_ret,
max_limau_offus,
max_limhipo_offus,
max_limpln_offus,
max_limtdc_offus,
mobs,
sdo_auto,
sdoau_offus,
sdohipo_offus,
sdotdc_offus,
sdopln_offus,
score_value,
num_tdc_offus,
num_au_offus,
num_hipo_offus,
num_pln_offus,
sexo_f,
tienescore,
edad,
es_nomina,
hbtdc_offus,
hbpln_offus,
txn_apparel,
fact_apparel,
txn_home_office_m,
fact_home_office_m,
txn_home_office_s,
fact_home_office_s,
txn_hotels_motels,
fact_hotels_motels,
txn_public_transp,
fact_public_transp,
txn_associations,
fact_associations,
txn_airlines,
fact_airlines,
txn_car_rental,
fact_car_rental,
txn_private_transp,
fact_private_transp,
txn_personal_care,
fact_personal_care,
txn_transp_boats,
fact_transp_boats,
txn_energy_goods,
fact_energy_goods,
txn_gas_station,
fact_gas_station,
txn_drugstores,
fact_drugstores,
txn_entertainment,
fact_entertainment,
txn_legal_services,
fact_legal_services,
txn_elec_dig,
fact_elec_dig,
txn_financial,
fact_financial,
txn_medical_ex,
fact_medical_ex,
txn_food_groceries,
fact_food_groceries,
txn_personal_s,
fact_personal_s,
txn_education,
fact_education,
txn_general_stores,
fact_general_stores,
txn_transp_other,
fact_transp_other,
txn_moving_storage,
fact_moving_storage,
txn_transp_service,
fact_transp_service,
txn_app_acc,
fact_app_acc,
txn_publish_print,
fact_publish_print,
txn_vet_pets,
fact_vet_pets,
txn_restaurants,
fact_restaurants,
txn_chil_ser,
fact_chil_ser,
txn_communications,
fact_communications,
txn_gambling,
fact_gambling,
txn_funeral_s,
fact_funeral_s,
logins
FROM bnt-lakehouse-brc-prod.ds_b_ant_brc.modelin
WHERE obs BETWEEN val_first_day AND val_last_day ;
END;



CREATE PROCEDURE ds_b_sp_core.perf_opt_plata(val_first_day DATE, val_last_day DATE)
BEGIN
INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_col_plt.t_b_col_tdc_mensual` (ambs_acct_id,
sdo_total_fin_monto,
clasificacion1_bandera,
mes_fecha,
ambs_abierta_fecha,
ambs_bloqueo_codigo_1,
ambs_bloqueo_codigo_2,
fecha_informacion
)
SELECT
ambs_acct,
sdo_total_fin,
clasificacion1,
mth,
ambs_date_opened,
ambs_block_code_1,
ambs_block_code_2,
fecha_informacion
FROM
`bnt-lakehouse-brc-prod.ds_b_col_brc.perf_opt` WHERE fecha_informacion BETWEEN val_first_day AND val_last_day ;
END;

CREATE PROCEDURE ds_b_sp_core.segmentocliendim_opt_oro()
BEGIN
truncate table `bnt-lakehouse-oro-prod.ds_b_dwh_cat_oro.t_b_dwh_cat_segmentos`;
INSERT INTO
`bnt-lakehouse-oro-prod.ds_b_dwh_cat_oro.t_b_dwh_cat_segmentos` (pdimsegmento_numero,
bancagrup_tipo,
segmentogrupclav_numero,
segmentogrupdes_desc,
segmentoclav_numero,
segmentodes_desc,
segmentodesalt_desc,
segmentoclavalt_desc,
subsegmento_numero
)
SELECT
pdimsegmento_numero,
bancagrup_tipo,
segmentogrupclav_numero,
segmentogrupdes_desc,
segmentoclav_numero,
segmentodes_desc,
segmentodesalt_desc,
segmentoclavalt_desc,
subsegmento_numero
FROM
`bnt-lakehouse-plt-prod.ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos`;
END;


CREATE PROCEDURE ds_b_sp_core.segmentocliendim_opt_plata()
BEGIN
truncate table `bnt-lakehouse-plt-prod.ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos`;
INSERT INTO
`bnt-lakehouse-plt-prod.ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos` (pdimsegmento_numero,
bancagrup_tipo,
segmentogrupclav_numero,
segmentogrupdes_desc,
segmentoclav_numero,
segmentodes_desc,
segmentodesalt_desc,
segmentoclavalt_desc,
subsegmento_numero
)
SELECT
pdimsegmento,
bancagrup,
segmentogrupclav,
segmentogrupdes,
segmentoclav,
segmentodes,
segmentodesalt,
segmentoclavalt,
subsegmento
FROM
`bnt-lakehouse-brc-prod.ds_b_dwh_cat_brc.segmentocliendim_opt`;
END;


CREATE PROCEDURE ds_b_sp_core.segmentos_clientes_opt_plata(val_first_day DATE, val_last_day DATE)
OPTIONS(
description="pase a plata")
BEGIN
INSERT INTO bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_segmentos
SELECT
cast(num_clie as int64)num_clie,
segmento,
subsegmento,
fecha_informacion
FROM bnt-lakehouse-brc-prod.ds_b_cli_brc.segmentos_clientes_opt
WHERE fecha_informacion BETWEEN val_first_day AND val_last_day;
END;