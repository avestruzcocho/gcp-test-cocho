#bnt-lakehouse-plt-prod
#ds_b_ant_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_adquisiciones_productos_observadas`
(
cliente_id INT64 OPTIONS(description="Número de cliente"),
producto_tipo STRING(6) OPTIONS(description="Tipo de producto"),
num_caso INT64 OPTIONS(description="Número de caso"),
fecha_informacion DATE OPTIONS(description="Fecha de captura"),
primer_valor_decreto STRING(80) OPTIONS(description="Primer decreto"),
decreto_desc STRING(80) OPTIONS(description="Descripción decreto"),
max_nun_credito FLOAT64 OPTIONS(description="Número de crédito"),
num_credito FLOAT64 OPTIONS(description="Número de crédito"),
grupo_tipo STRING(14) OPTIONS(description="Tipo grupo")
)
PARTITION BY fecha_informacion
OPTIONS(
description="Tabla de Fugas Propension Productos",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);


CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_codigos_postales`
(
d_codigo_id INT64 OPTIONS(description="Llave"),
codpos_long_numero FLOAT64 OPTIONS(description="Latitud del código postal del cliente"),
codpos_lat_numero FLOAT64 OPTIONS(description="Longitud del código postal del cliente")
)
OPTIONS(
description="Tabla de códigos postales. Latitud y longitud del código postal de los clientes",
labels=[("capa", "plata"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_hipotecario_observadas`
(
cliente_id INT64 OPTIONS(description="Número de cliente"),
credito INT64 OPTIONS(description="Número de crédito evaluado"),
fuga_bandera INT64 OPTIONS(description="1: Si el cliente movió su crédito hipotecario a otro banco 0: El cliente mantuvo su crédito hipotecario en el banco"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY fecha_informacion
OPTIONS(
description="Tabla de Fugas Abandono Hipotecario",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_fugas_total_personal_observadas`
(
cliente_id INT64 OPTIONS(description="Número de cliente"),
fecha_informacion DATE OPTIONS(description="Fecha de información"),
objetivo INT64 OPTIONS(description="1: Si el cliente abandono, 0: Si el cliente no abandono"),
fecha_abandono DATE OPTIONS(description="Fecha de abandono")
)
PARTITION BY fecha_abandono
OPTIONS(
description="Tabla de Fugas Abandono Total",
labels=[("capa", "bronce"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_ins_abn_hip_hist_vxx`
(
credito_numero INT64 OPTIONS(description="Número de crédito"),
mes_fecha DATE OPTIONS(description="Fecha de información (mth de month)"),
plazo_total_credito_meses_numero FLOAT64 OPTIONS(description="Plazo del crédito"),
credito_monto FLOAT64 OPTIONS(description="Importe del crédito"),
garantia_monto FLOAT64 OPTIONS(description="Valor de la garantía"),
tasa_cobrada_pct FLOAT64 OPTIONS(description="Tasa cobrada"),
contable_ultimo_balance_saldo FLOAT64 OPTIONS(description="Saldo contable último en balance, previo a la liquidación "),
modalidad_credito_cve FLOAT64 OPTIONS(description="Modalidad del crédito"),
ingreso_tipo STRING OPTIONS(description="Tipo de ingreso"),
broker_nombre STRING OPTIONS(description="Bróker del cliente"),
broker_bandera FLOAT64 OPTIONS(description="Tiene bróker Es una flag o indicadora (0 si no tiene, 1 si tiene)"),
antig_credito_meses_numero FLOAT64 OPTIONS(description="Antigüedad del crédito en meses"),
pago_exigible_monto FLOAT64 OPTIONS(description="Pago exigible al crédito hipotecario"),
pago_monto FLOAT64 OPTIONS(description="Pago al crédito hipotecario"),
plazo_remanente_credito_numero FLOAT64 OPTIONS(description="Plazo remanente"),
aforo_monto FLOAT64 OPTIONS(description="Aforo del crédito"),
nivel_riesgo_cliente_tipo STRING OPTIONS(description="Nivel de riesgo del cliente"),
prom_voluntad_pago_7m_monto FLOAT64 OPTIONS(description="Promedio de voluntad de pago 7 meses"),
cliente_id INT64 OPTIONS(description="Número de cliente"),
consultas_buro_1m_numero FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en el último mes"),
consultas_buro_3m_numero FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 3 meses"),
consultas_buro_6m_numero FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 6 meses"),
consultas_buro_12m_numero FLOAT64 OPTIONS(description="Número de consultas a buró de crédito en los últimos 12 meses"),
max_num_pagos_vencidos_numero FLOAT64 OPTIONS(description="Máxima morosidad histórica, pv es pagos vencidos, es muy conocido este concepto en el banco"),
pct_ltv_monto FLOAT64 OPTIONS(description="Importe del crédito / Valor de la garantía LTV es loan to value, también un término muy conocido en el banco"),
pct_ltv_cierre_monto FLOAT64 OPTIONS(description="Saldo actual a mes de cierre / importe del crédito "),
score_riesgo_numero FLOAT64 OPTIONS(description="Es el score de riesgos, es un valor entre 0 y 1000")
)
PARTITION BY DATE_TRUNC(mes_fecha, MONTH)
OPTIONS(
description="Tabla de clientes listos para ser calificados por el modelo de abandono hipotecario",
labels=[("capa", "plata"), ("tipo", "produccion")]
);


CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_ant_plt.t_b_ant_modelin`
(
cliente_id INT64 OPTIONS(description="Número de cliente"),
fecha_informacion INT64 OPTIONS(description="Fecha de información"),
txn_depositos_nom_numero FLOAT64 OPTIONS(description="Número de transacciones de depósito en Nómina"),
txn_retiros_nom_numero FLOAT64 OPTIONS(description="Número de transacciones de retiro de Nómina"),
txn_retiros_nom_offus_numero FLOAT64 OPTIONS(description="Número de transacciones de retiro de la cuenta de Nómina a una cuenta externa"),
sdoprom_mens_fondos_inversion_monto FLOAT64 OPTIONS(description="Saldo promedio mensual en Fondos de Inversión"),
sdoprom_trim_casa_bolsa_monto FLOAT64 OPTIONS(description="Saldo promedio trimestral Casa de Bolsa"),
sdoprom_mens_pagare_plazo_monto FLOAT64 OPTIONS(description="Saldo promedio mensual en pagares a plazos"),
sdoprom_mens_vista_monto FLOAT64 OPTIONS(description="Saldo promedio vista"),
sdoprom_mens_mesa_dinero_monto FLOAT64 OPTIONS(description="Saldo promedio mensual en mesa de dinero"),
fact_total_tdc_monto FLOAT64 OPTIONS(description="Suma de la facturación en Tarjeta de crédito"),
uso_mensual_tdc_pct FLOAT64 OPTIONS(description="Porcentaje de utilización de la Tarjeta de Crédito mensual (suma de saldos / suma de límites de crédito)"),
meses_antig_tdc_numero FLOAT64 OPTIONS(description="Mínima antigüedad en Tarjetas de Crédito"),
saldo_total_cierre_tdc_monto FLOAT64 OPTIONS(description="Saldo total en TDC's"),
linea_max_tdc_monto FLOAT64 OPTIONS(description="Máximo límite de Crédito en TDC off-us"),
tenencia_auto_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito automotriz, 1 si tiene, 0 si no tiene"),
tenencia_bxi_bandera FLOAT64 OPTIONS(description="Flag o indicadora de banca por internet (la banca por internet no es lo mismo que la banca móvil)"),
tenencia_casa_bolsa_bandera FLOAT64 OPTIONS(description="Flag o indicadore de Casa de Bolsa"),
tenencia_credito_nomina_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito de nómina"),
tenencia_hipo_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito hipotecario"),
tenencia_mesa_dinero_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de mesa de dinero"),
tenencia_credito_personal_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de crédito personal"),
tenencia_pagare_plazo_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de pagares a plazos"),
tenencia_seguros_bandera FLOAT64 OPTIONS(description="Si el cliente cuenta con seguro"),
tenencia_fondos_inversion_bandera FLOAT64 OPTIONS(description="Flag o indicadora de tenencia de fondos de inversión"),
tenencia_tdc_bandera FLOAT64 OPTIONS(description="Flago o indicadora de tenencia de tarjeta de crédito"),
tenencia_vista_bandera FLOAT64 OPTIONS(description="Indicadora de tenencia de Producto vista "),
antig_emisora_meses_numero NUMERIC(20) OPTIONS(description="Antigüedad en meses de la emisora"),
depositos_nom_monto FLOAT64 OPTIONS(description="Monto depositado a cuenta de nómina"),
retiros_nom_monto FLOAT64 OPTIONS(description="Monto retirado de cuenta de nómina"),
max_auto_offus_monto FLOAT64 OPTIONS(description="Máximo límite en créditos de auto off-us"),
max_hipo_offus_monto FLOAT64 OPTIONS(description="Máximo límite en créditos hipotecarios off-us"),
max_credito_personal_offus_monto FLOAT64 OPTIONS(description="Máximo límite en créditos personales off-us"),
monto_max_tdc_offus_monto FLOAT64 OPTIONS(description="Máximo límite en tarjetas de crédito off-us"),
antig_cliente_meses_numero FLOAT64 OPTIONS(description="Antigüedad en banorte"),
saldo_total_auto_monto FLOAT64 OPTIONS(description="Saldo total crédito auto"),
saldo_total_auto_offus_monto FLOAT64 OPTIONS(description="Saldo total crédito auto off-us"),
saldo_total_hipo_offus_monto FLOAT64 OPTIONS(description="Saldo total crédito hipotecario off-us"),
saldo_total_tdc_offus_monto FLOAT64 OPTIONS(description="Saldo total tarjeta de crédito off-us"),
total_credito_personal_offus_monto FLOAT64 OPTIONS(description="Saldo total crédito préstamo personal off-us"),
score_bc_monto FLOAT64 OPTIONS(description="Score de buró de crédito"),
tdc_offus_numero FLOAT64 OPTIONS(description="Número de tarjetas de crédito off-us"),
total_auto_offus_numero FLOAT64 OPTIONS(description="Número de créditos de auto off-us"),
total_hipo_offus_numero FLOAT64 OPTIONS(description="Número de créditos hipotecarios off-us"),
credito_personal_offus_numero FLOAT64 OPTIONS(description="Número de prestamos personales off-us"),
genero_femenino_bandera FLOAT64 OPTIONS(description="Flag o indicadora si el cliente es mujer"),
score_bc_bandera FLOAT64 OPTIONS(description="Flag o indicadora si el cliente tiene score"),
edad_cliente_anios_numero FLOAT64 OPTIONS(description="Edad del cliente"),
nom_3m_bandera FLOAT64 OPTIONS(description="Haber recibido más de 100 pesos en nomina en los ultimos 3 meses"),
uso_tdc_offus_monto FLOAT64 OPTIONS(description="Monto ocupado de su límite de crédito en TDC off-us"),
uso_credito_personal_offus_monto FLOAT64 OPTIONS(description="Monto ocupado de su límite de crédito personal off-us"),
txn_ropa_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Apparel"),
fact_ropa_numero BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Apparel"),
txn_teletrabajo_material_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Home Office Material"),
fact_teletrabajo_material_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Home Office Material"),
txn_teletrabajo_servicios_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Home Office Services"),
fact_teletrabajo_servicios_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Home Office Services"),
txn_hoteles_moteles_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Hotels Motels"),
fact_hoteles_moteles_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Hotels Motels"),
txn_transporte_publico_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Public Transport"),
fact_transporte_publico_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Public Transport"),
txn_asociaciones_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Associations"),
fact_asociaciones_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Associations"),
txn_aerolineas_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Airlines"),
fact_aerolineas_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Airlines"),
txn_renta_auto_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Car Rental"),
fact_renta_auto_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Car Rental"),
txn_transporte_priv_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Private Transport"),
fact_transporte_priv_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Private Transport"),
txn_cuidado_personal_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Personal Care"),
fact_cuidado_personal_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Personal Care"),
txn_transporte_botes_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transport Boats"),
fact_transporte_botes_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transport Boats"),
txn_bienes_energeticos_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Energy Goods"),
fact_bienes_energeticos_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Energy Goods"),
txn_gasolineria_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Gas Station"),
fact_gasolineria_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Gas Station"),
txn_farmacias_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Drugstores"),
fact_farmacias_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Drugstores"),
txn_entretenimiento_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Entertainment"),
fact_entretenimiento_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Entertainment"),
txn_servicios_legales_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Legal Services"),
fact_servicios_legales_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Legal Services"),
txn_electronicos_digital_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Electronics Digital"),
fact_electronicos_digital_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Electronics Digital"),
txn_financiera_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Financial"),
fact_financiera_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Financial"),
txn_gastos_medicos_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Medical Expenses"),
fact_gastos_medicos_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Medical Expenses"),
txn_alimentos_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Food Groceries"),
fact_alimentos_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Food Groceries"),
txn_servicios_personales_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Personal Services"),
fact_servicios_personales_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Personal Services"),
txn_educacion_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Education"),
fact_educacion_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Education"),
txn_tiendas_gral_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en General Stores"),
fact_tiendas_gral_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en General Stores"),
txn_transporte_otros_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transport Other"),
fact_transporte_otros_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transport Other"),
txn_mudanza_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Moving Storage"),
fact_mudanza_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Moving Storage"),
txn_servicios_transporte_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Transportation Services"),
fact_servicios_transporte_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Transportation Services"),
txn_ropa_accesorios_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Apparel Accesory"),
fact_ropa_accesorios_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Apparel Accesory"),
txn_imprenta_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Publishing Printing"),
fact_imprenta_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Publishing Printing"),
txn_veterinario_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Veterinary Pets"),
fact_veterinario_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Veterinary Pets"),
txn_restaurantes_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Restaurants"),
fact_restaurantes_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Restaurants"),
txn_servicios_infantiles_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Children Services"),
fact_servicios_infantiles_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Children Services"),
txn_comunicacion_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Communications"),
fact_comunicacion_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Communications"),
txn_apuestas_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Gambling"),
fact_apuestas_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Gambling"),
txn_servicios_funerarios_numero BIGNUMERIC(38) OPTIONS(description="Transacciones con TDC y Débito en Funeral Services"),
fact_servicios_funerarios_monto BIGNUMERIC(58, 20) OPTIONS(description="Facturación con TDC y Débito en Funeral Services"),
inicio_sesion_app_movil_numero BIGNUMERIC(38) OPTIONS(description="Número de logeos en la APP móvil")
)
PARTITION BY RANGE_BUCKET(fecha_informacion, GENERATE_ARRAY(200000, 209999, 1))
OPTIONS(
description="Tabla que contiene la concentración de datos agregados que permiten tener una visión global del cliente. Es un reporte previo a la generación de variables.",
labels=[("capa", "plata"), ("tipo", "produccion")]
);

#ds_b_cap_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_cap_plt.t_b_cap_dispersion_nomina_m`
(
  cliente_id INT64 OPTIONS(description=""Número de cliente Altamira""),
  mes_fecha DATE OPTIONS(description=""Mes y año de la información""),
  importe_acum_monto NUMERIC(12, 2) OPTIONS(description=""Acumulado de dispersiones de nómina recibidas en el mes y año de información""),
  fecha_informacion DATE OPTIONS(description=""Fecha de información"")
)
PARTITION BY fecha_informacion
OPTIONS(
  description=""Tabla con información de cuentas que reciben dispersiones de nómina, concentrado mensual"",
  labels=[(""capa"", ""plata""), (""tipo"", ""produccion"")]
);


#ds_b_cli_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_datos_complementarios`
(
cliente_id INT64 OPTIONS(description="Número de cliente Altamira"),
alta_fecha DATE OPTIONS(description="Fecha de alta del cliente Altamira"),
persona_tipo STRING(5) OPTIONS(description="Tipo de personalidad jurídica del cliente (PF, PFAE, PM)"),
nac_fecha DATE OPTIONS(description="Fecha de nacimiento del cliente"),
estudios_desc STRING(30) OPTIONS(description="Escolaridad máxima del cliente"),
cp_id NUMERIC(5) OPTIONS(description="Código Postal"),
tel1_numero STRING(17) OPTIONS(description="Teléfono del cliente (Primero de 3 disponibles en Altamira)"),
e_mail_id STRING(50) OPTIONS(description="Correo electrónico del cliente"),
reus_bandera STRING(2) OPTIONS(description="Bandera REUS (Clientes que no desean ser contactados para ofertas comerciales)"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de información de clientes activos (Aquellos con por lo menos alguna relación activa de producto) del Banco",
labels=[("capa", "plata"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_fusiones`
(
clie_fusio_id INT64 OPTIONS(description="Número de cliente que se fusiona"),
clie_perm_numero NUMERIC(8) OPTIONS(description="Número de cliente que permanece tras una fusión"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de relación de último cliente que permanece despues de la fusión",
labels=[("capa", "plata"), ("tipo", "produccion")]
);

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_productos`
(
cliente_id INT64 OPTIONS(description="Número de cliente del producto"),
cuenta_id INT64 OPTIONS(description="Número de cuenta Altamira"),
producto_tipo STRING(20) OPTIONS(description="Nombre de la familia de producto"),
estatus_tipo STRING(10) OPTIONS(description="Estatus de la cuenta"),
nom_subp_nombre STRING(100) OPTIONS(description="Nombre del producto"),
fecha_informacion DATE OPTIONS(description="Fecha de la información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de información de la relación de cuenta cliente con empresa",
labels=[("capa", "plata"), ("tipo", "produccion")]
);


CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_cli_plt.t_b_cli_segmentos`
(
cliente_id INT64 OPTIONS(description="Número de cliente Altamira"),
segmento_nombre STRING(3) OPTIONS(description="Descripción segmento del cliente"),
subsegmento_numero NUMERIC(2) OPTIONS(description="Descripción subsegmento del cliente"),
fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
description="Tabla de información mensual e historica de segmentos de clientes",
labels=[("capa", "plata"), ("tipo", "produccion")]
);


#ds_b_col_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_col_plt.t_b_col_tdc_mensual`
(
  ambs_acct_id STRING(20) OPTIONS(description="Número de cuenta"),
  sdo_total_fin_monto FLOAT64 OPTIONS(description="Saldo total al cierre, incluye promociones"),
  clasificacion1_bandera STRING(2) OPTIONS(description="Bandera (SI/NO) cuenta clasificada (Vigente/Vencida) y no clasificada"),
  mes_fecha DATE OPTIONS(description="Mes y año de la información"),
  ambs_abierta_fecha DATE OPTIONS(description="Fecha de apertura de la cuenta"),
  ambs_bloqueo_codigo_1 STRING(1) OPTIONS(description="Código de bloqueo 1"),
  ambs_bloqueo_codigo_2 STRING(1) OPTIONS(description="Código de bloqueo 2"),
  fecha_informacion DATE OPTIONS(description="Fecha de ejecución")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
  description="Tabla de perfil de Pago tarjeta de credito",
  labels=[("capa", "plata"), ("tipo", "produccion")]
)


#ds_b_dwh_cap_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista`
(
  cuenta_id STRING(19) OPTIONS(description=""Cuenta de cheques, llave única en sistema Altamira""),
  fechaultmov_date DATE OPTIONS(description="" Fecha del último movimiento""),
  cliente_dwh_id INT64 OPTIONS(description=""Llave foranea (subrogada) de la dimensión Cliente, la interfase contiene el campo CLAVE_CLIENTE con el valor del Cliente Altamira""),
  pdimproducto_id NUMERIC(9) OPTIONS(description=""Llave foranea (subrogada) de la dimensión Producto conformada por aplicativo""),
  pdimtiempo_fecha DATE OPTIONS(description=""Corresponde a la fecha del registro""),
  saldodisval_monto NUMERIC(17, 2) OPTIONS(description=""Saldo disponible al cierre del día valorizado"")
)
PARTITION BY DATE_TRUNC(pdimtiempo_fecha, MONTH)
OPTIONS(
  description=""Tabla de Hechos de Créditos APOLO, contiene saldos financieros y contables por Línea y Crédito"",
  labels=[(""capa"", ""oro""), (""tipo"", ""produccion"")]
);


#ds_b_dwh_cat_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos`
(
  pdimsegmento_numero NUMERIC(9) OPTIONS(description=""Llave subrogada primaria de la tabla SegmentoDim""),
  bancagrup_tipo STRING(20) OPTIONS(description=""Clave de Banca o Área de Negocio (ya no está en uso)""),
  segmentogrupclav_numero NUMERIC(18) OPTIONS(description=""Clave de agrupación de Segmentos como Personal o Pymes, tiene como objetivo agregar todos los segmentos relacionados.""),
  segmentogrupdes_desc STRING(30) OPTIONS(description=""Descripción de agrupación de Segmentos como Personal o Pymes, tiene como objetivo agregar todos los segmentos relacionados.""),
  segmentoclav_numero NUMERIC(18) OPTIONS(description=""Clave de segmento de cliente que describe el perfil financiero basado en sus productos y actividad.""),
  segmentodes_desc STRING(30) OPTIONS(description=""Descripción de segmento de cliente que describe el perfil financiero basado en sus productos y actividad.""),
  segmentodesalt_desc STRING(30) OPTIONS(description=""Descripción de segmento de cliente que describe el perfil financiero basado en sus productos y actividad.""),
  segmentoclavalt_desc STRING(5) OPTIONS(description=""Clave alfanumérica que se registra en Altamira para el Segmento.""),
  subsegmento_numero NUMERIC(9) OPTIONS(description=""Clave de subsegmento (ya no está en uso)"")
)
OPTIONS(
  description=""Tabla de catálogo que contiene los atributos de la relacion Cliente - Segmento"",
  labels=[(""capa"", ""plata""), (""tipo"", ""produccion"")]
);

#ds_b_dwh_cli_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos`
(
  numerocif_id INT64,
  pdimcliente_id NUMERIC,
  tipoperclav_id NUMERIC,
  aniosresdom_desc STRING,
  sexo_tipo STRING,
  estadociv_tipo STRING,
  codigopos_id STRING,
  nivelestclav_numero NUMERIC,
  estadoclav_id NUMERIC,
  ocupacionpmclav_id NUMERIC,
  ocupacionpfclav_id NUMERIC
);

#ds_b_rie_plt

CREATE TABLE `bnt-lakehouse-plt-prod.ds_b_rie_plt.t_b_rie_ingreso_cliente`
(
  ing_mensual_monto FLOAT64 OPTIONS(description=""Ingreso mensual estimado productivo""),
  cliente_id INT64 OPTIONS(description=""Número de cliente""),
  metodo_desc STRING(20) OPTIONS(description=""Método con el cual fue calculado el ingreso""),
  retrospectivo_bandera NUMERIC(6) OPTIONS(description=""1: Si la estimación de ingresos es Retrospectivo, hace 12 meses, 0: Si la estimación se hizo con base a información reciente.""),
  fecha_informacion DATE OPTIONS(description=""Fecha de información"")
)
PARTITION BY DATE_TRUNC(fecha_informacion, MONTH)
OPTIONS(
  description=""Tabla de Cliente-Ingresos.Es el estimador de la base de ingresos"",
  labels=[(""capa"", ""plata""), (""tipo"", ""produccion"")]
);"


