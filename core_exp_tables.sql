#bnt-lakehouse-core-prod
#Tablas 
#bitacora
CREATE TABLE `bnt-lakehouse-core-prod.bitacora.catalogo_insumos`
(
  id_tabla INT64,
  nombre_modelo STRING,
  nombre_landing_zone STRING,
  nombre_bronce STRING,
  nombre_plata STRING
);

CREATE TABLE `bnt-lakehouse-core-prod.bitacora.validacion_insumos`
(
  nombre_tabla STRING,
  fecha DATE,
  reproceso STRING,
  estatus STRING
);

#ds_bitacora
CREATE TABLE `bnt-lakehouse-core-prod.ds_bitacora.t_ejecuciones_composer`
(
  id_dag STRING,
  id_task STRING,
  id_run STRING,
  tabla STRING,
  estatus_ejecucion BOOL,
  mensaje_error STRING,
  fecha_auditoria TIMESTAMP,
  fecha_particion DATE,
  id_re_run INT64
);

#ds_metricas
CREATE TABLE `bnt-lakehouse-core-prod.ds_metricas.t_metricas_ingesta`
(
  tabla STRING,
  nombre_campo STRING,
  origen_metricas STRING,
  tipo_dato STRING,
  numero_registros STRING,
  numero_registros_nulos STRING,
  numero_valores_unicos STRING,
  media STRING,
  mediana STRING,
  minimo STRING,
  maximo STRING,
  cuartil_Q1 STRING,
  cuartil_Q2 STRING,
  cuartil_Q3 STRING,
  desviacion_estandar STRING,
  frecuencias ARRAY<STRUCT<tipo STRING, conteo STRING>>,
  frecuencias_json STRING,
  fecha_auditoria TIMESTAMP,
  fecha_informacion DATE OPTIONS(description=""Fecha de información"")
)
PARTITION BY fecha_informacion
OPTIONS(
  description=""Tabla de información sobre métricas  ""
);


#fugas_pruebas
CREATE TABLE `bnt-lakehouse-core-prod.fugas_pruebas.fugas_hipotecario_observadas`
(
  num_clie INT64 OPTIONS(description=""Número de cliente""),
  credito FLOAT64 OPTIONS(description=""Número de crédito evaluado""),
  flag_fuga INT64 OPTIONS(description=""1: Si el cliente movió su crédito hipotecario a otro banco 0: El cliente mantuvo su crédito hipotecario en el banco""),
  fecha_informacion STRING OPTIONS(description=""Fecha de información"")
)
OPTIONS(
  description=""Tabla de Fugas Abandono Hipotecario"",
  labels=[(""capa"", ""bronce""), (""tipo"", ""produccion"")]
);
