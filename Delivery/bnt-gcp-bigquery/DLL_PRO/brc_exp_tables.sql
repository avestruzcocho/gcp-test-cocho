#bnt-lakehouse-brc-pro
#Tablas 

#ds_b_ant_brc
CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.adquisiciones_productos_observadas`
(
sic FLOAT64 OPTIONS(description="Número de cliente"),
producto STRING(6) OPTIONS(description="Tipo de producto"),
num_caso INT64 OPTIONS(description="Número de caso"),
fecha_captura DATE OPTIONS(description="Fecha de captura"),
first_value_decreto STRING(80) OPTIONS(description="Primer decreto"),
decreto STRING(80) OPTIONS(description="Descripción decreto"),
max_nun_credito FLOAT64 OPTIONS(description="Número de crédito"),
num_credito FLOAT64 OPTIONS(description="Número de crédito"),
grupo STRING(14) OPTIONS(description="Tipo grupo")
)
PARTITION BY fecha_captura
OPTIONS(
description="Tabla de Fugas Propension Productos",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.codigos_postales_mexico_ii`
(
d_codigo INT64 OPTIONS(description="Llave"),
codpos_long FLOAT64 OPTIONS(description="Latitud del código postal del cliente"),
codpos_lat FLOAT64 OPTIONS(description="Longitud del código postal del cliente")
)
OPTIONS(
description="Tabla de códigos postales. Latitud y longitud del código postal de los clientes",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.fugas_hipotecario_observadas`
(
num_clie FLOAT64 OPTIONS(description="Número de cliente"),
credito FLOAT64 OPTIONS(description="Número de crédito evaluado"),
flag_fuga FLOAT64 OPTIONS(description="1: Si el cliente movió su crédito hipotecario a otro banco 0: El cliente mantuvo su crédito hipotecario en el banco"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY fecha_informacion
OPTIONS(
description="Tabla de Fugas Abandono Hipotecario",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.fugas_total_personal_observadas`
(
clie_final FLOAT64 OPTIONS(description="Número de cliente"),
fecha_obs DATE OPTIONS(description="Fecha de información"),
target FLOAT64 OPTIONS(description="1: Si el cliente abandono, 0: Si el cliente no abandono"),
fecha_abandono DATE OPTIONS(description="Fecha de abandono")
)
PARTITION BY fecha_abandono
OPTIONS(
description="Tabla de Fugas Abandono Total",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.insumos_abandono_hipoteca_hist`
(
credito FLOAT64 OPTIONS(description="Número de crédito"),
mth DATE OPTIONS(description="Fecha de información (mth de month)"),
plazo FLOAT64 OPTIONS(description="Plazo del crédito"),
impcred FLOAT64 OPTIONS(description="Importe del crédito"),
impgaranti FLOAT64 OPTIONS(description="Valor de la garantía"),
tasacobrad FLOAT64 OPTIONS(description="Tasa cobrada"),
n_saldocontable FLOAT64 OPTIONS(description="Saldo contable último en balance, previo a la liquidación"),
modalidad FLOAT64 OPTIONS(description="Modalidad del crédito"),
tipo_ingreso STRING OPTIONS(description="Tipo de ingreso"),
broker STRING OPTIONS(description="Bróker del cliente"),
f_broker FLOAT64 OPTIONS(description="Tiene bróker Es una flag o indicadora (0 si no tiene, 1 si tiene)"),
mob FLOAT64 OPTIONS(description="Antigüedad del crédito en meses"),
exigible FLOAT64 OPTIONS(description="Pago exigible al crédito hipotecario"),
pago FLOAT64 OPTIONS(description="Pago al crédito hipotecario"),
n_plazo_remanente FLOAT64 OPTIONS(description="Plazo remanente"),
n_ltv FLOAT64 OPTIONS(description="Aforo del crédito"),
nivel_riesgo STRING OPTIONS(description="Nivel de riesgo del cliente"),
prom_vpago FLOAT64 OPTIONS(description="Promedio de voluntad de pago 7 meses"),
sic FLOAT64 OPTIONS(description="Número de cliente"),
consulta_1m FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en el último mes"),
consulta_3m FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 3 meses"),
consulta_6m FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 6 meses"),
consulta_12m FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 12 meses"),
max_npv FLOAT64 OPTIONS(description="Máxima morosidad histórica, pv es pagos vencidos, es muy conocido este concepto en el banco"),
ltv FLOAT64 OPTIONS(description="Importe del crédito / Valor de la garantía LTV es loan to value, también un término muy conocido en el banco"),
ltv_cierre FLOAT64 OPTIONS(description="Saldo actual a mes de cierre / importe del crédito "),
n_score_riesgo FLOAT64 OPTIONS(description="Es el score de riesgos, es un valor entre 0 y 1000")
)
PARTITION BY DATE_TRUNC(mth, MONTH)
OPTIONS(
description="Tabla de clientes listos para ser calificados por el modelo de abandono hipotecario",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_ant_brc.modelin`
(
num_clie FLOAT64 OPTIONS(description="Número de cliente"),
obs INT64 OPTIONS(description="Fecha de información"),
txn_dep FLOAT64 OPTIONS(description="Número de transacciones de depósito en Nómina"),
txn_ret FLOAT64 OPTIONS(description="Número de transacciones de retiro de Nómina"),
txn_r3 FLOAT64 OPTIONS(description="Número de transacciones de retiro de la cuenta de Nómina a una cuenta externa"),
sp_socinv FLOAT64 OPTIONS(description="Saldo promedio mensual en Fondos de Inversión"),
sp_cb FLOAT64 OPTIONS(description="Saldo promedio trimestral Casa de Bolsa"),
sp_plazo FLOAT64 OPTIONS(description="Saldo promedio mensual en pagares a plazos"),
sp_vista FLOAT64 OPTIONS(description="Saldo promedio vista"),
sp_mesa FLOAT64 OPTIONS(description="Saldo promedio mensual en mesa de dinero"),
fact FLOAT64 OPTIONS(description="Suma de la facturación en Tarjeta de crédito"),
util_tdc FLOAT64 OPTIONS(description="Porcentaje de utilización de la Tarjeta de Crédito mensual (suma de saldos / suma de límites de crédito)"),
mobs_tdc FLOAT64 OPTIONS(description="Mínima antigüedad en Tarjetas de Crédito"),
sdo_cierre_tdc FLOAT64 OPTIONS(description="Saldo total en TDC's"),
ambs_crlim FLOAT64 OPTIONS(description="Máximo límite de Crédito en TDC off-us"),
fam_auto FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito automotriz, 1 si tiene, 0 si no tiene"),
fam_bxi FLOAT64 OPTIONS(description="Flag o indicadora de banca por internet (la banca por internet no es lo mismo que la banca móvil)"),
fam_casabolsa FLOAT64 OPTIONS(description="Flag o indicadore de Casa de Bolsa"),
fam_crednomina FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito de nómina"),
fam_hipo FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito hipotecario"),
fam_mesadinero FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de mesa de dinero"),
fam_personal FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito personal"),
fam_plazo FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de pagares a plazos"),
fam_seguros FLOAT64 OPTIONS(description="Si el cliente cuenta con seguro"),
fam_sociedades FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de fondos de inversión"),
fam_tdc FLOAT64 OPTIONS(description="Flago o indicadora de tenencia de tarjeta de crédito"),
fam_vista FLOAT64 OPTIONS(description="Indicadora de tenencia de Producto vista"),
mobs_emi NUMERIC(20) OPTIONS(description="Antigüedad en meses de la emisora"),
monto_dep FLOAT64 OPTIONS(description="Monto depositado a cuenta de nómina"),
monto_ret FLOAT64 OPTIONS(description="Monto retirado de cuenta de nómina"),
max_limau_offus FLOAT64 OPTIONS(description="Máximo límite en créditos de auto off-us"),
max_limhipo_offus FLOAT64 OPTIONS(description="Máximo límite en créditos hipotecarios off-us"),
max_limpln_offus FLOAT64 OPTIONS(description="Máximo límite en créditos personales off-us"),
max_limtdc_offus FLOAT64 OPTIONS(description="Máximo límite en tarjetas de crédito off-us"),
mobs FLOAT64 OPTIONS(description="Antigüedad en banorte"),
sdo_auto FLOAT64 OPTIONS(description="Saldo total crédito auto"),
sdoau_offus FLOAT64 OPTIONS(description="Saldo total crédito auto off-us"),
sdohipo_offus FLOAT64 OPTIONS(description="Saldo total crédito hipotecario off-us"),
sdotdc_offus FLOAT64 OPTIONS(description="Saldo total tarjeta de crédito off-us"),
sdopln_offus FLOAT64 OPTIONS(description="Saldo total crédito préstamo personal off-us"),
score_value FLOAT64 OPTIONS(description="Score de buró de crédito"),
num_tdc_offus FLOAT64 OPTIONS(description="Número de tarjetas de crédito off-us"),
num_au_offus FLOAT64 OPTIONS(description="Número de créditos de auto off-us"),
num_hipo_offus FLOAT64 OPTIONS(description="Número de créditos hipotecarios off-us"),
num_pln_offus FLOAT64 OPTIONS(description="Número de prestamos personales off-us"),
sexo_f FLOAT64 OPTIONS(description="Flag o indicadora si el cliente es mujer"),
tienescore FLOAT64 OPTIONS(description="Flag o indicadora si el cliente tiene score"),
edad FLOAT64 OPTIONS(description="Edad del cliente"),
es_nomina FLOAT64 OPTIONS(description="Haber recibido más de 100 pesos en nomina en los ultimos 3 meses"),
hbtdc_offus FLOAT64 OPTIONS(description="Monto ocupado de su límite de crédito en TDC off-us"),
hbpln_offus FLOAT64 OPTIONS(description="Monto ocupado de su límite de crédito personal off-us"),
txn_apparel BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Apparel"),
fact_apparel BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Apparel"),
txn_home_office_m BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Home Office Material"),
fact_home_office_m BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Home Office Material"),
txn_home_office_s BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Home Office Services"),
fact_home_office_s BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Home Office Services"),
txn_hotels_motels BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Hotels Motels"),
fact_hotels_motels BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Hotels Motels"),
txn_public_transp BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Public Transport"),
fact_public_transp BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Public Transport"),
txn_associations BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Associations"),
fact_associations BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Associations"),
txn_airlines BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Airlines"),
fact_airlines BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Airlines"),
txn_car_rental BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Car Rental"),
fact_car_rental BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Car Rental"),
txn_private_transp BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Private Transport"),
fact_private_transp BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Private Transport"),
txn_personal_care BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Personal Care"),
fact_personal_care BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Personal Care"),
txn_transp_boats BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transport Boats"),
fact_transp_boats BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transport Boats"),
txn_energy_goods BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Energy Goods"),
fact_energy_goods BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Energy Goods"),
txn_gas_station BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Gas Station"),
fact_gas_station BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Gas Station"),
txn_drugstores BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Drugstores"),
fact_drugstores BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Drugstores"),
txn_entertainment BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Entertainment"),
fact_entertainment BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Entertainment"),
txn_legal_services BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Legal Services"),
fact_legal_services BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Legal Services"),
txn_elec_dig BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Electronics Digital"),
fact_elec_dig BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Electronics Digital"),
txn_financial BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Financial"),
fact_financial BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Financial"),
txn_medical_ex BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Medical Expenses"),
fact_medical_ex BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Medical Expenses"),
txn_food_groceries BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Food Groceries"),
fact_food_groceries BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Food Groceries"),
txn_personal_s BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Personal Services"),
fact_personal_s BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Personal Services"),
txn_education BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Education"),
fact_education BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Education"),
txn_general_stores BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en General Stores"),
fact_general_stores BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en General Stores"),
txn_transp_other BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transport Other"),
fact_transp_other BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transport Other"),
txn_moving_storage BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Moving Storage"),
fact_moving_storage BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Moving Storage"),
txn_transp_service BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transportation Services"),
fact_transp_service BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transportation Services"),
txn_app_acc BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Apparel Accesory"),
fact_app_acc BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Apparel Accesory"),
txn_publish_print BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Publishing Printing"),
fact_publish_print BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Publishing Printing"),
txn_vet_pets BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Veterinary Pets"),
fact_vet_pets BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Veterinary Pets"),
txn_restaurants BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Restaurants"),
fact_restaurants BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Restaurants"),
txn_chil_ser BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Children Services"),
fact_chil_ser BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Children Services"),
txn_communications BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Communications"),
fact_communications BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Communications"),
txn_gambling BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Gambling"),
fact_gambling BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Gambling"),
txn_funeral_s BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Funeral Services"),
fact_funeral_s BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Funeral Services"),
logins BIGNUMERIC(38) OPTIONS(description="Número de logeos en la APP móvil")
)
PARTITION BY RANGE_BUCKET(obs, GENERATE_ARRAY(200000, 209999, 1))
OPTIONS(
description="Tabla que contiene la concentración de datos agregados que permiten tener una visión global del cliente. Es un reporte previo a la generación de variables.",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);


#ds_b_cap_brc
CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_cap_brc.ctasactnom_opt`
(
  num_clie NUMERIC(8) OPTIONS(description="Número de cliente Altamira"),
  mth DATE OPTIONS(description="Mes y año de la información"),
  importe_acum NUMERIC(12, 2) OPTIONS(description="Acumulado de dispersiones de nómina recibidas en el mes y año de información"),
  fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
  description="Tabla con información de cuentas que reciben dispersiones de nómina, concentrado mensual",
  labels=[("capa", "bronce"), ("tipo", "produccion")]
);

#ds_b_cli_brc

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_cli_brc.altamira_fusiones_fin_opt`
(
clie_fusio INT64 OPTIONS(description="Número de cliente que se fusiona"),
clie_perm INT64 OPTIONS(description="Número de cliente que permanece tras una fusión"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de relación de último cliente que permanece despues de la fusión",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_cli_brc.altclientedim_sas_opt`
(
num_clie NUMERIC(8) OPTIONS(description="Número de cliente Altamira"),
fecha_alta DATE OPTIONS(description="Fecha de alta del cliente Altamira"),
tipo_persona STRING(5) OPTIONS(description="Tipo de personalidad jurídica del cliente (PF, PFAE, PM)"),
fecha_nac DATE OPTIONS(description="Fecha de nacimiento del cliente"),
estudios STRING(30) OPTIONS(description="Escolaridad máxima del cliente"),
cp NUMERIC(5) OPTIONS(description="Código Postal"),
tel1 STRING(17) OPTIONS(description="Teléfono del cliente (Primero de 3 disponibles en Altamira)"),
e_mail STRING(50) OPTIONS(description="Correo electrónico del cliente"),
reus STRING(2) OPTIONS(description="Bandera REUS (Clientes que no desean ser contactados para ofertas comerciales)"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de información de clientes activos (Aquellos con por lo menos alguna relación activa de producto) del Banco",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_cli_brc.altclienterelcuen_sas_opt`
(
num_clie NUMERIC(12) OPTIONS(description="Número de cliente del producto"),
cuenta INT64 OPTIONS(description="Número de cuenta Altamira"),
tipo STRING(20) OPTIONS(description="Nombre de la familia de producto"),
estatus STRING(10) OPTIONS(description="Estatus de la cuenta"),
nom_subp STRING(100) OPTIONS(description="Nombre del producto"),
fecha_informacion DATE OPTIONS(description="Fecha de la información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de información de la relación de cuenta cliente con empresa",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_cli_brc.segmentos_clientes_opt`
(
num_clie NUMERIC(8) OPTIONS(description="Número de cliente Altamira"),
segmento STRING(3) OPTIONS(description="Descripción segmento del cliente"),
subsegmento NUMERIC(2) OPTIONS(description="Descripción subsegmento del cliente"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla que Contiene el nivel al que corresponde el cliente",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

#ds_b_col_brc

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_col_brc.perf_opt`
(
  ambs_acct STRING(20) OPTIONS(description="Número de cuenta"),
  sdo_total_fin FLOAT64 OPTIONS(description="Saldo total al cierre, incluye promociones"),
  clasificacion1 STRING(2) OPTIONS(description="Bandera (SI/NO) cuenta clasificada (Vigente/Vencida) y no clasificada"),
  mth DATE OPTIONS(description="Mes y año de la información"),
  ambs_date_opened DATE OPTIONS(description="Fecha de apertura de la cuenta"),
  ambs_block_code_1 STRING(1) OPTIONS(description="Código de bloqueo 1"),
  ambs_block_code_2 STRING(1) OPTIONS(description="Código de bloqueo 2"),
  fecha_informacion DATE OPTIONS(description="Fecha de ejecución")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
  description="Tabla de perfil de Pago tarjeta de credito",
  labels=[("capa", "bronce"), ("tipo", "desarrollo")]
);

#ds_b_dwh_cap_brc

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_dwh_cap_brc.altchequesfact_opt`
(
  cuenta STRING(19) OPTIONS(description="Cuenta de cheques, llave única en sistema Altamira"),
  fechaultmov DATE OPTIONS(description=" Fecha del último movimiento"),
  pdimcliente NUMERIC(9) OPTIONS(description="Llave foranea (subrogada) de la dimensión Cliente, la interfase contiene el campo CLAVE_CLIENTE con el valor del Cliente Altamira"),
  pdimproducto NUMERIC(9) OPTIONS(description="Llave foranea (subrogada) de la dimensión Producto conformada por aplicativo"),
  pdimtiempo DATE OPTIONS(description="Corresponde a la fecha del registro"),
  saldodisval NUMERIC(17, 2) OPTIONS(description="Saldo disponible al cierre del día valorizado")
)
PARTITION BY DATE_TRUNC(pdimtiempo, MONTH)
OPTIONS(
  description="Tabla de Hechos de Créditos APOLO, contiene saldos financieros y contables por Línea y Crédito",
  labels=[("capa", "bronce"), ("tipo", "produccion")]
);


#ds_b_dwh_cat_brc

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_dwh_cat_brc.segmentocliendim_opt`
(
  pdimsegmento NUMERIC(9) OPTIONS(description="Llave subrogada primaria de la tabla SegmentoDim"),
  bancagrup STRING(20) OPTIONS(description="Clave de Banca o Área de Negocio (ya no está en uso)"),
  segmentogrupclav NUMERIC(18) OPTIONS(description="Clave de agrupación de Segmentos como Personal o Pymes, tiene como objetivo agregar todos los segmentos relacionados."),
  segmentogrupdes STRING(30) OPTIONS(description="Descripción de agrupación de Segmentos como Personal o Pymes, tiene como objetivo agregar todos los segmentos relacionados."),
  segmentoclav NUMERIC(18) OPTIONS(description="Clave de segmento de cliente que describe el perfil financiero basado en sus productos y actividad."),
  segmentodes STRING(30) OPTIONS(description="Descripción de segmento de cliente que describe el perfil financiero basado en sus productos y actividad."),
  segmentodesalt STRING(30) OPTIONS(description="Descripción de segmento de cliente que describe el perfil financiero basado en sus productos y actividad."),
  segmentoclavalt STRING(5) OPTIONS(description="Clave alfanumérica que se registra en Altamira para el Segmento."),
  subsegmento NUMERIC(9) OPTIONS(description="Clave de subsegmento (ya no está en uso)")
)
OPTIONS(
  description="Tabla de catálogo que contiene los atributos de la relacion Cliente - Segmento",
  labels=[("capa", "bronce"), ("tipo", "produccion")]
);


#ds_b_dwh_cli_brc
CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_dwh_cli_brc.altclientedim_opt`
(
  numerocif STRING,
  pdimcliente NUMERIC,
  tipoperclav NUMERIC,
  aniosresdom STRING,
  sexo STRING,
  estadociv STRING,
  nivelestclav NUMERIC,
  estadoclav NUMERIC,
  ocupacionpmclav NUMERIC,
  ocupacionpfclav NUMERIC,
  codigopos STRING
);


#  ds_b_rie_brc

CREATE TABLE `bnt-lakehouse-brc-pro.ds_b_rie_brc.crm_base_ingresos_opt`
(
  ing_mensual FLOAT64 OPTIONS(description="Ingreso mensual estimado productivo"),
  sic NUMERIC(13) OPTIONS(description="Número de cliente"),
  metodo STRING(20) OPTIONS(description="Método con el cual fue calculado el ingreso"),
  retrospectivo NUMERIC(6) OPTIONS(description="1: Si la estimación de ingresos es Retrospectivo, hace 12 meses, 0: Si la estimación se hizo con base a información reciente."),
  fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
  description="Tabla de Cliente-Ingresos.Es el estimador de la base de ingresos",
  labels=[("capa", "bronce"), ("tipo", "produccion")]
);