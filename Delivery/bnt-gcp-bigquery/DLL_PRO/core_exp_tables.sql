#bnt-lakehouse-core-pro
#Tablas
#bitacora

CREATE OR REPLACE TABLE `bitacora.validacion_insumos`
(
  nombre_tabla STRING,
  fecha DATE,
  reproceso STRING,
  estatus STRING
)OPTIONS(
  description="Tabla de validacion de ingestas de insumos",
  labels=[("capa", "core")]
);

#ds_bitacora
CREATE OR REPLACE TABLE `ds_bitacora.t_ejecuciones_composer`
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
)OPTIONS(
  description="Tabla de registro de ejecuciones de composer",
  labels=[("capa", "core")]
);

#ds_metricas
CREATE OR REPLACE TABLE `ds_metricas.t_metricas_ingesta`
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
  fecha_informacion DATE OPTIONS(description="Fecha de información")
)
PARTITION BY fecha_informacion
OPTIONS(
  description="Tabla de información sobre métricas",
  labels=[("capa", "core")]
);

DROP SCHEMA IF EXISTS fugas_pruebas;
